AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Model = "models/pla/mim-104f patriot_platform.mdl"
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
	local ent = ents.Create( "ai_pac3" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	timer.Simple( 2.0, function()	
		if !IsValid(ent.Commander) then
			ent.Commander = ply
			ply:PrintMessage( HUD_PRINTTALK, "The Patriot launcher is waiting for your orders" )
			ply:SetNetworkedEntity("Ai_pac3", ent)	
		end
	end,ent)
	
	ply:Give( "targetdesignator" )
	ply:SelectWeapon( "targetdesignator" )
	
	return ent
	
end

function ENT:Initialize()

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
	
	self.Gibs = { "models/pla/mim-104f patriot_turret.mdl", "models/pla/mim-104f patriot_launcher.mdl", "models/pla/mim-104f patriot_platform.mdl" }
	self.GibsPos = { Vector( 0, -141, -15 ), Vector( -154, 0, 0 ), Vector( 0,0,0 ) }
	
	self.Turret = ents.Create("prop_physics_override")
	self.Turret:SetModel( "models/pla/mim-104f patriot_turret.mdl")
	self.Turret:SetPos(self:GetPos() + self:GetForward() * -141 + self:GetUp() * -15)
	self.Turret:SetParent( self )
	self.Turret:SetAngles( self:GetAngles() )
	self.Turret:Spawn()

	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( "models/pla/mim-104f patriot_launcher.mdl" )
	self.Weapon:SetPos(self:GetPos() + self:GetForward() * -154 )
	self.Weapon:SetParent( self.Turret )
	self.Weapon:SetAngles( self:GetAngles() +Angle(-45,0,0) )
	self.Weapon:Spawn()

	self.Wheel = {}
	self.WheelPos = {Vector(-92,-44,-59),Vector(-153,-44,-59),Vector(-99,44,-59),Vector(-153,44,-59)}
	
	for i=1,#self.WheelPos do
	self.Wheel[i] = ents.Create("prop_physics_override")
	self.Wheel[i]:SetModel( "models/pla/mim-104f patriot_wheel.mdl" )
	self.Wheel[i]:SetPos(self:GetPos() + self:GetForward()*self.WheelPos[i].x + self:GetRight()*self.WheelPos[i].y + self:GetUp()*self.WheelPos[i].z)
	if i<3 then	self.Wheel[i]:SetAngles( self:GetAngles() +Angle(0,90,0) ) else self.Wheel[i]:SetAngles( self:GetAngles() +Angle(0,-90,0) )	end
	self.Wheel[i]:Spawn()		

	if ( self.Wheel[i]:GetPhysicsObject():IsValid() ) then	
		self.Wheel[i]:GetPhysicsObject():Wake()		
		self.Wheel[i]:GetPhysicsObject():SetMass(50)
	end
	constraint.NoCollide( self.Wheel[i], self, 0, 0 )
	constraint.NoCollide( self.Wheel[i], self.Turret, 0, 0 )
	constraint.NoCollide( self.Wheel[i], self.Weapon, 0, 0 )
	constraint.Axis( self.Wheel[i], self, 0, 0, Vector(100,0,0), Vector(0,0,0), 0, 0, 0 , 0 , self:GetRight(), false )
	end
	
	self.RightLeg= {}
	self.RightLegPos = {Vector(68,38,-30),Vector(-205,57,-30)}	
	for i=1,#self.RightLegPos do
		self.RightLeg[i] = ents.Create("prop_physics_override")
		self.RightLeg[i]:SetModel( "models/pla/mim-104f patriot_rightleg.mdl")
		self.RightLeg[i]:SetPos(self:GetPos() + self:GetForward()*self.RightLegPos[i].x + self:GetRight()*self.RightLegPos[i].y + self:GetUp()*self.RightLegPos[i].z)
		self.RightLeg[i]:SetAngles( self:GetAngles() + Angle(0,0,-15))
		self.RightLeg[i]:Spawn()
		
		if ( self.RightLeg[i]:GetPhysicsObject():IsValid() ) then	
			self.RightLeg[i]:GetPhysicsObject():Wake()		
		self.RightLeg[i]:GetPhysicsObject():SetMass(100)
		end
		constraint.Axis( self.RightLeg[i], self, 0, 0, Vector(100,0,0), Vector(0,0,0), 0, 0, 0 , 0 , self:GetForward(), false )
		constraint.Weld( self.RightLeg[i], self, 0, 0, 0, true, false )
		constraint.NoCollide( self.RightLeg[i], self, 0, 0 )
		constraint.NoCollide( self.RightLeg[i], self.Turret, 0, 0 )
		constraint.NoCollide( self.RightLeg[i], self.Weapon, 0, 0 )	
	end
	
	self.LeftLeg= {}
	self.LeftLegPos = {Vector(68,-38,-26),Vector(-205,-56,-26)}	
	for i=1,#self.LeftLegPos do
		self.LeftLeg[i] = ents.Create("prop_physics_override")
		self.LeftLeg[i]:SetModel( "models/pla/mim-104f patriot_LeftLeg.mdl")
		self.LeftLeg[i]:SetPos(self:GetPos() + self:GetForward()*self.LeftLegPos[i].x + self:GetRight()*self.LeftLegPos[i].y + self:GetUp()*self.LeftLegPos[i].z)
		self.LeftLeg[i]:SetAngles( self:GetAngles() + Angle(0,0,10) )
		self.LeftLeg[i]:Spawn()

		if ( self.LeftLeg[i]:GetPhysicsObject():IsValid() ) then	
			self.LeftLeg[i]:GetPhysicsObject():Wake()		
		self.LeftLeg[i]:GetPhysicsObject():SetMass(100)
		end
		constraint.Axis( self.LeftLeg[i], self, 0, 0, Vector(100,0,0), Vector(0,0,0), 0, 0, 0 , 0 , self:GetForward(), false )
		constraint.Weld( self.LeftLeg[i], self, 0, 0, 0, true, false )
		constraint.NoCollide( self.LeftLeg[i], self, 0, 0 )
		constraint.NoCollide( self.LeftLeg[i], self.Turret, 0, 0 )
		constraint.NoCollide( self.LeftLeg[i], self.Weapon, 0, 0 )	
	end

	self.TowProp = ents.Create("prop_physics_override")
	self.TowProp:SetModel( "models/props_junk/PropaneCanister001a.mdl")
	self.TowProp:SetPos(self:GetPos() + self:GetForward()*194.5 + self:GetUp()*-25)
	self.TowProp:SetAngles( self:GetAngles() )
	self.TowProp:Spawn()
	self.TowProp:SetColor(Color(0,0,0,255))

	if ( self.TowProp:GetPhysicsObject():IsValid() ) then	
		self.TowProp:GetPhysicsObject():Wake()		
	self.TowProp:GetPhysicsObject():SetMass(100)
	end
	constraint.Weld( self, self.TowProp, 0, 0, 0, true, true )
	constraint.NoCollide( self.TowProp, self, 0, 0 )
	constraint.NoCollide( self.TowProp, self.Turret, 0, 0 )
	constraint.NoCollide( self.TowProp, self.Weapon, 0, 0 )

	
	constraint.NoCollide( self.Turret, self, 0, 0 )
	constraint.NoCollide( self.Turret, self.Weapon, 0, 0 )
	constraint.NoCollide( self.Weapon, self, 0, 0 )
	constraint.NoCollide( self.Weapon, self.Turret, 0, 0 )
	constraint.Elastic( self.Weapon, self.Turret, 0, 0, Vector(155,-15,20), Vector(-0,-15,0), 100, 1000000, 0, "models/pla/mIM-104F Patriot/PAC3_launcher", 4, false )
	constraint.Elastic( self.Weapon, self.Turret, 0, 0, Vector(155,15,20), Vector(-0,15,0), 100, 1000000, 0, "models/pla/mIM-104F Patriot/PAC3_launcher", 4, false )
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
	local theta = self:GetNetworkedFloat( "LaunchAngle" )

	a.r= b.r
	a.p = apr( a.p, theta, 1.45 )
	b.y = apr( b.y, dir.y, 1.45 )

	self.Weapon:SetAngles( LerpAngle( 0.042, a, self.Weapon:GetAngles() ) )
	self.Turret:SetAngles( LerpAngle( 0.042, b, self.Turret:GetAngles() ) )	

end

function ENT:FireMissile()

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
			self:FireMissile()
			self.canfire = false
			-- timer.Simple( 3.0,reload,self)		   
			timer.Simple( self.PrimaryDelay, function() self.canfire = true end,self)
		end
		
		if (self.canfire && self.Commander:GetNetworkedBool("DestroyTarget") ) then		
			self:FireMissile()
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
	for i=1,#self.RightLeg do
	self.RightLeg[i]:Remove()
	end
	for i=1,#self.LeftLeg do
	self.LeftLeg[i]:Remove()
	end
	self.TowProp:Remove()
	
	self.Commander:SetNetworkedEntity("Ai_pac3", NULL )
	self:Remove()

end

