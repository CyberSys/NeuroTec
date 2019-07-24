
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


function ENT:Initialize()
	self.HealthVal = 1000
	self.Speed = 0
	self:SetModel( "models/aftokinito/wot/german/h39_stuka_rocket.mdl" )
	self:SetOwner( self.Owner )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	-- ParticleEffectAttach( "arty_muzzleflash", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
 
    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
	
		phys:Wake()
		phys:SetMass( 2000 )
		phys:EnableGravity( true )
		phys:EnableDrag( false )
	
	end
	
	self.Sauce = 7
	
end


function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end
	
	local dmg = dmginfo:GetDamage()

	self.HealthVal = self.HealthVal - dmg
	
	if(	self.HealthVal < 0 ) then
		
		self.Destroyed = true
			
		local fx = EffectData()
		fx:SetStart( self:GetPos() )
		util.Effect("Explosion", fx )
		
		self:Remove()
		
	end
	
end

function ENT:ActivateRocket()
	
	self.Activated = true
	self.Destroyed = true
	-- self:GetPhysicsObject():EnableGravity( false )
	//ParticleEffectAttach( "rockettrail", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
	self:SetDTBool(0, true)
	self.booo = CreateSound( self, "ambient/gas/cannister_loop.wav")
	self.booo:Play()
	self:EmitSound( "bf2/tanks/d30_artillery_Fire.mp3", 511, 100 )
	self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 2000000 )
	
	ParticleEffect( "tank_muzzleflash", self:GetPos(), self:GetAngles(), self, 0 )
 
end


function ENT:Think()
	
	if( !self.Activated ) then return end
	--
	if( self.Sauce >= 0 ) then
		
		 self.Speed = self.Speed + 50000
	
		-- self:GetPhysicsObject():EnableDrag( false )
		-- self:GetPhysicsObject():SetMass( 5000 )
		
		self.Sauce = self.Sauce - 1
		-- print( self.Sauce )
		self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * self.Speed + VectorRand()*155 )
		-- self:GetPhysicsObject():AddAngleVelocity( Vector( 50, 0, 0 ) ) //spinning shell :D
	else
		-- self:GetPhysicsObject():EnableGravity( true )
		self:StopParticles()
	
	end
	
	-- print( math.floor( self:GetVelocity():Length()) )
end

function ENT:PhysicsCollide( data, physobj )

	if( !self.Activated ) then return end
	
	if( data.DeltaTime > 0.4 && self.Sauce <= 0 ) then
				
		-- local Deflect = self:TankAmmo_ShouldDeflect( data, physobj )
		
		-- if( Deflect ) then return end
		
		if ( IsValid( data.HitEntity ) && data.HitEntity:GetOwner() == self:GetOwner() ) then // Plox gief support for SetOwner ( table )
			
			return
			
		end
		
		local fx
	
	
		if (data.Speed > 50 ) then 
			
			if( !IsValid( self.Owner ) ) then self.Owner = self end
			if( !IsValid( self.Creditor ) ) then self.Creditor = self end
			
			if( data.HitEntity && !data.HitEntity:IsWorld() ) then
				
				 fx = "rt_impact_tank"

			else
				
				fx = "rt_impact_tank"
		
			end
			local sfx = EffectData()
			sfx:SetOrigin( self:GetPos() )
			util.Effect( "Explosion", sfx )
			if( self:WaterLevel() > 0 ) then
				
				fx = "water_impact_big"
				
			end
		
			ParticleEffect( fx, self:GetPos(), Angle(0,0,0), nil )
			
			local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
			util.Decal("Scorch", a, b )
			
			self:Explode()
			
		end
	
	end
	
end

function ENT:OnRemove()
	if( IsValid( self.booo ) )  then

		self.booo:Stop()
	
	end 
	
end

function ENT:Explode()
	
	if( !self.Activated ) then return end
	
	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	

	self:PlayWorldSound( "ambient/explosions/explode_2.wav" )

	-- local pe = ents.Create( "env_physexplosion" );
	-- pe:SetPos( self:GetPos() );
	-- pe:SetKeyValue( "Magnitude", 12 );
	-- pe:SetKeyValue( "radius", 128 );
	-- pe:SetKeyValue( "spawnflags", 19 );
	-- pe:Spawn();
	-- pe:Activate();
	-- pe:Fire( "Explode", "", 0 );
	-- pe:Fire( "Kill", "", 0.5 );
	
	if( self.MinDamage && self.MaxDamage ) then
		
		local dmg = math.random( self.MinDamage, self.MaxDamage )
		
		if( dmg > self.MaxDamage * 0.9 && self.Owner:IsPlayer() ) then
			
			self.Owner:PrintMessage( HUD_PRINTCENTER, "CRIT!" )
		
		end
		
		-- print( dmg, self.Radius, self.Creditor:GetClass(), self.Owner:GetClass() )
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos() + Vector(0,0,75 ), 620, dmg )
		-- print( "woop")
	else
	
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos()+ Vector(0,0,75 ), self.Radius or 512, self.MaxDamage or math.random( 500, 750 ) )

	end
	
	self:Remove()
	
end
