AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( self.FolderName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()

    
	if( self.SkinCount && self.SkinCount > 1 ) then
	
		ent:SetSkin( math.random(1, self.SkinCount ) )
	
	end

	return ent
	
end


function ENT:Initialize()
	self.AmmoIndex = 1
               
	self:TanksDefaultInit()

    -- self.Tower:SetBodygroup(0,0)
    -- self.Barrel:SetBodygroup(4)
    
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 5000000 )
	
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

    self.AmmoTypes = { 
                    
                    {
                        PrintName = "75mm Pak 40 L/46",
                        Type = "sent_tank_apshell",
                        MinDmg = 500,
                        MaxDmg = 900,
                        Radius = self.BlastRadius,
                        Delay = self.PrimaryDelay,
                        Sound = self.ShootSound,
                    };
                    {
                        PrintName = "75mm Pak 40 L/46",
                        Type = "sent_tank_armorpiercing",
                        MinDmg = 400,
                        MaxDmg = 800,
                        Radius = self.BlastRadius,
                        Delay = self.PrimaryDelay,
                        Sound = self.ShootSound,
                    }

                
                };

	self:TankDefaultUse( ply, caller )
	
end

function ENT:Think()

	self:TankDefaultThink()

	self:NextThink( CurTime() )
	
	return true
	
end
	
function ENT:PhysicsUpdate()
	
	-- if( self.HasTower ) then
	
		-- self:TankTowerRotation()
	
	-- else
		
		self:TankNoTowerRotation()
	
	-- end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end

