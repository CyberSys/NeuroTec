AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)
	
	local rand1 = math.random(0,1)

	
	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( self.FolderName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	    
	-- if( rand1 == 0 ) then
		
		-- ent.BarrelPos = "X Y Z" 
		
	-- end
	
	ent:Spawn()
	ent:Activate()

	

	return ent
	
end


function ENT:Initialize()
	self.AmmoIndex = 1
               
	self:TanksDefaultInit()

    self.Tower:SetBodygroup(0,0)
    self.Barrel:SetBodygroup(0,4)
    
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 5000000 )
	
	self:StartMotionController()
	
	local ent = self
	-- if( self.SkinCount && self.SkinCount > 1 ) then
	
		-- ent:SetSkin( math.random(1, self.SkinCount ) )
	
	-- end

    ent.Tower:SetBodygroup(0,math.random(0,1) )
    
	if rand1 == 1 then
		ent.Barrel:SetBodygroup(0,0)
	elseif rand1 == 0 then
		ent.Barrel:SetBodygroup(0,1)
	end
	
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

    if self.Barrel:GetBodygroup(0) == 0 and self.Tower:GetBodygroup(0) == 1 then --Short Short
        self.AmmoTypes = { 
						
						{
							PrintName = "90 mm T15E1 HE",
							Type = "sent_tank_shell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
						{
							PrintName = "90 mm T15E1 AP",
							Type = "sent_tank_apshell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
						--{
						--	PrintName = "High Velocity Armor Piercing Round",
						--	Type = "sent_tank_armorpiercing",
						--	MinDmg = 550,
						--	MaxDmg = 950,
						--	Radius = 128,
						--	Delay = self.APDelay,
						--	Sound = self.ShootSound,
						--}

					
		};    
    elseif self.Barrel:GetBodygroup(0) == 1 and self.Tower:GetBodygroup(0) == 0 then --Long Long
        self.AmmoTypes = { 
						
						{
							PrintName = "76 mm M1A1 HE",
							Type = "sent_tank_shell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
						{
							PrintName = "76 mm M1A1 AP",
							Type = "sent_tank_apshell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
		};
    else --No one matches
           self.AmmoTypes = { 
						
						{
							PrintName = "76 mm M1A1 HE",
							Type = "sent_tank_shell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
						{
							PrintName = "76 mm M1A1 AP",
							Type = "sent_tank_apshell",
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
					}
        -- if ( self.IsDriving && IsValid( self.Pilot ) ) then
            -- self.Pilot:PrintMessage( HUD_PRINTCENTER, "Gun and turret don't match" )
        -- end
        -- self:TankExitVehicle()
    end
	self:TankDefaultUse( ply, caller )
	
end

function ENT:Think()

	self:TankDefaultThink()
    
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

