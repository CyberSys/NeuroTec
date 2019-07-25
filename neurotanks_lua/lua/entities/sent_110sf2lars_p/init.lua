
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "URAL / Launch Pod"
ENT.Model = "models/spec45as/arma2/ural-vehicle-2xosniy-base.mdl"

// Speed Limits
ENT.MaxVelocity = 50
ENT.MinVelocity = -50

ENT.InitialHealth = 1700
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 500
ENT.MinDamage = 100
ENT.BlastRadius = 256
ENT.CannonPitch = 0
ENT.Range = 1000
ENT.Reloading = false

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 180,0)
	local ent = ents.Create( "sent_110sf2lars_p" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()

	self:TankAddLiquidsBase()
	
	self.TowerAngle = 0
	
	self.LastReminder = CurTime()
	
	self.DamageTakenFront = 0
	self.DamageTakenRear = 0
	self.DamageTakenRight = 0
	self.DamageTakenLeft = 0
	self.EngineBroken = false
	self.BrokenYaw = 0 -- Huurrr
	
	self.ArmorThicknessFront = 0.1
	self.ArmorThicknessRear = 0.1
	self.ArmorThicknessSide = 0.1
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self:SetNetworkedInt("MaxRange",self.MaxRange)
	self:SetNetworkedInt("MinRange",self.MinRange)
	self:SetNetworkedInt("ArtilleryAccuracy",self.ArtilleryAccuracy)
	self.Yaw = 0
	
	// Misc
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	
	local baseprop = ents.Create("prop_physics_override")
	baseprop:SetModel( "models/props_wasteland/kitchen_counter001d.mdl" )
	baseprop:SetPos( self:LocalToWorld( Vector( 0, -102,18 ) ) )-- self:GetPos() + self:GetForward() * -102 + self:GetUp() * 71 )
	baseprop:SetParent( self )
	baseprop:SetColor( Color( 0, 45, 0, 25 ) )
	baseprop:SetSkin( self:GetSkin() )
	baseprop:SetAngles( self:GetAngles() + Angle( 0, 0, 0 ) )
	baseprop:Spawn()
	
	self.Tower = ents.Create("prop_physics_override")
	self.Tower:SetModel("models/wic/ground/110sf2/110sf2_turret.mdl")
	self.Tower:SetPos( self:LocalToWorld( Vector( 0, -102, 39 ) ) )-- self:GetPos() + self:GetForward() * -102 + self:GetUp() * 71 )
	self.Tower:SetParent( self )
	self.Tower:SetSkin( self:GetSkin() )
	self.Tower:SetAngles( self:GetAngles() + Angle( 0, 90, 0 ) )
	self.Tower:Spawn()
	self.TowerPhys = self.Tower:GetPhysicsObject()	
	if ( self.TowerPhys:IsValid() ) then
	
		self.TowerPhys:Wake()
		self.TowerPhys:EnableGravity( true )
		-- //self.TowerPhys:EnableDrag( true )
		
	end
	
	self.Barrel = ents.Create("prop_physics_override")
	self.Barrel:SetModel("models/wic/ground/110sf2/110sf2_cannon.mdl")
	self.Barrel:SetPos( self:LocalToWorld( Vector( 0, -145, 49 ) ) ) -- self:GetPos() + self:GetForward() * -145 + self:GetUp() * 81 )
	self.Barrel:SetParent( self.Tower )
	self.Barrel:SetSkin( self:GetSkin() )
	self.Barrel:SetAngles( self:GetAngles() + Angle( 0, 90, 0 ) )
	self.Barrel:Spawn()
	self.BarrelPhys = self.Barrel:GetPhysicsObject()
	
	if ( self.BarrelPhys:IsValid() ) then
	
		self.BarrelPhys:Wake()
		self.BarrelPhys:EnableGravity( true )
		//self.BarrelPhys:EnableDrag( true )
		
	end
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 1 )
		
	end
	

	
	self:StartMotionController()
	
	self.Truck = ents.Create("prop_vehicle_jeep")
	self.Truck:SetPos( self:GetPos() )
	self.Truck:SetAngles( self:GetAngles() )
	self.Truck:SetModel( "models/spec45as/arma2/ural-vehicle-2xosniy-base.mdl"  )
	self.Truck:SetKeyValue("vehiclescript", "scripts/vehicles/ural.txt")
	
	self.Truck:SetSkin( math.random(1,9) )
	self.Truck:Spawn()
	self.Truck:Activate()
	self.Truck:Fire("turnon",0,0)
	self.Truck:Fire("handbrakeoff",0,0)
	self.Truck:Fire("Lock",0,0)
	self.Truck.IsNeuroGroundVehicle = true
	
	self:SetAngles( self.Truck:GetAngles() + Angle( 0, 0, 0 ) )
	-- self:SetParent( self.Truck )
	self:SetPos( self.Truck:GetPos() + self.Truck:GetUp() * 32 )
	local weld = constraint.Weld( self, self.Truck, 0,0,0 )
	local collide = constraint.NoCollide( self.Truck, self, 0, 0)	
		
	self:SetColor( Color( 0,0,0,0 ) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetSkin( math.random(0,1 ) )
	
	self.SeatPos = { Vector( 30, 45, 63 ), Vector( 5, 45, 63 ) }
	self.Seats = {}
	
	for i=1,#self.SeatPos do
		
		self.Seats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
		self.Seats[i]:SetPos( self.Truck:LocalToWorld( self.SeatPos[i] ) )
		self.Seats[i]:SetModel( "models/nova/jeep_seat.mdl" )
		self.Seats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.Seats[i]:SetKeyValue( "limitview", "0" )
		self.Seats[i].HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
		self.Seats[i]:SetAngles( self:GetAngles() + Angle( 0, 0, 0 ) )
		self.Seats[i]:SetParent( self.Truck )
		self.Seats[i]:SetColor( Color( 0,0,0,0) )
		self.Seats[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
		self.Seats[i]:Spawn()
		self.Seats[i]:Fire("Lock",0,0)
	
	end
		
end

function ENT:OnTakeDamage(dmginfo)
		
	self:TankDefaultTakeDamage( dmginfo )
	
end

function ENT:OnRemove()

	-- for i=1,3 do
	
		-- self.EngineMux[i]:Stop()
		
	-- end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilotSpecial()
	
	end

	if( IsValid( self.Truck ) ) then
		
		self.Truck:Remove()
	
	end
	
end

function ENT:PhysicsCollide( data, physobj )

	timer.Simple(0,function()
	if ( data.Speed > self.MaxVelocity * 0.8 && data.DeltaTime > 0.2 ) then 
		
		--self:SetNetworkedInt("health",self.HealthVal)
		
	end
	end)
	
end

function ENT:Use(ply,caller)

	if ( !self.IsDriving && !IsValid( self.Pilot ) ) then 
		
		ply:PrintMessage( HUD_PRINTCENTER, "Hold Jump and use WASD to aim the tower" )
		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsDriving = true
		self.Pilot = ply
		self.Owner = ply
		self.Pilot:EnterVehicle( self.Truck )
		-- ply:Spectate( OBS_MODE_CHASE  )
		-- ply:DrawViewModel( false )
		-- ply:DrawWorldModel( false )
		-- ply:StripWeapons()
		ply:SetScriptedVehicle( self )
		
		ply:SetNetworkedBool("InFlight",true)
		ply:SetNetworkedEntity( "Tank", self )
		ply:SetNetworkedEntity( "Tower", self.Tower)
		ply:SetNetworkedEntity( "Barrel", self.Barrel )
		-- ply:SetNetworkedEntity( "Weapon", self.MGun )
		self:SetNetworkedEntity("Pilot", ply )
		self.LastUse = CurTime() + 1
		self:NextThink(CurTime() + 1 )

	end
	
end


function ENT:EjectPilotSpecial()
	
	if ( !IsValid( self.Pilot ) ) then 
	
		return
		
	end
	
	-- self.Pilot:UnSpectate()
	-- self.Pilot:DrawViewModel( true )
	-- self.Pilot:DrawWorldModel( true )
	-- self.Pilot:Spawn()
	self.Pilot:SetNetworkedBool( "InFlight", false )
	self.Pilot:SetNetworkedEntity( "Tank", NULL ) 
	self.Pilot:SetNetworkedEntity( "Tower", NULL)
	self.Pilot:SetNetworkedEntity( "Barrel", NULL )
	self.Pilot:SetNetworkedEntity( "Gun", NULL )
	self.Pilot:SetNetworkedEntity( "Weapon", NULL )
	self:SetNetworkedEntity("Pilot", NULL )
	
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -100 + self:GetUp() * 16 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsDriving = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = NULL
	
end

function ENT:Think()
	
	self:CheckFluids()
	self:TankFuelChecker()
	
	if( IsValid( self.Pilot ) && !self.Pilot:Alive() ) then
		
		self:EjectPilotSpecial()
		
	end
	
	--if( self.HealthVal < 0 ) then self:
	
	for k,v in pairs( player.GetAll() ) do
		
		if( v:GetPos():Distance( self:GetPos() ) < 100 && v:KeyDown( IN_USE ) ) then
			
			if( v.LastUseKeyDown && v.LastUseKeyDown + 1.5 > CurTime() ) then return end
			
			local tr,trace = {},{}
			tr.start = v:GetShootPos()
			tr.endpos = tr.start + v:GetAimVector() * 150
			tr.filter = v
			trace = util.TraceLine( tr )
			
			if( trace.Hit && ( trace.Entity == self || trace.Entity == self.Truck || trace.Entity:GetOwner() == self ) ) then
				
				if( v == self.Pilot ) then return end
				if( !IsValid( self.Pilot ) ) then
					
					self:Use( v, v, 0, 0 )
					
					break
					
				end
				
				for i=1,#self.Seats do
					
					local d = self.Seats[i]:GetDriver()
					
					if( !IsValid( d ) ) then
						
						v:EnterVehicle( self.Seats[i] )
						v.LastUseKeyDown = CurTime()
						
						break
						
					end
					
				end
			
			end
		
		end
		
	end
	
	self.Tower:SetSkin( self:GetSkin() )
	self.Barrel:SetSkin( self:GetSkin() )
	-- self.MGun:SetSkin( self:GetSkin() )
	
	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	-- for i = 1,3 do
	
		-- self.EngineMux[i]:ChangePitch( self.Pitch, 0.1 )
		
	-- end
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:EjectPilotSpecial()
			-- self:Remove()
		
		end
		
	end
	
	if ( self.IsDriving && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 50 )
			
		if( self.Pilot:KeyDown( IN_USE ) && self.LastUse <= CurTime() ) then
			
			self.LastUse = CurTime() + 0.5
			self:EjectPilotSpecial()
			
			
			return
			
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilotSpecial()
			
			return
			
		end

		// Attack
		if ( self.Pilot:KeyDown( IN_ATTACK ) ) then
			
			if( self:GetVelocity():Length() > 50 ) then
				
				self.Pilot:PrintMessage( HUD_PRINTCENTER, "You can't fire while moving!" )
				
			else
			
				self:LaunchArtilleryStrike()
			
			end
			
		end
		
		if ( IsValid(self.Tower) && IsValid( self.Barrel) ) then
			local _b = self.Barrel:GetAngles()
			self.Range = math.abs(self.MaxRange*math.sin( math.rad(_b.p) )) + self.MinRange
			self:SetNetworkedInt("Range",self.Range)
		end
		
	end

	self:NextThink( CurTime() )
	return true
	
end

function ENT:LaunchMissile(shootpos)

			local fx = EffectData()
			fx:SetStart( self:GetPos() )
			fx:SetOrigin( self:GetPos() + self:GetRight() * 100 + self:GetUp() * 15  )
			fx:SetNormal( self:GetUp() )
			fx:SetMagnitude( 50 )
			fx:SetScale( 500.0 )
			fx:SetRadius( 500 )
			util.Effect( "ThumperDust", fx )
			
			local tr, trace = {},{}
			-- tr.start = self.Pilot:GetShootPos()
			-- tr.endpos = self.Pilot:GetAimVector() * 150000
			tr.start = self.Tower:GetPos()
			tr.endpos = self.Tower:GetPos() + self.Tower:GetForward() * self.Range			
			tr.filter = { self, self.Barrel, self.Tower, self.Pilot }
			-- tr.mask = MASK_SOLID
			tr.mask = MASK_aLL
			
			trace = util.TraceLine( tr )
			
			local tr2, trace2 = {},{}
			tr2.start = tr.endpos
			tr2.endpos = tr.endpos + Vector(0,0,-100000)
			trace2 = util.TraceLine( tr2 )

			local Shell = ents.Create( "sent_lars_missile" )
			Shell:SetModel( "models/gibs/HGIBS.mdl" )
			Shell:SetPos( self.Barrel:LocalToWorld( shootpos ) )
			Shell:SetAngles( self.Barrel:GetAngles() + Angle( math.Rand( -.5,.5), math.Rand( -1.5,1.5), math.Rand( -.5,.5) ) )
			Shell:Spawn()
			Shell.Owner = self.Pilot
			Shell:Activate() 
			Shell:GetPhysicsObject():Wake()
			Shell:GetPhysicsObject():SetMass( 10 )
			-- Shell:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * 95000 )
			Shell:EmitSound( "bf2/tanks/d30_artillery_fire.mp3", 511, math.random( 70, 100 ) )
			
			local ArtAc =self.ArtilleryAccuracy
			Shell.ImpactPoint = trace2.HitPos --+ //Vector(math.Rand(0,50*(10-ArtAc)),math.Rand(0,50*(10-ArtAc)),0)

			local e1 = EffectData()
			e1:SetStart( self.Barrel:LocalToWorld( shootpos ) )
			e1:SetNormal( Shell:GetForward() )
			e1:SetEntity( Shell )
			e1:SetScale( 1.5 )
			util.Effect( "tank_muzzle", e1 )
			
			local e1 = EffectData()
			e1:SetStart( Shell:GetPos() )
			e1:SetNormal( Shell:GetForward() )
			e1:SetOrigin( Shell:GetPos() )
			e1:SetEntity( Shell )
			e1:SetScale( 1.5 )
			util.Effect( "Launch2", e1 )

end

function ENT:LaunchArtilleryStrike()
	
	if ( !self ) then // silly timer errors.		
		
		return		
	
	end
	
	
	if  ( self.BulletDelay < CurTime() ) then	
		local barrelpos = { Vector( 142, 46, 20.5 ), Vector( 142, -18, 20.5 ) }
		
		self.BulletDelay = CurTime() + 12.5
			
		for i=0,5 do 
		timer.Simple(i/4, function() 	
							if (IsValid( self )) then
							self:LaunchMissile(Vector( 138, 46-i*5.6, 20.5 ))
							end 
					end)
		end
		for i=6,11 do 
		timer.Simple(i/4, function()
							if (IsValid( self )) then
							self:LaunchMissile(Vector( 138, -18-5.6*(i-6), 20.5 ))
							end 
					end)
		end
	
	end
end

function ENT:PhysicsUpdate()

	if ( self.IsDriving && self.Pilot && self.Pilot:KeyDown( IN_JUMP )) then

		self:GetPhysicsObject():Wake()
		self.Barrel:GetPhysicsObject():Wake()
		self.Tower:GetPhysicsObject():Wake()
		
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()

		local _t = self.Tower:GetAngles()
		local _b = self.Barrel:GetAngles()

	
		if( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
		
			self.TowerAngle = self.TowerAngle - 0.45
		
		elseif( self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
			
			self.TowerAngle = self.TowerAngle + 0.45
			
		end
		

		
		local angg = self:GetAngles() 
		angg:RotateAroundAxis( self:GetUp(), 90 + -self.TowerAngle )

		self.Tower:SetAngles( LerpAngle( 0.008, _t, angg ) )
		_t = self.Tower:GetAngles()
		
		if ( self.Pilot:KeyDown( IN_FORWARD ) ) then
			self.CannonPitch = self.CannonPitch - 0.25
		elseif ( self.Pilot:KeyDown( IN_BACK ) ) then
			self.CannonPitch = self.CannonPitch + 0.25
		end
		
		if ( self.CannonPitch < -46 ) then self.CannonPitch = -46 end
		if ( self.CannonPitch > -0.5 ) then self.CannonPitch = -0.5 end

		-- self.Barrel:SetAngles( Angle( _t.p + self.CannonPitch, _t.y, _t.r ) )
		self.Barrel:SetAngles( LerpAngle( 0.08, _b, Angle( _t.p + self.CannonPitch, _t.y, _t.r ) ) ) 
		
	end
	
end

function ENT:CheckOnGround()

	local tr, trace = {},{}
	
	local hitcount = 0
	
	for i=1,10 do
		
		tr[i].start = self:GetPos() + self:GetForward() * -256 + self:GetForward() * ( i * 51.2 )
		tr[i].endpos = self:GetPos() + self:GetForward() * -256 + self:GetForward() * ( i * 51.2 ) + self:GetUp() * -72
		tr[i].filter = self
		tr[i].mask = MASK_SOLID
		
		trace[i] = util.TraceLine( tr )
			
		if( trace.HitWorld ) then
			
			hitcount = hitcount + 1
		
		end
		
	end
	
	if ( hitcount >= 5 ) then
		
		return true
	
	end
	
	return false
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local tr, trace = {}
	local hitcount = 0
	local _a = self:GetAngles()
	local z = 0

	for i=1,20 do
		
		tr.start = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetRight() * math.sin(CurTime()) * 50
		tr.endpos = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetUp() * -14  + self:GetRight() * math.sin(CurTime()) * 50
		tr.filter = self
		tr.mask = MASK_SOLID
		//self:DrawLaserTracer( self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetRight() * dir, self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetUp() * -17  + self:GetRight() * dir )
		
		trace = util.TraceLine( tr )
		
		if( trace.Hit && !trace.HitSky ) then
			
			hitcount = hitcount + 1
			//z = z + trace.HitPos.z
			
		end

		
	end


	if( hitcount < 10 ) then
		
		//self.Speed = math.Approach( self.Speed, 0, 0.02 )
		
	end
	
	if ( self.IsDriving && IsValid( self.Pilot ) && hitcount > 5 && !self.Pilot:KeyDown( IN_JUMP ) ) then
	
		phys:Wake()
		
		if( self:GetVelocity():Length() > 50 && hitcount > 6 ) then			
						
			local fx = EffectData()
			fx:SetOrigin( self:GetPos() + self:GetForward() * -60 )
			fx:SetScale( 2.0 )
			util.Effect("WheelDust", fx )
			
		end
		
		local mYaw = self:GetAngles().y
		local ap = self:GetAngles()
		local dir = Angle( 0,0,0 )
		local p = { { Key = IN_FORWARD, Speed = 0.65 };
					{ Key = IN_BACK, Speed = -0.65 }; }
		
		local keydown = false
		
		for k,v in ipairs( p ) do
		
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed
				keydown = true
				
			end			
			
		end
		
		if( !keydown ) then
			
			self.Speed = math.Approach( self.Speed, 0, 0.6 )
				
		end
		
		if( self.Pilot:KeyDown( IN_JUMP ) ) then
				
			self.Speed = self.Speed * 0.99
			
		end
		
		local dir = 0
		
		self.Speed = math.Clamp( self.Speed,  -100, 100 )//-10.8, 10.88 )
		
		if( self.Speed > 5 ) then
		
			if( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
						
				self.Yaw = math.Approach( self.Yaw, 0.44, 0.052 )
				dir = -0.2
				
			elseif( self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
			
				self.Yaw = math.Approach( self.Yaw, -0.44, 0.052 )
				dir = 0.2
				
			else
				
				self.Yaw = math.Approach( self.Yaw, 0, 0.02 )
			
			end
		
		
		else
			
			self.Yaw = 0
		
		end
		
		local p = self:GetPos()
		local pr = {}
		pr.secondstoarrive	= 0.1
		pr.pos 				= p + self:GetForward() * self.Speed
		pr.maxangular		= 1000
		pr.maxangulardamp	= 1000
		pr.maxspeed			= 19
		pr.maxspeeddamp		= 12.95 //13
		pr.dampfactor		= 0.1 //.05 // 1.5
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( self:GetAngles().p, mYaw + self.Yaw, self:GetAngles().r )
		
		phys:ComputeShadowControl(pr)
	
	else
		
		self.Speed = math.Approach( self.Speed, 0, 0.1 )
	
	end	
end



