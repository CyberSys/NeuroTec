
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self:SetModel("models/weapons/w_missile_launch.mdl")
	-- self:SetOwner(self.Owner)
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
	Glow:SetKeyValue("rendercolor","255 150 100")
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
	Shine:SetKeyValue("rendercolor", "255 130 100")
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
		phys:SetMass( 500 )
		-- phys:SetVelocity( self:GetForward() * self.ShellVelocity  )
		phys:SetVelocity( self:GetForward() * AMMO_VELOCITY_HE_SHELL )
	end

end

function ENT:Think()
	
	-- local brl = self.Owner:GetScriptedVehicle().Barrel
	-- print( ( self:GetPos() - brl:GetPos() + brl:GetForward() * 200 ):Length2D() )
	if( self:WaterLevel() > 0 ) then

		ParticleEffect( "water_impact_big", self:GetPos(), Angle(0,0,0), nil )
		
		self:Remove()
		
		return
		
	end
	
	self:NextThink( CurTime() + 0.3 )

	-- self:GetPhysicsObject():ApplyForceCenter( self:GetAngles():Forward() * 4000 )
	-- self:GetPhysicsObject():AddAngleVelocity( Vector( 1000, 0, 0 ) ) //spinning shell :D

end

function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
		if( data.DeltaTime > 0.1 ) then
					
			-- local Deflect = self:TankAmmo_ShouldDeflect( data, physobj )
			
			-- if( Deflect ) then return end
			
			if ( IsValid( data.HitEntity ) && data.HitEntity:GetOwner() == self:GetOwner() ) then // Plox gief support for SetOwner ( table )
				
				return
				
			end
			
			if (data.Speed > 50 ) then 
				
				if( !IsValid( self.Owner ) ) then self.Owner = self end
				if( !IsValid( self.Creditor ) ) then self.Creditor = self end
				
				if( data.HitEntity && !data.HitEntity:IsWorld() ) then
					
					ParticleEffect( "HE_impact_wall", self:GetPos(), Angle(0,0,0), nil )
					-- print( "HE hit nonworld")
				else
					
					ParticleEffect( "HE_impact_dirt", self:GetPos(), Angle(0,0,0), nil )
					-- print( "HE hit world") 
					
				end
				
				
				local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
				util.Decal("Scorch", a, b )
				
				self:Explode()
				
			end
		
		end
	end)
end

function ENT:Explode()

	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	

	self:PlayWorldSound( "ambient/explosions/explode_2.wav" )

	local pe = ents.Create( "env_physexplosion" );
	pe:SetPos( self:GetPos() );
	pe:SetKeyValue( "Magnitude", 50 );
	pe:SetKeyValue( "radius", 76 );
	pe:SetKeyValue( "spawnflags", 19 );
	pe:Spawn();
	pe:Activate();
	pe:Fire( "Explode", "", 0 );
	pe:Fire( "Kill", "", 0.5 );
	
	if( self.MinDamage && self.MaxDamage ) then
		
		local dmg = math.random( self.MinDamage, self.MaxDamage )
		
		if( dmg > self.MaxDamage * 0.9 && self.Owner:IsPlayer() ) then
			
			self.Owner:PrintMessage( HUD_PRINTCENTER, "CRIT!" )
		
		end
		
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos()+Vector(0,0,12), self.Radius or 512, dmg )
	
	else
	
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos()+Vector(0,0,12), 512, math.random( 100, 450 ) )

	end
	-- print( "WHAT", self.MinDamage, self.MaxDamage )
	self:Remove()
end
