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

    
	if( self.SkinCount && self.SkinCount > 1 ) then
	
		ent:SetSkin( math.random(1, self.SkinCount ) )
	
	end
	
	local rand = math.random(0,1)
	ent.Barrel:SetBodygroup(0,rand)
	
	return ent
	
end


function ENT:Initialize()
     
    self.AmmoTypes = { 
                    
                    {
                        PrintName = "122 mm howitzer A-19 HE",
                        Type = "sent_artillery_shell",
                        MinDmg = self.MinDamage,
                        MaxDmg = self.MaxDamage,
                        Radius = self.BlastRadius,
                        Delay = self.PrimaryDelay,
                        Sound = self.ShootSound,
						
                    };

                
                };
self.AmmoStructure = {
						{  
							Tower = 0,
							Barrel = 0, 
							Ammo = {										
								{
									PrintName = "122 mm howitzer A-19 HE",
									Type = "sent_artillery_shell",
									MinDmg = self.MinDamage,
									MaxDmg = self.MaxDamage,
									Radius = self.BlastRadius,
									Delay = self.PrimaryDelay,
									Sound = self.ShootSound,
								};
							};
						};
						{
							Tower = 0,
							Barrel = 1, 
							Ammo = {											
								{
									PrintName = "152 mm Howitzer ML-20 mod. 1931 HE",
									Type = "sent_artillery_shell",
									MinDmg = self.MinDamage*2,
									MaxDmg = self.MaxDamage*2,
									Radius = self.BlastRadius*2,
									Delay = self.PrimaryDelay*2,
									Sound = self.ShootSound,
								};
							};
						};
						
					};

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

