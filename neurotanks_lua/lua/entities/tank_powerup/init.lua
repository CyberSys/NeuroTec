
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.explodeDel = NULL
ENT.explodeTime = 10

function ENT:Initialize()
	
	self.Type = math.random( 1, 2 )
	-- local models = { "models/powerups/pwu_speed.mdl","models/powerups/pwu_repair.mdl" }
	
	self:SetModel( "models/aftokinito/powerups/repair.mdl" )
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	self:SetPos( self:GetPos() + self:GetUp() * 50 )
	
end

function ENT:OnTakeDamage( dmginfo )


end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime > 0.2 ) then
		
		if( IsValid( data.HitEntity ) && data.HitEntity.VehicleType && data.HitEntity.VehicleType == VEHICLE_TANK && data.Speed > 5 ) then
			
			local tank = data.HitEntity
			if( tank.HealthVal < tank.InitialHealth && !tank.EngineBroken ) then
				
				
				if( type( tank.FireTrails ) == "table" ) then
					
					for i=1,#tank.FireTrails do
						
						if( IsValid( tank.FireTrails[i] ) ) then
							
							tank.FireTrails[i]:Remove()
						
						end
						
					end
					
				end
				
				tank.BrokenYaw = 0
				tank.HealthVal = tank.HealthVal + 750
				if( tank.HealthVal > tank.InitialHealth ) then tank.HealthVal = tank.InitialHealth end
				
				tank:SetNetworkedInt( "health", math.floor( tank.HealthVal ) )
				
				self:EmitSound( "buttons/button5.wav", 511, 100 )
				
				local fx = EffectData()
				fx:SetOrigin( self:GetPos() )
				fx:SetStart( self:GetPos() )
				fx:SetNormal( self:GetUp() )
				fx:SetScale( 10 )
				util.Effect("VortDispel", fx )
				
				self:Remove()
				
			end
			
		end
		
	end
	
end
