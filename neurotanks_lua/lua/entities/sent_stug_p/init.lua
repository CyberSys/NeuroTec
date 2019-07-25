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

	
	-- if( self.SkinCount && self.SkinCount > 1 ) then
	
		-- ent:SetSkin( math.random(1, self.SkinCount ) )
	
	-- end

	return ent
	
end


function ENT:Initialize()
	
	-- local rnd = math.random(0,1)
	-- sideskirts, more armor on side
	-- if( rnd == 1 ) then
	
		-- self.ArmorThicknessFront = 0.22
		-- self.ArmorThicknessRear = 0.25
		-- self.ArmorThicknessSide = 0.27
	
	-- end
    
	-- self:SetBodygroup( 1, 0 )
	
   self.AmmoStructure = { 
						{
							Barrel = 0,
							Tower = 0,
							BarrelPos = Vector( 20, -8, 61  ),
							Ammo = {
										
										{
											PrintName = "7,5 cm StuK 40 L/43",
											Type = "sent_tank_apshell",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage,
											Radius = 10,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};

									};
						};
						{
							Barrel = 1,
							Tower = 0,
							BarrelPos = Vector( 20, -8, 57  ),
							Ammo = {
										{
											PrintName = "7,5 cm PaK 39 L/48",
											Type = "sent_tank_apshell",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage*1.25,
											Radius = 10,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};

									};
						};	
						{
							Barrel = 2,
							Tower = 0,
							BarrelPos = Vector( 20, -8, 57  ),
							Ammo = {
										
										{
											PrintName = "7,5 cm PaK 39 L/48",
											Type = "sent_tank_apshell",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage*1.55,
											Radius = 10,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};

									};
						};	
						{
							Barrel = 3,
							Tower = 0,
							BarrelPos = Vector( 20, -8, 57  ),
							Ammo = {
										
										{
											PrintName = "7,5 cm PaK 39 L/48",
											Type = "sent_tank_apshell",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage*1.75,
											Radius = 10,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};

									};
						};	
						{
							Barrel = 4,
							Tower = 0,
							BarrelPos = Vector( 20, -8, 57 ),
							Ammo = {
										
										{
											PrintName = "10,5 cm StuH 42 L/28",
											Type = "sent_tank_apshell",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage*1.79,
											Radius = 10,
											Delay = self.PrimaryDelay,
											Sound = self.ShootSound,
										};

									};
						};	
						{
							Barrel = 5,
							Tower = 0,
							BarrelPos = Vector( 21, -8, 57  ),
							Ammo = {
										
										{
											PrintName = "7,5 cm PaK 42 L/70",
											Type = "sent_tank_apshell",
											MinDmg = self.MinDamage,
											MaxDmg = self.MaxDamage*1.9,
											Radius = 10,
											Delay = self.PrimaryDelay,
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

    self.AmmoTypes = { 
                    
                    {
                        PrintName = "75mm Pak 40 L/46",
                        Type = "sent_tank_apshell",
                        MinDmg = self.MinDamage,
                        MaxDmg = self.MaxDamage,
                        Radius = self.BlastRadius,
                        Delay = self.PrimaryDelay,
                        Sound = self.ShootSound,
                    };
                    {
                        PrintName = "75mm Pak 40 L/46",
                        Type = "sent_tank_armorpiercing",
                        MinDmg = self.MinDamage,
                        MaxDmg = self.MaxDamage,
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

