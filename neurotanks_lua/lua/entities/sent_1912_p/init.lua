AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, class )

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( class )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()

	return ent
	
end


function ENT:Initialize()
	
	local models = 
	{
		{  	-- Medic
			Mdl = "models/aftokinito/neurotanks/german/l912_body1.mdl",
			Callback = function( ent )
				
				for k,v in pairs( ents.FindInSphere( ent:GetPos(), 512 ) ) do
					
					if( v:IsPlayer() && v:Alive() &&  v:Health() < 100 ) then
				
						v:SetHealth( v:Health()+0.001)
					
					end
					
					
				end
				
			end 
		};
		{   -- Ammo
			Mdl = "models/aftokinito/neurotanks/german/l912_body4.mdl",
			Callback = function( ent )
				
				for k,v in pairs( ents.FindInSphere( ent:GetPos(), 512 ) ) do
					
					if( v.TankType && v.IsDriving && IsValid( v.Pilot ) ) then
						
						if( math.random(1,3) == 2 ) then return end
						
						local tank = v
			
						if( tank.UnUsed ) then return end
						-- print( "woop 3" )
							
						if( tank.AmmoTypes && tank.AmmoIndex && tank.AmmoTypes[tank.AmmoIndex] ) then
				
							if( tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount < tank.AmmoTypes[tank.AmmoIndex].MaxAmmo ) then
								
								tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount = tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount + ( 10 * ( 5 - tank.TankType ) )
								
								if( tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount > tank.AmmoTypes[tank.AmmoIndex].MaxAmmo ) then
									
									tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount = tank.AmmoTypes[tank.AmmoIndex].MaxAmmo
									
								end
									
								tank:SetNetworkedInt("NeuroTanks_ammoCount", tank.AmmoTypes[tank.AmmoIndex].CurrentAmmoCount )
								
								-- local fx = EffectData()
								-- fx:SetScale( 15 )
								-- fx:SetOrigin( tank:GetPos() )
								-- util.Effect( "ManhackSparks", fx )
								
								-- self:Remove()
									
							end
							
						end
					
					end
				
				
				end
			
			end 
		};
		{   -- Fuel
			Mdl = "models/aftokinito/neurotanks/german/l912_body5.mdl",
			Callback = function( ent )
				
				for k,v in pairs( ents.FindInSphere( ent:GetPos(), 512 ) )  do
					
					if( v.TankType && v.IsDriving && IsValid( v.Pilot ) ) then
						
						local tank = v
						if( tank.Fuel && tank.MaxFuel && tank.Fuel < tank.MaxFuel ) then
			
							tank.Fuel = tank.Fuel + 0.25
							
							if( tank.Fuel > tank.MaxFuel ) then tank.Fuel = tank.MaxFuel end
							tank:SetNetworkedInt("TankFuel", tank.Fuel )
							
							
						end
					
					end
					
				end
				
			end 
		};
	}
	
	local _Type = models[math.random(1,#models)] 
	self.Model = _Type.Mdl
	self.ThinkCallback = _Type.Callback
	
	
	self.AmmoTypes = 
	{
		{
			PrintName = "20mm GSh-301",
			Type = "sent_tank_mgbullet",
			Delay = self.PrimaryDelay,
			Sound = self.ShootSound,
			MinDmg = self.MinDamage,
			MaxDmg = self.MaxDamage,
			Radius = self.BlastRadius,
			BulletCount = 1,
			TraceRounds = 0,
			Tracer = "tracer",
			Muzzle = "mg_muzzleflash",
			BulletHose = true,
		};
	}
	
	self:TanksDefaultInit()

	self:StartMotionController()
	
						
						
end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime < 0.2 ) then return end
	
	self:TankDefaultCollision( data, physobj )
	
end

function ENT:OnTakeDamage(dmginfo)
	
	self:TankDefaultTakeDamage( dmginfo )
	
end

function ENT:OnRemove()
	
	self:TankDefaultRemove()
	
end

function ENT:Use(ply,caller)

	self:TankDefaultUse( ply, caller )
	
end

function ENT:Think()

	self:TankDefaultThink()
	
	if( IsValid( self.Pilot ) && self.IsDriving ) then
		
		self.ThinkCallback( self )
		
	end
		
	-- Make sure you get the right ammo post-barrelchange
	self:NextThink( CurTime() )
	
	return true
	
end
	
function ENT:PhysicsUpdate()
	
	if( self.HasTower ) then
	
		self:TankTowerRotation()
	
	else
		
		self:TankNoTowerRotation()
	
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end

