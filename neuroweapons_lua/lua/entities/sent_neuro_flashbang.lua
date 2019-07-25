AddCSLuaFile()
ENT.Type 			= "anim"
ENT.PrintName		= "Flashbang Grenade"
ENT.Author			= "Hoffa"

ENT.Spawnable			= false
ENT.AdminSpawnable		= false 
ENT.AdminOnly 			= true 

-- ENT.Sound = Sound( "ambient/fire/gascan_ignite1.wav" )
ENT.Model = "models/weapons/w_eq_flashbang_thrown.mdl"


if SERVER then 


	function ENT:Initialize()

		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )	
		self:SetSolid( SOLID_VPHYSICS )
		self:SetModel(self.Model)
		self.PhysObj = self:GetPhysicsObject()
		-- self.IncrementalSize = 0 
		-- self.LastIncrement = 0 
		self.ThrownTime = CurTime()
		
		if( self.PhysObj:IsValid() ) then
		
			self.PhysObj:Wake()
			
		end
		
	end
	
	function ENT:PhysicsCollide( data ) 
		
		if( data.DeltaTime > .2 ) then 
			
			self:EmitSound("weapons/flashbang/grenade_hit1.wav", 511, 100 )
			
		end 
	
	end 

	function ENT:Use( activator, caller )

	end
		
	function ENT:OnTakeDamage( d ) end 
	
	function ENT:Think()
		
		if( !IsValid( self.Owner ) ) then return end 
		-- self.IncrementalSize = self.IncrementalSize + 1 
		local timeDiff = math.floor(( CurTime() - self.ThrownTime ))
		-- print( timeDiff )
		
		if( timeDiff > 2 && !self.ActivatedAlmonds ) then 
			
			self.ActivatedAlmonds = true 
			local dist, targetAngle, vAng, dot, trace 
			
			self:EmitSound("weapons/flashbang/flashbang_explode"..math.random(1,2)..".wav", 511, 100 )
			self:SetNWBool("Flashed", true )
			local fx = EffectData()
			fx:SetOrigin( self:GetPos() )
			fx:SetStart( self:GetPos() )
			fx:SetScale( 1.0 )
			fx:SetMagnitude( 5 )
			util.Effect("Sparks", fx )
			self:Fire("kill","",.5)
			util.BlastDamage( self, self.Owner, self:GetPos(), 64, 10 )
			util.Decal( "Scorch", self:GetPos() + Vector(0,0,32), self:GetPos() - Vector(0,0,32) )
			for k,v in pairs( player.GetAll() ) do 
				dist = ( self:GetPos() - v:GetPos() ):Length()
				if( dist < 1024 ) then 
					targetAngle = ( self:GetPos() - v:GetPos() ):GetNormalized()
					vAng = v:GetAimVector()
					dot = targetAngle:Dot( vAng )
					trace = util.TraceLine( { start = self:GetPos(), endpos = v:GetShootPos(), filter = { self, v }, mask = MASK_BLOCKLOS } )
					
					-- print( trace.Hit, trace.Entity, dot, dist )
					if( !trace.Hit ) then 
						if( dot <= 0 ) then 
							dot = .15 
						end 
						v:SetDSP( 36, false ) -- Make it ring in the players ears
						v:SendFlashbangHit( dot )
				
						-- affect bot behavior
						if( v:IsBot() ) then 
							
							local oldTarget = v.Target
							v.Target = v
							v.FollowTarget = NULL 
							-- Reset target
							timer.Simple( dot * 5, function() 
								if( IsValid( v ) ) then 
									
									v.Target = oldTarget
								
								end 
								
							end )
							
						end 
						
					end 
					
				end 
				
			end 
			
		
		end 
		
	end

	function ENT:OnRemove()

	end


end 

if CLIENT then 

	function ENT:Initialize()

		local pos = self:GetPos()
		self.Emitter = ParticleEmitter( pos , false )
		
	end

	local SpriteMat = Material( "sprites/physg_glow2" )
	function ENT:Draw()

		self:DrawModel()
		if( self:GetNWBool("Flashed") ) then 
			
			self:SetNWBool("Flashed", false )
			self.StartRenderSprite = CurTime() 
			
			local dlight = DynamicLight( self:EntIndex() )
			if ( dlight ) then

				dlight.Pos = self:GetPos()
				dlight.r = 255
				dlight.g = 255
				dlight.b = 255
				dlight.Brightness = 1
				dlight.Decay = 1
				dlight.Size = 2048
				dlight.DieTime = CurTime() + 0.25

			end
		
			for i=1,10 do 
				
				local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:GetPos() )
				
				if ( particle ) then
					
					particle:SetVelocity( VectorRand() * 100 )
					particle:SetDieTime( math.Rand( 7, 12 ) )
					particle:SetStartAlpha( math.Rand( 25, 45 ) )
					particle:SetEndAlpha( 0 )
					particle:SetStartSize( math.Rand( 15, 35 ) )
					particle:SetEndSize( math.Rand( 280, 300 ) )
					particle:SetRoll( math.Rand(0, 360) )
					particle:SetRollDelta( math.Rand(-1, 1) )
					particle:SetColor( math.Rand(135,145), math.Rand(135,145), math.Rand(135,145) ) 
					particle:SetAirResistance( 100 ) 
					particle:SetGravity( VectorRand() * 50 ) 	
					particle:SetCollide( false )
					

				end
				
			end 
			
		end 
		
		if( self.StartRenderSprite && CurTime() - self.StartRenderSprite < .25 ) then 
					
			cam.Start3D() 
				-- cam.IgnoreZ( true )
				render.SetMaterial( SpriteMat ) -- Tell render what material we want, in this case the flash from the gravgun
				render.DrawSprite( self:GetPos(), 256, 256, Color( 255, 255, 255, 255 ) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
				-- cam.IgnoreZ( false )
				
			cam.End3D()
		
		end 
		
	end

	function ENT:OnRemove()

	end

end 
