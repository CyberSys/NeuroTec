

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "Hover Car"
ENT.Model = "models/haxxer/hovercar.mdl"

// Speed Limits
ENT.MaxVelocity = 500
ENT.MinVelocity = -400

ENT.InitialHealth = 1000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 500
ENT.MinDamage = 100
ENT.BlastRadius = 256

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
	local ent = ents.Create( "sent_hovercar_p" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()

	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	
	// Misc
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	// Sound
	local esound = {}
	self.EngineMux = {}
	esound[1] = "npc/combine_gunship/dropship_onground_loop1.wav"
	esound[2] = "npc/combine_gunship/gunship_engine_loop3.wav"
	//esound[3] = "vehicles/diesel_loop2.wav"

	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 100
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:PlayEx( 511 , self.Pitch )
	
	end
	
	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	self.Yaw = 0
	self.PhysObj = self:GetPhysicsObject()
	
	//self.Started = false
	
	self.PilotSeat = ents.Create( "prop_vehicle_prisoner_pod" )
	self.PilotSeat:SetPos( self:LocalToWorld( Vector( 40, 42, 5 ) ) )
	self.PilotSeat:SetModel( "models/nova/jeep_seat.mdl" )
	self.PilotSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
	self.PilotSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
	self.PilotSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 15 ) )
	self.PilotSeat:SetParent( self )
	self.PilotSeat:SetKeyValue( "LimitView", "0" )
	self.PilotSeat:SetColor( 0,0,0,0 )
	self.PilotSeat:Spawn()
	self.PilotSeat:Fire("Locked","",0)
	
	self.SeatPos = { Vector( 40, 3.1, 5 ), Vector( 0, 42, 5 ), Vector( 0, 3.1, 5 )}
	self.Seats = {}
	
	for i=1,#self.SeatPos do
		
		self.Seats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
		self.Seats[i]:SetPos( self:LocalToWorld( self.SeatPos[i] ) )
		self.Seats[i]:SetModel( "models/nova/jeep_seat.mdl" )
		self.Seats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.Seats[i]:SetKeyValue( "limitview", "0" )
		self.Seats[i].HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
		self.Seats[i]:SetAngles( self:GetAngles() + Angle( 0, -90, 15 ) )
		self.Seats[i]:SetParent( self )
		self.Seats[i]:SetColor(0,0,0,0)
		self.Seats[i]:Spawn()
		self.Seats[i]:Fire("lock","",0)
		
	end
	
	local lp = { Vector( 146, -7, 20 ), Vector( 146, 54, 20 ) }
	local la = { Angle( -75, -3,0 ), Angle( -75,3,0 ) }
	
	self.HeadLights = {}
	self.LightsOn = false
	
	-- for i=1,#lp do
		
		-- self.HeadLights[i] = ents.Create("gmod_lamp")
		-- self.HeadLights[i]:SetPos( self:LocalToWorld( lp[i] ) )
		-- self.HeadLights[i]:SetAngles( self:GetAngles() + la[i] )
		-- self.HeadLights[i]:SetParent( self )
		-- self.HeadLights[i]:SetColor( 0,0,0,0 )
		-- self.HeadLights[i]:Spawn()
		-- self.HeadLights[i]:SetLightColor( Color ( 180,180,255 ) )
		-- self.HeadLights[i]:SetFlashlightTexture(  "effects/flashlight001" )
		-- self.HeadLights[i]:SetOn( true )
		-- self.HeadLights[i]:SetMaterial( self:GetMaterial() )
		-- self.HeadLights[i]:SetModel( "models/props_junk/PopCan01a.mdl" )
		-- self.HeadLights[i].flashlight:SetKeyValue( "lightfov", 120 )
		-- self.HeadLights[i].flashlight:SetKeyValue( "farz", 4048 )
		
	-- end
	
	self.PosLights = {}
	self.PLPos = { 
					Vector( -156, 62, 35 ), 
					Vector( -156, 55, 55 ), 
					Vector( -156, 25, 55 ), 
					Vector(  -156, -5, 55 ), 
					Vector( -156, -40, 47 ), 
					Vector( -156, -63, 35 ),
					Vector( 133, -55, 16 )
				}
	local Cols = { 
					"255 120 120", 
					"255 120 120", 
					"255 120 120", 
					"255 120 120", 
					"255 120 120", 
					"255 120 120", 
					"55 55 250"
				}
	local Mats  = {
					"sprites/orangeglow1.vmt",
					"sprites/orangeglow1.vmt",
					"sprites/orangeglow1.vmt",
					"sprites/orangeglow1.vmt",
					"sprites/orangeglow1.vmt",
					"sprites/orangeglow1.vmt",
					"sprites/light_glow02.vmt"
				}
				
	for i=1,#self.PLPos do
	
		self.PosLights[i] = ents.Create( "env_sprite" )
		self.PosLights[i]:SetParent( self )	
		self.PosLights[i]:SetPos( self:LocalToWorld( self.PLPos[i] ) ) -----143.9 -38.4 -82
		self.PosLights[i]:SetAngles( self:GetAngles() )
		self.PosLights[i]:SetKeyValue( "spawnflags", 1 )
		self.PosLights[i]:SetKeyValue( "renderfx", 0 )
		self.PosLights[i]:SetKeyValue( "scale", 0.5 )
		self.PosLights[i]:SetKeyValue( "rendermode", 9 )
		self.PosLights[i]:SetKeyValue( "HDRColorScale", .75 )
		self.PosLights[i]:SetKeyValue( "GlowProxySize", 2 )
		self.PosLights[i]:SetKeyValue( "model", Mats[i] )
		self.PosLights[i]:SetKeyValue( "framerate", "10.0" )
		self.PosLights[i]:SetKeyValue( "rendercolor", Cols[i] )
		self.PosLights[i]:SetKeyValue( "renderamt", 255 )
		self.PosLights[i]:Spawn()
	
	end
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 10000 )
		
	end

	self:StartMotionController()
	
	
end

function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then

		self.Burning = true
		local p = {}
		p[1] = self:GetPos() + self:GetForward() * -50 + self:GetRight() * 25 + self:GetUp() * 15
		p[2] = self:GetPos() + self:GetForward() * -50 + self:GetRight() * 25 + self:GetUp() * 15
		for _i=1,2 do
		
			local f = ents.Create("env_fire_trail")
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
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end

end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.8 && data.DeltaTime > 0.2 ) then 
		
		--self:SetNetworkedInt("health",self.HealthVal)
		
	end
	
end

function ENT:Use(ply,caller)

	if ( !self.IsDriving && !IsValid( self.Pilot ) ) then 
		
		self.LastUsed = CurTime()
		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsDriving = true
		self.Pilot = ply
		self.Owner = ply
		
		-- for i=1,#self.HeadLights do
		
			-- self.HeadLights[i]:SetOn( true )
			
		-- end
		
		self.Pilot:EnterVehicle( self.PilotSeat )
		
	else
	
		for i=1,#self.Seats do
						
			local d = self.Seats[i]:GetDriver()
			if( !IsValid( d ) ) then
				
				ply:EnterVehicle( self.Seats[i] )
				
				break
				
			end
			
		end		
	
	end
	
end


function ENT:EjectPilotSpecial()
	
	if ( !IsValid( self.Pilot ) ) then 
	
		return
		
	end
	
	-- self.Pilot:UnSpectate()
	-- self.Pilot:Spawn()
	-- self.Pilot:DrawViewModel( true )
	-- self.Pilot:DrawWorldModel( true )
	self.Pilot:SetNetworkedBool( "InFlight", false )
	-- self:SetNetworkedEntity("Pilot", NULL )
	
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -150 + self:GetUp() * 16 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	-- self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsDriving = false
	self:SetLocalVelocity(Vector(0,0,0))
	
	self.Pilot = NULL
	
	-- for i=1,#self.HeadLights do
	
		-- self.HeadLights[i]:SetOn( false )
		
	-- end
	
end

function ENT:Think()

	local _mod = self.Speed
	if( _mod < 0 ) then
		
		_mod = -1*_mod
		
	end
	
	self.Pitch = math.Approach( self.Pitch, math.Clamp( math.floor( ( 100 * ( _mod / 100 ) ) + ( self:GetVelocity():Length() / 7 ) ), 90,180 ), 0.25 )

	for i = 1,#self.EngineMux do
	
		self.EngineMux[i]:ChangePitch( self.Pitch - ( i * 5 ), 0.1 )
		
	end
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:EjectPilotSpecial()
			self:Remove()
		
		end
		
	end
	
	
	
	if ( self.IsDriving && IsValid( self.Pilot ) ) then
		
		if( self.Pilot:KeyDown( IN_USE ) && self.LastUsed + 0.5 <= CurTime() ) then
			
			self:EjectPilotSpecial()
			self.LastUsed = CurTime()
			
			return
			
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilotSpecial()
			
		end
		
	end
		
	self:NextThink( CurTime() )
	return true
	
end

local function apr(a,b,c)
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end

function ENT:PhysicsUpdate()
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local tr, trace = {}
	local hitcount = 0
	local _a = self:GetAngles()
	local z = 0

	for i=1,15 do
		
		tr.start = self:GetPos() + self:GetForward() * -200 + self:GetForward() * ( i * 60 ) + self:GetUp() * 15
		tr.endpos = self:GetPos() + self:GetForward() * -200 + self:GetForward() * ( i * 60 ) + self:GetUp() * -50000
		tr.filter = self
		tr.mask = MASK_SOLID + MASK_WATER
		-- //self:DrawLaserTracer( self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetRight() * dir, self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetUp() * -17  + self:GetRight() * dir )
		
		trace = util.TraceLine( tr )
		
		if( trace.Hit && !trace.HitSky ) then
			
			hitcount = hitcount + 1
			z = z + trace.HitPos.z
			
		end

		
	end
	
	local average = 0
	
	if( hitcount > 0 ) then
	
		average = z / hitcount
	
	end

	if( self.IsDriving && IsValid( self.Pilot ) ) then
		
		if ( hitcount > 2 ) then
		
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
			local p = { { Key = IN_FORWARD, Speed = 1.15 };
						{ Key = IN_BACK, Speed = -0.85 }; }
			
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
					
				self.Speed = self.Speed * 0.9
				
			end
			
			local dir = 0
			
			self.Speed = math.Clamp( self.Speed,  -100, 150 )//-10.8, 10.88 )
			
			if( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
						
				self.Yaw = math.Approach( self.Yaw, 0.89, 0.052 )
				dir = -0.2
				
			elseif( self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
			
				self.Yaw = math.Approach( self.Yaw, -0.89, 0.052 )
				dir = 0.2
				
			else
				
				self.Yaw = math.Approach( self.Yaw, 0, 0.02 )
			
			end
			
			
			local p = self:GetPos()
			local tr, trace = {},{}
			tr.start = self:GetPos() + self:GetUp() * -50 
			tr.endpos = tr.start + self:GetForward() * 4500 + Vector( 0,0,-5000 )
			tr.filter = { self, self.Pilot }
			tr.mask = MASK_SOLID + MASK_WATER
			trace = util.TraceLine( tr )
		
			local a = self:GetAngles()
			local desiredAngle
			if( trace.Hit && self.Speed > 25 ) then
				
				desiredAngle = trace.HitNormal:Angle().p - 270
			
			else
			
				desiredAngle = 0
				
			end
			
			p.z = average + 1500 + self.Speed
			
			local downparam = ap.p
			if( downparam > 0 ) then downparam = 0 end
			//self.Pilot:PrintMessage( HUD_PRINTCENTER, self.Speed )
			
			local pr = {}
			pr.secondstoarrive	= 0.1
			pr.pos 				= p + self:GetForward() * self.Speed + self:GetUp() * 1.11
			pr.maxangular		= 1000
			pr.maxangulardamp	= 1000
			pr.maxspeed			= 19
			pr.maxspeeddamp		= 12.95 //13
			pr.dampfactor		= 0.21 //.05 // 1.5
			pr.teleportdistance	= 10000
			pr.deltatime		= deltatime
			pr.angle = Angle( Lerp( 0.01, a.p, math.Clamp(  desiredAngle, -5, 5 ) ), mYaw + self.Yaw, -self.Yaw * 9  )
			
			
			phys:ComputeShadowControl(pr)
		
		else
			
			local pr = {}
			pr.secondstoarrive	= 0.1
			pr.pos 				= self:GetPos() + self:GetForward() * self.Speed + Vector( 0,0,-0.75 )
			pr.maxangular		= 1000
			pr.maxangulardamp	= 1000
			pr.maxspeed			= 19
			pr.maxspeeddamp		= 12.95 //13
			pr.dampfactor		= 0.1 //.05 // 1.5
			pr.teleportdistance	= 10000
			pr.deltatime		= deltatime
			pr.angle = self:GetAngles()
			
			phys:ComputeShadowControl(pr)
		
			--self.Speed = math.Approach( self.Speed, 0, 0.05 )
		
		end	
	
	else
			
			local pr = {}
			pr.secondstoarrive	= 0.1
			pr.pos 				= self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * 0.65
			pr.maxangular		= 1000
			pr.maxangulardamp	= 1000
			pr.maxspeed			= 19
			pr.maxspeeddamp		= 12.95 //13
			pr.dampfactor		= 0.1 //.05 // 1.5
			pr.teleportdistance	= 10000
			pr.deltatime		= deltatime
			pr.angle = Angle( 0, self:GetAngles().y, 0 )
			
			phys:ComputeShadowControl(pr)
	
	
	end
end

