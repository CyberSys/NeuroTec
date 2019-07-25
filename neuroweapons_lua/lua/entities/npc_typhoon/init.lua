AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Model = "models/hunter/tubes/circle4x4.mdl"
ENT.Sound = "weapons/ar2/npc_ar2_altfire.wav"//"bf2/weapons/m249_Fire.wav"//"weapons/shotgun/shotgun_dbl_Fire7.wav"
ENT.Destroyed = false
ENT.Burning = false
ENT.DeathTimer = 0
ENT.MaxDamage = 20
ENT.MinDamage = 10
ENT.BlastRadius = 666
ENT.InitialHealth = 4000
ENT.HealthVal = nil
ENT.Firemode = false
function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "npc_typhoon" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()

	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS)	
	self:SetSolid( SOLID_VPHYSICS )
	self.PhysObj = self:GetPhysicsObject()
	self.LastReminder = CurTime()
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self.Firemode = false
	self:SetColor( Color(150,150,150,255) )
	self:SetMaterial( "phoenix_storms/dome" )
	
	self.Turret = ents.Create("prop_physics_override")
	self.Turret:SetModel( "models/solcommand/typhoon/base.mdl")
	self.Turret:SetPos(self:GetPos() + self:GetUp() * 45)
	self.Turret:SetParent( self )
	self.Turret:Spawn()

	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( "models/solcommand/typhoon/launcher.mdl" )
	self.Weapon:SetPos(self.Turret:GetPos() + self.Turret:GetUp() * 40)
	self.Weapon:SetParent( self.Turret )
	self.Weapon:Spawn()
			   
	local Missilepos = {}
	Missilepos[1] = Vector( 7, 11, 58 )
	Missilepos[2] = Vector( 7, 0, 58 )
	Missilepos[3] = Vector( 7, -11, 58 )

	Missilepos[4] = Vector( 7, 11, 45 )
	Missilepos[5] = Vector( 7, 0, 45 )
	Missilepos[6] = Vector( 7, -11, 45 )

	Missilepos[7] = Vector( 7, 11, 31 )
	Missilepos[8] = Vector( 7, 0, 31 )
	Missilepos[9] = Vector( 7, -11, 31 )

	Missilepos[10] = Vector( 7, 11, 17 )
	Missilepos[11] = Vector( 7, 0, 17 )
	Missilepos[12] = Vector( 7, -11, 17 )
	
	self.Missile = {}
		   for i = 1, 12 do
		
		self.Missile[i] = ents.Create("prop_physics")
		self.Missile[i]:SetPos( self.Turret:LocalToWorld( Missilepos[i] ) )
		self.Missile[i]:SetModel( "models/hawx/weapons/aim-9 sidewinder.mdl" )
		self.Missile[i]:SetAngles( self.Weapon:GetAngles() )
		self.Missile[i]:SetParent( self.Weapon )
		self.Missile[i]:Spawn()
	
		
	end
		
	self.MissilePhys = {}
	for i = 1, 2 do
	
		self.MissilePhys[i] = self.Missile[i]:GetPhysicsObject()
		self.MissilePhys[i]:Wake()
		self.MissilePhys[i]:SetMass( 1 )
		self.MissilePhys[i]:EnableGravity( false )
		self.MissilePhys[i]:EnableCollisions( false )

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

	local pos = Target:GetPos()
	local mp = self.Weapon:GetPos()
	
	local dir = ( pos - mp ):Angle()
	local a = self.Weapon:GetAngles()
	local b = self.Turret:GetAngles()
	a.p, a.r= apr( a.p, dir.p, 8.5 ),apr( a.r, dir.r, 8.5 )
	b.y = apr( b.y, dir.y, 14.5 )
	
	self.Weapon:SetAngles( a )
	self.Turret:SetAngles( b )	
	
end

function ENT:FireSTORM()
	
	local Missilepos = {}
	Missilepos[1] = Vector( 7, 11, 58 )
	Missilepos[2] = Vector( 7, 0, 58 )
	Missilepos[3] = Vector( 7, -11, 58 )

	Missilepos[4] = Vector( 7, 11, 45 )
	Missilepos[5] = Vector( 7, 0, 45 )
	Missilepos[6] = Vector( 7, -11, 45 )

	Missilepos[7] = Vector( 7, 11, 31 )
	Missilepos[8] = Vector( 7, 0, 31 )
	Missilepos[9] = Vector( 7, -11, 31 )

	Missilepos[10] = Vector( 7, 11, 17 )
	Missilepos[11] = Vector( 7, 0, 17 )
	Missilepos[12] = Vector( 7, -11, 17 )
	
	local r = ents.Create("sent_a2a_rocket")
	r:SetPos( self.Turret:GetPos() + Missilepos[math.random(1,12)] )
	r:SetAngles(self.Weapon:GetAngles())
	r:SetModel( "models/hawx/weapons/aim-9 sidewinder.mdl" ) 
	r:Spawn()
	r.Target = self.Target
	r.Owner = self
	r:SetOwner(self)
	r:SetPhysicsAttacker(self)				
	self:EmitSound( "lockon/missileshoot.mp3", 510, math.random( 100, 130 ) )

end

function ENT:FireMissile(n)

	local Missilepos = {}
	Missilepos[1] = Vector( 7, 11, 58 )
	Missilepos[2] = Vector( 7, 0, 58 )
	Missilepos[3] = Vector( 7, -11, 58 )

	Missilepos[4] = Vector( 7, 11, 45 )
	Missilepos[5] = Vector( 7, 0, 45 )
	Missilepos[6] = Vector( 7, -11, 45 )

	Missilepos[7] = Vector( 7, 11, 31 )
	Missilepos[8] = Vector( 7, 0, 31 )
	Missilepos[9] = Vector( 7, -11, 31 )

	Missilepos[10] = Vector( 7, 11, 17 )
	Missilepos[11] = Vector( 7, 0, 17 )
	Missilepos[12] = Vector( 7, -11, 17 )

	local r = ents.Create("sent_a2a_rocket")
	r:SetPos( self.Turret:GetPos() + Missilepos[n] )
	r:SetAngles(self.Weapon:GetAngles())
	r:SetModel( "models/hawx/weapons/aim-9 sidewinder.mdl" ) 
	r:Spawn()
	r.Target = self.Target
	r.Owner = self
	r:SetOwner(self)
	r:SetPhysicsAttacker(self)
	self:EmitSound( "lockon/missileshoot.mp3", 510, math.random( 100, 130 ) )
	self.Missile[n]:SetColor(Color( 0,0,0,0 ))
	timer.Simple( 2, function() if( !IsValid( self ) ) then return end self.Missile[n]:SetColor(Color(255,255,255,255)) end, self.Missile[n])
end

function ENT:PhysicsUpdate()
	
end

function ENT:Think()

	self.Owner = self

	if ( self.HealthVal < 300 ) then
		
		self:NextThink(CurTime() + 0.2 )
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Turret:GetPos() + self.Turret:GetRight() * math.random(-32,32) + self.Turret:GetForward() * math.random(-32,32)  )
		util.Effect( "immolate", effectdata )

	end
	
	local tr = {}
	tr.start= self.Turret:GetPos() + self.Turret:GetRight() * -1 + self.Turret:GetUp() * 55 + self.Turret:GetForward()*80 
	tr.endpos= tr.start + self.Weapon:GetForward()* 30000
	tr.filter= { self, self.Turret, self.Weapon,
	self.Missile[1], self.Missile[2], self.Missile[3],
	self.Missile[4], self.Missile[5], self.Missile[6],
	self.Missile[7], self.Missile[8], self.Missile[9],
	self.Missile[10], self.Missile[11], self.Missile[12] }
	local Trace = util.TraceLine(tr)
		
	if Trace.HitNonWorld && Trace.Entity && Trace.Entity == self.Target then
				
		if !self.Firemode then
				
			self:FireMissile(math.random(1,12))
		
		else
			
			self:FireSTORM()
				 
		end
	end
			
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 10000 ) ) do
		
		if ( IsValid( v ) && ( v.HealthVal || v:IsPlayer() || v:IsNPC() || string.find( v:GetClass(), "sent" ) ) ) then -- yo
						
			if ( v:GetVelocity():Length() > 200  && v.Owner != self.Owner && v:GetOwner() != self:GetOwner() ) then // looooooong
				
				if ( v:GetPos().z > self:GetPos().z + 200 )  then -- still not done with it wtf?
					
					self.Target = v
					
					// Aimbot!!
					self:LerpAim(v)

					if ( self.Target:GetPos().z > self:GetPos().z + 4000 )  then
						
						self.Firemode = true
					
					else
						
						self.Firemode = false
					
					end
	
					if ( self.Target:GetPos().z > self:GetPos().z + 2058 )  then
					
						local TSR = self:GetVar('DoRocket',0)
						
						if (TSR + 15) > CurTime() then return end
				
						self:SetVar('DoRocket',CurTime())
						timer.Simple( 1.4, function() if(IsValid( self ) ) then self:FireSTORM() end end )
					end
					
				end
				
			end
			
		end
		
	end
	
	local TSlaunch = self:GetVar('TLaunch', 0)
	if ( TSlaunch + 4 ) > CurTime() then return end
	self:SetVar( 'TLaunch', CurTime() )
				
	if ( IsValid( self.Target ) && self.Target:GetPos():Distance( self:GetPos() ) > 14000 ) then
		
		self.Target = NULL
		
	end
	
	if ( self.Destroyed ) then 

		self.Target = NULL
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Turret:GetPos() + self.Turret:GetRight() * math.random(-62,62) + self.Turret:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
	end
		
	if self.DeathTimer > 35 then
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Turret:GetPos() )
		util.Effect( "Airstrike_explosion", effectdata )
		
		self:Remove()
			
	end
	
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
	
	if ( self.HealthVal < 0 ) then
		
		
		self:DeathFX()
		
	end
	
end

function ENT:OnRemove()

	self:Remove()

end

