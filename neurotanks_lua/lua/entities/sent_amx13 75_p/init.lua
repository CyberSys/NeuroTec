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
	
		ent:SetSkin( math.random(0, self.SkinCount ) )
	
	end

	local rand2 = math.random(0,4)

	ent.Barrel:SetBodygroup( 0, rand2)


	return ent
	
end


function ENT:Initialize()

	self.AmmoIndex = 1
	self:TanksDefaultInit()
    self.Tower:SetBodygroup(0,0)
    
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 5000000 )
	
	self:StartMotionController()
	self.BodygroupAmmo = 
	{
		{ 	-- First Body group loadout
			{
				PrintName = "75 mm SA50 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "75 mm SA50 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
		{	-- Second boydgroup loadout
			{
				PrintName = "76 mm Gun T185 AP",
				Type = "sent_tank_apshell",
				Delay = self.APDelay,
				Sound = self.ShootSound,
			};
			{
				PrintName = "76 mm Gun T185 HE",
				Type = "sent_tank_shell",
				Delay = self.PrimaryDelay,
				Sound = self.ShootSound,
			};
		};
	}
						
						
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

	-- for k,v in pairs( self:GetTable() ) do 
		-- if type(v) == "table" then
			-- PrintTable()
		-- print("tank[tankName]["..k.."] = ",v)
	-- end

	-- for k,v in ipairs(self:GetTable()) do
		-- print("tank[tankName]["..k.."] = "..v)
	-- end
    self.AmmoTypes = self.BodygroupAmmo[ self.Barrel:GetBodygroup(0) + 1 ] -- Since Luas first table index is 1 and bodygroups use 0 we add one
	self:TankDefaultUse( ply, caller )
	
end

function ENT:Think()

	self:TankDefaultThink()
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

