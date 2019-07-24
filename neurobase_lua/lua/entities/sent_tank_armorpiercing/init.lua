
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.explodeDel = NULL
ENT.explodeTime = 10

function ENT:Initialize()

	self:SetModel("models/weapons/w_missile_launch.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
 
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
	Shine:SetKeyValue("rendercolor", "195 255 195")
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
	self:GetPhysicsObject():SetVelocity( self:GetForward() * AMMO_VELOCITY_aPHE_SHELL )
	end

	self.explodeDel = CurTime() + self.explodeTime
end

function ENT:PhysicsUpdate()
	if( self:WaterLevel() > 1 ) then
		
		self:NeuroPlanes_SurfaceExplosion()
		
		self:Remove()
		
		return
		
	end
end

function ENT:Think()
	
	if( self.Detonating == true ) then 			

		local fx = EffectData()
		fx:SetStart( self:GetPos() )
		fx:SetOrigin(self:GetPos() )
		fx:SetNormal( self:GetForward()*-1 )
		fx:SetScale( 5.8 )
		util.Effect("ManhackSparks", fx )
		
		return 
			
	end
	-- self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 40000 )
	-- self:GetPhysicsObject():AddAngleVelocity( Vector( 1000, 0, 0 ) ) //spinning shell :D

	self:NextThink( CurTime() + 0.1 )

end

function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
	local tr,trace={},{}
	tr.start = self:GetPos() + self:GetForward() * 15
	tr.endpos = self:GetPos() + self:GetForward() * 9
	tr.filter = { self, self.Owner }
	tr.mask = MASKK_SOLID 
	trace = util.TraceLine( tr )
	-- print( trace.Hit, trace.Entity )
	
	-- self:SetParent( data.HitEntity ) 
	debugoverlay.Line( data.HitPos, data.HitPos + data.HitNormal * 15, 120,Color(255,55,55,255), true )
	if( !trace.Hit && !trace.StartSolid && WhyIsThisbrokenRemoveTHisWhenItsFixed ) then -- !trace.Hit &&
		
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
		
		self:SetPos( data.HitPos + data.HitNormal * 10 ) 
		self:SetAngles( self:GetAngles() + AngleRand() * 4.5 )
			
		-- ParticleEffect( "ap_impact_wall",  data.HitPos, Angle(0,0,0), nil )

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
		
		if( self.Detonating == true ) then return end
		local Deflect = self:TankAmmo_ShouldDeflect( data, physobj )
        if( Deflect ) then return end
		
		if ( IsValid( data.HitEntity ) && data.HitEntity:GetOwner() == self:GetOwner() ) then // Plox gief support for SetOwner ( table )
			
			return
			
		end
		
		local dh = data.HitNormal:Angle()
		local da = self:GetAngles()
		
		-- local a,b,c = self:VecAngD( dh.p, da.p ),self:VecAngD( dh.y, da.y ),self:VecAngD( dh.r, da.r )
		
		
		-- if( ( a > 110 || a < -110 || b > 110 || b < -110 || c > 110 || c < -110) && 
			-- IsValid( data.HitEntity ) && data.HitEntity.VehicleType && data.HitEntity.VehicleType == VEHICLE_TANK ) then	

			-- self:EmitSound( "physics/metal/metal_sheet_impact_bullet1.wav", 511, 100 )
			-- local fx = EffectData()
			-- fx:SetStart( data.HitPos )
			-- fx:SetOrigin( data.HitPos )
			-- fx:SetNormal( data.HitNormal )
			-- fx:SetScale( 4.5 )
			-- util.Effect("ManhackSparks", fx )

			-- return 
		
		-- end
		
		if( !IsValid( self.Owner ) ) then self.Owner = self end
		if( !IsValid( self.Creditor ) ) then self.Creditor = self end
		
		if (data.Speed > 50 && data.DeltaTime > 0.21 ) then 
			
			self:EmitSound( "physics/metal/metal_sheet_impact_bullet1.wav", 511, 100 )
			
			if( IsValid( data.HitEntity ) && data.HitEntity.HealthVal ) then
				
				local penval = data.HitEntity.ArmorThicknessFront
				if( penval == nil ) then penval = 0.2 end
				-- print( penval, ( 64 * penval ) )
				self:SetPos( data.HitPos + data.HitNormal * ( 1 + ( 32 * penval   ) ) )
				self:SetParent( data.HitEntity )
				
				local fx = EffectData()
				fx:SetStart( data.HitPos )
				fx:SetOrigin( data.HitPos )
				fx:SetNormal( data.HitNormal )
				fx:SetScale( 10.5 )
				util.Effect("ManhackSparks", fx )
				
				self.Detonating = true
				
				timer.Create( tostring(self:EntIndex()), math.Rand( 0.1, .3 ), 1, function() if( IsValid( self ) ) then self:Explode() end end )
				
			else
			
				local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
				util.Decal("Scorch", a, b )
			
				self:Explode() 
			
			end
			
		end			
			
	end
	end)
end

function ENT:Explode()

	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	
	if( !IsValid( self.Creditor ) ) then
		
		self.Creditor = self
		
	end
	
	self.ExplodeOnce = 1
	-- local expl = ents.Create("env_explosion")
	-- expl:SetKeyValue("spawnflags",128)
	-- expl:SetPos( self:GetPos() )
	-- expl:Spawn()
	-- expl:Fire("explode","",0)
	
	-- local FireExp = ents.Create("env_physexplosion")
	-- FireExp:SetPos(self:GetPos())
	-- FireExp:SetParent(self)
	-- FireExp:SetKeyValue("magnitude", 100000)
	-- FireExp:SetKeyValue("radius", 1024)
	-- FireExp:SetKeyValue("spawnflags", "1")
	-- FireExp:Spawn()
	-- FireExp:Fire("Explode", "", 0)
	-- FireExp:Fire("kill", "", 5)
	
	self:PlayWorldSound( "ambient/explosions/explode_2.wav" )
	
	ParticleEffect( "ap_impact_wall", self:GetPos(), Angle(0,0,0), nil )
	
	
	if( self.MinDamage && self.MaxDamage ) then
		
		local dmg = math.random( self.MinDamage, self.MaxDamage )
		
		if( dmg > self.MaxDamage * 0.9 && self.Owner:IsPlayer() ) then
			
			self.Owner:PrintMessage( HUD_PRINTCENTER, "CRIT!" )
		
		end
		
		if( self.Detonating ) then 
			dmg = dmg * 2 
		end 
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos() + self:GetForward()*18,  self.Radius or 512, dmg )
	
	else
	-- w
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos()+ self:GetForward()*18, self.Radius or 512, math.random( 200, 550 ) )

	end
	
	self:Remove()
	
end
