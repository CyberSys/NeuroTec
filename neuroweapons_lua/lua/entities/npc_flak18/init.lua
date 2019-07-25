AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Model = "models/ranson/ranson_flak18_at_base.mdl"
ENT.Sound = "weapons/ar2/npc_ar2_altfire.wav"//"bf2/weapons/m249_Fire.wav"//"weapons/shotgun/shotgun_dbl_Fire7.wav"
ENT.Destroyed = false
ENT.Burning = false
ENT.DeathTimer = 0
ENT.MaxDamage = 20
ENT.MinDamage = 10
ENT.BlastRadius = 666
ENT.InitialHealth = 4000
ENT.HealthVal = nil
ENT.canfire = true

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos
	local ent = ents.Create( "npc_flak18" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( Angle( 0,0,0 ) )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()

	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )	
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
	self.Weapon:SetAngles( self:GetAngles() )
	self.Weapon:Spawn()

	local Missilepos = {}
	Missilepos[1] = Vector( 10, 7, 93 )
	Missilepos[2] = Vector( 10, -7, 93 )
	
	self.Missile = {}
	
	for i = 1, 2 do
		
		self.Missile[i] = ents.Create("prop_physics")
		self.Missile[i]:SetPos( self:LocalToWorld( Missilepos[i] ) )
		self.Missile[i]:SetModel("models/mm1/box.mdl") --( "models/hawx/weapons/aim-132 asraam.mdl" )
		self.Missile[i]:SetAngles( self:GetAngles() )
		self.Missile[i]:SetParent( self.Weapon )
		self.Missile[i]:Spawn()
		self.Missile[i]:SetColor( 0,0,0,0 )
		
	end
	
	self.MissilePhys = {}

	for i = 1, 2 do
	
		self.MissilePhys[i] = self.Missile[i]:GetPhysicsObject()
		if IsValid(self.MissilePhys[i]) then
			self.MissilePhys[i]:Wake()
			self.MissilePhys[i]:SetMass( 1 )
			self.MissilePhys[i]:EnableGravity( false )
			self.MissilePhys[i]:EnableCollisions( false )
		end
	end

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

end

local function apr(a,b,c)
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end

function ENT:LerpAim(Target)

	if ( !IsValid( Target ) ) then

		return

	end

	local pos = Target:GetPos() + Target:OBBCenter()

	local mp = self.Weapon:GetPos()
	
	local dir = ( pos - mp ):Angle()
	local a = self.Weapon:GetAngles()
	local b = self.Turret:GetAngles()
	a.p, a.r= apr( a.p, dir.p, 8.5 ),apr( a.r, dir.r, 8.5 )
	b.y = apr( b.y, dir.y, 14.5 )
	
	self.Weapon:SetAngles( LerpAngle( 0.009, a, self.Weapon:GetAngles() ) )
	self.Turret:SetAngles( LerpAngle( 0.009, b, self.Turret:GetAngles() ) )	
	
end

function ENT:FireFLAK()

	local shell = ents.Create("sent_aa_flak_huge")
	shell:SetPos( self.Weapon:GetPos() + self.Weapon:GetForward() * 200 )
	shell:SetAngles( self.Weapon:GetAngles() + Angle( math.Rand( -2.5,2.5),math.Rand( -2.5,2.5),math.Rand( -2.5,2.5) ) )
	shell:SetOwner( self.Owner )
	shell.Owner = self
	shell:Spawn()
	shell:GetPhysicsObject():ApplyForceCenter( shell:GetForward() * 950000 )
  
	
--	self:EmitSound( "weapons/mortar/mortar_Fire1.wav", 511, math.random(110,117) )
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
	cartridge:SetModel( "models/155Cartridge/Cartridge.mdl" ) 
	cartridge:Spawn()
	cartridge:GetPhysicsObject():ApplyForceCenter( cartridge:GetForward() * -100 + cartridge:GetRight() * 100 )
	cartridge:Fire("kill","", math.random(2,3) )
	cartridge:EmitSound( "player/pl_shell3.wav", 100, 100 )
	
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


end

function ENT:PhysicsUpdate()
		
	if( IsValid( self.Target ) ) then 
		
		self:LerpAim( self.Target )
		
		if( self.Target.Destroyed ) then
			
			self.Target = NULL
			
			return
			
		end
		
		if( self:GetPos():Distance( self.Target:GetPos() ) > 11000 ) then 
			
			self.Target = NULL 

			return 
		end
		
	end
	
end

function ENT:Think()
	
	self:NextThink(CurTime())
	self.Owner = self
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

	if( !IsValid( self.Target ) ) then

		for k,v in pairs( ents.FindInSphere( self:GetPos(), 17000 ) ) do

			if ( v:GetNetworkedEntity("Pilot")		|| 
				v:IsVehicle() 						|| 
				v.HealthVal != nil					|| 
				string.find(v:GetClass(),"npc_*")	|| 
				v:GetOwner() != self				&&
				string.find(v:GetClass(),"nuke" ) ) && 
				string.find( v:GetClass(), "prop_physics" ) == nil &&
				string.find( v:GetClass(), "flak" ) == nil then // yo
				
				if ( v:GetVelocity():Length() > 10 && v.Owner != self.Owner && v:GetOwner() != self:GetOwner() ) then // looooooong
					
					if ( v:GetPos().z > self:GetPos().z + 2050 )  then // still not done with it wtf?
						
						
						self.Target = v
		
					end

				end

			end
		
		end
	
	else
		
		// basic line of sight
		local tr, trace = {},{}
		tr.start = self:GetPos()
		tr.endpos = self.Target:GetPos()
		tr.filter = self
		trace = util.TraceLine( tr )
	
		if ( self.canfire && !self.Target.Destroyed && trace.Hit && trace.Entity == self.Target ) then
			
			self:FireFLAK()
			self.canfire = false
			timer.Simple( 3.0,reload,self)
		   
		end
	
	end
	
end

function reload( ent )
	
	if( !IsValid( ent ) ) then return end
	
	ent.canfire = true
	ent:EmitSound( "bf2/tanks/t-90_reload.wav", 511, math.random( 70, 100 ) )
	
 end

function ENT:OnTakeDamage(dmginfo)
	
	local dt = dmginfo:GetDamageType()
	
	if( dt && DMG_BLAST_SURFACE == DMG_BLAST_SURFACE || dt && DMG_BLAST == DMG_BLAST || dt && DMG_BURN == DMG_BURN   ) then 
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
	
	self:Remove()

end

