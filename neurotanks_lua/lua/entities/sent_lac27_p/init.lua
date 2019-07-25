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
 
    -- rand2 = math.random(0,3)
    -- ent.Barrel:SetBodygroup(0,rand2)
    
	return ent
	
end


function ENT:Initialize()

	self.AmmoIndex = 1
		self.AmmoTypes = 
	{
		{
			PrintName = ".50 Cal Auto",
			Type = "sent_tank_mgbullet",
			Delay = self.PrimaryDelay,
			Sound = Sound("bf4/misc/mg_fire.wav"),
			MinDmg = self.MinDamage,
			MaxDmg = self.MaxDamage,
			Radius = self.BlastRadius,
			BulletCount = 1,
			TraceRounds = 1,
			Tracer = "tracer",
			Muzzle = "mg_muzzleflash",
			BulletHose = true,
		};
	}
	
	
	self:TanksDefaultInit()
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 50000000000 )
	
	self:StartMotionController()

	local props = {
	{ "models/killstr3aks/wot/american/skirts_body.mdl", Vector( 0,0, 0 ), false };
	{ "models/killstr3aks/wot/american/cockpit_l_body.mdl", Vector( 0,0, 0 ), true };
	{ "models/killstr3aks/wot/american/cockpit_r_body.mdl", Vector( 0,0, 0 ), true };
	{ "models/killstr3aks/wot/american/engines_body.mdl", Vector( 0,0, 0 ), true };
	{ "models/killstr3aks/wot/american/ramp_body.mdl", Vector( 442,0, 57.0 ), false, Angle( 15, 0, 0 ) };
	
	}
	
	-- local 
	self.Stuff = {}
	
	for k,v in ipairs( props ) do
		
		
		local e = ents.Create("prop_physics")
		e:SetPos( self:LocalToWorld( v[2] ) )
		if( v[4] ) then
		
			e:SetAngles( self:GetAngles() + v[4] )
		
		else
		
			e:SetAngles( self:GetAngles() )
			
		end
		e:SetModel( v[1] )
		e:Spawn()
		e:GetPhysicsObject():SetMass( 10 )
		e:GetPhysicsObject():SetBuoyancyRatio( self.FloatRatio ) 
		if ( !v[3] ) then
			e:SetParent( self )
		end
		
		table.insert( self.Stuff, e )
		
		self:DeleteOnRemove( e )
		-- e:GetPhysicsObject():SetBuoyancyRatio( self.FloatRatio ) 
		-- push this to the next frame to that e is valid. 
		timer.Simple( 0, function()
			if( IsValid( e ) ) then
				
				constraint.Weld( self, e, 0, 0, 0, true, false )
				constraint.Keepupright( e, Angle( 0,0,0 ), 0, 25.92 )
			end
			
		end )

	end
	
	for k=1,#self.Stuff  do
		
		local e = self.Stuff[k]
		local b = self.Stuff[#self.Stuff+1 - k]
		timer.Simple( 0, function()
			if( IsValid( v ) ) then
				
				constraint.Weld( self, e, 0, 0, 0, true, false )
				constraint.Weld( b, e, 0, 0, 0, true, false )
				
			end
			
		end )
			
	end
	
	self.Skirts = self.Stuff[1] -- bad solution
	
	-- timer.Simple( 5,
	-- function()
		
		-- if( IsValid( self ) ) then
			
			-- print( )
			
		-- end
		
	-- end )
	
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

   	-- self.AmmoTypes = self.BodygroupAmmo[self.Barrel:GetBodygroup(0)+1] -- Since Luas first table index is 1 and bodygroups use 0 we add one
	
	self:TankDefaultUse( ply, caller )
	if( self:WaterLevel() == 0 ) then
	
		timer.Simple( self.StartupDelay or 1, function()
			if( IsValid( self ) ) then
			
				self:GetPhysicsObject():SetVelocity( self:GetUp() * 300 )
				
			end
			
		end )
		
	end
	
	for k,v in pairs( self.Stuff ) do
	
		if( IsValid( v ) && v:GetPhysicsObject() ) then
			
			v:GetPhysicsObject():Wake()
		
		end
	end
	
	self.PhysObj:Wake()
	
	
end

function ENT:Think()

	self:TankDefaultThink()
	-- Make sure you get the right ammo post-barrelchange
	self:NextThink( CurTime() )
	
	return true
	
end
	
function ENT:PhysicsUpdate()
	
	-- self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 200000 + self:GetRight() * 45500 )
	if( self.HasTower ) then
	
		self:TankTowerRotation()
	
	else
		
		self:TankNoTowerRotation()
	
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end

