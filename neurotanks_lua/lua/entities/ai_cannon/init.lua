AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Model = "models/ranson/ranson_flak18_at_base.mdl"
ENT.Sound = "weapons/ar2/npc_ar2_altfire.wav"//"bf2/weapons/m249_fire.wav"//"weapons/shotgun/shotgun_dbl_fire7.wav"
ENT.Destroyed = false
ENT.Burning = false
ENT.DeathTimer = 0
ENT.MaxDamage = 20
ENT.MinDamage = 10
ENT.BlastRadius = 666
ENT.InitialHealth = 4000
ENT.HealthVal = nil
ENT.canfire = true
ENT.Commander = NULL
function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "ai_cannon" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
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
	self.IsFlying = true // Prevent physgunning
	
	self.Gibs = { "models/ranson/ranson_flak18_at_turret.mdl", "models/ranson/ranson_flak18_at_cannon.mdl", "models/ranson/ranson_flak18_at_base.mdl" }
	self.GibsPos = { Vector( 0, 0, 53 ), Vector( -32, 0, 74 ), Vector( 0,0,0 ) }
	
	self.Turret = ents.Create("prop_physics_override")
	self.Turret:SetModel( "models/ranson/ranson_flak18_at_turret.mdl")
	self.Turret:SetPos(self:GetPos() + self:GetUp() * 53)
	self.Turret:SetParent( self )
	self.Turret:SetAngles( self:GetAngles() )
	self.Turret:Spawn()

	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( "models/ranson/ranson_flak18_at_cannon.mdl" )
	self.Weapon:SetPos(self:GetPos() + self:GetForward() * -32 + self:GetUp() * 74 )
	self.Weapon:SetParent( self.Turret )
	self.Weapon:SetAngles( self:GetAngles() +Angle(-45,0,0) )
	self.Weapon:Spawn()

	constraint.NoCollide( self.Turret, self, 0, 0 )
	constraint.NoCollide( self.Turret, self.Weapon, 0, 0 )
	constraint.NoCollide( self.Weapon, self, 0, 0 )
	constraint.NoCollide( self.Weapon, self.Turret, 0, 0 )

	local seed = math.random( 0, 1000 )
	self.guid = tostring( CurTime() - seed )..self:EntIndex( )
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		
	end
		
	self.Owner = self
	
	self:SetPhysicsAttacker(self.Owner)

	-- self.AmmoIndex = 1
	-- self.AmmoTypes = { 
						
						-- {
							-- PrintName = "8,8 cm FlaK 18 AP",
							-- Type = "sent_tank_apshell",
							-- MinDmg = self.MinDamage,
							-- MaxDmg = self.MaxDamage,
							-- Radius = 10,
							-- Delay = self.PrimaryDelay,
							-- Sound = self.ShootSound,
						-- };
						-- {
							-- PrintName = "8,8 cm FlaK 18 AA",
							-- Type = "sent_tank_flak",
							-- MinDmg = self.MinDamage,
							-- MaxDmg = self.MaxDamage,
							-- Radius = 1024,
							-- Delay = self.PrimaryDelay,
							-- Sound = self.ShootSound,
						-- };                        
						-- {
							-- PrintName = "8,8 cm FlaK 18 HE",
							-- Type = "sent_tank_shell",
							-- MinDmg = self.MinDamage,
							-- MaxDmg = self.MaxDamage,
							-- Radius = self.BlastRadius,
							-- Delay = self.PrimaryDelay,
							-- Sound = self.ShootSound,
						-- };

					
					-- };
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

	-- a.p, a.r= apr( a.p, dir.p, 8.5 ),apr( a.r, dir.r, 8.5 )
	-- a.p, a.r= theta,apr( a.r, dir.r, 8.5 )
	a.p, a.r= theta, b.r
	b.y = apr( b.y, dir.y, 14.5 )

	self.Weapon:SetAngles( LerpAngle( 0.009, a, self.Weapon:GetAngles() ) )
	self.Turret:SetAngles( LerpAngle( 0.009, b, self.Turret:GetAngles() ) )	

end

function ENT:FireFLAK()

	-- local shell = ents.Create("sent_aa_flak_huge")
	local shell = ents.Create("sent_artillery_shell")
	if IsValid(self.Target) then
	shell.ImpactPoint = self.Target:GetPos()
	else
	shell.ImpactPoint = self:GetPos() + self.Weapon:GetForward()*10000
	end
	shell:SetModel( "models/weapons/w_missile_closed.mdl" )
	shell:SetPos( self.Weapon:GetPos() + self.Weapon:GetForward() * 200 )
	-- shell:SetAngles( self.Weapon:GetAngles() + Angle( math.Rand( -2.5,2.5),math.Rand( -2.5,2.5),math.Rand( -2.5,2.5) ) )
	shell:SetAngles( self.Weapon:GetAngles() )
	shell:SetOwner( self.Owner )
	shell.Owner = self
	shell:Spawn()
	-- shell:GetPhysicsObject():ApplyForceCenter( shell:GetForward() * 950000 )
	
	local LaunchVel = 	self:GetNetworkedFloat( "LaunchVelocity", 3000 )
	-- print("Launchvel = "..LaunchVel)
	shell:GetPhysicsObject():SetVelocity( shell:GetForward() * LaunchVel )
 
	
--	self:EmitSound( "weapons/mortar/mortar_fire1.wav", 511, math.random(110,117) )
	local FlakSound = {}
	FlakSound[1] = "IL-2/gun_big_02.wav"
	FlakSound[2] = "IL-2/gun_big_04.wav"
	FlakSound[3] = "IL-2/gun_big_06.wav"
	FlakSound[4] = "IL-2/gun_big_07.wav"
	self:EmitSound( FlakSound[math.random(1,4)], 511, math.random(110,117) )

	local cartridge = ents.Create("prop_physics")
//	cartridge:SetPos( self:GetPos() + Vector(-52, 8, 78) )
	cartridge:SetPos( self.Weapon:GetPos() + Vector(-20, 18, 4) )
	cartridge:SetAngles(self.Weapon:GetAngles())
	cartridge:SetModel( "models/155Cartridge/cartridge.mdl" ) 
	cartridge:Spawn()
	cartridge:GetPhysicsObject():ApplyForceCenter( cartridge:GetForward() * -100 + cartridge:GetRight() * 100 )
	cartridge:Fire("kill","", math.random(2,3) )
	cartridge:EmitSound( "player/pl_shell3.wav", 100, 100 )
	
	ParticleEffect("arty_muzzleflash", self.Weapon:GetPos() + self.Weapon:GetForward() * 200, self.Weapon:GetAngles(), self.Weapon )
	
	local fx = EffectData()
	fx:SetStart( self:GetPos() )
	fx:SetOrigin( self:GetPos() + 10*Vector( math.random(-10,10),math.random(-10,10), 1 ) )
	fx:SetNormal( self:GetUp() )
	fx:SetMagnitude( 50 )
	fx:SetScale( 500.0 )
	fx:SetRadius( 500 )
	util.Effect( "ThumperDust", fx )
	
	local e = EffectData()
	e:SetStart( shell:GetPos() )
	e:SetEntity( shell )
	e:SetScale( math.random (4, 5) ) 
	e:SetNormal( cartridge:GetForward() )
	util.Effect( "launch2", e )
	
	local e = EffectData()
	e:SetStart( self:GetPos() )
	e:SetScale( math.random (4, 5) ) 
	util.Effect( "part_dis", e )

	local shake = ents.Create( "env_shake" )
	shake:SetPos( self:GetPos() )
	shake:SetOwner( self )
	shake:SetKeyValue( "amplitude", "1000" )
	shake:SetKeyValue( "radius", "5000" )
	shake:SetKeyValue( "duration", "1" )
	shake:SetKeyValue( "frequency", "255" )
	shake:SetKeyValue( "spawnflags", "4" )
	shake:Spawn()
	shake:Activate()
	shake:Fire( "StartShake", "", 0 )
	shake:Fire( "kill", "", 2 )

end

function ENT:PhysicsUpdate()
		
	-- if( IsValid( self.Target ) ) then 
		
		-- self:LerpAim( self.Target )
		
		-- if( self.Target.Destroyed ) then
			
			-- self.Target = NULL
			
			-- return
			
		-- end
		
		-- if( self:GetPos():Distance( self.Target:GetPos() ) > 11000 ) then 
			
			-- self.Target = NULL 

			-- return 
		-- end
		
	-- end
	if IsValid(self.Taget) then
			local TargetPos = self.Target:GetPos()
			local ta = ( self:GetPos() - TargetPos ):Angle()
			local ma = self:GetAngles()
			local offs = self:VecAngD( ma.y, ta.y )

			local TargetAngle = -offs + 180
	if IsValid(self.Weapon) then
			local ang = self.Weapon:GetAngles()
			ang:RotateAroundAxis( self:GetUp(), TargetAngle )
	end
	end
	
	
end
function ENT:TrackingTarget()
	if( IsValid( self.Target ) ) then 
		
		-- self:LerpAim( self.Target )
		self:Targetting( self.Target )
		
		if( self.Target.Destroyed ) then
			
			self.Target = NULL
			
			return
			
		end
		
		-- if( self:GetPos():Distance( self.Target:GetPos() ) > 11000 ) then 
			
			-- self.Target = NULL 

			-- return 
		-- end
		
	end
	

end

function ENT:Use(ply,caller)
	if !IsValid(self.Commander) then
		self.Commander = ply
		ply:PrintMessage( HUD_PRINTTALK, "Authorized to fire" )
		ply:SetNetworkedEntity("Ai_cannon", self)
		return
	else
		if (self.Commander != ply) then
			self.Commander = ply
			ply:PrintMessage( HUD_PRINTTALK, "New user authorized to fire" )
		end

		if ( self.canfire ) then// && self.LastPrimaryAttack + self.PrimaryCooldown <= CurTime() ) then
		self:SetPhysicsAttacker(ply)
print("on use")
			
			self:FireFLAK()
			self.canfire = false
			-- timer.Simple( 1.0, self:reload(),self)
			timer.Simple( 1.0, function() self.canfire = true end,self)
			-- self.LastPrimaryAttack = CurTime()	   
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
			self:FireFLAK()
			self.canfire = false
			-- timer.Simple( 3.0,reload,self)		   
			timer.Simple( 3.0, function() self.canfire = true end,self)
		end
		
		if (self.canfire && self.Commander:GetNetworkedBool("DestroyTarget") ) then		
			self:FireFLAK()
			self.canfire = false
			-- timer.Simple( math.random(5.0,6.0),reload,self)
			-- timer.Simple( 1.0,reload,self)		   
			timer.Simple( 3.0, function() self.canfire = true end,self)
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
	
	self.Commander:SetNetworkedEntity("Ai_cannon", NULL )
	self:Remove()

end

