
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.HealthVal = 50
ENT.Destroyed = false

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 8
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "tank_ammo_box" )  
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	ent:GetPhysicsObject():Wake()
	ent.Owner = ply
	
	return ent

end

function ENT:Initialize()
	
	self:SetModel( "models/items/ammocrate_smg1.mdl" )
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:GetPhysicsObject():SetMass( 50 )
	-- self:SetPos( self:GetPos() + self:GetUp() * 16 )
	
end

function ENT:Think()

end

function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end

	if( self.HealthVal > 0 ) then
	
		self.HealthVal = self.HealthVal - dmginfo:GetDamage()
		self.Owner = dmginfo:GetAttacker()

		
	else
		
		self:Explode()
		
	end
	
end

function ENT:Explode()

	self.Destroyed = true
	
	local fx = EffectData()
	fx:SetStart( self:GetPos() )
	fx:SetOrigin( self:GetPos() )
	fx:SetScale( 60 )
	util.Effect("Firecloud", fx )
	self:EmitSound( "explosion3.wav", 511, 100 )

	util.BlastDamage( self, self.Owner, self:GetPos(), 128, 512  )
	
	-- for k,v in pairs( ents.FindInSphere( self:GetPos(), 64) ) do
		
		-- if( IsValid( v ) ) then
			
			-- v:Ignite( 1, 1 )
			
			
		-- end
	
	-- end
	
	-- self:Fire("break","",0)
	self:Remove()
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime > 0.2 ) then
		
		-- print( "woop 1 " )
		if( IsValid( data.HitEntity ) && data.HitEntity.VehicleType && data.HitEntity.VehicleType == VEHICLE_TANK && data.Speed > 0 ) then
			-- print( "woop 2" )
			
			local tank = data.HitEntity
			
			if( tank.UnUsed ) then return end
			-- print( "woop 3" )
				
			if( tank.AmmoTypes && tank.AmmoIndex && tank.AmmoTypes[tank.AmmoIndex] ) then
	
				if( tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount < tank.AmmoTypes[tank.AmmoIndex].MaxAmmo ) then
					
					tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount = tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount + ( 10 * ( 5 - tank.TankType ) )
					
					if( tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount > tank.AmmoTypes[tank.AmmoIndex].MaxAmmo ) then
						
						tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount = tank.AmmoTypes[tank.AmmoIndex].MaxAmmo
						
					end
						
					tank:SetNetworkedInt("NeuroTanks_ammoCount", tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount )
					
					local fx = EffectData()
					fx:SetScale( 15 )
					fx:SetOrigin( self:GetPos() )
					util.Effect( "ManhackSparks", fx )
					
					self:Remove()
						
				end
				
			end
			
			
		end
		
		
	end
	
end
