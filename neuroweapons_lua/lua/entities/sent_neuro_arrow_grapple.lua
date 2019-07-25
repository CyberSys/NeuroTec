AddCSLuaFile()

ENT.PrintName = "Grappling Arrow"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Equipment Stuff"
ENT.Base = "base_anim"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.InitialHealth = 75
ENT.Model = "models/ml/explosive_arrow.mdl" 
local SpriteMat = Material( "sprites/physg_glow2" )
function ENT:Initialize()

	self.HealthVal = self.InitialHealth 
	self:SetNWInt("HealthVal", math.floor( self.HealthVal ) )
	
	if SERVER then
		
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:GetPhysicsObject():SetMass( 50 )
		self:Fire("Kill","",15)
		self:SetAngles( self:GetAngles() + AngleRand() * .0015 )

		-- self:Ignite(30,30)
		
		-- timer.Simple( 0.1, function()
			-- local own = self:GetOwner()
			-- print( own )
			-- if ( IsValid( own ) && own:IsPlayer() ) then 
			-- print( "cyka" )
			-- local bone = own:LookupBone("ValveBiped.Bip01_R_Hand")
			
			-- local rape = constraint.Rope( self, 
								-- own, 
								-- 0, 
								-- bone, 
								-- Vector(), 
								-- Vector(), 
								-- 1024, 
								-- 1024, 
								-- 0, 
								-- 8, 
								-- "materials/rope", 
								-- false )
			-- print( rape )
	
			
			-- end 
		-- end )
		util.SpriteTrail( self, 0, Color( 255,255,255, 255 ), true, 4, 0, 1, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
		
		local Glow = ents.Create("env_sprite")				
		Glow:SetKeyValue("model","sprites/light_glow01.vmt")
		Glow:SetKeyValue("rendercolor","255 255 255")
		Glow:SetKeyValue("scale",tostring(.1))
		Glow:SetKeyValue("renderfx", "1")
		Glow:SetKeyValue("rendermode", "3")
		Glow:SetPos(self:GetPos())
		Glow:SetParent(self)
		Glow:Spawn()
		Glow:Activate()
	
		-- local Shine = ents.Create("env_sprite")
		-- Shine:SetPos(self:GetPos())
		-- Shine:SetKeyValue("renderfx", "1")
		-- Shine:SetKeyValue("rendermode", "3")
		-- Shine:SetKeyValue("renderamt", "50")
		-- Shine:SetKeyValue("rendercolor", "191 64 0")
		-- Shine:SetKeyValue("framerate12", "20")
		-- Shine:SetKeyValue("model", "sprites/fire.spr")
		-- Shine:SetKeyValue("scale", tostring( 16 ) )
		-- Shine:SetKeyValue("GlowProxySize", tostring( 32 ))
		-- Shine:SetParent(self)
		-- Shine:Spawn()
		-- Shine:Activate()
		self.CreationTime = CurTime()
		
	end 
	
	if( CLIENT ) then 

		local pos = self:GetPos()
		self.Emitter = ParticleEmitter( pos , false )
		
	end 
	
end 
function ENT:Draw()

	self:DrawModel()
	-- local dlight = DynamicLight( self:EntIndex() )
	-- if ( dlight ) then

		-- local c = Color( 255+math.random(-5,5), 255+math.random(-5,5), 255, 100 )

		-- dlight.Pos = self:GetPos()
		-- dlight.r = c.r
		-- dlight.g = c.g
		-- dlight.b = c.b
		-- dlight.Brightness = 2.5
		-- dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
		-- dlight.Size = math.random(64,128)
		-- dlight.DieTime = CurTime() + 0.025

	-- end
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
				particle:SetDieTime( math.Rand( 3, 4 ) )
				particle:SetStartAlpha( math.Rand( 25, 45 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 15, 35 ) )
				particle:SetEndSize( math.Rand( 180, 200 ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( math.Rand(135,145), math.Rand(135,145), math.Rand(135,145) ) 
				particle:SetAirResistance( 100 ) 
				particle:SetGravity( VectorRand() * 50 ) 	
				particle:SetCollide( false )

			end
			
		end 
		
	end 
	
	if( self.StartRenderSprite && CurTime() - self.StartRenderSprite < .15 ) then 
				
		cam.Start3D() 
			-- cam.IgnoreZ( true )
			render.SetMaterial( SpriteMat ) -- Tell render what material we want, in this case the flash from the gravgun
			render.DrawSprite( self:GetPos(), 256, 256, Color( 255, 255, 255, 255 ) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
			-- cam.IgnoreZ( false )
			
		cam.End3D()
	
	end 
end 

function ENT:OnRemove()
	
	if( CLIENT ) then 
	else

	
	end 

end 

function ENT:PhysicsCollide( data )
	
	local dot = self:GetForward():Dot( data.HitNormal )
	if( self.LastBounce && self.LastBounce + .25 >= CurTime() ) then return end 
	
	if( dot <= .8 && !self.Bounced ) then 

		self.LastBounce = CurTime()
		self.Bounced = true 
		self:GetPhysicsObject():SetVelocity( data.OurOldVelocity * .9 )
		local effectdata = EffectData()
		effectdata:SetOrigin( data.HitPos + data.HitNormal )
		effectdata:SetStart( data.HitPos + data.HitNormal )
		effectdata:SetNormal( data.HitNormal )
		effectdata:SetMagnitude( 2 )
		effectdata:SetScale( 1 )
		effectdata:SetRadius( 4 )
		util.Effect( "Sparks", effectdata )
		
		return 
		
	end 
	
	if( self.Collided ) then return end 
	self.Collided = true 
		
	timer.Simple( 0, function() if (IsValid( self ) ) then 
		self:SetSolid( SOLID_NONE ) 
		self:SetMoveType( MOVETYPE_NONE )
	-- local w = constraint.Weld( self, data.HitEntity, 0,0, 0, true, false )
	end end )
	self:Fire("kill","",.15)
	self.Phys = self:GetPhysicsObject();
	if(self.Phys and self.Phys:IsValid()) then
		self.Phys:SetMass(1);
	end
	self:PhysicsInitSphere(1,"metal");
	self:SetCollisionBounds(-1*Vector(1,1,1),Vector(1,1,1));
	self:SetPos( data.HitPos ) 
	if( data.HitEntity == game.GetWorld() ) then 
		self:EmitSound("weapons/crossbow/hit1.wav", 511, 100 )
		-- timer.Simple( 0, function() 
		self:SetMoveType( MOVETYPE_NONE )
		-- end )
		
	elseif ( data.HitEntity )  then 
		
		self:PhysicsDestroy()
		self:SetMoveType( MOVETYPE_NONE )
		self:SetParent( data.HitEntity ) 
		self:EmitSound("weapons/crossbow/hitbod"..math.random(1,2)..".wav", 511, 100 )
		
	end 
	
	local effectdata = EffectData()
	effectdata:SetOrigin( data.HitPos )
	effectdata:SetStart( data.HitNormal )
	effectdata:SetNormal( data.HitNormal )
	effectdata:SetMagnitude( 1 )
	effectdata:SetScale( 1.1 )
	effectdata:SetRadius( 1 )
	self.HitEntity = data.HitEntity 
		
	self:DetonateFlashbang()
   if data.HitWorld and data.MatType == MAT_METAL then
		util.Effect( "micro_he_impact_plane", effectdata )
	elseif( data.HitEntity && ( data.HitEntity.IsBodyPart || data.HitEntity:IsPlayer() || data.HitEntity:IsNPC() ) && data.MatType != MAT_METAL ) then 
		effectdata:SetScale( 0.8 )
		util.Effect( "micro_he_blood", effectdata )
	else
		util.Effect( "micro_he_impact", effectdata )
	end
end
function ENT:DetonateFlashbang()
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
		if( dist < 512 ) then 
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

function ENT:Think()
	if( SERVER ) then 
		
		if( self:WaterLevel() > 0 ) then self:Remove() return end 
		
		if( self.CreationTime && self.CreationTime + 1.5 <= CurTime() && !self.Detonated ) then 
		
			self.Detonated = true 
			self:DetonateFlashbang()
			
			return 
		
		end 
		
		local par = self:GetParent()
		if( IsValid( par ) && par:IsPlayer() && !par:Alive( ) ) then 
			
			self:Remove()
			
			return
			
		end 
		
	else 

	end 

end 

function ENT:Use( ply, act, a, b )
	
	if( ply:IsPlayer() ) then 
		
		ply:Give( 1, "AirboatGun", false )
		self:Remove()
		
	end 

end 

