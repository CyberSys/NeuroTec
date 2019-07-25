AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = "models/hawx/planes/f-15e strikeeagle.mdl"
//Speed Limits
ENT.MaxVelocity = 3500
ENT.MinVelocity = 900

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 1.8

ENT.InitialHealth = 2500
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 400
ENT.DeathTimer = 0

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 8

ENT.LockOn = false

// Equipment
ENT.MachineGunModel = "models/weapons/w_shot_xm1014.mdl"
ENT.MachineGunOffset = Vector( 91, 54, 89 )
ENT.CrosshairOffset = 89

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03
ENT.SecondaryCooldown = 25.0
ENT.SecondaryFireMode = true // Initial secondary firemode: true = dumbfire, false = homing
ENT.Rocket1 = "sent_a2s_rocket"
ENT.Rocket2 = "sent_a2a_rocket"

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	
	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	
	self.Pilot = ents.Create("prop_physics_override")
	self.Pilot:SetPos( self:GetPos() )
	self.Pilot:SetModel("models/airboatgun.mdl")
	self.Pilot:SetAngles( self:GetAngles() )
	self.Pilot:SetParent( self )
	self.Pilot:SetOwner( self )
	self.Pilot:SetSolid( SOLID_NONE )
	self.Pilot:SetColor( Color( 0,0,0,0 ) )
	self.Pilot:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.Pilot:Spawn()
	
	self.PavePenny = ents.Create("info_target")
	self.PavePenny:SetPos( self:GetPos() )
	self.PavePenny:Spawn()
	
	// Sound
	local esound = {}
	self.EngineMux = {}
	
	esound[1] = "physics/metal/canister_scrape_smooth_loop1.wav"
	esound[2] = "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav"
	esound[3] = "ambient/levels/canals/dam_water_loop2.wav"
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 80
	self.EngineMux[1]:PlayEx( 500 , self.Pitch )
	self.EngineMux[2]:PlayEx( 500 , self.Pitch )
	self.EngineMux[3]:PlayEx( 500 , self.Pitch )
	
	// Armamanet
	self.RocketVisuals = {}
	self.Armament = {
					{ Mdl = "models/hawx/weapons/aim-07 sparrow.mdl", Pos = Vector( -15, -94, 68 ), Ang = Angle( 0, 0, 45 ) };
					{ Mdl = "models/hawx/weapons/aim-07 sparrow.mdl", Pos = Vector( -15, 94, 68 ), Ang = Angle( 0, 0, 0 ) };
					{ Mdl = "models/hawx/weapons/agm-65 maverick.mdl", Pos = Vector( -29, -129, 68 ), Ang = Angle( 0, 0, 0 ) };
					{ Mdl = "models/hawx/weapons/agm-65 maverick.mdl", Pos = Vector( -29, 129, 68 ), Ang = Angle( 0, 0, 0 ) };
					}

	local i = 0
	for k,v in pairs( self.Armament ) do
		
		i = i + 1
		self.RocketVisuals[i] = ents.Create("prop_physics_override")
		self.RocketVisuals[i]:SetModel( v.Mdl )
		self.RocketVisuals[i]:SetPos( self:GetPos() + self:GetForward() * v.Pos.x + self:GetRight() * v.Pos.y + self:GetUp() * v.Pos.z )
		self.RocketVisuals[i]:SetAngles( self:GetAngles() + v.Ang )
		self.RocketVisuals[i]:SetParent( self )
		self.RocketVisuals[i]:SetSolid( SOLID_NONE )
		self.RocketVisuals[i]:Spawn()
		
	end
	
	local o = self.MachineGunOffset
	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( self.MachineGunModel )
	self.Weapon:SetPos( self:GetPos() + self:GetForward() * o.x + self:GetRight() * o.y + self:GetUp() * o.z  )
	self.Weapon:SetAngles( self:GetAngles() )
	self.Weapon:SetSolid( SOLID_NONE )
	self.Weapon:SetParent( self )
	self.Weapon:Spawn()
	
	// reference point on the map, should probably use tracelines to verify the spot so the plane wont fly into stuff.
	self.CycleTarget = ents.Create("sent_neurotarget")
	self.CycleTarget.Owner = self
	self.CycleTarget:SetPos( self:GetPos() + Vector(1024,1024,1024))
	self.CycleTarget:Spawn()
	
	// Misc
	self:SetModel( self.Model )	
	self:SetSkin( math.random( 0, 1 ) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass(10000)
		
	end

	self:StartMotionController()

end


function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	if ( self.Target == self.CycleTarget && IsValid( dmginfo:GetInflictor() ) ) then
		
		self.Target = dmginfo:GetInflictor()
	
	end

	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	if ( self.HealthVal < 200 && !self.Burning ) then
	
		self.Burning = true
		local p = {}
		p[1] = self:GetPos() + self:GetForward() * -240 + self:GetRight() * -28 + self:GetUp() * 69
		p[2] = self:GetPos() + self:GetForward() * -240 + self:GetRight() * 28 + self:GetUp() * 69	
		for _i=1,2 do
		
			local f = ents.Create("env_Fire_trail")
			f:SetPos( p[_i] )
			f:SetParent( self )
			f:Spawn()
			
		end
		
	end
	
	if ( self.HealthVal < 5 ) then
	
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass(2000)
		self:Ignite(60,100)
		
	end
	
end

function ENT:OnRemove()

	for i=1,3 do
	
		self.EngineMux[i]:Stop()
		
	end
	
	self.PavePenny:Remove()
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.7 && data.DeltaTime > 0.2 ) then 

		local explo = EffectData()
		explo:SetOrigin(self:GetPos())
		explo:SetScale( 1.50 )
		explo:SetNormal(data.HitNormal)
		util.Effect( "nn_explosion", explo )
		
		util.BlastDamage( self, self, data.HitPos, 2048, 500)

		self:ExplosionImproved()
		
		self.Entity:Remove()
			
	end
	
end

function ENT:ScanForEnemiesSpecial()

	local dist = dist or 25600
	local tempd = tempd or 0
	local t = t or self.CycleTarget

	for k,v in pairs( ents.FindInSphere( self:GetPos(), 25600 ) ) do

		if ( v != self && v:GetClass() != self:GetClass() && v:GetClass() != "npc_missile_homer" ) then
		
			if ( v:IsPlayer() || v:IsNPC() || ( v:IsVehicle() && v:GetVelocity():Length() > 1 ) || string.find( v:GetClass(), "npc_" ) )  then
			
				if( v.Destroyed ) then 
				
					return 
				
				end
				
				tempd = self:GetPos():Distance( v:GetPos() )
				
				if ( tempd < dist ) then
					
					dist = tempd
					t = v
					
				end
				
				self.Target = t
				
			end
			
		end
		
		if ( !IsValid( self.Target ) ) then //better safe than sorry
		
			self.Target = self.CycleTarget
			
		end
		
	end
	
end

function ENT:DoPrimaryAttack()
	
	for i=1,2 do
		
		timer.Simple( i * self.PrimaryCooldown, function() if( IsValid( self ) ) then self:PrimaryAttack() end end )
		
	end

end


function ENT:Think()

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	for i = 1,3 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch,0.01 )
		
	end

	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:Remove()
		
		end
		
	end
	
	local tr,trace = {},{}
	tr.start = self:GetPos() + self:GetForward() * 1024
	tr.endpos = self:GetPos() + self:GetForward() * 11000
	tr.filter = { self, self.Pilot }
	tr.mask = MASK_SOLID
	trace = util.TraceEntity( tr, self )
	
	local e = trace.Entity
	
	local logic = ( IsValid( e ) && ( e:IsNPC() || e:IsPlayer() || e:IsVehicle() || type(e) == "CSENT_vehicle" ) )
	
	if ( logic && e != self && e:GetOwner() != self && e:GetOwner() != self.Pilot && e:GetClass() != self:GetClass() ) then
		
		self:ClearTarget()
		self:SetTarget( e )
		self.LockOn = true
	
	else
	
		if ( !self.LockOn ) then
			
			self:ScanForEnemiesSpecial()
			
		end
		
	end
		
	if( IsValid( self.Target ) ) then
		
		// Movement stuff
		local a = ( self.Target:GetPos() - self:GetPos() ):Angle()
		local b =  Angle( 0, self:GetPhysicsObject():GetAngles().y, 0 )
	
		self.Yaw = self:VecAngD( a.y, b.y )
		self.Pitch = self:VecAngD( a.p, b.p )
		
		local trace,tr = {},{}
		tr.start = self.Target:GetPos()
		tr.endpos = tr.start - Vector(0,0,700)
		tr.filter = { self, self.Target }
		tr.mask = MASK_SOLID_BRUSHONLY
		trace = util.TraceLine( tr )
		
		self.TargetDistance = self:GetPos():Distance( self.Target:GetPos())
		local logic1 = ( self.TargetDistance > 3000 )
		local logic2 = ( self.Yaw > -10 && self.Yaw < 10 )
		
		if( self.Target:OnGround() && logic1 && logic2 ) then // Fly in, shoot, leave.
			
			self.PavePenny:SetPos( self.Target:GetPos() + self.Target:GetUp() * 72 )
			
			self:DoPrimaryAttack()
			
		elseif( self.Target:OnGround() && !logic1 || trace.HitWorld ) then
		
			local p = self.Target:GetPos() + self.Target:GetUp() * 2048
			
			p.x = p.x + math.sin(CurTime()) * 700
			p.x = p.y + math.cos(CurTime()) * 700
			
			self.PavePenny:SetPos( p )
		
		elseif ( !self.Target:OnGround() ) then
		
			self.PavePenny:SetPos( self.Target:GetPos() + self.Target:GetForward() * 256 )
		
		end
		
		self.MaxAng = self.MaxAng or 100
		local targetVelocity = self.Target:GetVelocity():Length()
		
		if( self.Target:OnGround() ) then
			
			self.MaxVelocity = 2600
			self.MaxAng = 50
			self.BankingFactor = 2.5
			
		else
			
			if ( targetVelocity > 1800 ) then
				
				self.MaxVelocity = targetVelocity * 1.2 // Match opponents speed
				self.MaxAng = 65
				self.BankingFactor = 2.3
			
			else
			
				self.MaxVelocity = 2800
				self.MaxAng = 45
				self.BankingFactor = 2.1
			
			end
			
		end
		
		if (  self.Target == self.CycleTarget ) then
		
			self.MaxVelocity = 1000
			self.MaxAng = 20
			self.BankingFactor = 4.2
			
		end
		
		
		
		self.Pilot:PointAtEntity( self.PavePenny )

		// Lock-on method
		local smallcone = ( self.Yaw > -5 && self.Yaw < 5 && self.Pitch > -5 && self.Pitch < 5 && self.TargetDistance < 9001 )
		
		if ( smallcone ) then
			
			self:DoPrimaryAttack()
			
			if ( !self.Target:OnGround() ) then
				
				self.LockOn = true
			
			end
			
		end
		
		// Secondary Attack
		
		if ( self.LastSecondaryAttack + self.SecondaryCooldown <= CurTime() ) then
			
			local logic = ( self.Yaw > -11 && self.Yaw < 11 && self.Pitch > -11 && self.Pitch < 11 )
			local logic2 = ( self.Yaw > -2 && self.Yaw < 2 && self.Pitch > -5 && self.Pitch < 5 && self.Target:OnGround() )
			
			if( logic2 ) then
			
				self.SecondaryFireMode = true
				self.SecondaryCooldown = 15
				self:SecondaryAttack()
			
			end
			
			if ( self.LockOn ) then
				
				self.SecondaryFireMode = false
				self.LockOn = false
				self.SecondaryCooldown = 25
				self:SecondaryAttack()
				
			elseif ( !self.LockOn && logic && self.TargetDistance > 1500 ) then
			
				self.SecondaryFireMode = true
				self.SecondaryCooldown = 15
				self:SecondaryAttack()
				
			end	
			
		end
			
	else
	
		self.Target = self.CycleTarget
		self.LockOn = false
		
	end
	
end


function ENT:SpawnFlare()
	
	local f = ents.Create("nn_flare")
	f:SetPos( self:GetPos() + self:GetUp() * -8 + self:GetForward() * 256 )
	f:SetAngles( self:GetAngles() )
	f:Spawn()
	f:SetOwner( self )
	f:Fire("kill","",5)
	f:GetPhysicsObject():SetMass( 100 )
	f:SetVelocity( self:GetVelocity() * 5000 )
	f:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 50000 )
	f:EmitSound( "weapons/flaregun/fire.wav",311, 100 )
	
	timer.Simple( math.random(1,2), 
					function(a,b,c)
					
						if ( IsValid( self ) ) then
						
							for k,v in pairs( ents.GetAll() ) do
							
								local c = v:GetClass()
								
								local logic = ( string.find( c, "rocket" ) != nil ||
												string.find( c, "missile" ) != nil ||
												string.find( c, "rpg" ) != nil ||
												string.find( c, "homing" ) != nil ||
												string.find( c, "heatseek" ) != nil ||
												string.find( c, "fire" ) )
								
								local logic2 = ( v:GetOwner() != self )
								
								if ( logic && logic2 && v:GetPos():Distance( self:GetPos() ) < 3000 ) then
									
									if ( !IsValid( v.Target ) ) then
										
										v:ExplosionImproved()
										v:SetNetworkedEntity("Target",nil)
										v:Remove()
										
									else
									
										v.Target = r
										
									end
									
								end
								
							end
							
						end
						
					end	)
	
end

function ENT:PrimaryAttack()
	
 	local bullet = {} 
 	bullet.Num 		= 1
 	bullet.Src 		= self.Weapon:GetPos() + self.Weapon:GetForward() * 171
 	bullet.Dir 		= self.Weapon:GetAngles():Forward()		// Dir of bullet 
 	bullet.Spread 	= Vector( .019, .019, .019 )				// Aim Cone 
 	bullet.Tracer	= math.random( 2, 4 )					// Show a tracer on every x bullets  
 	bullet.Force	= 450					 					// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 40, 45 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer" 
 	bullet.Callback    = function ( a, b, c )
							
							local e = EffectData()
							e:SetOrigin(b.HitPos)
							e:SetNormal(b.HitNormal)
							e:SetScale( 4.5 )
							util.Effect("ManhackSparks", e)

							local e = EffectData()
							e:SetOrigin(b.HitPos)
							e:SetNormal(b.HitNormal)
							e:SetScale( 1.5 )
							util.Effect("HelicopterMegaBomb", e)
							
							util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 150, 8 )
							
							return { damage = true, effects = DoDefaultEffect } 
							
						end 
 	
	self.Weapon:FireBullets( bullet )
	
	self.Weapon:EmitSound( "ah64fire.wav", 511, 140 )
	
	local effectdata = EffectData()
	effectdata:SetStart( self.Weapon:GetPos() + self:GetForward() * 140 )
	effectdata:SetOrigin( self.Weapon:GetPos() + self:GetForward() * 140 )
	effectdata:SetEntity( self.Weapon )
	effectdata:SetNormal( self:GetForward() )
	util.Effect( "a10_muzzlesmoke", effectdata )  

	self.LastPrimaryAttack = CurTime()
	
end

function ENT:SecondaryAttack()
	

	if ( self.SecondaryFireMode ) then
		
		self.NumRockets = math.random(4,6)
		
		for i=1,self.NumRockets do
				
			timer.Simple( i * 0.4, function() self:SmallBarrage() end )
		
		end
		
	else
	
		if ( !IsValid( self.Target ) ) then
			
			return
		
		else
			
			self:LaunchHoming()
			
		end
			
	end
		
	self.LastSecondaryAttack = CurTime()
	
end

function ENT:SmallBarrage()
	
	local rnd = math.random(1,2)
	local e = self.RocketVisuals[rnd]
	
	if ( IsValid( e ) ) then
		
		local r = ents.Create( self.Rocket1 )
		r:SetPos( e:GetPos() + self:GetUp() * math.random(-8,8) + self:GetForward() * math.random(60,100) )
		r:SetAngles( self:GetAngles() )
		r:SetOwner( self )
		r:SetPhysicsAttacker( self )
		r:Spawn()
		r:Fire("Kill","",20)
		r:SetVelocity( self:GetVelocity() * math.random( 90, 100 ) )
		
		self:EmitSound( "weapons/rpg/rocketfire1.wav", 511, 140 )
		
		local sm = EffectData()
		sm:SetStart( e:GetPos() )
		sm:SetScale(0.8)
		util.Effect( "Launch2", sm )
	
	end
	
end

function ENT:LaunchHoming()
	
	local rnd = math.random(3,4)
	if ( IsValid( self.RocketVisuals[rnd] ) ) then
		local r = ents.Create( self.Rocket2 )
		r:SetPos( self.RocketVisuals[rnd]:GetPos() )
		r:SetModel( self.RocketVisuals[rnd]:GetModel() )
		r:SetOwner( self )
		r:SetPhysicsAttacker( self.Pilot )
		r.Target = self.Target
		r:Spawn()
		r:Fire("Kill","",20)
		r:SetAngles( self.RocketVisuals[rnd]:GetAngles() )
		r:SetVelocity( self:GetVelocity() )
		self:EmitSound( "weapons/rpg/rocketfire1.wav", 511, 80 )
		
		self:ClearTarget()
	end
	
end

function ENT:SetTarget ( t )

	self.Target = t

end

function ENT:ClearTarget()

	self.Target = nil // Clear Target

end

function ENT:FindAvoidancePoint( pos, dir, length )

	local tr,trace = {},{}
	tr.start = pos
	tr.endpos = pos + dir * length
	tr.filter = self
	tr.mask = MASK_SOLID
	trace = util.TraceLine( tr )
	
	local newPos = nil
	
	if ( trace.Hit ) then
			
		newPos = trace.HitPos + trace.HitNormal * -( length * 2 )
			
	end
	
	if ( newPos ) then
	
		local t = util.QuickTrace( trace.HitPos, newPos, self )
		
		if ( t.Hit ) then
		
			newPos = newPos + Vector( 0, 0, 1024 )
		
		end
	
	end
	
	return newPos
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	if ( IsValid( self.Pilot ) && IsValid( self.Target ) ) then
		
		
		if  ( self.Speed >	self.MaxVelocity ) then
		
			self.Speed = self.Speed - 2
			self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity * 10 )
			
		else
			
			self.Speed = self.Speed + 1
			self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
			
		end
		
		local a = self.Pilot:GetPos() + self.Pilot:GetForward() * 2000 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r
		
		local fpos = self:FindAvoidancePoint( self:GetPos(), self:GetForward(), 7000 )
		
		if ( IsValid( self.PavePenny ) ) then
			
			if ( fpos ) then
				
				self.PavePenny:SetPos( fpos )
				self:DrawLaserTracer( self:GetPos() + self:GetForward() * 7000, fpos )
			end
		
		end

		local pr = {}
		local pilotAng = self.Pilot:GetForward():Angle()
		
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed
		pr.maxangular		= self.MaxAng // 400
		pr.maxangulardamp	= self.MaxAng // 10 000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime

		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0
			
		else
		
			r = ( self.offs / self.BankingFactor ) * -1
			
		end
		
		pr.angle = pilotAng + Angle( 0, 0, r )
		
		
		phys:ComputeShadowControl(pr)
	
	end

end

