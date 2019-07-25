AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, class )

	local SpawnPos = tr.HitPos + tr.HitNormal * 55
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
	
	
	self.AmmoTypes = { 
						{
							PrintName = "30CM MK-12 HURT",
							Type = "sent_artillery_shell",
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = self.BlastRadius,
							Delay = self.PrimaryDelay,
							Sound = Sound("bf2/tanks/d30_artillery_fire.mp3"),
						};
						{
							PrintName = "300MM PAIN",
							Type = "sent_tank_300mm_rocket",
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = self.BlastRadius,
							Delay = self.PrimaryDelay,
							Sound = Sound("bf2/tanks/d30_artillery_fire.mp3"),
						};
						{
							PrintName = "30CM MISERY",
							Type = "sent_tank_38cm_rocket",
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = self.BlastRadius,
							Delay = self.PrimaryDelay,
							Sound = Sound("bf2/tanks/d30_artillery_fire.mp3"),
						};
						{
							PrintName = ".3M DESPAIR",
							Type = "sent_tank_clustershell",
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = self.BlastRadius,
							Delay = self.PrimaryDelay,
							Sound = Sound("bf2/tanks/d30_artillery_fire.mp3"),
						};


					};
	self:TanksDefaultInit()
	self:StartMotionController()
	   local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
	
		phys:Wake()
		phys:SetMass( 500000000000000000000 )
		-- phys:EnableGravity( true )
		-- phys:EnableDrag( false )
	
	end
	
	self.Shake = ents.Create( "env_shake" )
	self.Shake:SetOwner( self.Owner )
	self.Shake:SetPos( self.Entity:GetPos() )
	self.Shake:SetParent( self )
	self.Shake:SetKeyValue( "amplitude", "200" )	-- Power of the shake
	self.Shake:SetKeyValue( "radius", "3500" )	-- Radius of the shake
	self.Shake:SetKeyValue( "duration", "0.3" )	-- Time of shake
	self.Shake:SetKeyValue( "frequency", "255" )	-- How har should the screenshake be
	self.Shake:SetKeyValue( "spawnflags", "4" )	-- Spawnflags( In Air )
	self.Shake:Spawn()
	self.Shake:Activate()
	
	local CIWSpos = {Vector( -650, -44, 712 ),Vector( -650, 44, 712 )}
	for i=1,#CIWSpos do
		
		local phalanx = ents.Create("prop_physics")
		phalanx:SetPos( self:LocalToWorld( CIWSpos[i] ) )
		phalanx:SetAngles( self:GetAngles() + Angle(0,180,0) )
		phalanx:SetModel( "models/ukulele/props_v1_flying_bomb/v1_flying_bomb_ramp.mdl" )
		-- phalanx:SetParent( self )
		phalanx:Spawn()
		phalanx:GetPhysicsObject():SetMass( 500000000 )
	 	phalanx:SetColor( Color( 145,150,145,255) )
		constraint.Weld( self, phalanx,0,0, 0, true, true )
		self:DeleteOnRemove( phalanx )
	end
	-- constraint.Keepupright( self, self.PhysObj:GetAngles(), 0, 5 )
	
	
	self.Tower:SetColor( Color( 145,150,145,255 ) )
	self.Barrel:SetColor( Color( 145,150,145,255 ) )
	-- for i=1,#self.MicroTurrets do
		
		-- local v = self.MicroTurrets[i]
		-- if( IsValid( v ) ) then
			
			-- v:SetColor( Color( 145,150,145,255) )
			-- v.Tower:SetColor( Color( 145,150,145,255) )
			-- v.Barrel:SetColor( Color( 145,150,145,255) )
		
		-- end
		
	-- end
end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime < 0.2 ) then return end
	
	self:TankDefaultCollision( data, physobj )
	
end

function ENT:OnTakeDamage(dmginfo)
	
	self:TankDefaultTakeDamage( dmginfo )
	
end

function ENT:OnRemove()
	
	self:TankExitVehicle()
	self:TankDefaultRemove()
	
end

function ENT:Use(ply,caller)

   	-- self.AmmoTypes = self.BodygroupAmmo[self.Barrel:GetBodygroup(0)+1] -- Since Luas first table index is 1 and bodygroups use 0 we add one
	
	-- for i=1,# do
		
		-- if( i > 2 ) then break end
		-- local v = self.MicroTurrets[i]
		-- if( IsValid( v ) ) then
			
			-- self.MicroTurrets[1]:Use( ply, ply, 0, 0  )
			
		-- end
	
	-- end
	
	self:TankDefaultUse( ply, caller )

	
end

function ENT:Think()

	if( IsValid( self.Pilot ) && self.IsDriving && !self.Destroyed && self.Fuel > 0 ) then
		local fw = self.Pilot:KeyDown( IN_FORWARD ) 
		local rw = self.Pilot:KeyDown( IN_BACK )
		local l = self.Pilot:KeyDown( IN_MOVELEFT )
		local r = self.Pilot:KeyDown( IN_MOVERIGHT )
		
	
		if( fw || rw || l || r ) then
			
			self.Shake:Fire( "StartShake", "", 0 )
		
		end
		
	end
	
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

