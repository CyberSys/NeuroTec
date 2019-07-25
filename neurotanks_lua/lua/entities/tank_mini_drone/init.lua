
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.MaxHealth = 800
ENT.HealthVal = 800
ENT.Destroyed = false
ENT.VehicleType = VEHICLE_TANK -- Used by ramming function on the tanks.
ENT.TankType = TANK_TYPE_LIGHT
ENT.NetWorth = 500

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 32
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "tank_mini_drone" )  
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	ent:GetPhysicsObject():Wake()
	ent.Owner = ply
	ent.Team = 0
	ent.HealthVal = math.random( self.MaxHealth/2, self.MaxHealth )
	
	return ent

end

local wide = 28
local back = -10
local tracks = { "models/gmodmodels/minitank_tread_left.mdl", "models/gmodmodels/minitank_tread_right.mdl" }
local trackpos = { Vector( back, wide, 0 ), Vector( back, -wide, 0 ) }

function ENT:Initialize()
	
	self:SetModel( "models/gmodmodels/minitank_bot.mdl" )
	-- self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	-- self:GetPhysicsObject():SetMass( 50000 )
	-- self:SetPos( self:GetPos() + self:GetUp() * 16 )
	
	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetPos( self:LocalToWorld( Vector( 52, 0, 15 ) ) )
	self.Weapon:SetAngles( self:GetAngles() + Angle( -1.9, 0 ,0 ) )
	self.Weapon:SetModel( "models/gmodmodels/minitank_bubble_turret.mdl" )
	self.Weapon:SetParent( self )
	self.Weapon:Spawn()
	
	self.LastAttack = CurTime()
	self.PrimaryDelay = 1.0
	self.MaxDistance = 500
	self.MaxRange = 3500 
	self.MaxSpeed = 400
	self.Tracks = {}
	self:GetPhysicsObject():SetDamping( 0.7, 2.0 )
	
	for i=1,#tracks do
			
		self.Tracks[i] = ents.Create("prop_physics_override")
		self.Tracks[i]:SetPos( self:LocalToWorld( trackpos[i]) )
		self.Tracks[i]:SetAngles( self:GetAngles() )
		self.Tracks[i]:SetModel( tracks[i] )
		self.Tracks[i]:SetSolid( SOLID_NONE )
		self.Tracks[i]:SetParent( self ) 
		self.Tracks[i]:Spawn()
		self.Tracks[i]:GetPhysicsObject():SetMass( 1 )
	
	end
	
	/*
	self.Wheels = {}
	self.PhysWheelPositions = {}
	local omi,oma = self:OBBMins(), self:OBBMaxs()
	local MyWidth = ( Vector( 0, oma.x, 0 ) - Vector( 0, omi.x, 0 ) ):Length() / 5
	local wang = Angle( 0,0,-90 )
	
	omi.y,oma.y = 0,0
	omi.z,oma.z = 0,0
	
	local MySize = ( omi - oma ):Length() + 10
	local MyExtraX = -30

	for i=1,3 do
		
		table.insert( self.PhysWheelPositions, Vector( ( -MySize/2.5 + ( i * 40 ) ) + MyExtraX, -MyWidth, 10 )  )
		table.insert( self.PhysWheelPositions, Vector( ( -MySize/2.5 + ( i * 40 ) ) + MyExtraX, MyWidth, 10 )  )
		-- print( "woop" )
	end
		
	for i=1,6 do
		
		self.Wheels[i] = ents.Create("prop_physics_override")
		self.Wheels[i]:SetModel( "models/combine_Helicopter/helicopter_bomb01.mdl" )
		
		-- if( i > 3 ) then
			
			-- wang = Angle( 0,0,90 )
		
		-- end
		
		-- self.DebugWheels = true
		local Radius = ( self.Wheels[i]:OBBMaxs() - self.Wheels[i]:OBBMins() ):Length()  / math.pi 
		
		self.Wheels[i]:SetAngles( self:GetAngles() + wang )	
		self.Wheels[i]:SetPos( self:LocalToWorld( self.PhysWheelPositions[i] ) )

		self.Wheels[i]:SetOwner( self )
		self.Wheels[i]:Spawn()
		self.Wheels[i]:GetPhysicsObject():SetMass( 100 )
		
		-- print( Radius ) 
		
		self.Wheels[i]:PhysicsInitSphere( Radius, self.Wheels[i]:GetMaterial() )
		self.Wheels[i]:SetCollisionBounds( Vector( -Radius, -Radius, -Radius ), Vector( Radius, Radius, Radius ) )
		
		local LPos1 = self.Wheels[i]:GetPhysicsObject():WorldToLocal( self.Wheels[i]:GetPos() )
		local LPos2 = self.PhysWheelPositions[i]
			
		self.Wheels[i].Axis = constraint.Axis( self.Wheels[i], self, 0, 0, LPos1 + Vector( 0, 0, 1 ), LPos2, 0, 0, 0, 1 )
		construct.SetPhysProp( self, self.Wheels[i], 0, nil,  { GravityToggle = false, Material = "rubber" } ) 
			
		
	end
	*/
	local esound = {}
	esound[1] = "vehicles/diesel_loop2.wav"
	self.EngineMux = {}
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		self.EngineMux[i]:Play()
		
	end

	
	
end

function ENT:OnRemove()
		
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end
	-- for i=1,#self.Wheels do
		
		-- if( IsValid( self.Wheels[i] ) ) then
		
			
			-- self.Wheels[i]:Remove()
			
		-- end

	-- end

end

local Threads = {
							"models/aftokinito/wot/american/t1_cunningham/t1_cunningham_track", 
							"models/aftokinito/wot/american/t1_cunningham/t1_cunningham_track_reverse", 
							"models/aftokinito/wot/american/t1_cunningham/t1_cunningham_track_forward"	}

-- Secondary Weapon
-- "materials/Gmodmodels/minitank_tread.vmt",
-- "materials/Gmodmodels/minitank_tread _forward.vmt",
-- "materials/Gmodmodels/minitank_tread _reverse.vmt"

-- }

function ENT:Think()


	local Mat = Threads[1]
	
	if( self:GetVelocity():Length() > 0 && (math.ceil(self:GetVelocity():GetNormalized().x) == math.ceil(self:GetForward().x)) && (math.ceil(self:GetVelocity():GetNormalized().y) == math.ceil(self:GetForward().y)) ) then
		
		Mat = Threads[3]
		
	elseif( self:GetVelocity():Length() > 0 && (math.floor(self:GetVelocity():GetNormalized().x) == -math.ceil(self:GetForward().x)) && (math.floor(self:GetVelocity():GetNormalized().y) == -math.ceil(self:GetForward().y)) ) then
		
		
		Mat = Threads[2]
	 
	end
	
	for i=1,#self.Tracks do
		
		self.Tracks[i]:SetMaterial(Mat)
		-- print("why")
	end
	
	self:NextThink(CurTime())
	
	
	
	if( self.HealthVal < self.MaxHealth / 3 ) then
	
		local edata = EffectData()
		edata:SetEntity(self)
		edata:SetMagnitude(10)
		edata:SetScale(10)
		util.Effect("TeslaHitBoxes", edata)
		
	end 
	
	local speed = math.Clamp( self:GetVelocity():Length()/1.5, 80, 180 )
	-- print( speed )
	
	for i=1,#self.EngineMux do
		
		self.EngineMux[i]:Play( 1.0)
		self.EngineMux[i]:ChangePitch( speed, 1.0 )
	
	end
	
	
	if( self.Destroyed ) then
	
		local junk = ents.Create("prop_physics")
		junk:SetPos( self:GetPos() )
		junk:SetAngles( self:GetAngles() )
		junk:SetModel( self:GetModel() )
		junk:SetColor( Color( 76, 76, 76, 255 ) )
		junk:Spawn()
		junk:SetOwner( self )
		junk:Fire( "kill", "", 30 )
		
		local explo = EffectData()
		explo:SetOrigin( self:GetPos( ) )
		util.Effect("Explosion", explo )
		
		ParticleEffectAttach( "fire_b", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
		
		ParticleEffect( "dusty_explosion_rockets", self:GetPos() + self:GetUp() * 25, Angle(0,0,0), nil )
	
		util.BlastDamage( self, self, self:GetPos(), 300, math.random( 1500, 2000 )  )
		
		self:Remove()
	
		return
		
	end

	local tr,trace={},{}
	tr.start = self:GetPos() + self:GetForward() * 72 + self:GetUp()*32
	tr.endpos = tr.start + self:GetUp() * -64
	tr.filter = { self, self.Weapon }
	tr.mask = MASK_WORLD
	trace = util.TraceLine( tr )
	-- self:DrawLaserTracer( tr.start, trace.HitPos )
	
	-- print( self:OnGround() )
	if( !trace.Hit ) then return end 
	
	local mp = self:GetPos()
		
	if( !IsValid( self.Target ) ) then
	
		local dist =  self.MaxRange+1
		local shortest = NULL
		
		for k,v in pairs( ents.FindInSphere( self:GetPos(), self.MaxRange ) ) do
			
			if( v:IsPlayer() ) then
			
				local tp = v:GetPos()
				if( ( tp - mp ):Length() < dist ) then
					
					dist = ( tp - mp ):Length()
					shortest = v
					
				end
			
			end
			
		end
		
		if( IsValid( shortest ) ) then
			
			self.Target = shortest
			self:SetNetworkedBool("HasTarget", true )
			
			return
			
		end
	
	else
		
		
		local traceresults = { false, false, false, false }
		
		local tracevectors = { Vector( 100, 0, 0 ), Vector( -100, 0, 0 ), Vector( 0, 75, 0 ), Vector( 0, -75, 0 ) }
		local trace = {}
		local tr = {}
		local length = 133
		
		tr.start = self:GetPos() + self:GetUp() * (40+(math.sin(CurTime())*10))
		tr.endpos = tr.start + self:GetForward() * ( length*1.25 ) + self:GetRight() * ( math.sin(CurTime()/frameTime()) * 55 )
		tr.filter = { self, self.Weapon }
		
		trace = util.TraceLine( tr )
		-- self:DrawLaserTracer( tr.start, trace.HitPos )
		traceresults[1] = trace.Hit
		
		tr.endpos = tr.start + self:GetForward() * -length
		trace = util.TraceLine( tr )
		-- self:DrawLaserTracer( tr.start, trace.HitPos )
		traceresults[2] = trace.Hit
		
		tr.endpos = tr.start + self:GetRight() * -length
		trace = util.TraceLine( tr )
		-- self:DrawLaserTracer( tr.start, trace.HitPos )
		traceresults[3] = trace.Hit
		
		tr.endpos = tr.start + self:GetRight() * length
		trace = util.TraceLine( tr )
		-- self:DrawLaserTracer( tr.start, trace.HitPos )
		traceresults[4] = trace.Hit
		
		local phys = self:GetPhysicsObject()
		local f,b,l,r = traceresults[1], traceresults[2], traceresults[3], traceresults[4]
		if( f && !b && !l && !r ) then
			
			phys:ApplyForceCenter( self:GetForward() * -900000 )
			
		end
		
		if( ( f && r || f && l ) && !b ) then
			
			phys:AddAngleVelocity( Vector( 0, 0, 222 ) )
		
			
		end
		if( b && !f && !r && !l ) then
			
			phys:ApplyForceCenter( self:GetForward() * 900000 )
			
		end
		
		if( l && !f && !b && !r ) then
			
			phys:AddAngleVelocity( Vector( 0, 0, -300 ) )
			-- print( "left ")
			
		elseif( r && !f && !b && !l ) then
			
			phys:AddAngleVelocity( Vector( 0, 0, 300 ) )
		
		end
			
		local tp = self.Target:GetPos()
		local IdealAngle = ( mp - tp ):Angle()
		local dist = ( tp - mp ):Length()
		
		if( dist > self.MaxRange ) then
			
			self.Target = NULL
			self:SetNetworkedBool("HasTarget", false )
			
			return
			
		end
		
		if( !self.Target:Alive() ) then
			
			self.Target = NULL
			self:SetNetworkedBool("HasTarget", false )
			
			return
			
		end
		
		local ma = self:GetAngles()
		local diff = self:VecAngD( ma.y, IdealAngle.y )
		local speed = self:GetVelocity():Length()
		-- print( speed )
		local tdir = 1
		
		if( diff < 44 && diff > -44 ) then
		
			tdir = -1
			
		end
			

		if( dist > self.MaxDistance && speed < self.MaxSpeed ) then
			-- local num = #self.Wheels
			-- for i=1,num do
				
				-- local Dir = 1
				-- if( i > num/2 ) then
					-- Dir = -1
				-- end
				
				-- self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( Vector( 0,0, 500000 ) )
				
			-- end
			self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 750000*tdir )
		
		end
			
		if( diff < -168 || diff > 168 ) then
		
	
		
		else
			
			if( speed > 0.1 ) then
			
				local a,b=2,3
				if( diff >= 0 ) then
					
					a = 3 
					b = 2
				
				end
				for i=1,#self.Tracks do
						
					if( i > 1 ) then

						self.Tracks[i]:SetMaterial(Threads[a])
					
					else
					
						self.Tracks[i]:SetMaterial(Threads[b])
						
					end
					
				
				end
				
			end
			
			self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, math.Clamp(  diff, -33, 33 ) * 3 ) )
		
		end
		
		local tr,trace ={},{}
		tr.start = self.Weapon:GetPos() + Vector( 0,0, 72 )
		tr.endpos = tp + Vector( 0,0, 200 )
		tr.filter = { self, self.Weapon, self.Target, self.Target.CurrentTank }
		tr.mask = MASK_SOLID
		trace = util.TraceLine( tr ) 
		
		if( trace.Hit ) then
			
			self.Target = NULL
			
			self:SetNetworkedBool("HasTarget", false )
			
			return
			
		end
		
		-- reuse the old trace table for our new trace.
		tr.start = self.Weapon:GetPos() + Vector( 0,0, 10 )
		tr.endpos = tr.start + self.Weapon:GetForward() * 500
		trace = util.TraceLine( tr ) 
		-- Make sure we dont shoot if a friend is in front of us
		local Ent = trace.Entity
		local hitfriend = ( IsValid( trace.Entity ) && trace.Entity:GetClass() == self:GetClass() )
		
		
		if( ( diff < -165 || diff > 165 ) && dist > self.MaxDistance/1.6 && !hitfriend ) then
			
			if( self.LastAttack + self.PrimaryDelay <= CurTime() ) then
			
				self.LastAttack = CurTime()
					
				self.Weapon:EmitSound( "wot/t1_cun/burst.wav", 511, 100 )
					
				local shell = ents.Create("sent_tank_mgbullet")
				shell:SetPos( self.Weapon:GetPos() + self.Weapon:GetForward() * 200 )
				shell:SetAngles( self.Weapon:GetAngles() )
				shell:SetOwner( self.Weapon )
				shell:SetPhysicsAttacker( self )
				shell.Owner = self
				shell:Spawn()
				shell:GetPhysicsObject():EnableGravity( true )
				shell:GetPhysicsObject():ApplyForceCenter( shell:GetForward() * 500000 )
				ParticleEffect("mg_muzzleflash", self.Weapon:GetPos() + self.Weapon:GetForward() * 55, self.Weapon:GetAngles(), self.Weapon )
				
				self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * -200000 )
				
			
			end
			
		
		end
	
	end

	
	
end

function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end
	local atk = dmginfo:GetAttacker()
	if( IsValid( atk ) && atk:GetClass() == self:GetClass() ) then return end
	
	if( self.HealthVal > 0 ) then
	
		self.HealthVal = self.HealthVal - dmginfo:GetDamage()
		
		
	else
		
		self.Destroyed = true
		
		return
		
	end
	
end

function ENT:MiniTankExplode()
	
	if( self.Destroyed ) then return end
	self.Destroyed = true

	self:EmitSound( "ambient/explosions/explode_4.wav", 511, 200 )
	local edata = EffectData()
	edata:SetEntity(self)
	edata:SetMagnitude(3)
	edata:SetScale(2)
	util.Effect("TeslaHitBoxes", edata)
	
	-- ParticleEffect("fire_b", self:GetPos(), Angle(0,0,0), self )
	
	-- ParticleEffect( "dusty_explosion_rockets", self:GetPos() + self:GetUp() * 55, Angle(0,0,0), self )
	
	util.BlastDamage( self, self, self:GetPos(), 256, 1500  )

	-- self:Remove()
	
	-- print( "what" )
	
end

function ENT:PhysicsCollide( data, physobj )
	

end
