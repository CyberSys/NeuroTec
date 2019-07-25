AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sound = "weapons/ar2/npc_ar2_altfire.wav"//"bf2/weapons/m249_fire.wav"//"weapons/shotgun/shotgun_dbl_fire7.wav"
ENT.Destroyed = false
ENT.Burning = false
ENT.DeathTimer = 0
ENT.MaxDamage = 20
ENT.MinDamage = 10
ENT.BlastRadius = 666
ENT.InitialHealth = 500
ENT.HealthVal = nil
ENT.canfire = true
ENT.Commander = NULL
function ENT:SpawnFunction( ply, tr)
	

	local SpawnPos = tr.HitPos + Vector(0,0,100)
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "ai_su08" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	timer.Simple( 2.0, function()	
		if !IsValid(ent.Commander) then
			ent.Commander = ply
			ply:PrintMessage( HUD_PRINTTALK, "The CYKA-08 SPG is waiting for your orders" )
			ply:SetNetworkedEntity("Ai_SU8", ent)	
		end
	end,ent)
	
	ply:Give( "targetdesignator" )
	ply:SelectWeapon( "targetdesignator" )
	
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
				
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self.PhysObj = self:GetPhysicsObject()
	self.LastReminder = CurTime()
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self.Firemode = false
	self.IsFlying = false // Prevent physgunning
	
	self.Gibs = { "models/aftokinito/wot/russian/su-08_turret.mdl", "models/aftokinito/wot/russian/su-08_gun.mdl" }
	self.GibsPos = { Vector( -31, 0, 65 ), Vector( -41, 0, 87 ) }
	
	self.Turret = ents.Create("prop_physics_override")
	self.Turret:SetModel( "models/aftokinito/wot/russian/su-08_turret.mdl")
	self.Turret:SetPos(self:GetPos() + self:GetForward() * -31 + self:GetUp() * 65 )
	self.Turret:SetParent( self )
	self.Turret:SetAngles( self:GetAngles() )
	self.Turret:Spawn()

	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( "models/aftokinito/wot/russian/su-08_gun.mdl" )
	self.Weapon:SetPos(self:GetPos() + self:GetForward() * -41 + self:GetUp() * 87 )
	self.Weapon:SetParent( self.Turret )
	self.Weapon:SetAngles( self:GetAngles() +Angle(-45,0,0) )
	self.Weapon:Spawn()

	self.Wheel = {}
	self.WheelPos = self.WheelPositions
	
	for i=1,#self.WheelPos do
	self.Wheel[i] = ents.Create("prop_physics_override")
	self.Wheel[i]:SetModel( self.TrackWheels[i] )
	self.Wheel[i]:SetPos(self:GetPos() + self:GetForward()*self.WheelPos[i].x + self:GetRight()*self.WheelPos[i].y + self:GetUp()*self.WheelPos[i].z)
	self.Wheel[i]:SetAngles( self:GetAngles() )
	self.Wheel[i]:Spawn()		

	if ( self.Wheel[i]:GetPhysicsObject():IsValid() ) then	
		self.Wheel[i]:GetPhysicsObject():Wake()		
		self.Wheel[i]:GetPhysicsObject():SetMass(50)
	end
	constraint.NoCollide( self.Wheel[i], self, 0, 0 )
	constraint.NoCollide( self.Wheel[i], self.Turret, 0, 0 )
	constraint.NoCollide( self.Wheel[i], self.Weapon, 0, 0 )
	constraint.Weld( self.Wheel[i], self, 0, 0, 0, true, false )
	end
	
	self.Track= {}
	for i=1,#self.TrackModels do
		self.Track[i] = ents.Create("prop_physics_override")
		self.Track[i]:SetModel(self.TrackModels[i])
		self.Track[i]:SetPos(self:GetPos() + self:GetForward()*self.TrackOffset.x + self:GetRight()*self.TrackOffset.y + self:GetUp()*self.TrackOffset.z)
		self.Track[i]:SetAngles( self:GetAngles() )
		self.Track[i]:Spawn()

		if ( self.Track[i]:GetPhysicsObject():IsValid() ) then	
			self.Track[i]:GetPhysicsObject():Wake()		
		self.Track[i]:GetPhysicsObject():SetMass(1000)
		end
		constraint.Weld( self.Track[i], self, 0, 0, 0, true, false )
		constraint.NoCollide( self.Track[i], self, 0, 0 )
		constraint.NoCollide( self.Track[i], self.Turret, 0, 0 )
		constraint.NoCollide( self.Track[i], self.Weapon, 0, 0 )	
	end
		
	constraint.NoCollide( self.Turret, self, 0, 0 )
	constraint.NoCollide( self.Turret, self.Weapon, 0, 0 )
	constraint.NoCollide( self.Weapon, self, 0, 0 )
	constraint.NoCollide( self.Weapon, self.Turret, 0, 0 )

	local seed = math.random( 0, 1000 )
	self.guid = tostring( CurTime() - seed )..self:EntIndex( )
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
	self.PhysObj:SetMass(100)
		
	end
		
	self.Owner = self
	
	self:SetPhysicsAttacker(self.Owner)

 	self:StartMotionController()

end

local function apr(a,b,c)
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end

function ENT:LerpAim(Target)

	if ( !IsValid( Target ) ) then

		return

	end
	
local theta = self:Targetting(Target)
	local pos = Target:GetPos() + Target:OBBCenter() + Vector(0,0,10000)

	local mp = self.Weapon:GetPos()
	
	local dir = ( pos - mp ):Angle()
	local a = self.Weapon:GetAngles()
	local b = self.Turret:GetAngles()
	
	-- a.p, a.r= apr( a.p, dir.p, 8.5 ),apr( a.r, dir.r, 8.5 )
	a.p, a.r= apr( a.p, dir.p, 8.5 ),apr( a.r, dir.r, 8.5 )
	b.y = apr( b.y, dir.y, 14.5 )
	
	self.Weapon:SetAngles( LerpAngle( 0.009, a, self.Weapon:GetAngles() ) )
	self.Turret:SetAngles( LerpAngle( 0.009, b, self.Turret:GetAngles() ) )	
	
end

function ENT:Targetting(Target)

	local pos = Target:GetPos() + Target:OBBCenter() + Vector(0,0,10000)
	local mp = self.Weapon:GetPos()
	
	local dir = ( pos - mp ):Angle()
	local a = self.Weapon:GetAngles()
	local b = self.Turret:GetAngles()

	self:BallisticTargetting(Target)
	local T = self:BallisticCalculation(Target:GetPos())
	-- local theta = self:GetNetworkedFloat( "LaunchAngle" )
	local theta = T

	a.r= b.r
	a.p = apr( a.p, theta, 1.45 )
	b.y = apr( b.y, dir.y, 1.45 )

	self.Weapon:SetAngles( LerpAngle( 0.002, a, self.Weapon:GetAngles() ) )
	self.Turret:SetAngles( LerpAngle( 0.002, b, self.Turret:GetAngles() ) )	

	-- print(T)
	-- return theta
end

function ENT:ArtilleryBarrage()

	local Shell = ents.Create( self.PrimaryAmmo )
	Shell:SetPos( self.Weapon:GetPos() + self.Weapon:GetForward() * self.BarrelLength ) 				
	Shell:SetAngles( self.Weapon:GetAngles() + Angle( math.Rand( -.1,.1 ), math.Rand( -.1,.1 ), math.Rand( -.1,.1 ) ) )
	Shell.Owner = self.Pilot
	Shell:SetOwner( self.Pilot )
	Shell:SetPhysicsAttacker( self.Pilot )
	Shell.Creditor = self      

	Shell:Spawn()
	Shell:Activate()
	Shell:GetPhysicsObject():Wake()		
	constraint.NoCollide( Shell, self, 0, 0)	
	constraint.NoCollide( Shell, self.Weapon, 0, 0)	
	Shell:GetPhysicsObject():SetVelocityInstantaneous( Shell:GetForward() * AMMO_VELOCITY_aRTILLERY_SHELL )
	Shell:GetPhysicsObject():EnableDrag( false )

		
	if( self.IsOnGround && GetConVarNumber("tank_dusteffects", 0 ) > 0 && !self.NoDust ) then			
			-- print( self.PrimaryDelay, "delay" )			
			local dustwaves,dustradius
			if (self.PrimaryDelay >=1) then	dustwaves=10 elseif (self.PrimaryDelay >=4) then dustwaves=50 else dustwaves=1 end
			if (self.PrimaryDelay >=4) then dustradius=100 else dustradius=0 end			
			for i=1,dustwaves do		
				local fx = EffectData()
				fx:SetStart( self:GetPos() )
				fx:SetOrigin( self:GetPos() + 10*Vector( math.random(-10,10),math.random(-10,10), 1 ) )
				fx:SetNormal( self:GetUp() )
				fx:SetMagnitude( 1 )
				fx:SetScale( 200.0+dustradius)
				fx:SetRadius( 300 )
				util.Effect( "ThumperDust", fx )			
			end	
	end
-- print("Artillery airstrike incoming!")

/*
	local shell = ents.Create("sent_ballistic_missile")
	if IsValid(self.Target) then
	shell.ImpactPoint = self.Target:GetPos()
	else
	shell.ImpactPoint = self:GetPos() + self.Weapon:GetForward()*10000
	end
	shell:SetModel( "models/military2/missile/missile_patriot.mdl" )
	shell:SetPos( self.Weapon:GetPos() + self.Weapon:GetForward() * 140 + self.Weapon:GetRight() * 23 + self.Weapon:GetUp() * 82)

	shell:SetAngles( self.Weapon:GetAngles() )
	shell:SetOwner( self )
	shell.Owner = self.Owner
	self:EmitSound("weapons/missile_launch.wav")
	timer.Simple( 0.25, function() 
	shell:Spawn() 
	ParticleEffect("arty_muzzleflash", self.Weapon:GetPos() + self.Weapon:GetForward() * 150, self.Weapon:GetAngles() + Angle(180,0,0), self.Weapon )	
	end,self)
*/	
end

function ENT:PhysicsUpdate()
		
	if IsValid(self.Taget) then
			local TargetPos = self.Target:GetPos()
			local ta = ( self:GetPos() - TargetPos ):Angle()
			local ma = self:GetAngles()
			local offs = self:VecAngD( ma.y, ta.y )

			local TargetAngle = -offs + 180
	if IsValid(self.Weapon) then
			local ang = self.Weapon:GetAngles()
			ang:RotateAroundAxis( self:GetUp(), LerpAngle( 0.1, self.Weapon:GetAngles(), TargetAngle ) )
	end
	end
	
	
end
function ENT:TrackingTarget()
	if( IsValid( self.Target ) ) then 		
		self:Targetting( self.Target )		
		if( self.Target.Destroyed ) then			
			self.Target = NULL			
			return			
		end				
	end

end

function ENT:Use(ply,caller)
	if !IsValid(self.Commander) then
		self.Commander = ply
		ply:PrintMessage( HUD_PRINTTALK, "Authorized to fire" )
		ply:SetNetworkedEntity("Ai_pac3", self)
		return
	else
		if (self.Commander != ply) then
			self.Commander = ply
			ply:PrintMessage( HUD_PRINTTALK, "New user authorized to fire" )
		end
	end	
end

function ENT:Think()
	
	self:NextThink(CurTime())
//	self.Owner = self
	self.Turret:SetSkin( self:GetSkin() )
	self.Weapon:SetSkin( self:GetSkin() )
		
	if ( self.Destroyed ) then 

		self.Target = NULL
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
	end
		
	if self.DeathTimer > 35 then
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() )
		util.Effect( "Airstrike_explosion", effectdata )
		
		self:Remove()
		
		return
		
	end

	if( !IsValid( self.Target )) then
		if IsValid( self.Commander ) then
		self.Target = self.Commander:GetNetworkedEntity("Target")
		self:SetNetworkedEntity("Target", self.Target)
		end
	else
		
		if self.Commander:GetNetworkedBool("TrackTarget", false) then
		self:TrackingTarget()
		else
		
		end
		
		// basic line of sight
		local tr, trace = {},{}
		tr.start = self.Weapon:GetPos()
		tr.endpos = self.Target:GetPos()
		tr.filter = self
		trace = util.TraceLine( tr )
	
		if ( self.canfire && !self.Target.Destroyed && trace.Hit && trace.Entity == self.Target ) then			
			self:ArtilleryBarrage()
			self.canfire = false
			-- timer.Simple( 3.0,reload,self)		   
			timer.Simple( self.PrimaryDelay, function() self.canfire = true end,self)
		end
		
		if (self.canfire && self.Commander:GetNetworkedBool("DestroyTarget") ) then		
			self:ArtilleryBarrage()
			self.canfire = false
			-- timer.Simple( math.random(5.0,6.0),reload,self)
			-- timer.Simple( 1.0,reload,self)		   
			timer.Simple( self.PrimaryDelay, function() self.canfire = true end,self)
		end

	end
	
end

function ENT:reload()
	 
	if( !IsValid( self ) ) then return end
	
	self.canfire = true
	self:EmitSound( "wot/chatillon/reload.wav", 511, math.random( 90, 100 ) )
	
 end

function ENT:OnTakeDamage(dmginfo)
	
	local dt = dmginfo:GetDamageType()
	
	if( ( bit.bor( dt, DMG_BLAST_SURFACE ) == DMG_BLAST_SURFACE ) || ( bit.bor(dt, DMG_BLAST )  == DMG_BLAST ) || ( bit.bor( dt, DMG_BURN ) == DMG_BURN  ) ) then 
		// Nothing, these can hurt us
	else
	
		local atk = dmginfo:GetAttacker()
		local infomessage = "This vehicle can only be damaged by armor piercing rounds and explosives!"
		
		if( self.LastReminder + 3 <= CurTime() && atk:IsPlayer() ) then
			
			self.LastReminder = CurTime()
			atk:PrintMessage( HUD_PRINTCENTER, infomessage )

		end
		
		return
		
	end
	
	self:TakePhysicsDamage( dmginfo )
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	
	self:SetNetworkedInt( "health" , self.HealthVal )
	
	if( self.HealthVal < 100 ) then
		
		self.Destroyed = true
		
	end
	
	if ( self.HealthVal < 10 ) then
		
		local deathsound = {}
		deathsound[1] = "IL-2/expl_cb_1_79_1.wav"
		deathsound[2] = "IL-2/expl_cb_1_79_2.wav"
		deathsound[3] = "IL-2/expl_cb_1_79_3.wav"
		self:EmitSound( deathsound[math.random(1,3)], 511, math.random(110,117) )
		
		self:ExplosionImproved()
		self:Remove()
		

	end
	
end

function ENT:OnRemove()
	
	if( self.Destroyed ) then
		
		for i=1,#self.Gibs do
			
			local gib = ents.Create("prop_physics")
			gib:SetPos( self:LocalToWorld( self.GibsPos[i] ) )
			gib:SetModel( self.Gibs[i] )
			gib:SetAngles( self:GetAngles() )
			gib:Spawn()
			gib:GetPhysicsObject():ApplyForceCenter( Vector( math.random( -500, 500 ), math.random( -500, 500 ), math.random( -500, 500 ) ) )
			gib:Fire("kill","",math.random(10,15))
			gib:Ignite( 60,60 )
			
		end
		
		
	end
	
	for i=1,#self.Wheel do
	self.Wheel[i]:Remove()
	end
	for i=1,#self.Track do
	self.Track[i]:Remove()
	end
	
	self.Commander:SetNetworkedEntity("Ai_pac3", NULL )
	self:Remove()

end

