
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.explodeDel = NULL
ENT.explodeTime = 10
ENT.HealthVal = 100
ENT.Destroyed = false

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 8
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "tank_fuel" )  
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	ent:GetPhysicsObject():Wake()
	ent.Owner = ply
	
	return ent

end

function ENT:Initialize()
	
	
	-- if( math.random(1,2) == 1 ) then
		
		-- self:SetModel( "models/props_junk/gascan001a.mdl" )
		-- self.FuelAmount = 500
		
	-- else
	local mdls = {"models/props_phx/oildrum001_explosive.mdl",  "models/props_phx/facepunch_barrel.mdl"  }
	self:SetModel( mdls[math.random(1,2)] )
	self.FuelAmount = 1500

	-- end
	
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.LeakPos = {}
	
	-- self:SetPos( self:GetPos() + self:GetUp() * 16 )
	
end

function ENT:Think()
	
	if( self.Destroyed ) then return end
	
	if( #self.LeakPos > 0 ) then
		
		for i = 1,#self.LeakPos do
			
			local fx = EffectData()
			fx:SetOrigin( self:LocalToWorld( self.LeakPos[i] ) )
			fx:SetScale( math.random( 2, 4) )
			util.Effect( "Firecloud", fx )
			util.BlastDamage( self, self,  self:LocalToWorld( self.LeakPos[i] ), 4, 2 )
			
		end
		
	end

end

function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end

	if( self.HealthVal > 0 ) then
	
		self.HealthVal = self.HealthVal - dmginfo:GetDamage()
		self.Owner = dmginfo:GetAttacker()
		
		table.insert( self.LeakPos, self:WorldToLocal( dmginfo:GetDamagePosition() ) )
		
		
	else
		
		
		self:Explode()
		
	end
	
end

function ENT:Explode()

	if( self.Destroyed ) then return end
	
	self.Destroyed = true
	
	ParticleEffect( "neuro_gascan_explo", self:GetPos(), Angle( 0,0,0 ), nil )
	
	-- self:Fire("break","",0)
	-- self:Break()
	
	self:EmitSound( "bf2/weapons/lw155_artillery_fire.mp3", 511, math.random(90,120) )

	util.BlastDamage( self, self.Owner, self:GetPos(), 128, self.FuelAmount/2  )

	self:Fire("kill","",0.3)
	
end

function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
	if( data.DeltaTime > 0.5 && data.Speed > 150 ) then
		
		if( IsValid( data.HitEntity ) && data.HitEntity.VehicleType && data.HitEntity.VehicleType == VEHICLE_TANK && data.Speed > 5 ) then
			
			local tank = data.HitEntity
			if( tank.Fuel && tank.MaxFuel && tank.Fuel < tank.MaxFuel ) then
				
				-- if( tank.Fuel <= 0 ) then
					
					-- timer.Simple( 1,function() if( tank ) then tank:StartupSequence() tank.IsDriving = true end end )
					
				-- end
				
				tank.Fuel = tank.Fuel + self.FuelAmount
				
				if( tank.Fuel > tank.MaxFuel ) then tank.Fuel = tank.MaxFuel end
				tank:SetNetworkedInt("TankFuel", tank.Fuel )
				
				self:Remove()
				
			end
		else
			
			if( data.Speed > 700 ) then
				
				self:Explode()
				
			end
			
		end
		
	end
	end)
	
end
