
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')



function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "sent_2s7pion_p" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	ent:SetSkin( math.random(0, 2) )
	return ent
	
end



function ENT:Initialize()
	
	self:TankAddLiquidsBase()
	
	self.Ai_sound = ents.Create("ai_sound")
	self.Ai_sound:SetPos( self:GetPos() )
	self.Ai_sound:SetParent( self )
	self.Ai_sound:SetKeyValue("soundtype","8")
	self.Ai_sound:SetKeyValue("volume","15000")
	self.Ai_sound:SetKeyValue("duration","3")
	self.Ai_sound:Spawn()
	self.Ai_sound:Fire("EmitAISound","",0)
	self.LastReminder = CurTime()
	
	self.DamageTakenFront = 0
	self.DamageTakenRear = 0
	self.DamageTakenRight = 0
	self.DamageTakenLeft = 0
	self.EngineBroken = false
	self.BrokenYaw = 0 -- Huurrr
	

	
	self.ArmorThicknessFront = 0.19
	self.ArmorThicknessRear = 0.1
	self.ArmorThicknessSide = 0.16
		
	self:SetNetworkedInt("Range", 12000 )
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self.LastAlarm = CurTime()
	
	self.ArtilleryToggle = true
	self.LandMines = {}
	
	self.LastLandMine = CurTime()
	self.LastSeatChange = CurTime()
	self.LastSmokeTick = CurTime()
	self.LastArtilleryMode = CurTime()
	self.LastLaunch = CurTime() + 1.0
	
	self.ForceVariable = 0
	
	
	// Misc
	self:SetModel("models/wic/ground/2s7 pion/2s7 pion_body.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self.Yaw = 0
	
	// Sound
	local esound = {}
	self.EngineMux = {}
	esound[1] = "wot/tigeri/idle.wav"
	esound[2] = "wot/tigeri/idle.wav"
	esound[3] = "wot/tigeri/idle.wav"
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 80

	
	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	
	self.Cannon = ents.Create("prop_physics_override")
	self.Cannon:SetModel("models/wic/ground/2s7 pion/2s7 pion_cannon.mdl")
	self.Cannon:SetPos( self:GetPos() + self:GetForward() * -152 + self:GetRight() * 0 + self:GetUp() * 94 )
	self.Cannon:SetParent( self )
	self.Cannon:SetSkin( self:GetSkin() )
	self.Cannon:SetAngles( self:GetAngles() )
	self.Cannon:SetColor( Color ( 255,255,255, 255 ) )
	
	self.Cannon:Spawn()
	self.CannonPhys = self.Cannon:GetPhysicsObject()	
	if ( self.CannonPhys:IsValid() ) then
	
		self.CannonPhys:Wake()
		self.CannonPhys:EnableGravity( true )
		//self.CannonPhys:EnableDrag( true )
		
	end

	self.Barrel = ents.Create("prop_physics_override")
	self.Barrel:SetModel("models/wic/ground/2s7 pion/2s7 pion_cannon.mdl")
	self.Barrel:SetPos( self:GetPos() + self:GetForward() * -152 + self:GetRight() * 0 + self:GetUp() * 94 )
	self.Barrel:SetParent( self.Cannon )
	self.Barrel:SetSkin( self:GetSkin() )
	self.Barrel:SetAngles( self:GetAngles() )
	self.Barrel:Spawn()
	self.BarrelPhys = self.Barrel:GetPhysicsObject()	
	if ( self.BarrelPhys:IsValid() ) then
	
		self.BarrelPhys:Wake()
		self.BarrelPhys:EnableGravity( true )
		//self.BarrelPhys:EnableDrag( true )
		
	end
	
	-- Hackfix until garry implements GetPhysicsObjectNum/count on the client.
	self.CannonProp = ents.Create("prop_physics_override")
	self.CannonProp:SetPos( self.Cannon:GetPos() + self:GetForward() * -154 + self:GetRight() * -32 + self:GetUp() * 94 )
	self.CannonProp:SetAngles( self.Cannon:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.CannonProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.CannonProp:SetParent( self.Cannon )
	self.CannonProp:SetColor( Color(  0,0,0,0 ) )
	self.CannonProp:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.CannonProp:Spawn()
	
	self.BarrelProp = ents.Create("prop_physics_override")
	self.BarrelProp:SetPos( self.Barrel:GetPos() + self.Barrel:GetAngles():Forward() * 469 )
	self.BarrelProp:SetAngles( self.Cannon:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.BarrelProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.BarrelProp:SetParent( self.Barrel )
	self.BarrelProp:SetColor( Color( 0,0,0,0 ) )
	self.BarrelProp:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.BarrelProp:Spawn()

	self.Stopper = ents.Create("prop_physics_override")
	self.Stopper:SetModel("models/wic/ground/2s7 pion/2s7 pion_stopper.mdl")
	self.Stopper:SetPos( self:GetPos() + self:GetForward() * -177 + self:GetUp() * 23 )
	self.Stopper:SetParent( self )
	self.Stopper:SetSkin( self:GetSkin() )
	self.Stopper:SetAngles( self:GetAngles() )
	self.Stopper:Spawn()
	self.StopperPhys = self.Stopper:GetPhysicsObject()	
	if ( self.StopperPhys:IsValid() ) then
	
		self.StopperPhys:Wake()
		self.StopperPhys:EnableGravity( true )
		//self.BarrelPhys:EnableDrag( true )
		
	end


	constraint.NoCollide( self.Cannon, self, 0, 0 )
	constraint.NoCollide( self.Cannon, self.Barrel, 0, 0 )
	constraint.NoCollide( self.Barrel, self, 0, 0 )

	self.SeatPos = { Vector( 129, -24, 57 ), Vector( 129, 24, 57 ) }
	self.Seats = {}
	self.MountedGuns = {}
	
	for i=1,#self.SeatPos do
		
		self.Seats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
		self.Seats[i]:SetPos( self:LocalToWorld( self.SeatPos[i] ) )
		self.Seats[i]:SetModel( "models/nova/jeep_seat.mdl" )
		self.Seats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.Seats[i]:SetKeyValue( "limitview", "60" )
		self.Seats[i].HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
		self.Seats[i]:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
		self.Seats[i]:SetParent( self )
		self.Seats[i]:SetColor( Color( 0,0,0,0) )
		self.Seats[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
		self.Seats[i]:Spawn()
		self.Seats[i].isChopperGunnerSeat = true
		
		self.MountedGuns[i] = ents.Create( "prop_physics_override" )
		self.MountedGuns[i]:SetPos( self.Seats[i]:LocalToWorld(  Vector( 0, 19, 27 ) ) )
		self.MountedGuns[i]:SetAngles( self:GetAngles() )
		self.MountedGuns[i]:SetModel( "models/weapons/hueym60/m60.mdl"  )
		self.MountedGuns[i]:SetParent( self )
		self.MountedGuns[i]:SetSolid( SOLID_NONE )
		self.MountedGuns[i].LastAttack = CurTime()
		self.MountedGuns[i]:Spawn()
		
		self.Seats[i].MountedWeapon = self.MountedGuns[i]
		
	end
	
	
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 10000 )
		
	end

	self:StartMotionController()

end

function ENT:OnTakeDamage(dmginfo)
		
	self:TankDefaultTakeDamage( dmginfo )
	
end

function ENT:OnRemove()

	for i=1,3 do
	
		self.EngineMux[i]:Stop()
		
	end
	
	for k,v in pairs( self.LandMines ) do
		
		if( IsValid( v ) ) then
			
			v:Fire("kill","",10)
			
		end
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilotSpecial()
	
	end
	self.BarrelProp:Remove()
	
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

		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsDriving = true
		self.Pilot = ply
		self.Owner = ply 
		 
		ply:Spectate( OBS_MODE_CHASE  )
		ply:DrawViewModel( false )
		ply:DrawWorldModel( false )
		ply:StripWeapons()
		ply:SetScriptedVehicle( self )
		
		ply:SetNetworkedBool("InFlight",true)
		
		ply:SetNetworkedEntity( "Tank", self )
		ply:SetNetworkedEntity( "Cannon", self.CannonProp )
		ply:SetNetworkedEntity( "Barrel", self.BarrelProp )
		ply:SetNetworkedEntity( "Tower", self )
		self:SetNetworkedEntity("Pilot", ply )
		self.LastUse = CurTime()
		self:NextThink( CurTime() + 1 )
		
		self:EmitSound( "vehicles/jetski/jetski_no_gas_start.wav", 511, 100 )
		
		timer.Simple( 0.8, 
			function() if ( IsValid( self ) ) then
		
				self.EngineMux[1]:PlayEx( 500 , self.Pitch )
				self.EngineMux[2]:PlayEx( 500 , self.Pitch )
				self.EngineMux[3]:PlayEx( 500 , self.Pitch )
				self:SetNetworkedBool("StartEmitters",true)
				
			end
			
		end )
		
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
	
	self.Pilot:UnSpectate()
	self.Pilot:DrawViewModel( true )
	self.Pilot:DrawWorldModel( true )
	self.Pilot:Spawn()
	self.Pilot:SetNetworkedBool( "InFlight", false )
	self:SetNetworkedBool("StartEmitters",false)
	self.Pilot:SetNetworkedEntity( "Tank", NULL ) 
	self.Pilot:SetNetworkedEntity( "Barrel", NULL )
	self:SetNetworkedEntity("Pilot", NULL )
	
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -150 + self:GetUp() * 25 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsDriving = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = NULL
	
	for i=1,3 do
	
		self.EngineMux[i]:Stop()
		
	end
	
	self:EmitSound( "ambient/machines/sputter1.wav", 511, 100 )
	
end

function ENT:Think()
	
	self:CheckFluids()
	self:TankFuelChecker()
	
	self.Cannon:SetSkin( self:GetSkin() )
	self.Barrel:SetSkin( self:GetSkin() )
	
	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	if ( IsValid(self.Tower) && IsValid( self.Barrel) ) then
	
		local _b = self.Barrel:GetAngles()
		self.Range = math.abs(self.MaxRange*math.sin( math.rad(_b.p) )) + self.MinRange
		self:SetNetworkedInt("Range",self.Range)

	end
		
	for i = 1,3 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.1 )
		
	end
	
	if ( self.Destroyed ) then 
		
		if( math.random(1,3) == 2 && self:WaterLevel() < 1 ) then
			
			local effectdata = EffectData()
			effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
			util.Effect( "immolate", effectdata )
			
		end
		
		
	end
	
	
	
	if ( self.IsDriving && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 82 )

		if( self.Pilot:KeyDown( IN_USE ) && self.LastUse + 0.5 <= CurTime() ) then
			
		
			self:EjectPilotSpecial()
			self.LastUse = CurTime()
			
			
			return
			
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilotSpecial()
			
		end
		
		
		-- if( self.Pilot:KeyDown( IN_JUMP ) && self.LastSmokeTick + 0.4 <= CurTime() ) then
		
			-- self.LastSmokeTick = CurTime()
			
			-- local fx = EffectData()
			-- fx:SetOrigin( self:GetPos() )
			-- fx:SetScale( 0.8 )
			-- fx:SetNormal( self:GetUp() )
			-- util.Effect("nn_smokescreen", fx )
			
			-- self:EmitSound( "ambient/machines/sputter1.wav", 100, 100 )
			
			-- self.Pilot:PrintMessage( HUD_PRINTCENTER, "Deploying Smoke Screen" )
		
		-- end
		
		
		-- // Attack
		-- if ( self.Pilot:KeyDown( IN_ATTACK ) ) then
		--			if ( self.ChopperGunAttack + 0.1 <= CurTime() ) then
					
					-- self:PrimaryAttack()
		-- end	
		-- end

		if ( self.Pilot:KeyDown( IN_RELOAD ) && self.LastLandMine + 1.5 <= CurTime() ) then			

			
			--//self:ArtilleryStrike()
			self.LastLandMine = CurTime()
			
			local nm = #self.LandMines+1
			
			if( nm < 20 ) then
				
				self.LandMines[nm] = ents.Create("sent_bouncingbetty")
				self.LandMines[nm]:SetPos( self:LocalToWorld( Vector( -48, 0, -5 ) ) )
				self.LandMines[nm]:SetAngles( self:GetAngles() )
				self.LandMines[nm]:SetOwner( self )
				self.LandMines[nm].Owner = self.Pilot
				self.LandMines[nm].Spawner = self.Pilot
				self.LandMines[nm]:SetPhysicsAttacker( self.Pilot )
				self.LandMines[nm]:Spawn()
				
				self:EmitSound( "ambient/machines/catapult_throw.wav", 511, 100 )
				
				local fx = EffectData()
				fx:SetOrigin( self.LandMines[nm]:GetPos() )
				fx:SetStart( self.LandMines[nm]:GetPos() )
				fx:SetNormal( self.LandMines[nm]:GetUp() )
				fx:SetScale( 0.17 )
				util.Effect( "ManhackSparks", fx )
			
			
			end
				

		end
		
		if ( self.Pilot:KeyDown( IN_ATTACK2 ) && self.LastLaunch <= CurTime() ) then
			
			if( self:GetVelocity():Length() < 10 ) then
				
				
				local mp = self:GetAngles().p
				local bp = self.Barrel:GetAngles().p
				
				if( self.LastAlarm + 3.2 <= CurTime() ) then
				
					self.Barrel:EmitSound( "npc/attack_helicopter/aheli_megabomb_siren1.wav", 150, 100 )
					self.LastAlarm = CurTime()
					self.Ai_sound:Fire("EmitAISound","",0)
					
				end
				
				local AngleDifference = self:VecAngD( mp, bp )
				if( AngleDifference < 5 ) then
					
					self.Pilot:PrintMessage( HUD_PRINTCENTER, "Unable to fire in transport mode.")
					self.ForceVariable = 0
					
				else
				
					self.ForceVariable = math.Approach( self.ForceVariable, 100, 0.2 )
					self.Pilot:PrintMessage( HUD_PRINTCENTER, "Charge: "..math.floor(self.ForceVariable).."%" )
			
				end
				
			else
				
				self.Pilot:PrintMessage( HUD_PRINTCENTER, "You can't fire while moving!" )
				
			end
			
		end
		
		if( ( self.ForceVariable > 0 && !self.Pilot:KeyDown( IN_ATTACK2 ) ) || ( self.ForceVariable == 100 ) ) then
			
		
			if( self.ForceVariable > 0 && self.BulletDelay > CurTime() ) then
				
				self.Pilot:PrintMessage( HUD_PRINTCENTER, "Reloading" )
				
				return
				
			end
			
			
			self.LastLaunch = CurTime() + 12.5
			self:SecondaryAttack()
			
			return
			
		end
		
	end
		
		-- Passenger Seat Swap
		for i=1,#self.Seats do
			
			local dr = self.Seats[i]:GetDriver()
			if( IsValid( dr ) ) then
				
				if( dr:KeyDown( IN_SPEED ) && self.LastSeatChange + 0.5 <= CurTime() ) then
					 
					self.LastSeatChange = CurTime()
				
					for j=1,#self.Seats do 
						
						local dr2 = self.Seats[j]:GetDriver()
						
						if( !IsValid( dr2 ) && self.Seats[i] != self.Seats[j] ) then
							
							dr:ExitVehicle()
							dr:EnterVehicle( self.Seats[j] )
							
							break
							
						end
								
					end
				
					
				end
			
			end
			
		end
			
	-- Passenger Seat Gun controls
	local seat
	local gunner
	local wep
	
	// Gunners
	for i=1,#self.Seats do
	
		seat = self.Seats[i]
		gunner = seat:GetDriver()
		wep = self.MountedGuns[i]
		
		if( IsValid( seat ) && IsValid( gunner ) && IsValid( wep ) ) then
		
			local ang = gunner:EyeAngles()
			
			if ( gunner:KeyDown( IN_ATTACK ) && wep.LastAttack + .0755 <= CurTime() ) then
				
				ang = ang + Angle( math.Rand(-.8,.8), math.Rand(-.8,.8), 0 )
				
				local bullet = {} 
				bullet.Num 		= 1
				bullet.Src 		= wep:GetPos() + wep:GetForward() * 55
				bullet.Dir 		= wep:GetAngles():Forward()					// Dir of bullet 
				bullet.Spread 	= Vector( .03, .03, .03 )				// Aim Cone 
				bullet.Tracer	= 1											// Show a tracer on every x bullets  
				bullet.Force	= 0						 				// Amount of force to give to phys objects 
				bullet.Damage	= math.random( 14, 38 )
				bullet.AmmoType = "Ar2" 
				bullet.TracerName = "Tracer" 
				bullet.Callback = function ( a, b, c )
				
										local effectdata = EffectData()
											effectdata:SetOrigin( b.HitPos )
											effectdata:SetStart( b.HitNormal )
											effectdata:SetNormal( b.HitNormal )
											effectdata:SetMagnitude( 100 )
											effectdata:SetScale( 25 )
											effectdata:SetRadius( 30 )
										util.Effect( "ImpactGunship", effectdata )
										
										util.BlastDamage( gunner, gunner, b.HitPos, 256, 18 )
										
										return { damage = true, effects = DoDefaultEffect } 
										
									end 
									
				wep:FireBullets( bullet )
		        wep:EmitSound( "npc/turret_floor/shoot"..math.random(2,3)..".wav", 511, math.random(40,50) )

				local effectdata = EffectData()
					effectdata:SetStart( wep:GetPos() )
					effectdata:SetOrigin( wep:GetPos() )
				util.Effect( "RifleShellEject", effectdata )  

				local e = EffectData()
					e:SetStart( wep:GetPos()+wep:GetForward() * 62 )
					e:SetOrigin( wep:GetPos()+wep:GetForward() * 62 )
					e:SetEntity( wep )
					e:SetAttachment(1)
				util.Effect( "ChopperMuzzleFlash", e )

				wep.LastAttack = CurTime()
	
			end

			
			wep:SetAngles( ang )
		end
		
	end
			
	
	self:NextThink( CurTime() )
	return true
	
end
--[[
local function ShellMaths(a,b,c)
	local acc = 9.81 / 2
	local X0 = self.BarrelProp:GetAngles():Forward()
	local Y0 = self.BarrelProp:GetAngles():Up()
	local origin = self.BarrelProp:GetPos() -- origin of the shell
	local X = ( a - origin.y ) * ( a - origin.y  ) -- pitch coordinate
	local Y = ( b - origin.z ) * ( b - origin.z  ) -- roll coordinate
	
	return math.sqrt( acc * X*X / Y ) --calculate the launching speed of the shell to reach the target
end
]]--
/*
function ENT:ArtilleryShellAngle(ply,tr)
	local g = 9.81
	local h = self.BarrelProp:GetPos()- self:GetPos()
	local d = tr.HitPos + tr.HitNormal * 75 - self.:GetPos()

	local a = math.atan((g*t^2-2.*h)/(g^2*t^4-4*g*t^2*h+4*h^2+4*d^2)^(1/2),2.*d/(g^2*t^4-4*g*t^2*h+4*h^2+4*d^2)^(1/2))	

	return a
end

function ENT:ArtilleryShellSpeed(ply,tr)
	local g = 9.81
	local h = self.BarrelProp:GetPos()- self:GetPos()
	local d = tr.HitPos + tr.HitNormal * 75 - self.:GetPos()

	local v = 0.5*(g^2*t^4-4*g*t^2*h+4*h^2+4*d^2)^(1/2)/t
	
	return v
end
*/
function ENT:PrimaryAttack()

	if ( !self ) then // silly timer errors.
		
		return
		
	end

		local Power
		if !self.ArtilleryToggle then
		Power = 50000
		else Power = 9999999
		end
		
		if  ( self.BulletDelay < CurTime() ) then	
	
		self.BulletDelay = CurTime() + 3 //math.random(3,6)

		self:EmitSound( "ambient/explosions/explode_2.wav", 511, math.random( 70, 100 ) )
		timer.Simple( 3, function() if( IsValid( self ) ) then self:EmitSound( "bf2/tanks/t-90_reload.wav", 511, math.random( 70, 100 ) ) end end )
		
		self:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * -10000 )
		
		local e1 = EffectData()
		e1:SetStart( self.Barrel:GetPos() + self.Barrel:GetForward() * 410	+ self.Barrel:GetRight() * 5  )
		e1:SetNormal( self.Barrel:GetForward() )
		e1:SetEntity( self.Barrel )
		e1:SetScale( 1.5 )
		util.Effect( "tank_muzzle", e1 )
		
		local fx = EffectData()
		fx:SetStart( self:GetPos() )
		fx:SetOrigin( self:GetPos() + 10*Vector( math.random(-10,10),math.random(-10,10), 1 ) )
		fx:SetNormal( self:GetUp() )
		fx:SetMagnitude( 1 )
		fx:SetScale( 500.0)
		fx:SetRadius( 300 )
		util.Effect( "ThumperDust", fx )
		
		local Shell = ents.Create( "sent_artillery_shell" )
		Shell:SetModel( "models/weapons/w_missile_launch.mdl" )
		Shell:SetPos( self.BarrelProp:GetPos() ) 				
		Shell:SetAngles( self.BarrelProp:GetAngles() )
		Shell:Spawn()
		Shell:Activate() 
		Shell.Owner = self.Pilot
		Shell:GetPhysicsObject():Wake()
		Shell:GetPhysicsObject():SetMass( 10 )
		Shell:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * 17000 )
		constraint.NoCollide( Shell, self, 0, 0)	
		constraint.NoCollide( Shell, self.Barrel, 0, 0)	
		constraint.NoCollide( Shell, self.BarrelProp, 0, 0)	
		
	end


	self:StopSound( "bf2/tanks/d30_artillery_fire.mp3" )
	self:StopSound( "bf2/tanks/t-90_reload.wav" )

end

function ENT:ExplosiveShellCallback(a,b,c)

	local info = DamageInfo( )  
		info:SetDamageType( DMG_NEVERGIB )  
		info:SetDamagePosition( b.HitPos )  
		info:SetMaxDamage( self.MaxDamage )  
		info:SetDamage( self.MinDamage )  
		info:SetAttacker( self )  
		info:SetInflictor( self )  
	
	local e = EffectData()
		e:SetOrigin( b.HitPos )
		e:SetScale( 0.1 )
		e:SetNormal( b.HitNormal )
	util.Effect("HelicopterMegaBomb", e)
		e:SetScale( 1.2 )
	util.Effect("ImpactGunship", e)
	
	for k, v in ipairs( ents.GetAll( ) ) do  
		
		if ( IsValid( v ) && v:Health( ) > 0 ) then  
			
			local p = v:GetPos( )  
			local t,tr = {},{}
				t.start = b.HitPos
				t.endpos = p
				t.mask = MASK_BLOCKLOS 
				t.filter = self
			tr = util.TraceLine( t )
			
			if ( p:Distance( b.HitPos ) <= self.BlastRadius ) then  
			
				if ( tr.Hit && tr.Entity ) then
				
					info:SetDamage( self.Damage * ( 1 - p:Distance( b.HitPos ) / self.BlastRadius ) )  
					info:SetDamageForce( ( p - b.HitPos ):Normalize( ) * 10 )  
					v:TakeDamageInfo( info )  
					
				end
				
			end 
			
		end  

	end  
	
	return { damage = true, effects = DoDefaultEffect } 
	
end

function ENT:ArtilleryStrike()

	if ( !self ) then // silly timer errors.
		
		return
		
	end
			
	if  ( self.BulletDelay < CurTime() ) then	
	
		self.BulletDelay = CurTime() + 5 //math.random(3,6)
		self:EmitSound( "bf2/tanks/d30_artillery_fire.mp3", 511, math.random( 70, 100 ) )
		self:EmitSound( "bf2/tanks/t-90_reload.wav", 511, math.random( 70, 100 ) )
		self:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * -10000 )
		
		local e1 = EffectData()
		e1:SetStart( self.Barrel:GetPos() + self.Barrel:GetForward() * 203	+ self.Barrel:GetRight() * 3  )
		e1:SetNormal( self.Barrel:GetForward() )
		e1:SetEntity( self.Barrel )
		e1:SetScale( 1.5 )
		util.Effect( "tank_muzzle", e1 )
	
		local tr, trace = {}, {}
		tr.start = self:GetPos() + Vector( 0,0, 2048 )
		tr.endpos = self.Pilot:GetAimVector() * 2500
		tr.mask = MASK_SOLID
		tr.filter = { self, self.Pilot, self.Barrel }
		trace = util.TraceLine( tr )
	
		local p = trace.HitPos
		local Shell = ents.Create( "sent_artillery_shell" )
		Shell:SetModel( "models/weapons/w_missile_closed.mdl" )
		Shell:SetPos( self:GetPos() + Vector( p.x, p.y, p.z + 5000 ) ) 				
		Shell:SetAngles( self.BarrelProp:GetAngles() )
		Shell:Spawn()
		Shell:Activate() 
		Shell:GetPhysicsObject():Wake()
		Shell:GetPhysicsObject():SetMass( 10 )
		Shell:GetPhysicsObject():ApplyForceCenter( Vector( 0, 0, -9999999 ) )

		
	end


	self:StopSound( "bf2/tanks/d30_artillery_fire.mp3" )
	self:StopSound( "bf2/tanks/t-90_reload.wav" )

end

function ENT:SecondaryAttack()

	if ( !self ) then // silly timer errors.
		
		return
		
	end
	
	-- Pions bang is so loud the concussive force can knock someone out. 
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 300 ) ) do
		
		if( v != self.Pilot ) then
		
			util.BlastDamage( self, self.Pilot, v:GetPos(), 1, 1 )
		
		end
		
	end
	
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
	
	self:EmitSound( "Pion/pion_fire_01.wav", 511, math.random( 70, 100 ) )
	timer.Simple( 3, function() if( IsValid( self ) ) then self:EmitSound( "bf2/tanks/t-90_reload.wav", 511, math.random( 70, 100 ) ) end end )
	
	self:GetPhysicsObject():ApplyForceCenter( self:GetAngles():Forward() * -5000 * self.ForceValue )

	-- ParticleEffect("tank_muzzleflash", self.Barrel:GetPos() + self.Barrel:GetForward() * 450, self.Barrel:GetAngles(), self.Barrel )
	ParticleEffect("arty_muzzleflash", self.Barrel:GetPos() + self.Barrel:GetForward() * 470, self.Barrel:GetAngles(), self.Barrel )
	
	
	local fx = EffectData()
	fx:SetStart( self:GetPos() )
	fx:SetOrigin( self:GetPos() + 10*Vector( math.random(-10,10),math.random(-10,10), 1 ) )
	fx:SetNormal( self:GetUp() )
	fx:SetMagnitude( 50 )
	fx:SetScale( 500.0 )
	fx:SetRadius( 500 )
	util.Effect( "ThumperDust", fx )
	
	local Power
	if !self.ArtilleryToggle then
	Power = 50000
	else Power = 50000
	end
	
	local aforce = ( 1 + self.ForceVariable )
	
	local Shell = ents.Create( "sent_artillery_shell" )
	Shell:SetModel( "models/weapons/w_missile_launch.mdl" )
	Shell:SetPos( self.BarrelProp:GetPos() ) 				
	Shell:SetAngles( self.BarrelProp:GetAngles() )
	Shell:Spawn()
	Shell:Activate() 
	Shell.Owner = self.Pilot
	Shell:SetOwner( self.Pilot )
	Shell:SetPhysicsAttacker( self.Pilot )
	Shell:GetPhysicsObject():Wake()
	Shell:GetPhysicsObject():SetMass( 10 )
	Shell:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * ( aforce * 3500 ) )
	-- print( aforce ) 
	self.Pilot:SetNetworkedEntity("ArtilleryShell", Shell )
	
	constraint.NoCollide( Shell, self, 0, 0)	
	constraint.NoCollide( Shell, self.Barrel, 0, 0)	
	constraint.NoCollide( Shell, self.BarrelProp, 0, 0)	
	
	
	self:StopSound( "bf2/tanks/d30_artillery_fire.mp3" )
	self:StopSound( "bf2/tanks/t-90_reload.wav" )

	self.ForceVariable = 0
	
end

function ENT:MountedGunCallback( a, b, c )

	if ( IsValid( self.Weapon ) ) then
	
		local e = EffectData()
		e:SetOrigin(b.HitPos)
		e:SetNormal(b.HitNormal)
		e:SetScale( 2.0 )
		util.Effect("ManhackSparks", e)

		util.BlastDamage( self.Weapon, self.Weapon, b.HitPos, 100, math.random(15,19) )
		
	end
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end

local function apr(a,b,c)
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end

function ENT:PhysicsUpdate()

	if ( self.IsDriving && IsValid( self.Pilot ) ) then

		self:GetPhysicsObject():Wake()
		
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
		local e = self:GetAngles()
					
		local ta = ( self.Cannon:GetPos() - a ):Angle()
		local ma = self.Cannon:GetAngles()
		local brlang = self.Barrel:GetAngles()
		local ba = ( self.Barrel:GetPos() - ( self.Pilot:GetPos() + self.Pilot:GetAimVector() * 5000 ) ):Angle()
	
	local tr, trace = {}		
		tr.start = self.Barrel:GetPos()
		tr.endpos = self.Barrel:GetPos() + self:GetForward() * 5000
		tr.filter = self
		tr.mask = MASK_SOLID		
		trace = util.TraceLine( tr )

		local pilotAng = self.Pilot:EyeAngles()

		local _t = self.Cannon:GetAngles()
		local _b = self.Barrel:GetAngles()
	
		local nottoofast = self:GetVelocity():Length() < 10
		
		if ( self.Pilot:KeyDown( IN_SPEED ) ) then
			
			if( nottoofast ) then
			
				self.CannonPitch = self.CannonPitch - 0.1
			
			else
			
				self.Pilot:PrintMessage( HUD_PRINTCENTER, "You're moving too fast to adjust firing angle." )
		
			end
		
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			if( nottoofast ) then
			
				self.CannonPitch = self.CannonPitch + 0.1
			
			else
			
				self.Pilot:PrintMessage( HUD_PRINTCENTER, "You're moving too fast to adjust firing angle." )
				
			end
			
		end

	
	if ( self.CannonPitch < -60 ) then self.CannonPitch = -60 end
	if ( self.CannonPitch > 0 ) then self.CannonPitch = 0 end

	self.Cannon:SetAngles( Angle( e.p + self.CannonPitch, e.y, e.r ) )
	self.Barrel:SetAngles( Angle( e.p + self.CannonPitch, e.y, e.r ) )


/*		
		if !self.ArtilleryToggle then
--		barrelpitch = math.Clamp( pilotAng.p, -15, 1 )
		barrelpitch = math.Clamp( cannonpitch, -80, 1 )

			self.Cannon:SetAngles( LerpAngle( 0.05, _t, Angle( barrelpitch + 10, _t.y, _t.r ) ) )
			self.Barrel:SetAngles( LerpAngle( 0.8, _b, Angle( barrelpitch + 10, _t.y, _t.r ) ) ) 

		else
		if( trace.Hit ) then
--		barrelpitch = math.Clamp( pilotAng.p, -80, 1 )
		else
--		barrelpitch = math.Clamp( 2*pilotAng.p, -80, 1 )
		end
		
			self.Cannon:SetAngles( LerpAngle( 0.05, _t, Angle( barrelpitch, e.y, _t.r ) ) )
			self.Barrel:SetAngles( LerpAngle( 0.8, _b, Angle( barrelpitch, _t.y, _t.r ) ) ) 			
			
		end
*/		
	self.offs = self:VecAngD( ma.y, ta.y )
	self.boffs = self:VecAngD( brlang.p, ta.p )
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
		
		tr.start = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetRight() * math.sin(CurTime()) * 40
		tr.endpos = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetUp() * -128  + self:GetRight() * math.sin(CurTime()) * 60
		tr.filter = self
		tr.mask = MASK_SOLID
		//self:DrawLaserTracer( self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetRight() * dir, self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetUp() * -17  + self:GetRight() * dir )
		
		trace = util.TraceLine( tr )
		
		if( trace.Hit ) then
			
			hitcount = hitcount + 1
			z = z + trace.HitPos.z
			
		end
		
	end
	
	z = z / hitcount

	local conditions = ( hitcount >= 7 || ( hitcount > 4 && _a.p > 1.5 ) ) && _a.p > -45 

	if ( self.IsDriving && IsValid( self.Pilot ) && conditions ) then
		phys:Wake()
		
		local mYaw = self:GetAngles().y
		local ap = self:GetAngles()
		local dir = Angle( 0,0,0 )
		local p = { { Key = IN_FORWARD, Speed = 0.275 };
					{ Key = IN_BACK, Speed = -0.15 }; }

		for k,v in ipairs( p ) do
		
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed

			else
			
				self.Speed = math.Approach( self.Speed, 0, 0.12 )
				
			end			
			
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		
		if( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
					
			self.Yaw = math.Approach( self.Yaw, 1.9, 0.152 )

		elseif( self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
		
			self.Yaw = math.Approach( self.Yaw, -1.9, 0.152)
			
		else
			
			self.Yaw = math.Approach( self.Yaw, 0, 1 )
		
		end
			
		local p = self:GetPos()
		p.z = z + 0.5
		
		local downparam = ap.p
		if( downparam > 0 ) then downparam = 0 end
		
		local pr = {}
		pr.secondstoarrive	= 0.1
		pr.pos 				= p + self:GetForward() * self.Speed
		pr.maxangular		= 1000
		pr.maxangulardamp	= 1000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000000
		pr.dampfactor		= 1.5
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( self:GetAngles().p, mYaw + self.Yaw, self:GetAngles().r )
		
		phys:ComputeShadowControl(pr)

	end	
end


