
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.MaxDamage = 1550
ENT.MinDamage = 1450
ENT.Radius = 128

function ENT:Initialize()

	self:SetModel("models/weapons/w_missile_launch.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetColor( Color( 55,55,55,255 ) )
    
	local TrailDelay = math.Rand( .25, .5 ) / 11
	local TraceScale1 = .5
	local TraceScale2 = .5
	local GlowProxy = 1
	
	self.SpriteTrail = util.SpriteTrail( 
						self, 
						0, 
						Color( 255, 
						205, 
						100, 
						225 ), 
						false,
						8, 
						8, 
						TrailDelay, 
						 1 / ( 0 + 6) * 0.5, 
						"trails/smoke.vmt" );
						
	self.SpriteTrail2 = util.SpriteTrail( 
						self, 
						0, 
						Color( 255, 
						255, 
						255, 
						15 ), 
						true,
						12, 
						0, 
						TrailDelay*60, 
						 1 / ( 0 + 48 ) * 0.5, 
						"trails/smoke.vmt" );
						
	local Glow = ents.Create("env_sprite")				
	Glow:SetKeyValue("model","sprites/orangeflare1.vmt")
	Glow:SetKeyValue("rendercolor","175 175 255")
	Glow:SetKeyValue("scale",tostring(TraceScale1))
	Glow:SetPos(self:GetPos())
	Glow:SetParent(self)
	Glow:Spawn()
	Glow:Activate()

	local Shine = ents.Create("env_sprite")
	Shine:SetPos(self:GetPos())
	Shine:SetKeyValue("renderfx", "0")
	Shine:SetKeyValue("rendermode", "5")
	Shine:SetKeyValue("renderamt", "255")
	Shine:SetKeyValue("rendercolor", "195 195 255")
	Shine:SetKeyValue("framerate12", "20")
	Shine:SetKeyValue("model", "light_glow01.spr")
	Shine:SetKeyValue("scale", tostring( TraceScale2 ) )
	Shine:SetKeyValue("GlowProxySize", tostring( GlowProxy ))
	Shine:SetParent(self)
	Shine:Spawn()
	Shine:Activate()
		
	local phys = self:GetPhysicsObject()
	
	if(phys:IsValid()) then
	
		phys:Wake()
		-- phys:SetMass( 5000 )
		-- phys:SetVelocity( self:GetForward() * self.ShellVelocity  )
		self:GetPhysicsObject():SetVelocity( self:GetForward() * AMMO_VELOCITY_aP_SHELL )
	end


	
	if( self.MinDamage && self.MaxDamage ) then
		
		self.DamageToDeal = math.random( self.MinDamage, self.MaxDamage )
		self.IsCritShell = ( self.DamageToDeal > self.MaxDamage * 0.9  )
		
		if( self.IsCritShell && self.Owner:IsPlayer() ) then
			
			self.Owner:PrintMessage( HUD_PRINTCENTER, "CRITICAL" )
		
		end
		
	end
	self.Trail = util.SpriteTrail(self, 0, Color(55,55,150,25), false, 12, 0, 0.1, 1/(15+1)*0.5, "trails/smoke.vmt") 
	-- print( self.MinDamage, self.MaxDamage, self.DamageToDeal )

end

function ENT:PhysicsUpdate()
		
	if( self:WaterLevel() > 1 ) then
		
		self:NeuroPlanes_SurfaceExplosion()
		
		self:Remove()
		
		return
		
	end

end
function ENT:Think()

	if( self:WaterLevel() > 0 ) then

		ParticleEffect( "water_impact_big", self:GetPos(), Angle(0,0,0), nil )
		
		self:Remove()
		
		return
		
	end
	
	if( self.Detonating == true ) then 			

		local fx = EffectData()
		fx:SetStart( self:GetPos() )
		fx:SetOrigin(self:GetPos() )
		fx:SetNormal( self:GetForward()*-1 )
		fx:SetScale( 5.5 )
		util.Effect("ManhackSparks", fx )
		
	end
	
	self:NextThink( CurTime() + 0.1 )

	
	-- self:GetPhysicsObject():AddAngleVelocity( Vector( 1000, 0, 0 ) ) //spinning shell :D

end

function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
		local PierceDepth = self.ArmorPiercingDepth or 8 
		local tr,trace={},{}
		tr.start = self:GetPos() + self:GetForward() * 25
		tr.endpos = self:GetPos() + self:GetForward() * 9
		tr.filter = { self, self.Owner }
		tr.mask = MASKK_SOLID 
		trace = util.TraceLine( tr )
		-- print( trace.Hit, trace.Entity )
	 
		debugoverlay.Line( data.HitPos, data.HitPos + data.HitNormal * PierceDepth, 120,Color(1,255,1,255), true )
		if( !trace.Hit && !trace.StartSolid  && !self.PiercedOnce  && thisShitISbroken ) then -- !trace.Hit &&
					
			self.PiercedOnce = true 
			if( IsValid( trace.Entity ) && trace.Entity:IsPlayer() ) then 
				
				local fx = EffectData()
				fx:SetOrigin( data.HitPos )
				fx:SetNormal( data.HitNormal)
				fx:SetEntity( self )
				fx:SetScale( 5 )
				util.Effect( "micro_he_blood", fx )
				
			end 

			self.MinDamage = self.MinDamage * .8
			self.MaxDamage = self.MaxDamage * .8 
			
			local effectdata = EffectData()
				effectdata:SetOrigin( data.HitPos )
				effectdata:SetStart( data.HitNormal )
				effectdata:SetNormal( data.HitNormal )
				effectdata:SetMagnitude( 1 )
				effectdata:SetScale( 1 )
				effectdata:SetRadius( 1 )
			util.Effect( "micro_he_impact_plane", effectdata )
				
			ParticleEffect( "ap_impact_wall", data.HitPos, Angle(0,0,0), nil )
		
			self:SetPos( data.HitPos + data.HitNormal * PierceDepth ) 
			self:SetAngles( self:GetAngles() + AngleRand() * 4.5 )
			-- self:SetParent( data.HitEntity )
			
			local fx = EffectData()
			fx:SetStart( data.HitPos )
			fx:SetOrigin( data.HitPos )
			fx:SetNormal( data.HitNormal )
			fx:SetScale( 25.5 )
			fx:SetMagnitude( 10 )
			util.Effect("ManhackSparks", fx )	
			local fx = EffectData()
			fx:SetStart( data.HitPos + data.HitNormal * 15  )
			fx:SetOrigin( data.HitPos + data.HitNormal * 15  )
			fx:SetNormal( -1 * data.HitNormal )
			fx:SetScale( 25.5 )
			fx:SetMagnitude( 10 )
			util.Effect("ManhackSparks", fx )
			self:GetPhysicsObject():SetVelocity( data.OurOldVelocity )
			-- print("DING")
			self:PlayWorldSound( "physics/metal/metal_sheet_impact_bullet1.wav" )
			
			self:EmitSound( "physics/metal/metal_sheet_impact_bullet1.wav", 511, 100 )
					
			local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
			util.Decal("Scorch", a, b )
			

			return 
			
		end 
		
		if( data.DeltaTime > 0.2 ) then
			
			if( IsValid( data.HitEntity ) && data.HitEntity:GetClass() == "prop_physics" && !self.HitOnce ) then
				
				self:SetPos( self:GetPos() + self:GetForward() * 4 )
				self:SetVelocity( data.OurOldVelocity )
				self.HitOnce = true
				
				-- return
			
			end
			
			if( self.Detonating == true ) then return end
			
			if ( IsValid( data.HitEntity ) && data.HitEntity:GetOwner() == self:GetOwner() ) then --// Plox gief support for SetOwner ( table )
				
				return
				
			end
			
			local Deflect = self:TankAmmo_ShouldDeflect( data, physobj )
			if( Deflect ) then return end

			
			if( !IsValid( self.Owner ) ) then self.Owner = self end
			if( !IsValid( self.Creditor ) ) then self.Creditor = self end
			
			if (data.Speed > 1 && data.DeltaTime > 0.1 ) then 
				
				--self:EmitSound( "physics/metal/metal_sheet_impact_bullet1.wav", 511, 100 )
				local hitobj = NULL
				
				if( data.HitEntity && !data.HitEntity:IsWorld() ) then
					
					hitobj = data.HitEntity
					ParticleEffect( "ap_impact_wall", self:GetPos(), Angle(0,0,0), nil )
					-- print( "ap hit non world" )
					
				else	
					
					ParticleEffect( "ap_impact_dirt", self:GetPos(), Angle(0,0,0), nil )
					-- print( "ap hit world" )
					
				end
		
				if( IsValid( data.HitEntity ) &&  data.HitEntity.HealthVal ) then
					
					self:SetPos( data.HitPos + data.HitNormal * 11 )
					-- self:DrawLaserTracer( data.HitPos, data.HitPos + data.HitNormal * 32 )
					self:SetParent( data.HitEntity )
					self.Detonating = true
			
					self:Explode( true, hitobj ) 

					
				else
					
							
					local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
					util.Decal("Scorch", a, b )
					

					self:Explode( false, hitobj ) 
				
				end
				
			end			
				
		end
	end)
end

function ENT:Explode( pierced, hitobj )

	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	
	local fx = EffectData()
	self:PlayWorldSound( "ambient/explosions/explode_2.wav" )
		
	if( pierced ) then
	
	
		fx:SetStart( self:GetPos() )
		fx:SetOrigin( self:GetPos() )
		fx:SetNormal( self:GetForward() * -1 )
		fx:SetScale( 100 )
		fx:SetMagnitude( 50 )
		util.Effect("RPGShotDown", fx )
		-- util.Effect("RPGShotDown", fx )
		fx = EffectData()
		fx:SetStart( self:GetPos() )
		fx:SetOrigin( self:GetPos() )
		fx:SetNormal( self:GetForward() * -1 )
		fx:SetScale( 4.1 )
		util.Effect("ManHackSparks", fx )
	
	else
		
		fx = EffectData()
		fx:SetStart( self:GetPos() )
		fx:SetOrigin( self:GetPos() )
		fx:SetNormal( self:GetForward() * -1 )
		fx:SetScale( 5 )
		util.Effect("ManHackSparks", fx )
	
	end
	
	-- print( self.DamageToDeal )
	if( pierced ) then 
		self.DamageToDeal = self.DamageToDeal * 2 
	end 
	
	if( self.MinDamage && self.MaxDamage ) then
		
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos() + self:GetForward() * 8, self.Radius or 100, self.DamageToDeal )
		-- print( self.Radius, self.DamageToDeal )
	else
	
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos() + self:GetForward() * 8, self.Radius or 100, math.random( 100, 450 ) )

	end
	
	self:Remove()
	
end
