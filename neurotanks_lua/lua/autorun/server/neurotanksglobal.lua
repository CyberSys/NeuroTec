AddCSLuaFile("autorun/client/neurotanksdrawfunctions.lua")
AddCSLuaFile("autorun/client/artilleryhud.lua")
AddCSLuaFile("autorun/client/c_neurotanksglobal.lua")
AddCSLuaFile("autorun/client/flir.lua")
AddCSLuaFile("autorun/client/neurotanksdrawfunctions.lua")
AddCSLuaFile("autorun/tankdamagetables.lua")
AddCSLuaFile("autorun/tank_networkstuff.lua")
-- include( "autorun/tankdamagetables.lua") 
resource.AddFile( "models/killstr3aks/wot/american")
resource.AddFile( "materials/models/killstr3aks/wot/american")

SPEED_CONSTANT_KMH = 14.58421379738968

util.AddNetworkString( "NeuroTanksCrewMembers" )
util.AddNetworkString( "NeuroCarsWheels" )

function AddDir(dir) // recursively adds everything in a directory to be downloaded by client
	local list = file.Find("../"..dir.."/*", "GAME" )
	for _, fdir in pairs(list) do
		if fdir != ".svn" then // don't spam people with useless .svn folders
			AddDir(fdir)
		end
	end
	for k,v in pairs(file.Find("../"..dir.."/*", "GAME" )) do
		resource.AddFile(dir.."/"..v)
	end
end

resource.AddFile( "sound/bf2/tanks/m1a2_fire_3p.wav" )
resource.AddFile( "sound/bf2/tanks/m1a2_fire_1p.wav" )
resource.AddFile( "sound/bf2/tanks/m1a2_reload.wav" )
resource.AddFile( "sound/bf2/tanks/m1a2_engine_start_idle_stop.wav" )
resource.AddFile( "sound/bf2/weapons/coaxial browning_fire.mp3" )
resource.AddFile("models/bfp4f/ground/m1a2/m1a2_body.mdl")
resource.AddFile("models/bfp4f/ground/m1a2/m1a2_tower.mdl")
resource.AddFile("models/bfp4f/ground/m1a2/m1a2_barrel.mdl")
resource.AddFile("models/bfp4f/ground/m1a2/m1a2_gun.mdl")

CreateConVar("tank_rotationsound", 1,  FCVAR_NOTIFY )
CreateConVar("tank_allowheadlights", 1,  FCVAR_NOTIFY )
CreateConVar("tank_dusteffects", 1,  FCVAR_NOTIFY )
CreateConVar("tank_gore", 0,  FCVAR_NOTIFY )
CreateConVar( "tank_WoTstyle", "1", true, false )
local function funcCallback(CVar, PreviousValue, NewValue)
	print(CVar.." changed from "..PreviousValue.." to "..NewValue.."!")
	
	for k,v in pairs( player.GetAll() ) do
		
		v:ConCommand("tank_wotstyle", NewValue )
	
	end
	
end
cvars.AddChangeCallback("tank_WoTstyle", funcCallback)

local type = type
local math = math
local pairs = pairs
local ipairs = ipairs


-- to avoid looking up convars each frame we only do it once a second to see if anythings changed.
local TankWotstyle = 0
local TankGore = 0
local TankHeadlights = 0
local TankRotationSound = 0
local Developer = 0
local JetCockpitView = 0
local TankDustEffects = 0
local TankNeuroWar = 0
local LastConVarTick = 0
hook.Add("Think","NeuroTanksUpdateConvars", function()
	
	if( LastConVarTick + 1 <= CurTime() ) then
		
		LastConVarTick = CurTime()
		
		TankWotStyle = GetConVarNumber("tank_wotstyle", 0 )
		TankGore = GetConVarNumber("tank_gore" , 0 )
		TankHeadlights = GetConVarNumber("tank_allowheadlights" , 0 )
		TankRotationSound = GetConVarNumber("tank_rotationsound", 0 )
		Developer = GetConVarNumber( "developer", 0 )
		JetCockpitView = GetConVarNumber( "jet_cockpitview", 0 )
		TankDustEffects = GetConVarNumber("tank_dusteffects", 0 )
		TankNeuroWar = GetConVarNumber( "neurowar", 0 )
		
	end

end )

hook.Add("PlayerLeaveVehicle", "FixWeaponsInRides", function( pl, ride )
	
	pl:SetAllowWeaponsInVehicle( false )

end ) 


local goresounds = { 
"physics/flesh/flesh_squishy_impact_hard3.wav",
	 -- "physics/lesh/flesh_bloody_break.wav",
	 "physics/flesh/flesh_squishy_impact_hard1.wav",
	 -- "npc/barnacle/arnacle_crunch3.wav",
	 -- "physics/lesh/flesh_bloody_break.wav" 
	 }
	 
for k,v in pairs( goresounds ) do
	
	util.PrecacheSound( v ) 
	
end

										
if( table.HasValue( hook.GetTable(), "NeuroTanks_ExplosionGore" ) ) then

	hook.Remove("OnDamagedByExplosion", "NeuroTanks_ExplosionGore" )

end

-- hook.Add("PlayerSpawnedVehicle", "NeuroTec_Carmageddon", function( ply, ent ) 
	
	-- ent:AddCallback( "PhysicsCollide", function( data, physobj ) 
		
		-- if( data.HitEntity:IsPlayer() && data.Speed > 1500 ) then
			
			-- local p = data.HitEntity
			-- p:EmitSound( goresounds[math.random( 1, #goresounds )], 511, math.random( 80, 120 ) )
			-- ParticleEffect("tank_gore", p:GetPos(), p:GetAngles(), nil )
		
		-- end
		
	-- end )

-- end )
-- hook.Add( "PreDrawHalos", "AddHalos", function()
	-- halo.Add( ents.FindByClass( "sent_tank_*" ), Color( 255, 0, 0 ), 5, 5, 1, false, false )
-- end )

local bodyparts = { 
	"models/skeleton/skeleton_arm.mdl", 
	"models/skeleton/skeleton_arm_l.mdl",
	"models/skeleton/skeleton_leg.mdl",
	"models/skeleton/skeleton_leg_l.mdl",
	"models/skeleton/skeleton_torso_noskins.mdl" 
	}
local spines = { 
	"models/skeleton/skeleton_torso3.mdl",
	
	}

-- dont wanna call too much junk here or we'll slow down the server.
-- hook.Add("ShouldCollide", "NeuroTanksShouldCollide", function( a, b ) 
	-- if( a.HealthVal || b.HealthVal ) then 
	
		-- return !( a.Owner && b.Owner && a.Owner == b.Owner )
	-- end 
	
-- end )

hook.Add("OnDamagedByExplosion", "NeuroTanks_ExplosionGore", function( ply, dmginfo )
	
	if( TankGore < 1 ) then return end
	
	local amt = dmginfo:GetDamage()
	local atk = dmginfo:GetAttacker()
	local p = ply
	
	if( ply:Health() + ply:Armor() <= 0 ) then
		
		
		local ppos = p:GetPos()
		local pang = p:GetAngles()

		-- for i=1,#bodyparts do
			 
			-- local bone = ents.Create("prop_ragdoll")
			-- bone:SetPos( ply:GetPos() + Vector( math.random(-8,8), math.random(-8,8), 72 ) )
			-- bone:SetAngles( ply:GetAngles() )
			-- bone:SetModel( bodyparts[i] )
			-- bone:Spawn()
			-- bone:Fire("kill","",60 )
			-- bone:GetPhysicsObject():SetVelocity( VectorRand() * 5505 )
			-- bone:GetPhysicsObject():AddAngleVelocity( VectorRand() * 50 )
			-- if( math.random( 1,10 ) == 3 ) then
			
				-- bone:Ignite( 50,50 )
			
			-- end
			
		-- end
		
		local rag = p:GetRagdollEntity()
		
		if( IsValid( rag ) ) then
			
			rag:Remove()
			
		end
		
		p:EmitSound( goresounds[math.random( 1, #goresounds )], 511, math.random( 80, 120 ) )
		ParticleEffect("tank_gore", p:GetPos(), p:GetAngles(), nil )

		
	end

end )

local function apr(a,b,c)

	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
	
end

hook.Remove("EntityRemoved", "NeuroTanks_ExitVehicleFix")
-- hook.Add("EntityRemoved", "NeuroTanks_ExitVehicleFix", function( ent )
	
	-- if( type( ent.OnRemove ) == "function" ) then
		-- if( IsValid( ent.Pilot ) ) then
			-- print( ent )
			-- ent:OnRemove()
			-- ent:Remove()
	-- print( PrintTable( ent:GetTable() ) )	 
	-- end
	
	-- if( IsValid( ent.Pilot ) && ent.TankType ) then
		
		
	-- end

-- end ) 

--[[
function GM:HandlePlayerDriving( ply )
	
	local pod = ply:GetVehicle()
	-- if( tank.TankType != nil ) then
	
	if( IsValid( ply:GetNetworkedEntity("Weapon", NULL ) ) ) then
		
		
		
	
	end
	-- end

end
]]--

local Meta = FindMetaTable("Entity")


-- Check fuel and set networked variables for the HUD and smoke emitters etc.
function Meta:TankFuelChecker()
	
	-- is whopping about and still got sauce in the tank.
	if ( self.IsDriving && IsValid( self.Pilot ) && self.Fuel > 0 ) then
		
		if( self.Speed >= self.MaxVelocity || self.Speed <= self.MinVelocity ) then
			
			-- More speed takes more fuel.
			self.Fuel = self.Fuel - self.FuelRateHeavy
			
		else
			
			-- slow speed and idle uses less fuel.
			self.Fuel = self.Fuel - self.FuelRate
			
		end
		
		
		if( self.Fuel <= 0 ) then
			-- Oops, we ran out.
			self.Fuel = 0 
			-- Stop our motion
			self.Speed = 0
			-- Stop engine loops
            for i=1,#self.EngineMux do self.EngineMux[i]:Stop() end
			-- Stop track sounds
            if self.HasCVol then self.CEngSound:Stop() end
			-- Stop all the other timers and checks.
			self.IsDriving = false
			-- Disable smoke
			self:SetNetworkedBool("IsStarted", false )
			
			local shtdwn = self.ShutDownSound or "vehicles/jetski/jetski_off.wav"
			self:EmitSound( shtdwn, 511, math.random( 95,100 ) )
			if( self.TowerSound ) then	
				
				self.TowerSound:Stop()
				
			end 
			
			if( self.Flamethrower ) then
			
				self.Flamethrower:StopParticles() 
				self.IsBurning = false 
				self.FlameTime =  0
				self.Flamesound:FadeOut( 0.1 )
				self.Flamesound2:FadeOut( 0.1 )
				
			end
			
		end
		
		-- Update fuel status on the client.
		if( self.LastFuelUpdate + 0.5 <= CurTime() ) then
			
			self.LastFuelUpdate = CurTime()
			self:SetNetworkedInt( "TankFuel", math.floor( self.Fuel ) )
			
		end
		
	end

end
-- make sure we're on the ground
function Meta:TankCheckWheels()
	
	if( !self.Wheels ) then return false end
	
	local hitcount = 0
	for i=1,#self.Wheels do
		
		if( IsValid( self.Wheels[i] ) ) then
			
			local tr,trace = {},{}
			tr.start = self.Wheels[i]:GetPos() + self.Wheels[i]:GetUp() * ( math.sin(CurTime())*48 )
			tr.endpos = tr.start + Vector( 0,0,-32 )
			tr.filter = { self, self.Wheels[i], self.Barrel, self.Tower }
			tr.mask = MASK_SOLID
			trace = util.TraceLine( tr )
			
			if( !IsValid( self.Wheels[i].Axis ) ) then return false end
			
			debugoverlay.Line( tr.start, trace.HitPos, 0.1, Color( 255,0,0,255 ), true  )
			-- self:DrawLaserTraceR( tr.start, tr.endpos )	
			if( trace.HitWorld ) then
				
				hitcount = hitcount + 1
				
				-- print( trace.HitEntity )
				
			end
			
		end
	
	end
	
	-- print( hitcount > #self.Wheels/2.5)
	
	return hitcount > #self.Wheels/2.5

end
function Meta:TankDriveLeft()

	if( self.DriveWheels ) then
			
		local mya = self:GetAngles()
		local MaxSteer = self.MaxSteeringVal or 0.5
		local forcemax = self.SteerForce or 2
		local speed = self:GetVelocity():Length()
		local maxspeed = self.MaxVelocity * 14.58421379738968
		local bodyspeed = self:GetPhysicsObject():GetAngleVelocity():Length()
		
		if( !self.ForceValue ) then self.ForceValue = 0 end
		if( speed < 5 ) then return end
		
		for k,v in ipairs( self.SteerOrder ) do
			
			if( IsValid( self.DriveWheels[v] ) && !self.DriveWheels[v].Destroyed ) then
				
				-- if(  ) then 
				MaxSteer = MaxSteer * ( 0.8 + ( speed / maxspeed )/10 )
				
				local dir = 1
				local lerpval = 0.0925
				local Ang = self:GetAngles()
		
				if( speed > 1 && bodyspeed > -100 && bodyspeed < 100 ) then
					
					local turnforce = forcemax * 0.45 + ( 1.0 + ( speed / maxspeed ) ) -  ( speed / maxspeed )/2
					-- print( self.CanFloat, self:WaterLevel() )
					if( self.CanFloat && self:WaterLevel() > 0 ) then
							
						turnforce = 0.025
						MaxSteer = turnforce
						
					end
					
					self.ForceValue = Lerp( lerpval, self.ForceValue, -turnforce )
					self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -MaxSteer ) )
		
					if( self.SteerOrderDirections != nil ) then
						
						if( self.SteerOrderDirections[k] && self.SteerOrderDirections[k] < 0 ) then
							
							dir = -1
						
						end
						
					end
				
					self.DriveWheels[v]:GetPhysicsObject():ApplyForceCenter( self:GetRight() * self.ForceValue*dir )
				end
				
			end
			
		end
		
	end
	
	if( !self.Wheels ) then return end
	
	-- print("dleft")
	local bodyspeed = self:GetPhysicsObject():GetAngleVelocity():Length()
	local bodyangspeed = self:GetPhysicsObject():GetAngleVelocity().z	
	local speed = self:GetVelocity():Length()
	local maxspeed = self.MaxVelocity * SPEED_CONSTANT_KMH
	if( speed > maxspeed || bodyangspeed > 40 || bodyspeed > 50) then return end
	local numwheels = #self.Wheels
	local turnmod = self.TurnMultiplier or 1.5
	local turnval = self.TurnMultiplier or 1.595
	turnval = math.Clamp( turnval, 1.3, 4 )
	if( self.IsUltraSlow ) then
			
		turnval = self.TurnMultiplier
			
	end
	
	
	
	local turnmod = self.TankWheelTurnMultiplier
	self.Yaw = 1
	self.Speed = 0
				
	for i=1,numwheels do
		
		self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, turnmod ) )
	
	end
	
	if( self.CanFloat && self:WaterLevel() > 0 )then
			
		turnval = .55
		
	end
	
	self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -turnval ) )
	
end
function Meta:TankDriveRight()

		if( self.DriveWheels ) then
			
		local mya = self:GetAngles()
		local MaxSteer = self.MaxSteeringVal or 0.5
		local forcemax = self.SteerForce or 2
		local speed = self:GetVelocity():Length()
		local maxspeed = self.MaxVelocity * 14.58421379738968
		local bodyspeed = self:GetPhysicsObject():GetAngleVelocity():Length()
		
		if( !self.ForceValue ) then self.ForceValue = 0 end
		if( speed < 15 ) then return end
		
		for k,v in ipairs( self.SteerOrder ) do
			
			if( IsValid( self.DriveWheels[v] ) && !self.DriveWheels[v].Destroyed ) then
				
				-- if(  ) then 
				MaxSteer = MaxSteer * ( 0.8 + ( speed / maxspeed )/10 )
				
				local dir = 1
				local lerpval = 0.0925
				local Ang = self:GetAngles()
		
				if( speed > 1 && bodyspeed > -100 && bodyspeed < 100 ) then
					
					local turnforce = forcemax * 0.45 + ( 1.0 + ( speed / maxspeed ) ) -  ( speed / maxspeed )/2
					-- print( self.CanFloat, self:WaterLevel() )
					if( self.CanFloat && self:WaterLevel() > 0 ) then
							
						turnforce = 0.025
						MaxSteer = turnforce
						
					end
					
					self.ForceValue = Lerp( lerpval, self.ForceValue, -turnforce )
					self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, MaxSteer ) )
		
					if( self.SteerOrderDirections != nil ) then
						
						if( self.SteerOrderDirections[k] && self.SteerOrderDirections[k] < 0 ) then
							
							dir = -1
						
						end
						
					end
				
					self.DriveWheels[v]:GetPhysicsObject():ApplyForceCenter( self:GetRight() * self.ForceValue*dir )
				end
				
			end
			
		end
		
	end
	
	if( !self.Wheels ) then return end
	
	-- print("drigt")
	local bodyspeed = self:GetPhysicsObject():GetAngleVelocity():Length()
	local bodyangspeed = self:GetPhysicsObject():GetAngleVelocity().z	
	local speed = self:GetVelocity():Length()
	local maxspeed = self.MaxVelocity * 14.58421379738968
	if( speed > maxspeed || bodyangspeed > 40 || bodyspeed > 50) then return end
	local numwheels = #self.Wheels
	local turnmod = self.TurnMultiplier or 1.5
	local turnval = self.TurnMultiplier or 1.595
	turnval = math.Clamp( turnval, 1.3, 4 )
	if( self.IsUltraSlow ) then
			
		turnval = self.TurnMultiplier
			
	end
	local turnmod = self.TankWheelTurnMultiplier
	self.Yaw = -1
	self.Speed = 0
				
	for i=1,numwheels do
		
		self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -turnmod ) )
	
	end
	
	if( self.CanFloat && self:WaterLevel() > 0 )then
			
		turnval = .55
		
	end
	self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, turnval ) )
	
end

function Meta:TankDriveForward()
	
	
	if( self.DriveWheels ) then
		
		for k,v in pairs( self.DriveOrder ) do
			
			if( IsValid( self.DriveWheels[v[1]] ) && !self.DriveWheels[v[1]].Destroyed ) then
				
				self.DriveWheels[v[1]]:GetPhysicsObject():AddAngleVelocity( Vector( 0,v[2]*self.FWDTorque, 0 )  ) 
		
			end
		
		end
		
	end
	
	if( self.Wheels && !self.IsMadMaxVehicle ) then
	
		local bodyspeed = self:GetPhysicsObject():GetAngleVelocity():Length()
		local bodyangspeed = self:GetPhysicsObject():GetAngleVelocity().z	
		local speed = self:GetVelocity():Length()
		local maxspeed = self.MaxVelocity * 14.58421379738968
		if( speed > maxspeed ) then return end
		
		local numwheels = #self.Wheels
		for i=1, numwheels do
			
			if( IsValid( self.Wheels[i] ) ) then
			
				local dir = -1
				
				if( i > numwheels/2 ) then
					dir = 1
				end
				
				self.WheelForceValue = math.Approach( self.WheelForceValue, -(2*self.TankWheelForceValFWD)*dir, ( self.WheelAccelerationValue or 1 ) )
				
				self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, self.WheelForceValue ) )
			
			end
		
		end
		
		if( self.CanFloat && self:WaterLevel() > 0 )then
				
			local boost = self.FloatBoost or 45
			self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * self.Speed * boost )
			print("CYKA")
		end
		
	else
		
		if( self.DriveWheels ) then
		
			
			
		end
	
	end
	
end

function Meta:TankDriveBackward()
	
	if( self.DriveWheels ) then
		
		for k,v in pairs( self.DriveOrder ) do
			
			if( IsValid( self.DriveWheels[v[1]] ) && !self.DriveWheels[v[1]].Destroyed ) then
				
				self.DriveWheels[v[1]]:GetPhysicsObject():AddAngleVelocity( Vector( 0,-v[2]*self.RWDTorque, 0 )  ) 
		
			end
		
		end
	end
		
	
	if( !self.Wheels || self.IsMadMaxVehicle ) then return end
	
	local speed = self:GetVelocity():Length()
	local maxspeed = self.MaxVelocity * 14.58421379738968
	if( speed > maxspeed ) then return end
	if( !self.TankWheelForceValRWD ) then self.TankWheelForceValRWD = 5000 end
	local numwheels = #self.Wheels
	for i=1, numwheels do
		
		if( IsValid( self.Wheels[i] ) ) then
		
			local dir = -1
			
			if( i > numwheels/2 ) then
				dir = 1
			end
			self.WheelForceValue = math.Approach( self.WheelForceValue, self.TankWheelForceValRWD*dir, ( self.WheelAccelerationValue or 1 )  )
			
			self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, self.WheelForceValue ) )
		
		end
	
	end

end

local maxspeed
function TankCreateHoverDust( ent )
	 
	if( !ent.IsRotorwashing ) then
		
		
		ent.Rotorwash = ents.Create("env_rotorwash_emitter")
		ent.Rotorwash:SetPos( ent:GetPos() )
		ent.Rotorwash:SetParent( ent )
		ent.Rotorwash:SetKeyValue( "altitude", "",100 )
		ent.Rotorwash:Spawn()
		-- print( "walla", ent.Rotorwash )
		ent.IsRotorwashing = true
	
	end

end

function TankRemoveHoverDust( ent )
	
	if( IsValid( ent.Rotorwash ) ) then
		
		ent.Rotorwash:Remove()
		ent.IsRotorwashing = false
	
	end

end

function Meta:TankHoverPhysics( phys, deltatime )
	
	if( self.CanFloat ) then
		
		local floatval = self.FloatRatio or 4.0
		self:GetPhysicsObject():SetBuoyancyRatio( floatval ) 
	
	end
	
	if( self.IsDriving ) then
		
		self:GetPhysicsObject():Wake()
	
		local mi,ma = self:WorldSpaceAABB()
		local len = ( mi - ma ):Length()
		local downlength = self.HoverTraceLength or 100
		local tracewidth = self.HoverTraceWidth or 100
		local upforce = self.HoverUpForce or 50000
		local tcount = self.HoverTraceCount or 10
		
		for i=1,tcount do
			
			local strt = Vector( -len/3+(i*len/tcount/1.5), math.sin(CurTime()*1000)*tracewidth, 0 )
			local tr,trace = {},{}
			tr.start = self:LocalToWorld( strt ) + Vector( 0,0,math.sin(CurTime()*100)*32 )
			tr.endpos = self:LocalToWorld( strt ) + self:GetUp() * -downlength
			tr.filter = { self, self.Skirts, self:GetOwner(), self.Barrel, self.Tower, self.Pilot, self.TowerProxy }
			tr.mask = MASK_SOLID + MASK_WATER
			-- tr.mins = Vector( -100,-100,-100 )
			-- tr.maxs = Vector( 100,100,100 )
			-- tr.ignoreworld = false
			trace = util.TraceLine( tr )
			
		
			if( trace.Hit ) then
				
				-- print( "yep" )
				-- self:GetPhysicsObject():Wake()
				self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * upforce + self:GetForward() * 0  )
			
				debugoverlay.Line( tr.start, tr.endpos, 0.1, Color( 0, 255,0,255 ), true )
			
			else
				
				debugoverlay.Line( tr.start, tr.endpos, 0.1, Color( 255, 0,0,255 ), true )
					
			end
		
		end
		
			if ( IsValid( self.Pilot ) && self:GetVelocity():Length() < self.MaxVelocity * 14 ) then
				-- print( "woo" )
				local a,b,c,d = IN_FORWARD, IN_BACK, IN_MOVELEFT, IN_MOVERIGHT
				local p = self.Pilot
				-- local fw,rw,lf,rt = , , p:KeyDown( d )
				-- print( fw, rw, lf, rt )
				local force = self.HoverPropForce or 5999
				local angforce = self.HoverTurnForce or 0.4231
				if( p:KeyDown( a ) ) then
					-- print( fw )
					self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * ( self.MaxVelocity * force ) )
					
				elseif(  p:KeyDown( b ) ) then
					
					self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * ( self.MinVelocity * force ) )
				
				end
				
				if(  p:KeyDown( c ) ) then
					
					self:GetPhysicsObject():AddAngleVelocity( Vector( 0,0, angforce ) )
					
				elseif( p:KeyDown( d ) ) then
				
					self:GetPhysicsObject():AddAngleVelocity( Vector( 0,0, -angforce ) )
				
				end
			end
		
		end

	

end

function Meta:TankCarTurnLogic()

			-- Make sure we haven't lost our threads.
			if( self.BothTracksBroken ) then return end
			if( self.GearBoxBroken ) then return end
			 			
			local angspeed1,angspeed2,wheelang,wvel	
			local speed = self:GetPhysicsObject():GetVelocity():Length()
			local maxspeed = self.MaxVelocity * 14.58421379738968 
			local minspeed = self.MinVelocity * 14.58421379738968 
			
			local bodyspeed = self:GetPhysicsObject():GetAngleVelocity():Length()
			local bodyangspeed = self:GetPhysicsObject():GetAngleVelocity().z
			
			local l,r = self.Pilot:KeyDown( IN_MOVELEFT ),self.Pilot:KeyDown( IN_MOVERIGHT )
			if( !self.LastWheelNetsend ) then
				
				self.LastWheelNetsend = CurTime()
				
			end
			if( self.LastWheelNetsend + 0.1 <= CurTime() ) then
				
				self.LastWheelNetsend = CurTime()
				-- print( "sent" )
				self:SetNetworkedBool("TurnLeft", l ) 
				self:SetNetworkedBool("TurnRight", r ) 
		
				
			end
			
			local steercap = 35
			
			if( ( l || r ) && bodyangspeed < steercap && bodyangspeed > -steercap && speed > 15  ) then
				
				local mya = self:GetAngles()
				local MaxSteer = self.MaxSteeringVal or 0.5
				local forcemax = self.SteerForce or 2
				if( !self.ForceValue ) then self.ForceValue = 0 end
				
				-- print(l,r )
				for k,v in ipairs( self.SteerOrder ) do
					
					if( IsValid( self.DriveWheels[v] ) && !self.DriveWheels[v].Destroyed ) then
						
						-- if(  ) then 
						MaxSteer = MaxSteer * ( 3.5 + ( speed / maxspeed )/10 )
						
						-- print( MaxSteer ) 
						
						local dir = 1
						local lerpval = 0.0925
						local Ang = self:GetAngles()
						
						-- print( self.Speed ) 
						-- if( self.Speed < 0 ) then dir = -1 end
						-- print( dir )
						-- print( speed, bodyspeed )
						if( speed > 1 && bodyspeed > -11 && bodyspeed < 11 ) then
							
							local turnforce = forcemax * 0.45 + ( 1.0 + ( speed / maxspeed ) ) -  ( speed / maxspeed )/2
							-- print( self.CanFloat, self:WaterLevel() )
							if( self.CanFloat && self:WaterLevel() > 0 ) then
									
								turnforce = 0.025
								MaxSteer = turnforce
								
							end
							
							if( l ) then
								
								self.ForceValue = Lerp( lerpval, self.ForceValue, -turnforce )
						
								self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, MaxSteer ) )
								
								-- self:GetPhysicsObject():ApplyForceOffset(  self:GetRight() * force*dir, self:GetForward() * 100 ) 
								-- Ang:RotateAroundAxis( self:GetUp(), 0.1 )
								-- self.WheelSockets[v]:SetAngles( self:GetAngles() )
								
								
							elseif( r ) then
								
								self.ForceValue = Lerp( lerpval, self.ForceValue, turnforce ) 
						
								self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -MaxSteer ) )
				
							end
							
							-- local dir = 1
							
							if( self.SteerOrderDirections != nil ) then
								
								if( self.SteerOrderDirections[k] && self.SteerOrderDirections[k] < 0 ) then
									
									dir = -1
								
								end
								
							end
							self.WheelSockets[v]:GetPhysicsObject():ApplyForceCenter( self:GetRight() * self.ForceValue*dir )
							self.DriveWheels[v]:GetPhysicsObject():ApplyForceCenter( self:GetRight() * self.ForceValue*dir )
							-- print( dir )
							
						end
						
					end
					
					
				end
				
			elseif( !r && !l && self.ForceValue ) then
							
					self.ForceValue = Lerp( 0.15, self.ForceValue, 0 )
						
					-- print( self.ForceValue )
						
					
			end
			
end


-- Motion for the big tanks
function Meta:TankHeavyPhysics( phys, deltatime )
	
	if( self.CanFloat && self.Tower:WaterLevel() > 1 ) then
		
		self:GetPhysicsObject():SetBuoyancyRatio( 0.0 )
	
	end
	
	-- Make sure we got sauce
	self:TankFuelChecker()
	-- Check if we're standing on the ground.
	
	/*
	if( type( self.BarrelPos ) == "Vector" ) then
	
		local bp = self.Barrel:GetPos()--self:WorldToLocal( self.Barrel:GetPos() )
		local tp = self.Tower:LocalToWorld( self.BarrelPos ) 
		local tpbpdist = bp:Distance( tp )
		
		-- print( self.TowerBarrelOffset / tpbpdist )
		-- print( tp, bp, bp == tp, bp:Distance( tp ), self.TowerBarrelOffset )
		self.Barrel:SetPos( LerpVector( 0.1, bp, tp ) )
		
		if( self.TowerBarrelOffset / tpbpdist > 1 ) then
			
		
		end
		
	
	end
	*/

	if( IsValid( self.TowerProxy ) && IsValid( self.Tower ) ) then 		
	
		self.TowerProxy:SetPos( self.Tower:GetPos() )  
		self.TowerProxy:SetAngles( self.Tower:GetAngles() ) 
		self.TowerProxy:SetBodygroup( 0, self.Tower:GetBodygroup(0) )
		
	end
	
	if( self:GetAngles().p > 55 ) then return end 
	
	-- Wake our physics objects.
	self:GetPhysicsObject():Wake()
	
	-- if( IsValid( self.Barrel ) ) then
		
		-- self.Barrel:GetPhysicsObject():Wake()
		
	-- end
	
	-- if( IsValid( self.Tower ) ) then
		
		-- self.Tower:GetPhysicsObject():Wake()
	
	-- end
	
	
	
	if( IsValid( self.Pilot ) ) then
	
		local anykey = ( self.Pilot:KeyDown( IN_FORWARD ) || self.Pilot:KeyDown( IN_BACK ) || self.Pilot:KeyDown( IN_MOVELEFT ) || self.Pilot:KeyDown( IN_MOVERIGHT ) )
		
		if( anykey ) then
			
			self.CVol = 0.56
			
		else
			
			self.CVol = 0.0
			
		end
		
	end
	
	if( self.IsHoverTank ) then
	
		self:TankHoverPhysics( phys, deltatime )
		
		return
		
	end
	
	local HasTower = false
	local Turn = ""

	if( self.PilotAimOffset && self.MaxBarrelYaw ) then
		
		HasTower = true
		
		if( self.PilotAimOffset <= 180-(self.MaxBarrelYaw*1.5) && self.PilotAimOffset >= 0 ) then
			
			Turn = false
			
		elseif( self.PilotAimOffset >= -180+(self.MaxBarrelYaw*1.5) && self.PilotAimOffset <= 0 ) then
			
			Turn = true
		
		else
			
			Turn = ""
			HasTower = false
			
		end
	
	end
	
	
	-- print( TLeft, TRight, Turn, math.floor( self.PilotAimOffset ) )
	
	if( self.DriveWheels ) then
		
		if( IsValid( self.Pilot ) && self.IsDriving ) then 
	
			self:TankCarTurnLogic()
			
			if(    !self.Pilot:KeyDown( IN_FORWARD ) 
					&& !self.Pilot:KeyDown( IN_BACK ) 
					&& !self.Pilot:KeyDown( IN_MOVERIGHT ) 
					&& !self.Pilot:KeyDown( IN_MOVELEFT ) ) then
						
				if( self.Pilot:KeyDown( IN_JUMP ) && self:GetVelocity():Length() > 30 ) then		
					
					for i=1,#self.DriveWheels do 
							
						if( IsValid( self.DriveWheels[i] ) ) then
						
							self.DriveWheels[i]:GetPhysicsObject():AddAngleVelocity( -self.DriveWheels[i]:GetPhysicsObject():GetAngleVelocity() )
						
						end
						
					end
					
				end
				
			end
						
			local angspeed1,angspeed2,wheelang,wvel	
			local speed = self:GetPhysicsObject():GetVelocity():Length()
			local maxspeed = self.MaxVelocity * 14.58421379738968 
			local minspeed = self.MinVelocity * 14.58421379738968 
			
			local bodyspeed = self:GetPhysicsObject():GetAngleVelocity():Length()
			local bodyangspeed = self:GetPhysicsObject():GetAngleVelocity().z
			

			if( speed <= maxspeed && bodyangspeed < 40 && bodyspeed < 50 ) then
				-- local dir = 1
				-- local idx = 1
				-- local speed = 0
				local maxtorque = self.FWDTorque or maxspeed
				local mintorque = self.RWDTorque or minspeed
				
				for k,v in pairs( self.DriveOrder ) do
					-- print( v[1], v[2] )
					if( IsValid( self.DriveWheels[v[1]] ) && !self.DriveWheels[v[1]].Destroyed ) then
						
						
						if( self.Pilot:KeyDown( IN_FORWARD ) ) then
							-- self.Speed = math.Approach( math.Clamp( self.Speed + 1, -maxspeed, maxspeed ), 
							self.Speed =  Lerp( 0.00112, self.Speed,  maxtorque*1.5 )
							-- print("asda")
						elseif( self.Pilot:KeyDown( IN_BACK ) ) then
							
							self.Speed = Lerp( 0.00112, self.Speed,  mintorque )
							
							-- self.DriveWheels[v[1]]:GetPhysicsObject():AddAngleVelocity( Vector( 0,-v[2]*self.WheelTorque/2, 0 )  ) 
						else
							
							self.Speed = Lerp( 0.2, self.Speed, 0 )
							
						end
						
						if( self.CanFloat && self:WaterLevel() > 0 ) then
							
							local boost = self.FloatBoost or 200
							self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * self.Speed*boost )
							
						end
						-- print( self.Speed )
						self.DriveWheels[v[1]]:GetPhysicsObject():AddAngleVelocity( Vector( 0,v[2]*self.Speed, 0 )  ) 
						
					end
				end
				
			end
			
		end
	
		return
		
	end
	

	if ( self.Wheels ) then
		
		-- Get our speed in units/s
		local speed = self:GetVelocity():Length()
		local maxspeed = self.MaxVelocity * 14.58421379738968  
		-- print( math.floor( speed ), math.floor( maxspeed ), self.MaxVelocity	 )
		
		-- get our wheels velocity
		local angspeed1 = self.Wheels[1]:GetPhysicsObject():GetAngleVelocity()
		local angspeed2 = self.Wheels[#self.Wheels/2]:GetPhysicsObject():GetAngleVelocity()
		
		-- Get our sideways velocity
		local bodyangspeed = self:GetPhysicsObject():GetAngleVelocity().z
		
		-- count our wheels so we know how to distribute the force equally
		local numwheels = #self.Wheels
		
		-- amount of force to apply to the tank in addition to the wheels movement.
		local boost = self:GetPhysicsObject():GetMass() * 0.85
		
		-- Trick our animation function into believing we're holding the movement keys down.
		self.Speed = math.floor( ( angspeed1.x + angspeed2.x / 2 ) / 200  )
		
		-- Check if we got a pilot and that we've started.
		if( IsValid( self.Pilot ) && self.IsDriving ) then 
			
			-- Make sure we haven't lost our threads.
			if( self.BothTracksBroken ) then return end
			if( self.GearBoxBroken ) then return end
			local turnforce = self.TankWheelForceValFWD*2
			local turnforcerev = self.TankWheelForceValREV*2
			local noturn = (  !self.Pilot:KeyDown( IN_MOVELEFT ) || !self.Pilot:KeyDown( IN_MOVERIGHT ) )
			if( self.Pilot:KeyDown( IN_FORWARD ) &&  speed < maxspeed ) then
				
				if( self.CanFloat && self:WaterLevel() > 0 ) then
					
					local speedboost = self.FloatBoost or 45
					self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * speedboost )
					
				end
				
				if( self.Pilot:KeyDown( IN_MOVELEFT ) || self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
					
					turnforce = turnforce/2
					turnforcerev = turnforcerev/2
					
				end
				
				self.Speed = 5
				
				self.WheelForceValue = math.Approach( self.WheelForceValue, turnforce, 1 )
				
				-- Give our hull a slight push to simulate torque on the chassis
				-- self:GetPhysicsObject():AddAngleVelocity( Vector( 0, -0.535, 0 ) )
				
				-- Loop through our wheels
				for i=1,numwheels do
						
					-- Determines the direction of the torque. This acts as our differential lock.
					local dir = -1
					
					-- numwheels/2 will return the left row of wheels so we need to change the 
					-- direction of the angle velocity when we're moving on to the right side wheels
					if( i > numwheels/2 ) then
						dir = 1
					end
					
					
					-- push us forward 
					-- self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * boost )
					-- Apply torque to the wheels. Make use of the differential.
					self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -self.WheelForceValue *dir ) )
				
				end
			
				
				
			elseif( self.Pilot:KeyDown( IN_BACK ) && speed < maxspeed ) then
                
				self.Speed = -5
				-- self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0.535, 0 ) )
				
				if( self.CanFloat && self:WaterLevel() > 0 ) then
					
					local speedboost = self.FloatBoost or 45
					self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * -speedboost )
					
				end
				
				self.WheelForceValue = math.Approach( self.WheelForceValue, turnforcerev, 1 )
				
				for i=1,numwheels do
						
					local dir = -1
					if( i > numwheels/2 ) then
						dir = 1
						
					end
					
					-- self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * -boost )
					self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, self.WheelForceValue *dir ) )
				
				end
			
			-- Slow the tank down if we're not pressing any keys.
			elseif(    !self.Pilot:KeyDown( IN_FORWARD ) 
					&& !self.Pilot:KeyDown( IN_BACK ) 
					&& !self.Pilot:KeyDown( IN_MOVERIGHT ) 
					&& !self.Pilot:KeyDown( IN_MOVELEFT ) ) then
						
					
					self.WheelForceValue = math.Approach( self.WheelForceValue, 0, 1 )
						
					for i=1,#self.Wheels do
				
						if( self.Pilot:KeyDown( IN_JUMP ) && self:GetVelocity():Length() > 50 ) then
					
					
							self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( -self.Wheels[i]:GetPhysicsObject():GetAngleVelocity() )
							-- self.Wheels[i].Axis:SetKeyValue("Friction", 50000 )
							-- self.Speed = 0
							-- PrintTable( self.Wheels[i].Axis:GetKeyValues()  )
							
						else	
							
					
							-- self.Wheels[i].Axis:SetKeyValue("Friction", 200 )	
								
							
						end
						
					end
					
			end
			
			local TLeft = ( HasTower == true && Turn == true && !self.Pilot:KeyDown( IN_JUMP ) && !self.ArtyView ) 
			local TRight = ( HasTower == true && Turn == false && !self.Pilot:KeyDown( IN_JUMP ) && !self.ArtyView  ) 
		
			-- Make use of the TurnMultiplier variable on the tanks. The higher value the faster turn.
			local turnval = self.TurnMultiplier or 1.595
			turnval = math.Clamp( turnval, 1.3, 4 )
			if( self.IsUltraSlow ) then
				
				turnval = self.TurnMultiplier
				
			end
			
			local turnmod = self.TankWheelTurnMultiplier
			if( speed > maxspeed/2 ) then turnval = turnval - ( speed / maxspeed )*0.7 end
			
			if( ( self.Pilot:KeyDown( IN_MOVELEFT ) || TRight )&& bodyangspeed < 60  ) then
				
				-- self.Yaw = 1
				-- self.Speed = 0
				
				-- for i=1,#self.Wheels/2 do
					
					-- self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -turnmod ) )
				
				-- end
				
				-- for j=numwheels/2,numwheels do
					
					-- self.Wheels[j]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -turnmod ) )
					-- self.Wheels[j]:GetPhysicsObject():AddAngleVelocity( -self.Wheels[j]:GetPhysicsObject():GetAngleVelocity() )
				-- end
				
				-- self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, turnval ) )
				
				self:TankDriveRight()
			elseif( ( self.Pilot:KeyDown( IN_MOVERIGHT ) || TLeft ) && bodyangspeed > -60) then
				
				self:TankDriveLeft()
				-- self.Yaw = -1
				-- self.Speed = 0
				
				-- for i=1,#self.Wheels/2 do
					
					-- self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, turnmod ) )
					-- self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( -self.Wheels[i]:GetPhysicsObject():GetAngleVelocity() )
					
				-- end
				
				-- for j=#self.Wheels/2,#self.Wheels do
					
					-- self.Wheels[j]:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, turnmod ) )
					
				
				-- end
				
				-- self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -turnval ) )
			
			else
			
				self.Yaw = 0
				
			end
			
			-- Braking
			
			



		end
	
	else
		
		-- local OnGround = self:TankCheckWheels()
	
		-- Make sure we haven't lost our threads.
		if( self.BothTracksBroken ) then return end
		if( self.GearBoxBroken ) then return end
		 
	
		-- Setup a raytrace
		local tr, trace = {}
		local hitcount = 0 -- We will use this to determine if enough of the tank is on solid ground to move.
		local _a = self:GetAngles()
		local z = 0
		local tracelength = self.TrackPos or -15 -- Start tracing from under the tank.
		
		-- Lets use 20 traces.
		for i=1,20 do
			
			-- This creates a sine pattern of traces between the tracks.
			tr.start = self:GetPos() + self:GetForward() * -150 + self:GetForward() * ( i * 13.55 ) + self:GetUp() * 16 + self:GetRight() * math.sin(CurTime() * self:EntIndex()) * 76
			tr.endpos = self:GetPos() + self:GetForward() * -150 + self:GetForward() * ( i * 13.55 ) + self:GetUp() * tracelength  + self:GetRight() * math.sin(CurTime() * self:EntIndex()) * 76
			tr.filter = { self, self.TrackEntities }
			tr.mask = MASK_SOLID

			
			debugoverlay.Line( tr.start, tr.endpos, 0.1, Color( 0, 255,0,255 ), true )
			trace = util.TraceLine( tr )
			-- Check results
			if( trace.Hit && !trace.HitSky ) then
				
				-- For each hit we add to this variable so we can later check if enough track is on the ground.
				hitcount = hitcount + 1
				
			end

			
		end
		
	
		-- Check if we're still in busieness and make sure we're not holding the brake lock (JUMP)
		
		
		-- print( self.Speed )
		if( IsValid( self.Pilot ) && self.Pilot:KeyDown( IN_JUMP ) && hitcount > 10 ) then
		
			local speed = self:GetVelocity():Length()
			if( !self.TravelDirection ) then self.TravelDirection = 1 end
			--börk
			if( speed > 75 ) then
			
				self:GetPhysicsObject():AddAngleVelocity( self:GetForward() * ( -1.55 * self.TravelDirection ) )
				
			end
		
		end
		
				

			 
		
		if ( self.IsDriving && IsValid( self.Pilot ) && hitcount > 10 && !self.Pilot:KeyDown( IN_JUMP )) then
		
			phys:Wake()
			
			-- If we're moving fast enough, make some dust.
			if( self:GetVelocity():Length() > 50 && hitcount > 6 ) then			
							
				local fx = EffectData()
				fx:SetOrigin( self:GetPos() + self:GetForward() * -60 )
				fx:SetScale( 2.0 )
				util.Effect("WheelDust", fx )
				
			end
			
			-- Get our yaw
			local mYaw = self:GetAngles().y
			-- Our angles
			local ap = self:GetAngles()
			local p = { { Key = IN_FORWARD, Speed = 0.5 };
						{ Key = IN_BACK, Speed = -0.5 }; }
			
			local keydown = false
			
			for k,v in ipairs( p ) do
			
				if ( self.Pilot:KeyDown( v.Key ) ) then
				
					-- self.Speed = self.Speed + v.Speed
					self.Speed = v.Speed
					
					keydown = true
					
					if( self.TrackEntities != nil ) then
						
						local speed = self:GetVelocity():Length()
						
						-- print( "braap", self.Speed, self.MinVelocity/100, self.MaxVelocity/100 ) 
						-- if( speed > self.MinVelocity/10 && speed < self.MaxVelocity/10 && self.Yaw == 0 ) then
							
							
							-- if( self.StartAngleVelocity ) then
								
								-- phys:AddAngleVelocity( Vector( 0, -self.StartAngleVelocity*2*v.Speed, 0 ) )
								
							-- else
							
							-- print( speed )
							if( speed < self.MaxVelocity * 4 ) then
								
								if( self.AngleForceDirection ) then
									
									phys:AddAngleVelocity( Vector( 0, 5*-v.Speed*self.AngleForceDirection, 0 ) )
									
								else
								
									phys:AddAngleVelocity( Vector( 0, 5*-v.Speed, 0 ) )
								
								end
								
							end
							
							-- end
						
						-- else
						
							-- phys:ApplyForceCenter( self:GetUp() * -500 ) 
							
						-- end
						
					end					
				end			
				
			end
			
			-- No keys held down, stop the tank.
			if( !keydown ) then
				
				
				self.Speed = 0
					
			end
			
			local dir = 0
			
			--self.Speed = math.Clamp( self.Speed,  self.MinVelocity, self.MaxVelocity )
	
			
			-- moving left
			if( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
							
				-- Use approach to simulate acceleration in the turn
				self.Yaw = math.Approach( self.Yaw, 0.44, 0.092 )
				dir = -0.2
				
				-- Rev the engine
				self.Pitch = 140
				
				
				self:GetPhysicsObject():AddAngleVelocity( self:GetUp() * -( 8 * dir ) )
				
			-- moving right
			elseif( self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
			
				self.Yaw = math.Approach( self.Yaw, -0.44, 0.092 )
				dir = 0.2
				self.Pitch = 140
				-- self.CVol = 1
				self:GetPhysicsObject():AddAngleVelocity( self:GetRight() * -( 10 * dir ) )
				
			else
				
				-- Straighten out our movement
				self.Yaw = math.Approach( self.Yaw, 0, 0.02 )
				-- self.CVol = 0
				
			end
		
			local p = self:GetPos()
			
			-- Limit our maxspeed since shadow controls doesn't know what a speedcap is.
			if( self.Speed > 0 && self:GetVelocity():Length() > (self.MaxVelocity / (0.75 * 0.0833333333 * 1.46666667 * 1.609344)) ) then 
				
				self.Speed = 0
				
			end
			
			-- Limit our min. speed.
			if( self.Speed < 0 && self:GetVelocity():Length() > -(self.MinVelocity / (0.75 * 0.0833333333 * 1.46666667 * 1.609344)) ) then
				
				self.Speed = 0
			
			end	
			
			-- Some tanks need an extra boost to start moving.
			if(self.Acceleration) then
			
				acc = math.Clamp(self.Acceleration, 0, 5)
			
			else
				
				acc = 3
				
			end
			
			local pr = {}
			pr.secondstoarrive	= 0.1
			pr.pos 				= p + self:GetForward() * self.Speed * 15
			pr.maxangular		= 10000
			pr.maxangulardamp	= 1000
			pr.maxspeed			=  12.5 + acc -- If we go lower than 12~ the tanks wont have any power up-hill.
			pr.maxspeeddamp		= 0
			pr.dampfactor		= 0.235
			pr.teleportdistance	= 10000
			pr.deltatime		= deltatime
			
			-- Degrees to turn
			local turnval = 3.756
			local turnval2 = 1.00001
			
			if( self.TurnMultiplier ) then
				
				turnval = self.TurnMultiplier
				
			end
			
			if( self.Speed == 0 ) then
			
				pr.angle = Angle( self:GetAngles().p, mYaw + ( self.Yaw * turnval ), self:GetAngles().r )
			
			else
			
				pr.angle = Angle( self:GetAngles().p, mYaw + self.Yaw + (self.BrokenYaw * turnval2), self:GetAngles().r )
			
			end
			
			phys:ComputeShadowControl(pr)
		
		else
			
			self.Speed = math.Approach( self.Speed, 0, 0.15 )

		end
		
	end
	
end

function Meta:TankDefaultPhysics( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
	if true then return end
	
	self:TankFuelChecker()
	
		local tr, trace = {}
		local hitcount = 0
		local _a = self:GetAngles()
		local z = 0

		for i=1,20 do
			
			tr.start = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetRight() * math.sin(CurTime() * self:EntIndex()) * 80
			tr.endpos = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetUp() * -40  + self:GetRight() * math.sin(CurTime() * self:EntIndex()) * 80
			tr.filter = self
			tr.mask = MASK_SOLID
			//self:DrawLaserTracer( self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetRight() * dir, self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetUp() * -17  + self:GetRight() * dir )
			
			trace = util.TraceLine( tr )
			
			if( trace.Hit && !trace.HitSky ) then
				
				hitcount = hitcount + 1
				-- //z = z + trace.HitPos.z
				
			end

			
		end
		
		if( self.GearBoxBroken ) then return end
		
		-- if( hitcount < 10 ) then
			
			-- //self.Speed = math.Approach( self.Speed, 0, 0.02 )
			
		-- end
		
		self.IsOnGround = hitcount > 5

		
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
			local p = { { Key = IN_FORWARD, Speed = 0.85 };
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
				
				self.Speed = self.Speed * 0.98
				
			end
			
			local dir = 0
			
			self.Speed = math.Clamp( self.Speed,  self.MinVelocity, self.MaxVelocity )
			
			if( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
						
				self.Yaw = math.Approach( self.Yaw, 0.44, 0.092 )
				dir = -0.2
				self.Pitch = 180
                -- self.CVol = 1
				
			elseif( self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
			
				self.Yaw = math.Approach( self.Yaw, -0.44, 0.092 )
				dir = 0.2
				self.Pitch = 180
                -- self.CVol = 1
		
			else
				
				self.Yaw = math.Approach( self.Yaw, 0, 0.02 )
                -- self.CVol = 0
			
			end
            
                if self.HasCVol then
                    self.CVol = 1
                end
		
			local p = self:GetPos()
			
			local downparam = ap.p
			if( downparam > 0 ) then downparam = 0 end
			
			
			local pr = {}
			pr.secondstoarrive	= 0.1
			pr.pos 				= p + self:GetForward() * self.Speed
			pr.maxangular		= 10000
			pr.maxangulardamp	= 10000
			pr.maxspeed			= 19
			pr.maxspeeddamp		= 12.95
			pr.dampfactor		= 0.155
			pr.teleportdistance	= 10000
			pr.deltatime		= deltatime
			
			
			if( self.Speed == 0 ) then
			
				pr.angle = Angle( self:GetAngles().p, mYaw + ( self.Yaw * 2.53 ), self:GetAngles().r )
			
			else
			
				pr.angle = Angle( self:GetAngles().p, mYaw + self.Yaw + self.BrokenYaw, self:GetAngles().r )
			
			end
			
			phys:ComputeShadowControl(pr)
		
		else
			
			self.Speed = math.Approach( self.Speed, 0, 0.1 )
		
		end

	
end

function Meta:TankDefaultRemove()
	
	if( IsValid( self.Pilot ) ) then
		
		timer.Simple( 0, function() CorrectPlayerObject( self.Pilot ) end )
		
	end
	
	self:TankExitVehicle()
	
	if( type( self.DriveWheels ) == "table" ) then
		
		for i=1,#self.DriveWheels do
				
			if( IsValid( self.DriveWheels[i] ) ) then
			
				self.DriveWheels[i]:Remove()
				
			end
			if( IsValid( self.WheelSockets[i] ) ) then
				
				self.WheelSockets[i]:Remove()
				
			end
			
		end
		
	end
	
	if( self.Flamesound && self.Flamesound2 ) then
		
		self.Flamesound:Stop()
		self.Flamesound2:Stop()
		
	end
	
	if( IsValid( self.Tower ) ) then
		
		self.Tower:Remove()
		
	end
	
	if( IsValid( self.TowerProxy ) ) then
	
		self.TowerProxy:Remove()
		
	end
	
	if( self.Wheels ) then
	
		for i=1,#self.Wheels do
			
			if( IsValid( self.Wheels[i] ) ) then
				
				self.Wheels[i]:Remove()
			
			end
			
		end
	
	end
	if( self.TrackEntities && type(self.TrackEntities) == "table" ) then
		
		for i=1,#self.TrackEntities do
			
			if( IsValid( self.TrackEntities[i] ) ) then
			
				self.TrackEntities[i]:Remove()
			
			end
			
			if( IsValid( self.TWheels[i] ) ) then
				
				self.TWheels[i]:Remove()
				
			end
			
		end
	
	end
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end
	
    if self.HasCVol then
        self.CEngSound:Stop()
	end
    
	self.TowerSound:Stop()

	if ( IsValid( self.ArtilleryCam ) ) then
	
		self.ArtilleryCam:Remove()
	
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:TankExitVehicle()
	
	end

	
end

function Meta:TankUpdateTrackStatus()
	
	if( self.TrackEntities && type(self.TrackPositions) == "table" ) then
		
		local LT = self.TrackEntities[1]
		local RT = self.TrackEntities[2]
		
		if( !IsValid( LT ) ) then return end
		if( !IsValid( RT ) ) then return end
		
		-- Damn you gbombs for removing my track welds.
		local Lweld, Rweld = self.TrackEntities[1].Weld, self.TrackEntities[2].Weld
		if( !IsValid( Lweld ) || !IsValid( Rweld ) && !self.BothTracksBroken || self.BothTracksBroken == true && self.BTBPlayOnce == nil) then
			
			self.BothTracksBroken = true
			
			if( self.BTBPlayOnce == nil ) then
				
				self.BTBPlayOnce = true
				timer.Simple( math.random(1,2 ), function()
					if( IsValid( self.PilotSeat ) ) then
					
						self.PilotSeat:EmitSound( "wot/radio/track_destroyed_0"..math.random(1,4)..".wav", 511, 100 )
						
					end
					
				end )
			
			end
			
			return
			
		end
		
		if( IsValid( LT ) && LT.Destroyed ) then
			
			self.BrokenYaw = math.Rand( 0.45, 1.45 )
		
			
		elseif( IsValid( RT ) && RT.Destroyed ) then
			
			self.BrokenYaw = -math.Rand( 0.45, 1.45 )
		
		elseif( IsValid( RT ) && IsValid( LT ) && !LT.Destroyed && !RT.Destroyed ) then
		
			self.BrokenYaw = 0
			self.BothTracksBroken = false
			
		end
		
		if( IsValid( LT ) && IsValid( RT ) && LT.Destroyed && RT.Destroyed ) then

			self.BrokenYaw = 0
			self.BothTracksBroken = true

		end
	
	end
	
end


function Meta:TankSyncronizeCrew( ply )
	
	if( !self.TankCrew ) then return end
	
	net.Start( "NeuroTanksCrewMembers" )
		net.WriteTable( self.TankCrew )
	net.Send( ply )
	-- print( "Syncing tank crew") 
	
end

function Meta:TankSendWheels( ply )
	
	local DataTable = {}
	
	
	for i=1,#self.SteerOrder do
		
		if( IsValid( self.DriveWheels[self.SteerOrder[i]] ) ) then
			
			timer.Simple(i/100, function()
			if( IsValid( self ) && IsValid( ply ) ) then
				
				net.Start( "NeuroCarsWheels" )
					
					-- print( i, self.SteerOrderDirections )
					
					net.WriteEntity( self.DriveWheels[self.SteerOrder[i]] )
				
				
					if( self.SteerOrderDirections && self.SteerOrderDirections[i] ) then
						
						net.WriteInt( self.SteerOrderDirections[i], 8 )
						
					end
					
					
				net.Send( ply )
				
			end
			
			end )
		end
		
	end
	
	
	
end

function Meta:TankDefaultTakeDamage( dmginfo )

	-- print("hit?")
	local atk = dmginfo:GetAttacker()
	
	if( atk == self.Pilot ) then return end
	-- print("hit 2?")
	if( IsValid( self.Pilot ) && self.Pilot:IsBot() && atk:IsPlayer() && !atk:IsBot() ) then
		
		-- if( !IsValid( self.Pilot.Target ) ) then
			
			self.Pilot.Target = atk
			
		-- end
	
	end
	-- print("hit 3?")
	if ( self.Destroyed ) then
		
		return

	end
	-- print("hit 4?")
	if( !self.LastRadioVoice ) then self.LastRadioVoice = CurTime() - 5 end

	
	-- if( damage < self.InitialHealth * ( self.ArmorThickness / 3.45 )  ) then return end
		
	local dt = dmginfo:GetDamageType()
	local dp = dmginfo:GetDamagePosition()
	local a = self:GetAngles()
	local b = ( self:GetPos() - dp ):Angle()
	local diff = self:VecAngD( a.y, b.y )
	
	local dmgfront = diff < -155 || diff > 155
	local dmgback = diff < 30 && diff > -30
	local dmgleft = diff < 155 && diff > 30
	local dmgright = diff > -155 && diff < -30
	local bitwise = ( bit.bor( dt, DMG_CRUSH ) == DMG_CRUSH ) || ( bit.bor( dt, DMG_BLAST_SURFACE ) == DMG_BLAST_SURFACE ) || ( bit.bor(dt, DMG_BLAST )  == DMG_BLAST ) || ( bit.bor( dt, DMG_BURN ) == DMG_BURN  )
	local damage = dmginfo:GetDamage()
	-- print( damage )
	
	if( bitwise ) then
		
		if( damage > 2000 ) then
			
			self:PlayWorldSound("wt/sounds/tank_hit_big_0"..math.random(1,4)..".wav" )
			
		elseif( damage > 1000 ) then
		
			self:PlayWorldSound("wt/sounds/tank_hit_med_0"..math.random(1,4)..".wav" )
		
		else 
			
			if( damage > 300 ) then 
			
				self:PlayWorldSound("wt/sounds/tank_hit_small2_0"..math.random(1,5)..".wav" )
			
			end 
			
		end 
		
	end 
	
	if( ( bit.bor( dt, DMG_BURN ) != DMG_BURN ) && bitwise ) then
	
		if( type( self.TankCrew ) == "table" ) then
			
			for i=1,#self.TankCrew do
				
				local seatpos = self:LocalToWorld( self.TankCrew[i].SeatPos )
				local dist = math.floor( ( dp - seatpos ):Length() )
				local dam = damage/10
				if( dist > 30 ) then dam = damage / 100 end
				local countDead = 0
				
				if( dist < 250 && !self.TankCrew[i].Dead ) then
						
					
					self.TankCrew[i].Health = self.TankCrew[i].Health - math.Clamp( math.abs(dam+math.random(1,2)), 0, 100 ) -- no u
					
					if( self.TankCrew[i].Health <= 0 ) then
						
						self.TankCrew[i].Health = 0
						self.TankCrew[i].Dead = true
						-- Driver got killed, stop the tank
						if( i == 1 ) then
						
							if( IsValid( self.Pilot ) ) then
								
								countDead = countDead + 1
								self.Pilot:PrintMessage( HUD_PRINTCENTER, "Your Driver was killed! Re-enter to assume his role." )
								self.Pilot:EmitSound( Sound("wot/radio/driver_killed_0"..math.random(1,4)..".wav"), 100, 100 )
								
								if( IsValid( atk ) && atk:IsPlayer() ) then
								
									atk:PrintMessage( HUD_PRINTCENTER, "You killed "..self.Pilot:Name().."'s Driver!" )
								
								end
								
							end
							
							self.Speed = 0
							-- Stop engine loops
							-- for i=1,#self.EngineMux do self.EngineMux[i]:Stop() end
							-- Stop track sounds
							-- if self.HasCVol then self.CEngSound:Stop() end
							-- Stop all the other timers and checks.
							self.IsDriving = false
							-- Disable smoke
							self:SetNetworkedBool("IsStarted", false )
							
							if( self.Flamethrower ) then
							
								self.Flamethrower:StopParticles() 
								self.IsBurning = false 
								self.FlameTime =  0
								self.Flamesound:FadeOut( 0.1 )
								self.Flamesound2:FadeOut( 0.1 )
								
							end
							
						-- Loader got killed, Increase our reload time.
						elseif( i == 2 ) then
							
							countDead = countDead + 1
							
							if( IsValid( self.Pilot ) ) then
							
								self.Pilot:PrintMessage( HUD_PRINTCENTER, "Your Loader was killed!" )
								self.Pilot:EmitSound( Sound("wot/radio/loader_killed_0"..math.random(1,4)..".wav"), 100, 100 )
								if( IsValid( atk ) && atk:IsPlayer() ) then
								atk:PrintMessage( HUD_PRINTCENTER, "You killed "..self.Pilot:Name().."'s Loader!" )
								end
								
							end
						
							if( self.AmmoTypes ) then
								
								for k,v in pairs( self.AmmoTypes ) do
									
									if( v.Delay ) then
										
										v.Delay = v.Delay * 2
										
									else 
										
										v.Delay = 8

									end
									
								end
								
							end
							
						elseif( i == 3 ) then
						
							countDead = countDead + 1
							
							if( IsValid( self.Pilot ) ) then
							
								self.Pilot:PrintMessage( HUD_PRINTCENTER, "Your Gunner was killed!" )
								self.Pilot:EmitSound( "wot/radio/gunner_killed_0"..math.random(1,4)..".wav", 100, 100 )
								if( IsValid( atk ) && atk:IsPlayer() ) then
								atk:PrintMessage( HUD_PRINTCENTER, "You killed "..self.Pilot:Name().."'s Gunner!" )
								end
							end
						
							self.InaccuracyPunishment = Angle( 3.84,3.34,3.74)*math.Rand(-1,1)
								
							
						elseif( i == 4 ) then
								
							countDead = countDead + 1
							
							if( IsValid( self.Pilot ) ) then
							
								self.Pilot:EmitSound( "wot/radio/commander_killed_0"..math.random(1,4)..".wav", 100, 100 )
								self.MouseScale3rdPerson = 0.015
								self.MouseScale1stPerson = 0.015
								self.Pilot:PrintMessage( HUD_PRINTCENTER, "Your Commander was killed!" )
								
								if( IsValid( atk ) && atk:IsPlayer() ) then
								atk:PrintMessage( HUD_PRINTCENTER, "You killed "..self.Pilot:Name().."'s Commander!" )
								end
							end
							
						end
						
					end
					
					self:TankSyncronizeCrew( self.Pilot )
					-- print( "Hurt Crewmember",  self.TankCrew[i].Health )
				end
					
			end
			
		end
		
	end
	
	if( IsValid( self.Tower ) ) then
		
		local hitturret = ( ( ( dp - self.Tower:GetPos() ):Length() < 16 ) && ( damage > self.InitialHealth * 0.192 ) )
		local nearturret = ( ( ( dp - self.Tower:GetPos() ):Length() < 30 ) && ( damage > self.InitialHealth * 0.15 ) )
		
		if( nearturret ) then
			
			local punishment = math.random(2,6)
			
			if( self.AmmoTypes && self.AmmoIndex && self.AmmoTypes[self.AmmoIndex] && self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount && self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount >= punishment ) then 
			
				self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount = self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount - punishment
				self:SetNetworkedInt("NeuroTanks_ammoCount", self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount )
				
				if( IsValid( self.Pilot ) ) then
				
					self.Pilot:EmitSound( "wot/radio/ammo_bay_damaged_0"..math.random(1,4)..".wav", 100, 100 )
					
					
				end
				
			end
			
		end
		
		if( hitturret ) then
			
			self:EmitSound( "ambient/explosions/explode_4.wav", 511, 200 )
			timer.Simple( 1, function() if ( IsValid( self ) ) then self:EmitSound( "ambient/explosions/explode_3.wav", 511, 200 ) end end )
			timer.Simple( 2, function() if ( IsValid( self ) ) then self:EmitSound( "ambient/explosions/explode_5.wav", 511, 200 ) end end )
			timer.Simple( 4, function() if ( IsValid( self ) ) then self:EmitSound( "ambient/explosions/explode_2.wav", 511, 200 ) end end )
			-- self.Tower:EmitSound( "ambient/explosions/explode_2.wav", 511, 200 )
			
			-- Ammo Rack
			if( IsValid( atk ) && atk:IsPlayer() ) then
				
				atk:PrintMessage( HUD_PRINTTALK, "You dealt "..math.floor(damage).." to "..self.PrintName.."'s Ammo Rack.. Ouch" )
				
			end
			
			if( IsValid( self.Pilot ) ) then

				-- self.Pilot:Fire("Ignite",2,2)
				self.Pilot:Ignite( 10, 10 )
				self:TankExitVehicle()

			end
		
			
			-- ParticleEffect( "tank_cookoff", self:GetPos() + Vector( 0,0,16 ), self:GetAngles(), self )
			ParticleEffectAttach( "tank_cookoff", PATTACH_ABSORIGIN_FOLLOW, self.Tower, 0 )
			
			self.WasCooked = true
			
			timer.Simple( 1, function() 
								if( IsValid( self ) ) then 
									
									self:TankDeathFX(true)
									
								end 
								
							 end )

			self.Destroyed = true
			
			return
			
		end
		
		
	end
	
	
	local bulletsponge = ( ( bit.bor( dt, DMG_BUCKSHOT ) == DMG_BUCKSHOT ) || ( bit.bor( dt, 4098 ) == 4098 ) || ( bit.bor( dt, DMG_NEVERGIB ) == DMG_NEVERGIB ) )
	-- print( dmginfo:GetDamageType() )
	-- print( bulletsponge )
	-- DMG_BUCKSHOT	 536870912
	-- DMG_BULLET 2
	if( dmgfront ) then 
		
		damage = damage * ( TANK_DAMAGE_MODIFIER_FRONT - self.ArmorThicknessFront )
		
		if( bitwise ) then
		
			self.DamageTakenFront = self.DamageTakenFront + damage
		 
		end
		
	end
	
	if( dmgback ) then
		
		damage = damage * ( TANK_DAMAGE_mODIFIER_REAR - self.ArmorThicknessRear )
		
		if( bitwise ) then
		
			
			--self:GetPhysicsObject():AddAngleVelocity( ( self:GetPos() - dp ):GetNormal() * damage/8 )
			self.DamageTakenRear = self.DamageTakenRear + damage
			
			
			-- big hit causes oil leak. No oil = engine overheats.
			if( damage > self.InitialHealth * 0.37 ) then
				
				self.OilLeaking = true
				
				-- print( self.PrintName, "is leaking oil" )
				
			end
			
			-- tough odds, but a square hit in the ass close enough to the center should be enough for an ammo explosion.
			--  /**&& math.random( 1, 10 ) == 5 )**/ 
			-- if( dp:Distance( self:GetPos() ) < 55 && damage > self.InitialHealth / 3) then
			-- if ( true ) then
			
				-- if( IsValid( self.Tower ) ) then
					
					
					
				
				-- end
				
			-- end
			
			if( dp:Distance( self:GetPos() ) < 110 ) then
				
				self.GearBoxHealth = self.GearBoxHealth - damage / 2
				
				self:SetNetworkedInt( "EngineGearBoxHealth", self.GearBoxHealth )
				
				-- print( self.PrintName, "GearBox hit" )
				
				if( self.GearBoxHealth < 0 && !self.GearBoxBroken ) then
					
					-- print( self.PrintName, "GearBox Busted" )
				
					-- Cant move without a gearbox :(
					-- self.MaxVelocity = 0
					-- self.MinVelocity = 0
					-- self.Speed = 0
					-- self.MaxYaw = 0
					-- self.MinYaw = 0
					self.GearBoxBroken = true
					
					-- that sounded nasty
					-- self:EmitSound("npc/combine_gunship/gunship_explode2.wav",211, 170 )
					self:PlayWorldSound( "wt/sounds/tank_hit_big_0"..math.random(1,4)..".wav")
					local gearboxparts = {
					"models/props_c17/TrapPropeller_Lever.mdl",
					"models/props_vehicles/carparts_axel01a.mdl",
					"models/mechanics/gears/gear12x12.mdl",
					"models/mechanics/gears/gear12x12.mdl"
					}
					
					for i=1,#gearboxparts do 
						
						local prop = ents.Create("prop_physics")
						prop:SetModel( gearboxparts[i] )
						prop:SetPos( self:GetPos() + Vector( math.random(-44,44),math.random(-44,44),32 ) )
						prop:SetAngles( self:GetAngles() )
						prop:Spawn()
						prop:SetVelocity( self:GetForward() * -100 )
						prop:Fire("kill",60)
						
					end
					
					local fx1=EffectData()
					fx1:SetOrigin(self:GetPos())
					util.Effect("Explosion",fx1)
			
				end
			
			end
			
			
		end
		
		
	end
	-- self.DefaultGearBoxHealth = 500
	-- self.GearBoxHealth = self.DefaultGearBoxHealth
	-- self.GearBoxBroken = false
	
	-- self.DefaultOilLevel = 100
	-- self.OilLevel = self.DefaultOilLevel
	-- self.OilPumpBroken = false
	-- self.OilLeaking = false
	
	-- self.EngineHeatCold = 0
	-- self.EngineHeatIdle = 100
	-- self.EngineHEatBoiling = 500
	-- self.EngineBoilingCooldown = 15
	
	-- self.EngineFluidCheck = CurTime()
	if( dmgleft || dmgright ) then
		
		damage = damage * ( TANK_DAMAGE_MODIFIER_SIDE  - self.ArmorThicknessSide )
		
		if( bitwise ) then
		
			if( dmgleft ) then
			
				self.DamageTakenLeft = self.DamageTakenLeft + damage
				
			else
			
				self.DamageTakenRight = self.DamageTakenRight + damage
			
			end
			
		end
		
	end
	-- print( damage )
	local Treshhold = self.InitialHealth * 0.745
	local EngineTreshold = self.InitialHealth * 0.89
	
	if( self.DamageTakenRear > EngineTreshold ) then
		
		self.MaxVelocity = 1
	
	end
	
	if( type(self.TrackPositions) == "table" ) then
			
		-- Nothing
		
	else
		
		if( self.HealthVal <= self.InitialHealth - Treshhold ) then
			
			if( self.DamageTakenLeft > Treshhold ) then
				
				self.BrokenYaw = math.Rand( 0.45, 1.45 )
				
			elseif( self.DamageTakenRight > Treshhold ) then
				
				self.BrokenYaw = -math.Rand( 0.45, 1.45 )
			
			end
			
		else
		
			self.BrokenYaw = 0
			
		end
		
	end
	
	-- Bitwise on the damage bitmasks to see if they can hurt.
	if( bitwise ) then 
		--// Nothing, these can hurt us
		if( !atk.LastMessage ) then
			atk.LastMessage = CurTime() - 2
		end
		
		if( atk:IsPlayer() ) then
			
			if( !atk.DamagedGroup ) then
				
				atk.DamagedGroup = 0 
				atk.DamagedGroupLast = CurTime()
				atk.LastVictim = self
				
			end
			
			atk.LastVictim = self
			
			if( atk.LastMessage <= CurTime()  ) then
				
				if( atk.DamagedGroupLast + 5.0 <= CurTime() || atk.LastVictim != self ) then
					
					atk.DamagedGroup = 0
					
				end
				
				atk.LastMessage = CurTime() + 1.0
				
				if( atk.DamagedGroup > 0 ) then
					
					atk:PrintMessage( HUD_PRINTTALK, "You dealt "..math.floor( atk.DamagedGroup ).." damage to "..self.PrintName )
					atk.DamagedGroup = 0
					
				else
				
					atk:PrintMessage( HUD_PRINTTALK, "You dealt "..math.floor( damage ).." damage to "..self.PrintName )
				
				end
				
				if( damage > self.HealthVal ) then
					
					atk:EmitSound("wot/global/enemy_killed_0".. math.random( 1, 8 ) ..".wav",511,100)
				
				else
				
					if math.floor(damage) > 2000 then
					
						self:EmitSound("wot/global/critical".. math.random( 1, 4 ) ..".wav",500,100)
						
						if IsValid( atk:GetScriptedVehicle() ) && atk:GetScriptedVehicle().VehicleType && atk:GetScriptedVehicle().VehicleType  == VEHICLE_TANK then
							
							atk:EmitSound("wot/global/armor_pierced_crit_by_player_".. math.random( 1, 3 ) ..".wav",511,100)
						
						end
						
					elseif math.floor(damage) < 400 then
					
						self:EmitSound("wot/global/hitlow".. math.random( 1, 3 ) ..".wav",500,100)
						
						if IsValid( atk:GetScriptedVehicle() ) && atk:GetScriptedVehicle().VehicleType && atk:GetScriptedVehicle().VehicleType  == VEHICLE_TANK then
							
							atk:EmitSound("wot/global/armor_not_pierced_by_player_0".. math.random( 1, 6 ) ..".wav",511,100)
						
						end
						
					else
						
						self:EmitSound("wot/global/hit".. math.random( 1, 9 ) ..".wav",500,100)
						
						if IsValid( atk:GetScriptedVehicle() ) && atk:GetScriptedVehicle().VehicleType && atk:GetScriptedVehicle().VehicleType  == VEHICLE_TANK and self.HealthVal > 5 then
							
							atk:EmitSound("wot/global/armor_pierced_by_player_0".. math.random( 1, 9 ) ..".wav",511,100)
							-- print(self.HealthVal)
							-- print("I executed this")
							
						end
						
					end
				
				end
				
			else
				
				atk.DamagedGroup = atk.DamagedGroup + damage
				atk.DamagedGroupLast = CurTime()
				
			end
		
		end
		
	else
	
		if( bulletsponge ) then

		
		end
		
		local infomessage = "This vehicle can only be damaged by armor piercing rounds and explosives!"
		
		if( self.LastReminder + 5 <= CurTime() && atk:IsPlayer() && atk != self.Pilot ) then
			
			self.LastReminder = CurTime()
			atk:PrintMessage( HUD_PRINTCENTER, infomessage )

		end
			

		return
		
	end
	
	self:TakePhysicsDamage(dmginfo)
    self.HealthVal = self.HealthVal - damage
    self:SetNetworkedInt( "health", self.HealthVal )

	if( self.HealthVal < 0 ) then
		 
		if( IsValid( self.Pilot ) ) then
			
			self:TankExitVehicle()
			
		end
		
		if( IsValid( self.Copilot ) ) then

			 self.Copilot:ExitVehicle()

		end
		
	end
	
	local dpos = dmginfo:GetDamagePosition()
	local fx = EffectData()
	fx:SetStart( dpos )
	fx:SetOrigin( dpos )
	fx:SetScale( 1.0 )
	util.Effect("HunterDamage", fx )
	
	-- if( IsValid( self.Pilot ) ) then
		
		-- self.Pilot:SetHealth( self.HealthVal )
		
	-- end
	
	if ( self.HealthVal < self.InitialHealth * 0.25 && !self.Burning ) then

		self.Burning = true
		self.FireTrails = {}
		
		for _i=1,math.random( 2 , 5 ) do
		
			self.FireTrails[_i] = ents.Create("env_fire_trail")
			self.FireTrails[_i]:SetPos( self.Tower:GetPos() + VectorRand() * 16 )
			self.FireTrails[_i]:SetParent( self )
			self.FireTrails[_i]:Spawn()
		
		end
		
		timer.Simple( math.random( 2.5,5.5 ), function() 
				
				if( IsValid( self ) ) then
					
					self:Ignite( 30, 30 )
					
				end
			
			end )
			
	end
	
	if ( self.HealthVal <= 0 ) then
	
		self.Destroyed = true
		self:Ignite(60,512)
		
		self.Killer = atk
		
		if( type( self.Tower ) == "table" || type( self.Barrel ) == "table" ) then
				
				
				
		else
		
			if( self.DontCook == nil && math.random(1,12 ) == 2 &&  self.TankType && self.TankType < TANK_TYPE_ARTILLERY && self.TankType > TANK_TYPE_LIGHT ) then
				
				-- self:EmitSound( "ambient/atmosphere/terrain_rumble1.wav", 511, 100 )
				self:EmitSound( "ambient/explosions/explode_4.wav", 511, 200 )
				timer.Simple( 1, function() if ( IsValid( self ) ) then self:EmitSound( "ambient/explosions/explode_3.wav", 511, 200 ) end end )
				timer.Simple( 2, function() if ( IsValid( self ) ) then self:EmitSound( "ambient/explosions/explode_5.wav", 511, 200 ) end end )
				timer.Simple( 4, function() if ( IsValid( self ) ) then self:EmitSound( "ambient/explosions/explode_2.wav", 511, 200 ) end end )
				-- self.Tower:EmitSound( "ambient/explosions/explode_2.wav", 511, 200 )
				
				if( IsValid( self.Pilot ) ) then
					
					-- local ply = self.Pilot
					self.Pilot:Fire("Ignite",2,2)
					self:TankExitVehicle()
					
					-- ply:Ignite( 15, 128 )
					
				end
			
		
				ParticleEffect( "tank_cookoff", self:GetPos() + Vector( 0,0,16 ), self:GetAngles(), self )
				self.WasCooked = true
				
				timer.Simple( 4, function() if( IsValid( self ) ) then self:TankDeathFX() end end )
				
				if( self.IsDriving ) then
					
					self.Speed = 15 
					
				end
				
				
			else

				self:TankDeathFX()
			
			end
			
		end
		
	end
	
end

function Meta:TankDeathFX()
	
	if( !IsValid( self ) ) then return end
	
	if( self.IsVeryDead ) then return end
	
	self.IsVeryDead = true
	
    self:EmitSound(self.HitSound or "wot/global/death".. math.random( 1, 5 ) ..".wav",500,100)
    self.PilotSeat:EmitSound( "wot/radio/vehicle_destroyed_0"..math.random(1,5)..".wav", 100, 100 )
	ParticleEffect("dusty_explosion_rockets", self:GetPos() + self:GetUp() * 100, Angle(0,0,0), nil )
    
	if( self.HugeDeathExplosion ) then
		
		-- ParticleEffectAttach( "fireplume", PATTAch_aBSORIGIN, body, 0 )
		ParticleEffect("fireball_explosion", self:GetPos() + self:GetUp() * 1, Angle(0,0,0), nil )
		
		-- ParticleEffect("V1_impact", self:GetPos() + self:GetUp() * 700, Angle(0,0,0), nil )
		self.Shake = ents.Create( "env_shake" )
		self.Shake:SetOwner( self.Owner )
		self.Shake:SetPos( self:GetPos() )
		-- self.Shake:SetParent( self )
		self.Shake:SetKeyValue( "amplitude", "500" )	-- Power of the shake
		self.Shake:SetKeyValue( "radius", "9500" )	-- Radius of the shake
		self.Shake:SetKeyValue( "duration", "5" )	-- Time of shake
		self.Shake:SetKeyValue( "frequency", "255" )	-- How har should the screenshake be
		self.Shake:SetKeyValue( "spawnflags", "4" )	-- Spawnflags( In Air )
		self.Shake:Spawn()
		self.Shake:Activate()
		self.Shake:Fire( "StartShake", "", 0 )
		util.BlastDamage( self, self, self:GetPos()+Vector(0,0,1024), 3000, 5000 )
		self:PlayWorldSound( "ambient/athmosphere/thunder2.wav")
		self:PlayWorldSound( "ambient/explosions/explode_7.wav")
		
		-- for k,v in pairs( player.GetAll() ) do
			
			-- if( ( v:GetPos() - self:GetPos() ):Length() < 25000 ) then
			
				
				-- v:SendLua([[surface.PlaySound("ambient/atmosphere/thunder2.wav")]])
				-- v:SendLua([[surface.PlaySound("ambient/explosions/explode_7.wav")]])
				
			
			-- end
			
		-- end
		
	end
	
	
	
	local pos = self:GetPos()
	local tone = Color( 160, 160, 160, 255 )
	
	-- if(math.random(1,2) == 1 ) then
		
		-- timer.Simple( 16, function() 
			-- if( pos ) then 
				
				-- local pwr = ents.Create("tank_powerup" )
				-- pwr:SetPos( pos )
				-- pwr:SetAngles( Angle( 0,0,0 ) )
				-- pwr:SetSolid( SOLID_VPHYSICS )
				-- pwr:Spawn()
				-- pwr:Fire("kill","",60)
				
			-- end
			
		-- end )
		
	-- end
	
	local barrel, tower, body
	
	if( IsValid( self.Barrel ) ) then
	
		barrel = ents.Create( "prop_physics" )
		barrel:SetPos( self.Barrel:GetPos() )
		barrel:SetAngles( self.Barrel:GetAngles() )
		barrel:SetModel( self.Barrel:GetModel() )
		barrel:SetMaterial( self.Barrel:GetMaterial() )
		barrel:SetSkin( self.Barrel:GetSkin() )
		barrel:SetColor( tone )
		
		if self.HasParts && self.BarrelPart then
		
			barrel:SetBodygroup( 0, self.BarrelPart )
			
		end
		
		barrel:Spawn()
		barrel:Fire("kill","", 30 )
		
	end
	
	if( IsValid( self.Tower ) ) then
		
		tower = ents.Create( "prop_physics" )
		tower:SetPos( self.Tower:GetPos() )
		tower:SetAngles( self.Tower:GetAngles() )
		tower:SetModel( self.Tower:GetModel() )
		tower:SetMaterial( self.Tower:GetMaterial() )
		tower:SetSkin( self.Tower:GetSkin() )
		tower:SetSolid( SOLID_VPHYSICS )
		tower:SetColor( tone )
		
		if self.HasParts && self.TowerPart then
			
			tower:SetBodygroup(0, self.TowerPart)
			
		end
		
		tower:Spawn()
		-- tower:PhysicsDestroy()
		tower:Fire("kill","", 30 )
		if( math.random( 1,3 ) == 2 ) then 
			barrel:SetParent( tower )
		end
		
		if( self.WasCooked ) then
			
			tower:GetPhysicsObject():SetMass( 500 )
			tower:GetPhysicsObject():ApplyForceCenter( tower:GetUp() * 265500 )
			
		end
		ParticleEffect("neuro_gascan_explo", tower:GetPos(), Angle(0,0,0), tower )
		ParticleEffectAttach( "fire_b", PATTACH_ABSORIGIN_FOLLOW, tower, 0 )
		
	end
	
	body = ents.Create("prop_physics")
	body:SetPos( self:GetPos() )
	body:SetAngles( self:GetAngles() )
	body:SetModel( self:GetModel() )
	body:SetMaterial( self:GetMaterial() )
	body:SetSkin( self:GetSkin() )
	-- body:SetCustomCollisionCheck( true )
	body:SetColor( tone )
	body:Spawn()
	body:Fire("kill","", 30 )
	-- body:SetSolid( SOLID_VPHYSICS )
	
	if( self.HugeDeathExplosion ) then
			
		ParticleEffectAttach( "fireplume", PATTAch_aBSORIGIN, body, 0 )
		ParticleEffect("FAB_groundwave", body:GetPos() + body:GetUp() * -200, Angle(0,0,0), nil )
		
	end
	
	body.Owner = self
	-- body:Ignite( 100, 100 )
	if( self.MicroTurrets ) then
	
		for k,v in pairs( self.MicroTurrets ) do
			
			if( IsValid( v ) ) then
				v:SetParent( body )
				v.Tower:SetParent( v )
				v.Barrel:SetParent( v )
				timer.Simple( math.Rand(0,2), function()
					if( IsValid( v ) ) then
						v.WasCooked = true
						v:TankDeathFX()
					end
					
				end )
					
			end
			
		end
	
	end
	
	ParticleEffectAttach( "fire_b", PATTACH_ABSORIGIN_FOLLOW, body, 0 )
	
	if( type( self.TrackEntities) == "table" ) then
		
		for i=1,#self.TrackEntities do
			
			if( IsValid( self.TrackEntities[i] ) ) then
				
				local track = ents.Create("prop_physics")
				track:SetPos( self.TrackEntities[i]:GetPos() )
				track:SetAngles(  self.TrackEntities[i]:GetAngles() )
				track:SetModel( self.TrackEntities[i]:GetModel() )
				-- track:SetSkin( self.TrackEntities[i]:GetSkin() )
				track:SetColor( tone )
				
				track:Spawn()
				track:Fire("kill","", 30 )
				-- track:Ignite( 100, 100 )
				-- track:SetOwner( body )
				-- track.Owner = body
				-- track.DefaultSkin = self.TrackAnimationOrder[1]
				track:SetParent( body )
				
			end
			
			if( self.TWheels && IsValid( self.TWheels[i] ) ) then
				
				local wheel = ents.Create("prop_physics")
				wheel:SetPos( self.TWheels[i]:GetPos() )
				wheel:SetAngles(  self.TWheels[i]:GetAngles() )
				wheel:SetModel( self.TWheels[i]:GetModel() )
				wheel:SetSkin( self.TWheels[i]:GetSkin() )
				wheel:SetColor( tone )
				wheel:Spawn()
				wheel:SetParent( body )
				if( IsValid( track ) ) then
					wheel:SetOwner( track )
				end
				wheel:Fire("kill","", 30 )
				if(math.random(1,2)==2) then
					wheel:SetParent( body )
				end
				-- wheel:Ignite( 100, 100 )
				wheel:SetOwner( body )
				
			end
			
		end
	
	end
	local parent = self:GetParent()
	-- we're attached to something.
	if( IsValid( parent ) ) then
		
		body:SetOwner( parent )
		barrel:SetOwner( parent )
		tower:SetOwner( parent )
		
	end
	for i=0,4 do
		
		local explo = EffectData()
		explo:SetOrigin(self:GetPos() + VectorRand() * 16 )
		util.Effect("Explosion", explo)

	end

	-- local f1 = EffectData()
	-- f1:SetOrigin(self:GetPos())
	-- util.Effect("immolate",f1)

	-- for i=1,10 do
	
		-- local fx=EffectData()
		-- fx:SetOrigin(self:GetPos()+Vector(math.random(-256,256),math.random(-256,256),math.random(-256,256)))
		-- fx:SetScale( i / 5 )
		-- util.Effect("AC130_Napalm",fx)
		
	-- end
	local inflictor = self.Killer or self
	if( !IsValid( inflictor ) ) then inflictor = self end
	
	util.BlastDamage( self, inflictor, self:GetPos() + Vector( 0,0,256 ) , 512+self.TankType*30, math.random( 1500, 3500) )
	
	
	self:TankExitVehicle()
	self:Fire("kill","",0)
	
	return
	
end

function Meta:StartupSequence()
	
	if( !IsValid( self ) ) then return end
	if( !IsValid( self.Pilot ) ) then return end
	
				-- self:SetNetworkedBool("IsStarted", true )
	self.IsDriving = true	
	self:SetNetworkedBool("IsStarted", true )
	-- self:StopSound( startupsound )
	if( self.PStartupsound ) then
	
		self.PStartupsound:Stop()
	
	end
	
	if( self.HoverRotorWashPoints ) then
		
		for i=1,#self.RotorWashPoints do
		
			if( IsValid( self.RotorWashPoints[i] ) ) then
		
				TankCreateHoverDust( self.RotorWashPoints[i] )
				
			end
			
		end
		
	end
	
	-- Engine sounds
	local volume = 511
	if( self.EngineVolume ) then
		
		volume = self.EngineVolume
		
	end
	
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:PlayEx( volume, self.Pitch )
		-- self.EngineMux[i]:ChangePitch(  100 + math.Clamp( self:GetVelocity():Length(), 0, 25 ), 0.1 )
		
	end
	if self.HasCVol then
	
		--self.CEngSound = CreateSound(self, self.TrackSound)
		self.CEngSound:PlayEx( self.CVol, 100 )
			
	end
	-- Head lights
	if( type( self.HeadLights ) == "table" && TankHeadlights > 0 ) then
		
		-- for i=1,#self.HeadLights.Lamps do
			
			-- if( IsValid( self.HeadLights.Lamps[i] ) ) then
			
				-- self.HeadLights.Lamps[i]:Fire("TurnOn","",0)
			
			-- end
			
		-- end
		
		-- self:CreateHeadlightSprites()
		
	end

end

function Meta:UpdateTankAmmoStruct()

	if( self.AmmoStructure ) then
		
		local brl = self.Barrel:GetBodygroup(0)
		local twr = self.Tower:GetBodygroup(0)
		self.LastBarrel = brl
		self.LastTower = twr
		
		for k,v in pairs( self.AmmoStructure ) do

			if( v.Tower == twr && v.Barrel == brl ) then
				
				self.AmmoTypes = v.Ammo
				if( v.BarrelPos ) then
					
					self.Tower:SetAngles( self:GetAngles() )
					self.Barrel:SetParent( NULL )
					self.Barrel:SetPos( self:LocalToWorld( v.BarrelPos ) )
					self.Barrel:SetParent( self.Tower )
					
				end
				
				break
				
			end
		
		end
				
		if( !self.AmmoTypes ) then
			
			self.AmmoTypes = self.AmmoStructure[1]
			print( "Undefined barrel/tower combination:", self.Barrel:GetBodygroup(0), self.Tower:GetBodygroup(0), self:GetClass() )
			
		end
		
	end
	
end

function Meta:TankDefaultUse( ply, caller )
	
	
	if( self.HealthVal <= 0 ) then return end -- D: how did this happen?
	
	if( ply == self.Pilot ) then return end
	if( self.Fuel && self.Fuel <= 0 ) then 
		
		ply:PrintMessage( HUD_PRINTCENTER,  "out of fuel" )
		
		-- return 
	
	end
	
	if( type( self.TankCrew ) == "table" ) then
			
		local CountDead = 0
		for i=1,#self.TankCrew do
			
			if( self.TankCrew[i].Dead ) then
				
				CountDead = CountDead + 1
			
			end
			
		end
		
		-- Whole crew dead, we can't drive this alone.
		if( CountDead == #self.TankCrew ) then
			
			local phrases = {	
			"There's so much blood D: I can't drive this",
			"This shit smells like rotten ass. I'm not driving this..",
			"There's brain on the ammo rack.. I'm not touching this",
			"The crew is dead. You can't drive this alone"
			};
			
			ply:PrintMessage( HUD_PRINTCENTER, phrases[math.random(1,#phrases)] )
			ply:PrintMessage( HUD_PRINTTALK, "This tank is too messy for a gentleman to drive" )

			return false
		
		end
		
	end
	
	if( self.OilLevel && self.OilLevel <= 0 ) then 
	
			ply:PrintMessage( HUD_PRINTCENTER,  "Major Oil Leak!" )
			
		return
	
	end
	
	if ( !self.IsDriving && !IsValid( self.Pilot ) ) then
		
		-- if( IsValid( self.Tower ) ) then
		
			-- self.Tower:GetPhysicsObject():Wake()
			
		-- end
		    
		-- Expand on this loop here for variables like Barrel Pos, etc
		
		if( self.DriveWheels ) then
			
			timer.Simple( 1, function()
			if( IsValid( self ) && IsValid( ply ) ) then
			
				self:TankSendWheels( ply )
			end
			
			end )
		end
			
		self:UpdateTankAmmoStruct()
		
		

		if( type( self.AmmoTypes ) == "table" && type(self.AmmoTypes[self.AmmoIndex]) == "table" ) then
		
			self:SetNetworkedString("NeuroTanks_activeWeapon", self.AmmoTypes[self.AmmoIndex].PrintName )
			self:SetNetworkedString("NeuroTanks_activeWeaponShell", self.AmmoTypes[self.AmmoIndex].Type )
			
			
			for i=1,#self.AmmoTypes do

				if( self.AmmoTypes[i].MaxAmmo == nil && self.AmmoTypes[i].CurrentAmmoCount == nil ) then
					
					
					local Count = self.ForcedMagazineCount or ( 2+TANK_TYPE_MAX - self.TankType ) * 10
					-- print( Count )
					self.AmmoTypes[i].MaxAmmo = Count
					self.AmmoTypes[i].CurrentAmmoCount = Count

				end
				
			end
			
			self:SetNetworkedInt("NeuroTanks_ammoCount", self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount )
					
		end
		
		self:TankSyncronizeCrew( ply )
		ply:SendLua( "RotateHud( 1 ) " ) 
	
		self.UnUsed = false
		self.LastUsed = CurTime()
		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.Pilot = ply
		self.Owner = ply
		
		ply:SetNetworkedBool("InFlight",true )
		
		-- ply.Weapons = {}
		-- for k,v in pairs( ply:GetWeapons() ) do
			
			-- if( IsValid( v ) ) then
			
				-- ply.Weapons[k] = v:GetClass()
			
			-- end
			
		-- end
		-- 
		-- ply.Weps = ply:GetWeapons()
		
		-- if( self.AdvancedCommando ) then
	
			ply:EnterVehicle( self.PilotSeat )
		
		-- else
		
			-- ply.Col = ply:GetColor()
			-- ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			-- ply:SetColor( Color( 0,0,0,0 ) )
			-- ply:GodEnable( true )
			-- ply:StripWeapons()
			
		-- end
		
		ply.OriginalFOV = ply:GetFOV()
		ply:SetHealth( self.HealthVal )
	
		ply:SetScriptedVehicle( self )

		if( self.HasTower && type(self.Tower) != "table" ) then
		
			ply:SetNetworkedEntity( "Tank", self.Tower )
		
		else
		
			ply:SetNetworkedEntity( "Tank", self )
		
		end
		
		if( type( self.Barrel ) == "table" ) then
			
			ply:SetNetworkedEntity( "Barrel", self.Barrel[1] )
			
		else
		
			ply:SetNetworkedEntity( "Barrel", self.Barrel  )
		
		end
		
		if( self.HasMGun ) then
			
			ply:SetNetworkedEntity( "Weapon", self.MGun )
		
		end
		
		self:SetNetworkedEntity("Pilot", ply )
		
		
		ply:SetEyeAngles( self:GetAngles() )
		
        if self.CockpitSeatMoveWithTower then
			
			-- print( self.SeatAngle, self.SeatPos )
			
			self.Tower.Pilot = self.Pilot
            self.PilotModel = self.Tower:SpawnPilotModel( self.SeatPos, self.SeatAngle )
           	self.PilotModel:SetAngles( self.Tower:GetAngles() + self.SeatAngle )
			-- print( self:WorldToLocal( self.PilotModel:GetPos()  ) )
			
            -- self.PilotModel:SetPos( self:LocalToWorld( self.SeatPos ) )
			-- self.PilotModel:SetAngles( self.Tower:GetAngles() + Angle( 0, -90, 0 ) + self.SeatAngle )
			-- self.PilotModel:SetParent( self.Tower )
			
			-- print( self:WorldToLocal( self.PilotModel:GetPos()  ) )
			
			
            self.Pilot:SetColor( Color( 255,255,255,255 ) )
			
			if( self.HideDriver ) then
				
				self.Pilot:SetColor( Color( 0,0,0,0 ) )
				self.Pilot:SetRenderMode( RENDERMODE_TRANSALPHA )
				
			end
			
        end          
        
		
		self:TankSyncAmmo()
		
		if( self.Fuel && self.Fuel > 0 ) then
			

			self.PStartupsound = "vehicles/jetski/jetski_no_gas_start.wav"
			local startupdelay = 1.0
			
			if( self.StartupSound ) then
				
				self.PStartupsound = CreateSound( self, self.StartupSound )
				
			end
			
			if( self.StartupDelay ) then
				
				startupdelay = self.StartupDelay
				
			end
			
			-- self:EmitSound( startupsound, 511, 100 )
			self.PStartupsound:PlayEx( 101, 100 )
		
			-- Start the tank
			timer.Simple( startupdelay, 
			function() 
				
				self:StartupSequence()
				-- ply:SetEyeAngles( self:GetAngles() )
				-- ply:SetAngles( self:GetAngles() )
				
			end)
			
		end
		
	else
	
		if( IsValid( self.CopilotSeat ) ) then
			
			if( !IsValid( self.CopilotSeat:GetDriver() ) ) then
				
				ply:EnterVehicle( self.CopilotSeat )
				
				if( self.HasMGun ) then
				
					ply:SetNetworkedEntity( "Weapon", self.MGun )
					
				end
			
				return
				
			end
		
		end
		local found = false
		
		if( self.MicroTurrets ) then
			
			for i=1,#self.MicroTurrets do
			
				if( !IsValid( self.MicroTurrets[i].Pilot ) ) then
					
					self.MicroTurrets[i]:Use( ply, ply, 0, 0 )
					found = true
					
					break
					
				elseif( IsValid( self.MicroTurrets[i].Pilot ) ) then
					
					if( IsValid( self.MicroTurrets[i].CopilotSeat  ) ) then
						
						if( !IsValid( self.MicroTurrets[i].CopilotSeat:GetDriver() ) ) then
							
							self.MicroTurrets[i]:Use( ply, ply, 0, 0 )
							found = true
							
							break
							
						end
						
					end
				
				end
				
			end
		
		end
		
		if( self.ChillSeats && !found ) then
		
			for i=1,#self.ChillSeats do
				
				local d = self.ChillSeats[i]:GetDriver()
				
				if( !IsValid( d ) ) then
					
					ply:SetAllowWeaponsInVehicle( true )
					
					ply:EnterVehicle( self.ChillSeats[i] )
					
					break 
				
				end
				
			end
		
		end
	
	end
	
end


function Meta:TankMultiTowerRotation()
	
	if( !self.IsDriving ) then return end
	
	if( type(self.Tower) == "vector" ) then error( "You are calling the wrong rotation function moron. Look in your init.") end
	for i=1,#self.Tower do
	
		if( !IsValid( self.Tower[i] ) ) then return end
		
		if ( self.IsDriving && IsValid( self.Pilot ) ) then
		-- if( GetConVarNumber( "jet_cockpitview" ) == 0 and self.Pilot:KeyDown( IN_WALK ) ) then return end -- brilliant, not.
		
			
			self:GetPhysicsObject():Wake()	
			
			local tr,trace ={},{}
			tr.start = self:GetPos() + self:GetUp() * 500
			tr.endpos = tr.start + self.Pilot:GetAimVector() * 36000 + self:GetRight() * ( math.sin(FrameTime()) * 2048 * i )
			tr.filter = { self, self.Pilot, self.Head }
			tr.mask = MASK_SOLID
			trace = util.TraceLine( tr )
			
			local a = trace.HitPos --self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
			local ta = ( self.Tower[i]:GetPos() - a ):Angle()
			local ma = self:GetAngles()

			local pilotAng = self.Pilot:EyeAngles()
			local _t = self.Tower[i]:GetAngles()
			local _b =self.Barrel[i]:GetAngles()

			
			

			local barrelpitch = math.Clamp( pilotAng.p, _t.p - 45, _t.p + 25 )

			self.offs = self:VecAngD( ma.y, ta.y )	
			self.TPoffs = self:VecAngD( pilotAng.y, _t.y )	
			-- self.TP2offs = self:VecAngD( pilotAng.p, _b.p )	
			
			
			
			-- self.Pilot:PrintMessage( HUD_PRINTCENTER,  tostring( math.ceil( self.TPoffs ) ) )
			if( TankRotationSound > 0 ) then
			
				if ( ( self.TPoffs < -10 || self.TPoffs > 10 ) ) then
					
					if( !self.Turning ) then
			
						self.TowerSound:PlayEx( 0.25, 70 )
						self.Turning = true
						
					end
					local p = self.TPoffs
					if( p < 0 ) then
						p = p * -1
					end
					
					self.TowerSound:ChangePitch(  100 + ( p / 100 ), 0.1 )
					
				else
					
					if( self.Turning ) then
						
						self.TowerSound:Stop()
						if self.TowerStopSound then
							self:EmitSound( self.TowerStopSound, 10, 10 )
						end
						self.Turning = false
						-- print("Not Turning")
						
					end
					
				end
					
			end
			
			local angg = self:GetAngles()
			angg:RotateAroundAxis( self:GetUp(), -self.offs + 180 )
			self.Tower[i]:SetAngles( LerpAngle( 0.0195, _t, angg ) )
			_t = self.Tower[i]:GetAngles()
			self.Barrel[i]:SetAngles( Angle( barrelpitch, _t.y, _t.r ) )
	
					
			if( self.HasMGun ) then
				
				if( IsValid( self.Copilot ) ) then
					
					pilotAng = self.Copilot:EyeAngles()
				
				end
				
				local _g = self.MGun:GetAngles()
				_g.p, _g.y, _g.r = apr( _g.p, pilotAng.p, 40.5 ),apr( _g.y, pilotAng.y, 40.5 ),apr( _g.r, _t.r, 40.5 )
				self.MGun:SetAngles( Angle( _g.p, self.Tower:GetAngles().y, self.Tower:GetAngles().r ) )
                self.MgunTower:SetAngles( Angle( self.Tower:GetAngles().p, _g.y, self.Tower:GetAngles().r ) )
		
			end
			
		end
		
	end
	
end
function Meta:GunnerTowerRotation()

end

function Meta:TankTowerRotation()
	

	
	if( !IsValid( self.Tower ) ) then return end
	if( IsValid( self.TowerProxy ) && self.TowerProxy.HealthVal <= 350 ) then return end
	if( !self.IsDriving ) then return end
	if( IsValid( self.ATGM ) ) then
		
		local targetang = self.Barrel:GetAngles()
		
		if( IsValid( self.MGun ) ) then
			
			targetang.p = self.MGun:GetAngles().p
		
		end
		
		self.ATGM:SetAngles( targetang )
			
	end
	
	if( !IsValid( self.Pilot ) ) then self.Pilot = NULL return end
	
	local tr, trace = {},{}
	trace.start = self.Barrel:GetPos() + self.Barrel:GetForward() * self.BarrelLength
	trace.endpos = self.Pilot:GetAimVector() * 2500000
	trace.filter = { self, self.Tower, self.Barrel, self.Pilot, self.TowerProxy, self:GetParent() }
	trace.mask = MASK_SOLID
	tr = util.TraceLine( trace )
	-- if( IsValid( tr.Entity ) && !tr.HitWorld ) then
		
		-- tr.HitPos = Vector( tr.HitPos.x, tr.HitPos.y, tr.Entity:GetPos().z )
		
	-- end
	
	local hpos = self.Pilot.ClientVector or tr.HitPos
	local dist = ( trace.start - hpos ):Length()
	-- print( self.Pilot.ClientVector )
	if ( TankWotStyle > 0 && dist > 200 && !self.OverrideImpactPointPrediction) then
		
		if( IsValid( self.Pilot )  ) then
			
			

			-- if( IsValid( tr.HitEntity ) ) then
				
				-- hpos = tr.HitEntity:GetPos() - tr.HitEntity:GetUp()*32
			
			-- end
			
			if( Developer >= 1 ) then
				
				local Col = Color( 255, 0, 0, 255 ) 
				if( IsValid( tr.Entity ) ) then Col = Color( 0, 255, 0, 255 ) end
				debugoverlay.Line( trace.start, hpos, 0.1, Col, true )
				debugoverlay.Text( tr.HitPos, math.floor( self:GetPos():Distance( tr.HitPos ) ), 0.1, Color( 255, 0, 0, 0 ) )
			
			end
			
			if( tr.Fraction < 0.000021 ) then return end

			
			
			local TargetPos = hpos
			local ta = ( self:GetPos() - TargetPos ):Angle()
			local ma = self:GetAngles()
			local offs = self:VecAngD( ma.y, ta.y )
			local TargetAngle = -offs + 180
			local towerang = self.Tower:GetAngles()
			local diff = self:VecAngD( towerang.y, ta.y )
			local angg = self:GetAngles()
			local maxpitch = self.MaxBarrelPitch or 45
			local minpitch = self.MinBarrelPitch or 7.5
			
			local theta =  math.Clamp( self:BallisticCalculation( hpos ), ma.p-maxpitch, ma.p+7.5 )
			-- print ( theta, self:BallisticCalculation( hpos ) )
			angg:RotateAroundAxis( self:GetUp(), TargetAngle )
			
			self.Barrel:SetNetworkedInt("BarrelTheta",theta )
			self.Tower:SetAngles( LerpAngle( 0.05101793095, towerang, angg ) )
			self.Barrel:SetAngles( LerpAngle( 0.019, self.Barrel:GetAngles(), Angle( theta, towerang.y, towerang.r ) ) )
			
			self:TankTowerTurnSound()
			if( self.Pilot.ClientVector ) then
					
				self.Pilot:SetEyeAngles( ( self.Pilot:GetShootPos() - self.Pilot.ClientVector ):Angle() )
				local cv = self.Pilot.ClientVector
				local mp = ( self:GetPos() - cv ):Angle()
				local diff = math.AngleDifference( mp.y, ma.y )
				local left = diff > 0 && diff < 178
				local right = diff > -178 && diff < 0
				-- print( self.Pilot.CockpitView ) 
				
				if ( self.MaxBarrelYaw || self.Pilot:IsBot() ) then
				
					if( right ) then
						
						self:TankDriveRight()
					
					elseif( left ) then
						
						self:TankDriveLeft()
					
					end
					-- print( diff > 0 && diff < 175 )
					
				end
				
			end
			

			
		end
		
		return
		
	end
	
	-- if( IsValid( self.Pilot ) && self.Pilot:IsBot() ) then return end
	
	-- if ( self.IsDriving && IsValid( self.Pilot ) ) then
		
		-- local tr, trace = {},{}
		-- tr.start = self.Pilot:GetShootPos()
		-- tr.endpos = self.Pilot:GetAimVector() * 25000
		-- tr.filter = { self, self.Tower, self.Barrel, self.Pilot, self.MGun }
		-- tr.mask = MASK_SOLID
		-- trace = util.TraceLine( tr )
		
		-- local p = trace.HitPos - Vector( 0,0,50 )
		-- local d = self:GetPos():Distance( p )
		-- local g = -600
		-- local v = 10000
		-- local angle = 57.2957795 * ( 0.5 * math.asin( ( g*d) / (v^2) ) )
		
		-- local a = p
		-- local ta = ( self:GetPos() - a ):Angle()
		-- local t = self.Tower:GetAngles()
		-- local ma = self:GetAngles()
		
		-- print( angle )
		-- ma:RotateAroundAxis( self:GetUp(), self:VecAngD( ta.y, ma.y ) + 180 )
		-- self.Tower:SetAngles( LerpAngle( 0.25, t, ma ) )
		-- t = self.Tower:GetAngles()
		-- self.Barrel:SetAngles( Angle( angle, t.y, t.r  ) )
		
		-- return true
	
	-- end
	
	
		
	if ( self.IsDriving && IsValid( self.Pilot ) ) then
		
		
		
		
	-- if( GetConVarNumber( "jet_cockpitview" ) == 0 and self.Pilot:KeyDown( IN_WALK ) ) then return end 	
		-- print( "hello?" )
		self:GetPhysicsObject():Wake()
		
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()

		local pilotAng = self.Pilot:EyeAngles()
		local _t = self.Tower:GetAngles()
		local _b = self.Barrel:GetAngles()
	
		local barrelpitch = math.Clamp( pilotAng.p, _t.p - 45, _t.p + 6 )

		self.offs = self:VecAngD( ma.y, ta.y )	
		self.TPoffs = self:VecAngD( pilotAng.y, _t.y )	
		-- self.TP2offs = self:VecAngD( pilotAng.p, _b.p )	
		
		self:TankTowerTurnSound()
		
		-- self.Pilot:PrintMessage( HUD_PRINTCENTER,  tostring( math.ceil( self.TPoffs ) ) )

		
		local angg = self:GetAngles()
		angg:RotateAroundAxis( self:GetUp(), -self.offs + 180 )
		self.TowerPhys:SetAngles( LerpAngle( 0.1095, _t, angg ) )
		-- self.TowerAxis:SetAngles( LerpAngle( 0.1095, _t, angg ) )
		self.Tower:SetAngles( LerpAngle( 0.051095, _t, angg ) )
		-- self.Tower:SetPos( self:LocalToWorld( self.TowerPos ) )
		-- self.Tower:SetLocalAngles( LerpAngle( 0.1095, _t, angg ) )
		-- print( -self.offs + 180, self.Tower:GetAngles().y )
		-- print( math.floor( -self.offs ), math.floor( ta.y ), math.floor( self.Tower:GetAngles().y ) )
		-- self.TowerPhys:AddAngleVelocity( Vector( 0, 0, -self.offs + ta.y ) )
		_t = self.Tower:GetAngles()
		-- self.Barrel:SetAngles( Angle( barrelpitch, _t.y, _t.r ) )
		self.Barrel:SetAngles( Angle( Lerp( 0.051, _b.p, barrelpitch), _t.y, _t.r ) )

				
		if( self.HasMGun ) then
			
			-- self.Copilot:PrintMessage( HUD_PRINTCENTER, "WHY ARE YOU NOT WORKING YOU PIECE OF SHIT" )
			if( IsValid( self.Copilot ) ) then
				
				-- print(" !!!" )
				-- self.Copilot
				pilotAng = self.Copilot:EyeAngles()
			
			end
			
			local _g = self.MGun:GetAngles()
			_g.p, _g.y, _g.r = apr( _g.p, pilotAng.p, 40.5 ),apr( _g.y, pilotAng.y, 40.5 ),apr( _g.r, _t.r, 40.5 )
			self.MGun:SetAngles( _g )
		
			-- pilotAng = self.Pilot:EyeAngles()
			
		end
		
	end

end
function Meta:TankTowerTurnSound()

	if( TankRotationSound > 0 && self.TPoffs != nil ) then
	
		if ( ( self.TPoffs < -2 || self.TPoffs > 2 ) ) then
			
			if( !self.Turning ) then
	
				self.TowerSound:PlayEx( self.TowerTurnVolume or 0.5, 70 )
				self.Turning = true
				
			end
			local p = self.TPoffs
			if( p < 0 ) then
				p = p * -1
			end
			
			self.TowerSound:ChangePitch(  100 + ( p / 100 ), 0.1 )
			
		else
			
			if( self.Turning ) then
				
				self.TowerSound:Stop()
				if self.TowerStopSound then
					self:EmitSound( self.TowerStopSound, 66, 100 )
				end
				self.Turning = false
				-- print("Not Turning")
				
			end
			
		end
			
	end
	
end

function math.ClampAngle( ang, mi, ma )
	
	
	local _min = ang - mi
	local _max = ang + ma
	
	if(  _min < 0 ) then
		
		ang = _min + 360
		
	end

	if( _max > 360 ) then
		
		ang = _max - 360
		
	end
	
	return ang
	
end
--[[
function Meta:TankScudTowerRotation()
	
	if ( self.IsDriving && IsValid( self.Pilot ) ) then
		
<<<<<<< .mine
		local LerpSpeed = 0.01
=======
		local LerpSpeed = 0.09755
>>>>>>> .r946
		local myang = self:GetAngles()
		local scudang = self.Barrel:GetAngles()
		
			
		if( self.SCUDTransportMode ) then
		
			myang:RotateAroundAxis( self:GetRight(), myang.p+90 )
		
		end
		
		self.SCUDAngle = math.abs(scudang.p-self:GetAngles().p)
		self.SCUDRampAngle = math.abs(self.SCUDRamp:GetAngles().p-self:GetAngles().p)
		-- print( self.SCUDRampAngle < 2, self.SCUDAngle > 2 )
		-- if( self.SCUDRampAngle < 1 && self.SCUDAngle > 1 ) then self.SCUDRamp:SetParent( self ) end
		-- if( self.SCUDRampAngle > 1 ) then self.SCUDRamp:SetParent( self.Barrel ) end
		if( self.SCUDAngle > 88 && self.SCUDTransportMode ) then
			
			self.SCUDRamp:SetAngles( LerpAngle( LerpSpeed, self.SCUDRamp:GetAngles(), self:GetAngles() ) )
		
		else
			
			-- if( self.LastSCUDFire && self.LastSCUDFire + 0.5 >= CurTime() ) then return end
			-- if( self.SCUDAngle - self.SCUDRampAngle > 1 ) then return end
			
			self.SCUDRamp:SetAngles( LerpAngle( LerpSpeed, self.SCUDRamp:GetAngles(), myang ) )
			
		end
		
		
		-- print( self.SCUDAngle )
		if( self.SCUDAngle > 88 ) then
			
			self.SCUDRamp:SetBodygroup(0,1)
			
		else
			
			self.SCUDRamp:SetBodygroup(0,0)
		
		end
		
		if( scudang.p > myang.p && scudang.p <= myang.p+89 ) then
			
			self.TPoffs = 7
			self:TankTowerTurnSound()

		else
			
			self.TPoffs = 0
			self:TankTowerTurnSound()
		
		end
		-- print( math.abs( self.SCUDRamp:GetAngles().p - self.Barrel:GetAngles().p ) )
		-- if( math.abs( self.SCUDRamp:GetAngles().p - self.Barrel:GetAngles().p ) < 90 || ( self.LastSCUDFire && self.LastSCUDFire + 10 >= CurTime() ) ) then
			
			-- print( ( self.LastSCUDFire && self.LastSCUDFire + 10 = CurTime() ) )
			-- if( self.LastSCUDFire && self.LastSCUDFire + 0.2 >= CurTime() ) then return end
			-- print( math.abs( self.SCUDAngle - self.SCUDRampAngle ) )
			
			-- if( math.abs(self.SCUDRampAngle - self.SCUDAngle) < 1 ) then
				
				-- print( "walla?")
				-- print( myang.p+90 )
				-- if( self.SCUDRampAngle - self.Barrel:GetAngles().p < ) then return end
				print( self.SCUDRampAngle, self.SCUDAngle,math.abs( self.SCUDRampAngle - self.SCUDAngle )  )
				local ang = math.abs( self.SCUDRampAngle - self.SCUDAngle )
			
				-- if( ang < 88 || ( ang > 1 && self.LastSCUDFire && self.LastSCUDFire + 10 >= CurTime() ) ) then 
				
					self.Barrel:SetAngles( LerpAngle( LerpSpeed, scudang, myang )  )
			
				-- end
			
		-- end
		
	end
	
end
]]--

function Meta:TankScudTowerRotation()

    if ( self.IsDriving && IsValid( self.Pilot ) ) then

        local LerpSpeed = 0.01
        local myang = self:GetAngles()
        local scudang = self.Barrel:GetAngles()


        if( self.SCUDTransportMode ) then

            myang:RotateAroundAxis( self:GetRight(), myang.p+90 )

        end

        self.SCUDAngle = math.abs(scudang.p-self:GetAngles().p)
        -- print( self.SCUDAngle )
        if( self.SCUDAngle > 87 && self.SCUDTransportMode ) then

            self.SCUDRamp:SetAngles( LerpAngle( LerpSpeed, self.SCUDRamp:GetAngles(), self:GetAngles() ) )

        else

            self.SCUDRamp:SetAngles( LerpAngle( LerpSpeed, self.SCUDRamp:GetAngles(), self.Barrel:GetAngles() ) )

        end


        -- print( self.SCUDAngle )
        if( self.SCUDAngle > 88 ) then

            self.SCUDRamp:SetBodygroup(0,1)

        else

            self.SCUDRamp:SetBodygroup(0,0)

        end

        if( scudang.p > myang.p && scudang.p <= myang.p+89 ) then

            self.TPoffs = 7
            -- self.Turning = false
            self:TankTowerTurnSound()
            -- self:SetNetworkedInt("BarrelTheta",90)

        else

            self.TPoffs = 0
            -- self.Turning = true
            self:TankTowerTurnSound()

        end
        -- print( math.abs( self.SCUDRamp:GetAngles().p - self.Barrel:GetAngles().p ) )
        if( math.abs( self.SCUDRamp:GetAngles().p - self.Barrel:GetAngles().p ) < 6 || ( self.LastSCUDFire && self.LastSCUDFire + 2 >= CurTime() ) ) then

            self.Barrel:SetAngles( LerpAngle( LerpSpeed, scudang, myang )  )

        end

    end

end

function Meta:TankNoTowerRotation()

	if ( self.IsDriving && IsValid( self.Pilot ) ) then

		if ( TankWotStyle > 0 ) then
						
			local tr, trace = {},{}
			trace.start = self.Barrel:GetPos() + self.Barrel:GetForward() * self.BarrelLength
			trace.endpos = self.Pilot:GetAimVector() * 2500000
			trace.filter = { self, self.Tower, self.Barrel, self.Pilot, self.TowerProxy, self:GetParent() }
			tr = util.TraceLine( trace )
			local hpos = self.Pilot.ClientVector or tr.HitPos + tr.HitNormal * 1
			-- local dist = ( trace.start - hpos ):Length()
				-- print("Whut")
			
				if( Developer >= 1 ) then
					
					local Col = Color( 255, 0, 0, 255 ) 
					if( IsValid( tr.Entity ) ) then Col = Color( 0, 255, 0, 255 ) end
					debugoverlay.Line( trace.start, hpos, 0.1, Col, true )
					debugoverlay.Text( tr.HitPos, math.floor( self:GetPos():Distance( tr.HitPos ) ), 0.1, Color( 255, 0, 0, 0 ) )
				
				end
				
				if( tr.Fraction < 0.00001 ) then return end

				-- local theta = self:BallisticCalculation( hpos )
		
				local TargetPos = hpos -- self.Pilot.ClientVector or tr.HitPos
				local ta = ( self:GetPos() - TargetPos ):Angle()
				local ma = self:GetAngles()
				local offs = self:VecAngD( ma.y, ta.y )
				local TargetAngle = -offs + 180
				local towerang = self.Tower:GetAngles()
				local diff = self:VecAngD( towerang.y, ta.y )
				local angg = self:GetAngles()
				local maxpitch = self.MaxBarrelPitch or 45
				local bcalc = self:BallisticCalculation( hpos )
				local theta =  math.Clamp( bcalc, ma.p-maxpitch, ma.p+8 )
				-- print( theta, bcalc )
				angg:RotateAroundAxis( self:GetUp(), TargetAngle )
				
				local pilotAng = self.Pilot:EyeAngles()
				local _t = self.Tower:GetAngles()
				self.PilotAimOffset = math.AngleDifference( self:GetAngles().y, ta.y ) 
				
				if( self.MaxBarrelYaw ) then
				
					if( self.PilotAimOffset >= 180-self.MaxBarrelYaw || self.PilotAimOffset <= -180+self.MaxBarrelYaw ) then
				
						self.Tower:SetAngles( LerpAngle( 0.01193095, towerang, angg ) )
				
					end
					
				else
					
					self.Tower:SetAngles( LerpAngle( 0.01193095, towerang, angg ) )

				
				end
				-- if( 
				
				self.Barrel:SetAngles( LerpAngle( 0.01, self.Barrel:GetAngles(), Angle( theta, towerang.y, towerang.r ) ) )
				
				self:TankTowerTurnSound()
			
				if( self.Pilot.ClientVector && self.MaxBarrelYaw ) then
					
					self.Pilot:SetEyeAngles( ( self.Pilot:GetShootPos() - self.Pilot.ClientVector ):Angle() )
					local cv = self.Pilot.ClientVector
					local mp = ( self:GetPos() - cv ):Angle()
					local diff = math.AngleDifference( mp.y, ma.y )
					local left = diff > 0 && diff < 178
					local right = diff > -178 && diff < 0
					-- print( self.Pilot.CockpitView ) 
					if( right ) then
						
						self:TankDriveRight()
					
					elseif( left ) then
						
						self:TankDriveLeft()
					
					end
					-- print( diff > 0 && diff < 175 )
				
				end
		
			return
			
		end
		
		self:GetPhysicsObject():Wake()
		
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma1,ma2 = self:GetAngles(),self:GetAngles()
		local ba = self.Barrel:GetAngles()
		
		-- ma1:RotateAroundAxis( self:GetUp(), self.MaxBarrelYaw )
		-- ma2:RotateAroundAxis( self:GetUp(), -self.MaxBarrelYaw )
		
	
		local pilotAng = self.Pilot:EyeAngles()
		local _t = self.Tower:GetAngles()
		self.PilotAimOffset = math.AngleDifference( ma1.y, ta.y ) 
		-- print( adiff )
		if( self.PilotAimOffset >= 180-self.MaxBarrelYaw || self.PilotAimOffset <= -176+self.MaxBarrelYaw ) then
			
			_t.y = pilotAng.y
			
		end
		-- _t:RotateAroundAxis( self:GetUp(), math.Clamp( ta.y, cmin, cmax ) )
		
		-- self.Barrel:SetAngles( _t )
		
		if( self.HasMGun ) then
		
			local _g = self.MGun:GetAngles()
			_g.p, _g.y, _g.r = apr( _g.p, pilotAng.p, 40.5 ),apr( _g.y, pilotAng.y, 40.5 ),apr( _g.r, _t.r, 40.5 )
			self.MGun:SetAngles( _g )
			
			if( IsValid( self.MgunTower ) ) then
			
				self.MgunTower:SetAngles( _g )
			
			end
			
		end
		
		local maxpitch = self.MaxBarrelPitch or 15
		local barrelpitch = math.Clamp( pilotAng.p, _t.p - maxpitch, _t.p + 6 )
		local angg = Angle( _t.p, _t.y, _t.r )
	
		self.Tower:SetAngles( LerpAngle( 0.0395, _t, angg ) )

		_t = self.Tower:GetAngles()
		
		self.Barrel:SetAngles( Angle( Lerp( 0.051, ba.p, barrelpitch), _t.y, _t.r ) )
		
		
	end

end

function Meta:TankReloadAL()
	
	if( self.Reloading ) then return end
	
	self.Reloading = true
	
	if( self.Shots < 0 ) then self.Shots = 1 end
	
	local _max = self.MagazineSize - self.Shots
	
	self.Pilot:SendLua( "RotateHud( "..( self.PrimaryDelay / 2 * _max + 2 ).." ) " )

	for i=1,_max do                    
		
		-- check if we have any visual payload to re-render.
		if( self.VisualShells && self.ShellProxies ) then
			--
			timer.Simple( self.PrimaryDelay / 2 * i, 
			function()
				
				if( !IsValid( self ) ) then return end
				
				local prop = self.ShellProxies[i]
				if( IsValid( prop ) ) then
					
					prop:SetColor( Color( 255,255,255,255 ) )
					
					local fx = EffectData()
					fx:SetEntity( prop )
					util.Effect("propspawn", fx ) 
					
				end
				
			end )
	
		end
		
		timer.Simple( self.PrimaryDelay / 2 * i, function() 
			if( !self ) then return end 
			if( !self.Shots ) then return end
			if( !self.MagazineSize ) then return end
			
			self.Shots = math.Approach( self.Shots, self.MagazineSize, 1 )
			self:SetNetworkedInt("AutoLoaderShots", self.Shots )
            if( self.ReloadSound1!= nil &&  self.ReloadSound1 != "" )  then
			
				self:EmitSound( self.ReloadSound1, 70, 100 )
			
			end
			--
				
            -- self.Pilot:PrintMessage( HUD_PRINTTALK, "RELOADING:" .. i )
            -- self.Pilot:PrintMessage( HUD_PRINTTALK, "Shots:" .. self.Shots )
            -- self.Pilot:PrintMessage( HUD_PRINTTALK, "MagazineSize:" .. self.MagazineSize )   
            if self.Shots == self.MagazineSize then
			
                timer.Simple( 2, 
				function() 
					if( IsValid( self ) ) then 
						
						if( self.ReloadSound2 ) then
						
							self:EmitSound( self.ReloadSound2, 70, 100 ) 
							
						end
						
						self.Reloading = false
						self.BulletDelay = 0
						
					end
					
				end )
				
			end                 
			
		end )
	
	end  
    
	self.BulletDelay = CurTime() + ( self.PrimaryDelay / 1.5 * self.MagazineSize - self.Shots )

	if( IsValid( self.Pilot ) && self ) then
		
		self.Pilot:PrintMessage( HUD_PRINTTALK, self.PrintName..": Filling up Auto Loader. Please stand by." )    
		
	end
	
end

--- HK 250D Tank hardcoded shit
function Meta:TankMultiTowerAttack()

	if ( !self ) then // silly timer errors.
		
		return
		
	end
		
	if  ( self.BulletDelay < CurTime() ) then	

		self.BulletDelay = CurTime() + self.PrimaryDelay

		self:EmitSound( self.ShootSound, 100, math.random( 70, 100 ) )	
		

		local bpos = { Vector( 105, 17, 2 ), Vector( 105, -17, 2 ) }
		
		for i=1,#self.BarrelPos do
			
			for j=1,#bpos do
				
				local tr,trace = {},{}
				tr.start = self.Barrel[i]:LocalToWorld( bpos[j] )
				tr.endpos = tr.start + self.Barrel[i]:GetForward() * 36000
				tr.filter = { self, self.Pilot, self.Head }
				tr.mask = MASK_SOLID
				trace = util.TraceLine( tr )
				
				local fx = EffectData()
				fx:SetStart( tr.start )
				fx:SetOrigin( trace.HitPos )
				util.Effect("hklaser",fx )
				fx:SetNormal( trace.HitNormal )
				fx:SetStart( trace.HitPos )
				fx:SetScale( 20 )
				fx:SetMagnitude( 20 )
				util.Effect("Firecloud",fx )
				-- util.Effect("launch2",fx )
				if( trace.Hit && IsValid( trace.Entity ) ) then
					
					if( trace.Entity.HealthVal ) then
						
						trace.Entity.HealthVal = trace.Entity.HealthVal - math.random( 55, 98 ) -- hackfix to avoid tanks low damage immunity
						-- trace.Entity:SetNetworkedInt("health",trace.Entity.HealthVal )
					
						
					end
					
					trace.Entity:Ignite( 0.85, 256 )
					
				else
					
					self.Pilot:Neuro_DealDamage( DMG_DISSOLVE, math.random( 50, 95 ), trace.HitPos, 128, false, "" )		
					--util.BlastDamage( self, self.Pilot, trace.HitPos, 128, math.random( 15, 28 ) )
					
				
				end
				
			end
			
		end
		
	end
	
	//self:StopSound( self.ShootSound )
    
end

function Meta:ReloadRocketFrame( RType )
	
	local typ = RType or self.RocketAmmo
	-- print( "loading" )
	if( self.RocketFrames ) then
		
		for i=1,#self.RocketFrames do
			
			-- if( IsValid( self.RocketObjects[i] ) ) then
				
				-- self.RocketObjects[i]:Remove()
				
			-- end
			
			self.RocketObjects[i] = ents.Create( typ )
			self.RocketObjects[i]:SetPos( self:LocalToWorld( self.RocketPos[i] ) )
			self.RocketObjects[i]:SetOwner( self.RocketFrames[i] )
			self.RocketObjects[i]:SetAngles( self.RocketFrames[i]:GetAngles() )
			self.RocketObjects[i]:Spawn()
			-- self.RocketObjects[i]:PhysicsDestroy()
			self.RocketObjects[i].Owner = self
			self.RocketObjects[i]:SetParent( self.RocketFrames[i] )
			-- constraint.Weld( self.RocketObjects[i], self.RocketFrames[i],0,0, 0, true, true )
		
		end
		
	end
	-- print( "ready")
	-- self.BulletDelay = 0
	-- self.ShellDelay = 0
	-- self.LastRocketLaunch = 0
	-- self.LastPrimaryAttack = 0
	
end

function Meta:FireRocketFrame( info )
	
	if( info && self.RocketObjects ) then
			
		-- if( self.LastRocketLaunch && self.LastRocketLaunch + self.RocketDelay <= CurTime() ) then
		
			-- print("trying")
			-- self.LastRocketLaunch = CurTime()
			-- self.BulletDelay = CurTime()
			-- self.ShellDelay = CurTime()
			
			timer.Simple( self.RocketDelay, function() if( IsValid( self ) ) then self:ReloadRocketFrame() end end )
					
			for i=1, #self.RocketObjects do
		
					timer.Simple( i-1, function()
						
					if( IsValid( self ) ) then
							
						if( IsValid( self.RocketObjects[i] ) ) then
											
							self.RocketObjects[i]:SetParent( NULL )
							self.RocketObjects[i]:SetOwner( self )
							self.RocketObjects[i]:SetPos( self:LocalToWorld( self.RocketPos[i] ) + self.RocketObjects[i]:GetForward() * 1 )
							self.RocketObjects[i]:SetAngles( self.RocketFrames[i]:GetAngles() )
							self.RocketObjects[i]:ActivateRocket()
						
						end
						
					end
					
				 end )
				
			
			end
		
		
		end
		
	-- end
	
end

function Meta:TankPrimaryBulletAttack( num, particle, tracer, sound, tracerounds )
	self.BulletDelay = CurTime() + self.PrimaryDelay
	
	if( self.BarrelPorts ) then
		
		-- if( self.BulletDelay > CurTime() ) then return end 
		
		
		local num = #self.BarrelPorts
		for i=1,num do
			
			local bullet = {} 
			bullet.Num 		= bulletcount
			bullet.Src = self.Barrel:LocalToWorld( self.BarrelPorts[i] )
			bullet.Dir = self.Barrel:GetAngles():Forward()
			bullet.Filter = { self, self.Tower, self.Barrel, self.Pilot, self:GetParent() }
			bullet.Attacker = self.Pilot
			bullet.Spread 	= self.BulletSpread or Angle( .051, .051, .051 )
			bullet.Tracer	= tracerounds
			bullet.Force	= 5
			bullet.Damage	= math.random( self.MinDamage, self.MaxDamage ) / num
			bullet.AmmoType = "Ar2"
			bullet.TracerName 	= tracer
			bullet.Callback    = function ( a, b, c ) self:TankBulletHoseGunCallback( a, b, c ) end 

			self.Barrel:FireBullets( bullet )
			ParticleEffect(  particle, self.Barrel:LocalToWorld( self.BarrelPorts[i] ), self.Barrel:GetAngles(), self.Barrel )
			self:EmitSound(sound, 100, math.random( 70, 100 ) )
			
		end
		
		
	else
	
		local bullet = {} 
		bullet.Num 		= bulletcount
		bullet.Src = self.Barrel:GetPos() + self.Barrel:GetForward() * self.BarrelLength
		bullet.Dir = self.Barrel:GetAngles():Forward()
		bullet.Filter = { self, self.Tower, self.Barrel, self.Pilot, self:GetParent() }
		bullet.Attacker = self.Pilot
		bullet.Spread 	= self.BulletSpread or Angle( .051, .051, .051 )
		bullet.Tracer	= tracerounds
		bullet.Force	= 5
		bullet.Damage	= math.random( self.MinDamage, self.MaxDamage )
		bullet.AmmoType = "Ar2"
		bullet.TracerName 	= tracer
		bullet.Callback    = function ( a, b, c ) self:TankBulletHoseGunCallback( a, b, c ) end 

		self.Barrel:FireBullets( bullet )
		ParticleEffect(  particle, self.Barrel:GetPos() + self.Barrel:GetForward() * self.BarrelLength, self.Barrel:GetAngles(), self.Barrel )
		self:EmitSound(sound, 100, math.random( 70, 100 ) )

	end

end


function Meta:TankPrimaryAttack()
	
	-- if( !SinglePlayer() ) then
		
		-- local filter = RecipientFilter();
		-- filter:AddPlayer( self.Pilot )
		
		-- umsg.Start( "NeuroTanks_SendRecoil", filter );
			-- umsg.Bool( true )
		-- umsg.End()
		 
	-- end
	-- print("got this far")
	if( self.AmmoTypes && self.AmmoIndex && self.AmmoTypes[self.AmmoIndex] ) then
		-- print( "ok" )

		if( self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount && self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount > 0 ) then
			
			self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount = self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount - 1
			self:SetNetworkedInt("NeuroTanks_ammoCount", self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount or 0 )
			
		else
			
			-- print( "No ammo for this thing" )
			-- print( "Something went wrong!" )
			return false
			
		end
		if( self.AmmoTypes[self.AmmoIndex].BulletHose == true ) then
			
			local we = self.AmmoTypes[self.AmmoIndex]
			local count = we.BulletCount or 1
			local tracer = we.Tracer or "tracer"
			local sound = we.Sound or Sound("bf2/weapons/coaxial browning_fire.mp3")
			local particle = we.Muzzle or "AA_muzzle"
			local tracerounds = we.TraceRounds or 0
			self:TankPrimaryBulletAttack(count, particle, tracer, sound, tracerounds )
			
			return
			
		end
		
	end
	
	if( type( self.Barrel ) == "table" ) then
		
		self:TankMultiTowerAttack()
		
		return
	
	end
	
	if ( !self ) then // silly timer errors.
		
		return
		
	end
		
	local AmmoType = self.AmmoTypes[self.AmmoIndex].Type or self.PrimaryAmmo
	if( self.AmmoTypes[self.AmmoIndex].RocketFrame ) then
		
		self.BulletDelay = CurTime() + self.RocketDelay
		
		self:FireRocketFrame( self.AmmoTypes[self.AmmoIndex] )
		-- print("Walla habeeb")
		return
		
	end
	
		if( self.IsAutoLoader ) then
				
			self.Shots = self.Shots - 1
			self:SetNetworkedInt("AutoLoaderShots", self.Shots )
			if( self.Shots > 0 ) then
			
				self.Pilot:SendLua( "RotateHud( "..( 1 / self.RoundsPerSecond ).." ) " )
				
			end
			
			if( self.Shots < 1 && self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount > 0 ) then
				
				self:TankReloadAL()
				self.BulletDelay = CurTime() + ( self.PrimaryDelay * self.MagazineSize + 1 )
				-- if( IsValid( self.Pilot ) ) then
						
					-- self.Pilot:SendLua( "RotateHud( "..self.BulletDelay.." ) " )
					
						
				-- end
			
			else
				
				self.BulletDelay = CurTime() + ( 1 / self.RoundsPerSecond )
			
			end
			
		else
		
			self.BulletDelay = CurTime() + self.PrimaryDelay
		
		end
		
		-- if( JetCockpitView > 0 ) and (self.CockpitShootSound) then
		
			-- self:EmitSound( self.CockpitShootSound, 100, math.random( 70, 100 ) )
			
		-- else
		
			self:EmitSound( self.ShootSound, 511, math.random( 70, 100 ) )	
            self:PlayWorldSound( self.AmmoTypes[self.AmmoIndex].Sound )	
			
		-- end
		
		if ( !self.IsAutoLoader && self.PrimaryDelay > 0.5 ) then
			
			if( IsValid( self.Pilot ) ) then
						
				self.Pilot:SendLua( "RotateHud( "..self.PrimaryDelay.." ) " )
						
			end
					
			timer.Simple( self.PrimaryDelay/4, 
			function()
				if( IsValid( self ) ) then
				
					self:EmitSound( self.ReloadSound, 70, 100 )
					
				end
				
			end )
			
		end
		
		if( self.RecoilForce ) then
        
			
			-- self:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * -self.RecoilForce )
			local parent = self:GetParent()
			
			if( IsValid( parent ) ) then
				
				if( IsValid( parent:GetPhysicsObject() ) ) then
					
					parent:GetPhysicsObject():ApplyForceCenter( self.Tower:GetForward() * -self.RecoilForce )
				
				end
			
			else
			
				self:GetPhysicsObject():ApplyForceCenter( self.Tower:GetForward() * -self.RecoilForce )
			
			end
			
		else
		
			self:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * -1000000 )
		
		end
		
		
		local SpeedValue =  math.floor( self:GetVelocity():Length() / 50 ) 
		if( !self.BarrelLength ) then self.BarrelLength = 128 end
				
		local fxpos = self.Barrel:GetPos() + self.Barrel:GetForward() * self.BarrelLength
		
		if( self.BarrelPorts ) then
			
			self.BarrelPortIndex = self.BarrelPortIndex + 1
			if( self.BarrelPortIndex > #self.BarrelPorts ) then
				
				self.BarrelPortIndex = 1
				
			end
			
			fxpos = self.Barrel:LocalToWorld( self.BarrelPorts[self.BarrelPortIndex] )
			
			if( self.AmmoTypes[self.AmmoIndex].LaunchPorts ) then
				
				if( self.BarrelPortIndex > #self.AmmoTypes[self.AmmoIndex].LaunchPorts ) then
					
					self.BarrelPortIndex = 1
				
				end
				
				if( self.AmmoTypes[self.AmmoIndex].LaunchPorts[self.BarrelPortIndex] ) then
				
					
					fxpos = self.Barrel:LocalToWorld( self.AmmoTypes[self.AmmoIndex].LaunchPorts[self.BarrelPortIndex] )
				
				end
			
			end
			
			-- got visual payload, make it look like we're launching them.
			if( self.ShellProxies && self.VisualShells ) then
				
				local proxy = self.ShellProxies[ self.BarrelPortIndex ] 
				
				if( IsValid( proxy ) ) then
					
					fxpos = proxy:GetPos()
					proxy:SetRenderMode( RENDERMODE_TRANSALPHA )
					proxy:SetColor( Color( 0,0,0,0 ) )
			
				end
				
			end
			
		end
		timer.Simple(0,function()
		local Shell = ents.Create( AmmoType )
		Shell:SetPos( fxpos ) 				
		Shell:SetAngles( self.Barrel:GetAngles() + Angle( math.Rand( -.1,.1 ), math.Rand( -.1,.1 ), math.Rand( -.1,.1 ) ) )
		Shell.Owner = self.Pilot
		Shell:SetOwner( self.Pilot )
		Shell:SetPhysicsAttacker( self )
		Shell.Creditor = self      
        Shell.TankType = self.TankType
		
		-- if( self.IsScudLauncher ) then
		
		self.Pilot:SetNetworkedEntity("ArtilleryShell", Shell )
		
		-- end
		
		if( self.IsScudLauncher ) then
			
			self.SCUDTransportMode = false
			self.LastSCUDFire = CurTime() 
			
		end
		
		if( self.AmmoTypes[self.AmmoIndex].SmokeColor ) then
		
			Shell:SetNetworkedInt("SmokeColor",self.AmmoTypes[self.AmmoIndex].SmokeColor )
			
		end
		
		if( self.InaccuracyPunishment ) then
			
			Shell:SetAngles( Shell:GetAngles() + ( self.InaccuracyPunishment*math.Rand(-1,1) ) )
			
		end

		
		if( self.AmmoTypes[self.AmmoIndex].CustomParticleEffect ) then
				 
			Shell.CustomParticleEffect = self.AmmoTypes[self.AmmoIndex].CustomParticleEffect 
			Shell.DoCustomExplosion = true
			
		end
		
		if( self.AmmoTypes[self.AmmoIndex].Boosted ) then
				 
			Shell.Boosted = true
			
		end
		
		
		
		if( self.AmmoTypes[self.AmmoIndex].TargetHeight ) then
				 
			Shell.TargetHeight = self.AmmoTypes[self.AmmoIndex].TargetHeight
			
		end
			
	
		if( self.AmmoTypes[self.AmmoIndex].ShouldCluster ) then
				 
			Shell.ShouldCluster = self.AmmoTypes[self.AmmoIndex].ShouldCluster
			Shell.NumCluster = self.AmmoTypes[self.AmmoIndex].NumCluster
			Shell.ClusterType = self.AmmoTypes[self.AmmoIndex].ClusterType
			
		end
	

		
		
		if( self.AmmoTypes[self.AmmoIndex].ImpactDiveDistance ) then
				 
			Shell.ImpactDiveDistance = self.AmmoTypes[self.AmmoIndex].ImpactDiveDistance
			
		end
		
		if( self.AmmoTypes[self.AmmoIndex].ExhaustPosDistance ) then
				 
			Shell.ExhaustPosDistance = self.AmmoTypes[self.AmmoIndex].ExhaustPosDistance
			
		end
		
		if( self.MinDamage && self.MaxDamage ) then
			
			Shell.MinDamage = self.AmmoTypes[self.AmmoIndex].MinDmg or self.MinDamage
			Shell.MaxDamage = self.AmmoTypes[self.AmmoIndex].MaxDmg or self.MaxDamage
			Shell.Radius = self.AmmoTypes[self.AmmoIndex].Radius or self.BlastRadius
		
		end
		-- print( Shell.MinDamage, Shell.MaxDamage, Shell.Radius )
		
		Shell:Spawn()
		Shell:Activate()
				
		if( self.AmmoTypes[self.AmmoIndex].IsHoming ) then
			
			if( IsValid( self.Target ) ) then
				
				Shell.Target = self.Target
				self.Target = NULL
				
			else
			
				for i=1,30 do
					
					local tr,trace = {},{}
					tr.start = self.Barrel:GetPos() + self.Barrel:GetForward() * self.BarrelLength
					tr.endpos = tr.start + self.Pilot:GetAimVector() * 36000 + VectorRand() * 512
					tr.filter = { self, self.Tower, self.Barrel, self.TowerProxy, self.Pilot, self:GetParent() }
					tr.mask = MASK_SOLID
					trace = util.TraceLine( tr ) 
					
					if(  self.AmmoTypes[self.AmmoIndex].UseTargetVector ) then
						
						local pos = self.Pilot.ClientVector
						
						if( !pos && trace.Hit && !trace.HitSky ) then
							
							pos = trace.HitPos
							-- print("hit?")
						end
						
						if( pos ) then
							
							Shell.TargetPos = pos
							Shell.TargetDistance = ( Shell:GetPos() - pos ):Length()
							
						end
						-- print( Shell, pos, Shell.TagetPos )
						
					end
					
					if( trace.Hit && IsValid( trace.Entity ) && !trace.HitWorld && self:GetPos().z + 150 <= trace.Entity:GetPos().z ) then
							
						-- print( trace.Fraction ) 
						-- print( trace.Entity )
					
						Shell.Target = trace.Entity
						
					end
				
				end
				
			end
			
		end
		
		-- Shell:SetModel( "models/items/AR2_Grenade.mdl" )
		if( self.AmmoTypes[self.AmmoIndex].Model ) then
			
			Shell:SetModel( self.AmmoTypes[self.AmmoIndex].Model )
			
		end
		
		Shell:GetPhysicsObject():Wake()
		Shell:GetPhysicsObject():SetMass( 1000 )
		Shell:GetPhysicsObject():EnableDrag( false )
		Shell:GetPhysicsObject():EnableGravity( true )
		Shell:GetPhysicsObject():SetVelocityInstantaneous( Shell:GetForward() * TANK_aMMO_SPEEDS[ self.AmmoTypes[ self.AmmoIndex ].Type ] )
		-- Shell:GetPhysicsObject():SetVelocityInstantaneous( Shell:GetForward() * TANK_aMMO_SPEEDS[ self.AmmoTypes[ self.AmmoIndex ].Type ] )
		Shell:GetPhysicsObject():SetDamping( 0,0 )
		Shell:GetPhysicsObject():SetDragCoefficient( 0 )
		
		if( AmmoType == "sent_tank_300mm_rocket" ) then
			
			Shell:ActivateRocket()
			
		end
		-- special rules for this since we fire at a high arc.
		-- if( self.TankType == TANK_TYPE_ARTILLERY ) then 
			-- print( Shell:GetAngles().p )
			-- Shell:GetPhysicsObject():SetVelocityInstantaneous( Shell:GetForward() * AMMO_VELOCITY_aRTILLERY_SHELL )
			-- Shell:GetPhysicsObject():EnableDrag( false )
			
		-- else
		
		
		-- Shell:GetPhysicsObject():SetInertia( Shell:GetForward() * TANK_aMMO_SPEEDS[ self.AmmoTypes[ self.AmmoIndex ].Type ] )

		-- end
		
		local Forcevalue = -0.25 * self.TankType
		-- if( self.TankRecoilAngleForce ) then
			
		if( self.NoRecoil ) then Forcevalue = 0 end
		
			-- Forcevalue = self.TankRecoilAngleForce
			
		-- end
		
		--local normal = self.Barrel:GetForward() * Forcevalue
		local normal = ( Shell:GetPos() - self.Tower:GetPos()):GetNormal() * Forcevalue

		self:GetPhysicsObject():AddAngleVelocity( self.Tower:GetForward() * -Forcevalue )-- normal ) --Vector( normal.x, 0, normal.z ) )
		
	
		constraint.NoCollide( Shell, self, 0, 0)	
		constraint.NoCollide( Shell, self.Barrel, 0, 0)	
		end)
		local _vfx = "tank_muzzleflash"
	
		if( self.CustomMuzzle ) then
		
			_vfx =  self.CustomMuzzle
		
		else
		
			if( self.TankType > 2 ) then
			
				_vfx = "tank_muzzleflash"
			
			else
				
				if( string.find(AmmoType, "flak" ) ) then
				
					_vfx = "AA_muzzleflash"
				
				else
				
					_vfx = "apc_muzzleflash"
				
				end
				
			end
		
		end
		
		-- local particle = ents.Create("info_particle_system")         
		-- particle:SetKeyValue("start_active","1")       
		-- particle:SetKeyValue("effect_name", _vfx )
		-- particle:Spawn()     
		-- particle:Activate()     
		-- particle:SetPos(Shell:GetPos())
		-- particle:SetParent( self.Barrel )
		-- particle:SetAngles( self.Barrel:GetAngles() )
		-- particle:Fire("kill","",0.5)
		-- ParticleEffectAttach( _vfx, PATTAch_aBSORIGIN, Shell, 0 )
		
		ParticleEffect(  _vfx, fxpos, self.Barrel:GetAngles(), self.Barrel )

		
		if( self.IsOnGround && TankDustEffects > 0 && !self.NoDust ) then
			
			-- print( self.PrimaryDelay, "delay" )
			
			local dustwaves,dustradius
			if (self.PrimaryDelay >=1) then	dustwaves=10 elseif (self.PrimaryDelay >=4) then dustwaves=50 else dustwaves=1 end
			if (self.PrimaryDelay >=4) then dustradius=100 else dustradius=0 end
			if( self.PrimaryDelay < 1 ) then dustwaves = 1 dustradius = 0 end 
			
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

	//self:StopSound( self.ShootSound )
    if ( self.IsAutoLoader ) then
        
		if( self.ReloadSound1 ) then
			
			self:StopSound( self.ReloadSound1 )
			
		end
		
		if( self.ReloadSound2 ) then
		
			self:StopSound( self.ReloadSound2 )
		
		end
		
    else
        self:StopSound( self.ReloadSound )
    end
    
end
		
function Meta:TankToggleHeadLights()

	self.HeadLightsLast = CurTime() + 0.5
	self.HeadLightsToggle = !self.HeadLightsToggle
	self:SetNetworkedBool("Tank_Headlights", self.HeadLightsToggle )
	
	if( self.HeadLightsToggle ) then
		
		for i=1,#self.HeadLights.Lamps do
			
			if( IsValid( self.HeadLights.Lamps[i] ) ) then
			
				self.HeadLights.Lamps[i]:Fire("TurnOn","",0)
			
			end
			
		end
		
		self:CreateHeadlightSprites()
		
	else
		
		for i=1,#self.HeadLights.Lamps do
			
			if( IsValid( self.HeadLights.Lamps[i] ) ) then
			
				self.HeadLights.Lamps[i]:Fire("TurnOff","",0)
			
			end
			
		end
		self:RemoveHeadlightSprites()
	end
		
end

function Meta:TankAnimateTracks()
	
	if( self.TrackAnimationOrder != nil  ) then

		local Mat = self.TrackAnimationOrder[1]
		self.TravelDirection = 0
		
		for i=1,#self.TrackEntities do
			
			-- print( 2 )
			if( IsValid( self.TrackEntities[i] ) && !self.TrackEntities[i].Destroyed ) then
				-- print ( 3 )

				if( self:GetVelocity():Length() > 10 && (math.ceil(self:GetVelocity():GetNormalized().x) == math.ceil(self:GetForward().x)) && (math.ceil(self:GetVelocity():GetNormalized().y) == math.ceil(self:GetForward().y)) ) then
					
					Mat = self.TrackAnimationOrder[2]
					self.TravelDirection = 1
					
				elseif( self:GetVelocity():Length() > 10 && (math.floor(self:GetVelocity():GetNormalized().x) == -math.ceil(self:GetForward().x)) && (math.floor(self:GetVelocity():GetNormalized().y) == -math.ceil(self:GetForward().y)) ) then
					
					
					Mat = self.TrackAnimationOrder[3]
					self.TravelDirection = -1
					
				end
				
				-- print( Mat )
				self.TrackEntities[i]:SetMaterial( Mat )
				
			end
			
		end
		
		if( self.Speed == 0 && IsValid( self.TrackEntities[1] ) && IsValid( self.TrackEntities[2] ) ) then
			
			local LT = self.TrackEntities[1]
			local RT = self.TrackEntities[2] 
				
			if( self.Yaw > 0 ) then
			
		
				if( !LT.Destroyed ) then
				
					LT:SetMaterial( self.TrackAnimationOrder[3] )
				
				end
				
				if( !RT.Destryed ) then
				
					RT:SetMaterial( self.TrackAnimationOrder[2] )
				
				end
				
			elseif( self.Yaw < 0 ) then
				
				if( !LT.Destroyed ) then
				
					LT:SetMaterial( self.TrackAnimationOrder[2] )
				
				end
				
				if( !RT.Destroyed ) then
				
					RT:SetMaterial( self.TrackAnimationOrder[3] )
				
				end
				
			end
		
		end
		
	end
	
end
	
-- "Shtora" Counter Measure System
function Meta:Tank_ShtoraSystem()
	
	if( !IsValid( self.Tower ) ) then return end
	
	local mp = self:GetPos()
	local ma = self:GetAngles()
	
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 9000 ) ) do
		
		if( v.Target == self || v.Target == self.Pilot && v != self && v.Owner != self && v != self.Pilot || v.DestPos ) then
			
			if( v.DestPos ) then
				
				v.DestPos = v.Owner:GetPos() 
					
				return
				
			end
			
			local TA = ( mp - v:GetPos() ):Angle()
			local Elevation = math.floor( math.AngleDifference( ma.p, TA.p ) )
			local Azimuth = math.floor( math.AngleDifference( self.Tower:GetAngles().y, TA.y ) )
			
			if( !self.ShtoraLastIndication ) then self.ShtoraLastIndication = 0 end
			
			-- Field of view: -5° .. +25° elevation and 90° azimuth 
			if( Elevation > -25 && Elevation < 5 && Azimuth < -135 && Azimuth > 135 ) then
			
				if( self.ShtoraLastIndication + 2.0 <= CurTime() ) then
					
					v:SetTarget( NULL )
					v.Taret = NULL
					v:SetAngles( v:GetAngles() + Angle( math.Rand(-10,10), math.Rand(-10,10), 0 ) )
					
					self.ShtoraLastIndication = CurTime()
					
					if( IsValid( self.Pilot ) ) then
						
						self.Pilot:PrintMessage( HUD_PRINTTALK, "(Warning) Shtora Active Protection System: Jamming Incoming Projectile." )
						
					end
					
					
				end
			
			end
			
		end
		
	end	
	
end


function Meta:TankSyncAmmo()
	
	if( !self.AmmoTypes ) then return end
	
	local obj = self.AmmoTypes[self.AmmoIndex]
	
	local Min = obj.MinDmg
	local Max = obj.MaxDmg
	local Radius = obj.Radius
	if( !Min && !Max && !Radius ) then
	
		Min,Max,Radius = self:TankAmmo_GetDamage( obj.Type )
	
	end
	
	-- print( Min, Max, Radius )
	
	self.MinDamage = Min
	self.MaxDamage = Max
	self.BlastRadius = Radius
	self.PrimaryAmmo = obj.Type
	self.PrimaryDelay = obj.Delay or self.PrimaryDelay
	self.ShootSound = obj.Sound
	-- print("self.ShootSound: "..self.ShootSound)
	-- print("obj.Sound: "..obj.Sound)
	self.Pilot:PrintMessage( HUD_PRINTTALK, "Active Weapon: "..obj.PrintName.." Dmg: "..Min.."-"..Max )
	self:SetNetworkedString("NeuroTanks_activeWeapon", obj.PrintName )
	self:SetNetworkedString("NeuroTanks_activeWeaponShell", obj.Type )
	
end

function Meta:TankDefaultThink()
	self:NextThink(CurTime())
	if( self.TankCrew ) then
		
		for i=1,#self.TankCrew do
			
			debugoverlay.Text( self:LocalToWorld( self.TankCrew[i].SeatPos ), "Crew Member", 0.1, Color( 255, 0, 0, 0 ) )
			--walla2 
		
		end
		
	end
	
	if( self.MicroTurrets ) then
		
		for i=1,#self.MicroTurrets do
			
			if( IsValid( self.MicroTurrets[i] ) ) then
				
				local p = self.MicroTurrets[i]:GetPhysicsObject()
				if( IsValid( p ) ) then
					
					p:Wake()
					
				end
				
			end
		
		end
	
	end
	
	if( self.RocketFrames && IsValid( self.Pilot ) ) then
		
		local pa = self.Pilot:EyeAngles()
		local ma = self:GetAngles()
		-- print( math.floor(pa.p) )
		
		for i=1,#self.RocketFrames do
			
			if( IsValid( self.RocketFrames[i] ) ) then
			
				local ra = self.RocketFrames[i]:GetAngles()
				local Cap = math.AngleDifference( pa.p, ma.p ) 
				-- print( Cap )
				
				-- print( Aim )
				local va = 45
				
				local NewPitch = math.AngleDifference( ra.p, pa.p )+va
				
				ra:RotateAroundAxis( self:GetRight(), NewPitch )
				local Cap = math.AngleDifference( ra.p, ma.p ) 
				local Aim = ( Cap < -25 && Cap > -50 )
				if( Aim ) then
					
					self.RocketFrames[i]:SetAngles( ra )
					
				end
				
			end
		
		end
	
	end
	
	if( self.LastBarrel && self.LastTower ) then
		
		local bg = self.Barrel:GetBodygroup(0)
		local tg = self.Tower:GetBodygroup(0)
		if( self.LastBarrel != bg || self.LastTower != tg ) then
		
			self:UpdateTankAmmoStruct()
	
		end
		
	end	
	
	self:TankUpdateTrackStatus()
	self:CheckFluids()
	
	if( IsValid( self.Tower ) ) then
	
		self.Tower:SetSkin( self:GetSkin() )
	
	end
	
	if( IsValid( self.Barrel ) ) then
	
		self.Barrel:SetSkin( self:GetSkin() )
	
	end
	
	if( IsValid( self.MGun ) ) then
	
		self.MGun:SetSkin( self:GetSkin() )
        if( self.ComplexMGun ) then
            self.MgunTower:SetSkin( self:GetSkin() )
        end
        
	end
	
	local _mod = self.Speed
	if( _mod < 0 ) then
		
		_mod = -1*_mod
		
	end
	
    --self.CVol =  (100/self.MaxVelocity ) * self.Speed
    --self.CVol = math.Clamp( (( 100/self.MaxVelocity ) * self.Speed)/100, 0,1 )
    
    if self.HasCVol then 
		-- self.CEngSound:Play()
        self.CEngSound:ChangeVolume(self.CVol+( math.sin(CurTime()) ), 0.1)
    end
    
	self.Pitch = math.Clamp( 80 + ( 100/self.MaxVelocity ) * self.Speed, 100,255 )
			
	self:TankAnimateTracks()
	
	if( self.HasMGun &&  IsValid( self.Pilot ) ) then
			
		local pilotAng = self.Pilot:EyeAngles()
	
		if( IsValid( self.Copilot ) ) then
		
			pilotAng = self.Copilot:EyeAngles()
		
		end
		
		local _g = self.MGun:GetAngles()
		_g.p = pilotAng.p
		_g.y = pilotAng.y
		self.MGun:SetAngles( _g )
	
	end
	
	if( IsValid( self.Pilot ) && self.IsDriving ) then
		
		
		if( self:IsOnFire() ) then
			
			
			if( !self.LastExtinguish ) then	
				
				self.LastExtinguish = 0
				
			end
			
			if( self.LastExtinguish + 15 <=CurTime() ) then
			
				self.Pilot:PrintMessage( HUD_PRINTCENTER, "Press Jump to use fire extinguisher!") 
			
			end
			
			
			if( self.Pilot:KeyDown( IN_JUMP ) && self.LastExtinguish + 15 <= CurTime() ) then
				
				self.LastExtinguish = CurTime()
				
				self:EmitSound("HL1/ambience/steamburst1.wav", 511, 100 )
				
				for k,v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
					
					v:Extinguish()
					
					if( v:GetClass() == "env_fire_trail" ) then
						
						v:Remove()
					
					end
					
				end
				
				return
				
			end
		
		
		
		end
		
		if( !self.Pilot:Alive() ) then self:TankExitVehicle() return end
		
		if( IsValid( self.Ship ) && self.Pilot:KeyDown( IN_DUCK ) && self.LastUsed + 1 <= CurTime() ) then
			
			local ply = self.Pilot
			self:TankExitVehicle() 
			self.Ship:Use( ply, ply, 0, 0 )
			
			self.LastUse = CurTime()
			
			return
			
		end
		
		if( self.Pilot:KeyDown( IN_MOVELEFT ) || self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
			
			self.Pitch = 120
            -- self.CVol = 1
            
		elseif ( self.Pilot:KeyDown( IN_FORWARD ) ) then
			
			self.Pitch = 140 + math.Clamp(  math.floor( self:GetVelocity():Length()/10) , 0, 40 )
            -- self.CVol = 1
        
		elseif ( self.Pilot:KeyDown( IN_BACK ) ) then
			
			self.Pitch = 140 + math.Clamp(  math.floor( self:GetVelocity():Length()/10) , 0, 40 )
            -- self.CVol = 1
                    
        else
            -- self.CVol = 0
        end
		
		-- local speed = (self:GetVelocity():Length() * 0.75 * 0.0833333333 * 1.46666667)
		-- self:SetNetworkedInt( "SpeedMPH", speed )
	
	end
	--[[
	if( IsValid( self.Copilot ) && self.Copilot:IsBot() ) then
		
		if( IsValid( self.Copilot.Target ) ) then
			
			print( self.Copilot.Target )
			local tpos = self.Copilot.Target:GetPos()
			local coang = self.Copilot:EyeAngles()
			local myang = self.Tower:GetAngles()
			local tang = ( self.Copilot:GetShootPos() - tpos ):Angle()
			
			local offs = self:VecAngD( myang.y, tang.y )
				
			if( offs < 30 && offs > -30 ) then
				
				self.Copilot:SnapEyeAngles( LerpAngle( 0.45, coang, tang ) )
			
			else
				
				self.Copilot.Target = NULL
			
			end
		
		else
		
			self.Copilot:SnapEyeAngles( LerpAngle( 0.45, self.Copilot:EyeAngles(), self.Tower:GetAngles() ) )
			-- self.Copilot:SetEyeAngles( LerpAngle( 0.45, self.Copilot:EyeAngles(), self.Tower:GetAngles() ) )
			
			for k,v in pairs( ents.FindInSphere( self:GetPos(), 6500 ) ) do
			
				if( ( v:IsPlayer() || v.HealthVal || v:IsNPC() ) && v != self && v != self.Pilot && v != self.Copilot && v.Owner != self && v:GetOwner() != self ) then
					
					self.Copilot.Target = v
				
					break
				
				end
			
			end
		
		
		end
		
	end
	]]--
	
	
	local obj = self.Tower or self

	if( type(self.Tower) == "table" ) then
		
		obj = self.Tower[1]
		
	end
	
	if( IsValid( obj ) && obj:WaterLevel() < 2 ) then
		/*
		if( self.ManualGearbox && self.IsDriving && IsValid( self.Pilot ) ) then
			
			
			if( !self.Gear ) then 
				
				self.OldMaxVel = self.MaxVelocity
				
				local spd = math.floor( self.OldMaxVel * SPEED_CONSTANT_KMH )
				
				self.LastGearChange = CurTime()
				
				self.Gear = 1 
				self.Gears = { 
								spd / 100,
								spd / 20,
								spd / 10,
								spd / 2,
								spd / 1.1
							}
			end
	
			local curgear = self.Gears[self.Gear]
			local maxgear = #self.Gears
			local nextgear = (self.Gear+1<maxgear) and self.Gears[self.Gear+1] or self.Gears[maxgear]
			local speed = math.floor( self:GetVelocity():Length() )
			
			
			if( self.LastGearChange + 1.25 <= CurTime() ) then
				
				if( self.Pilot:KeyDown( IN_SPEED ) && self.Gear < maxgear && nextgear != maxgear ) then	
					
					self.Gear = self.Gear + 1
					self.LastGearChange = CurTime()
					self.Pilot:EmitSound( self.GearChangeSound, 511, 100 )
				
				elseif( self.Pilot:KeyDown( IN_DUCK ) && self.Gear-1 > 0 ) then
				
					self.Gear = self.Gear - 1
					self.LastGearChange = CurTime()
					self.Pilot:EmitSound( self.GearChangeSound, 511, 100 )
				
				end
				
			end
			
			
			local torque = math.floor( self.FWDTorque / self.Gear ) 
			self.MaxVelocity = self.OldMaxVel / ( maxgear+1 - self.Gear ) 
			print( torque, self.Gear, maxspeed )
			-- print( curgear, speed, self.Gear, nextgear, maxgear )
	
	
		end
		*/
		for i = 1,#self.EngineMux do
		
            self.EngineMux[i]:ChangePitch( self.Pitch - ( i * 5 ), 0.1 )
			
		end
        
        if self.HasCVol then
            self.CEngSound:ChangeVolume(self.CVol, 0.1)
		end
	else
	
		for i = 1,#self.EngineMux do
		
			self.EngineMux[i]:Stop()
			
		end
		if self.HasCVol then
            self.CEngSound:Stop()
		end
	end
	
	if ( self.Destroyed && obj:WaterLevel() < 2 && self.HealthVal < self.InitialHealth * 0.35 ) then 
		
		-- local effectdata = EffectData()
		-- effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		-- util.Effect( "immolate", effectdata )
		-- self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 200 then
            
			self:TankExitVehicle()
			self:Remove()
		
		end
		
	end
	
	if( IsValid( self.CopilotSeat ) ) then
		
		self.Copilot = self.CopilotSeat:GetDriver()
		
		if( IsValid( self.Copilot ) ) then
			
			-- self.MGun
			
		end
		
	end
	
	
	if ( IsValid( self.Pilot ) ) then
		
		if( !self.SeatPos ) then
		
			self.Pilot:SetPos( self:GetPos() + self:GetUp() * 500 )
			
		end
			
			
		
		
		if( self.CanLockOnTarget ) then
			
			if( !self.LockOnCounter ) then self.LockOnCounter = 0 end	
			if( !self.LastLockCheck ) then self.LastLockCheck = 0 end
			
			
			-- print( self.Target ) 
			if( self.LastLockCheck + 0.1 <= CurTime() ) then
				
				self.LastLockCheck = CurTime()
				
				if( IsValid( self.Target ) ) then
						
					local tp = self.Target:GetPos()
					local topos = self.Tower:GetPos()
					local ta = ( tp - topos ):Angle()
					local towang = self.Tower:GetAngles()
					local adiff =  math.abs( math.AngleDifference( ta.y, towang.y ) )
					-- print( adiff )
						if( self.Pilot:KeyDown( IN_DUCK ) || adiff > 75 ) then
							
							self.Pilot:PrintMessage( HUD_PRINTCENTER, "Target Released" )
							
							self.Target = NULL
							
						end
						
						
				else
					
					local tr,trace = {},{}
					tr.start = self.Barrel:GetPos() + self.Barrel:GetForward() * self.BarrelLength
					tr.endpos = tr.start + self.Pilot:GetAimVector() * 36500 + VectorRand() * 32
					-- tr.filter = { self, self:GetParent(), self.Owner, self.Pilot, self.Tower, self.Barrel, self.TowerProxy }
					tr.mask = MASK_SOLID
					trace = util.TraceLine( tr )
					
					-- self:DrawLaserTracer( tr.start, trace.HitPos )
					
					if( IsValid( trace.Entity ) ) then
						
						self.LockOnCounter = self.LockOnCounter + 1
						
						-- print( self.LockOnCounter ) 
						
						if( self.LockOnCounter > 3  ) then
							
							self.Pilot:PrintMessage( HUD_PRINTCENTER, "Target Locked" )
							self.LockOnCounter = 0
							self.Target = trace.Entity
							self.Barrel:EmitSound( "bf2/weapons/bomb_reload.mp3", 511, 100 )
							
							
						end
					
					
					end
					
					
				end
				
			end
			
		end
		
			
		if( self.Pilot:KeyDown( IN_USE ) && self.LastUsed + 0.5 <= CurTime() ) then
			
            -- if( GetConVarNumber( "neurowar" ) == 1 ) then
                -- return
            -- end
			self:TankExitVehicle()
			self.LastUsed = CurTime()
			
			return
			
		end
		
		if( self.IsDriving ) then
		
			if( self.AmmoTypes != nil ) then
			
				if( self.AmmoTypes != nil && #self.AmmoTypes > 1 && self.Pilot:KeyDown( IN_RELOAD ) && !self.Pilot:KeyDown(IN_ATTACK) && self.LastAmmoSwap + math.Clamp( self.PrimaryDelay, 1, 4 ) <= CurTime() && !self.Reloading /*&& self.BulletDelay <= CurTime()*/ ) then
					
					if( self.IsAutoLoader ) then
						
						-- if(  self.Shots != self.MagazineSize ) then
							
							-- self.Pilot:PrintMessage( HUD_PRINTTALK, "You can't change ammo until the current magazine is depleted!" )
							-- self.LastAmmoSwap = CurTime()
							
							-- return 
						
						-- else
							
						if( self.Pilot:KeyDown( IN_SPEED ) && self.Shots < self.MagazineSize ) then
							
							self:TankReloadAL()
							self.LastAmmoSwap = CurTime()
							
							return
							
						end
						
						self.Shots = 0
						self:TankReloadAL()
						self.BulletDelay = CurTime() + ( self.PrimaryDelay / 4 * self.MagazineSize )
						-- self.PrimaryDelay = CurTime() + ( self.PrimaryDelay / 4 * self.MagazineSize )
						self.LastAmmoSwap = CurTime() + ( self.PrimaryDelay * self.MagazineSize ) -1
					
						-- end
						
					end
					
					if not( self.IsAutoLoader ) then
						self:EmitSound( self.ReloadSound, 70, 100 )
					end
					self.LastAmmoSwap = CurTime()
					self.LastPrimaryAttack = CurTime()
					self.AmmoIndex = self.AmmoIndex + 1
					
					-- ENT.AmmoIndex = 1
					-- ENT.AmmoTypes = {
					
					if( self.AmmoIndex > #self.AmmoTypes || self.AmmoIndex < 1 ) then
						
						self.AmmoIndex = 1
						
					end
					
					self:SetNetworkedInt("NeuroTanks_ammoCount", self.AmmoTypes[self.AmmoIndex].CurrentAmmoCount )
					
					self:TankSyncAmmo()
					
					
				
					
				end
				
			end
			
			if( self.SmokeTubes != nil && self.Pilot:KeyDown( IN_SCORE ) && self.LastSmoke + 15.0 <= CurTime() ) then
				
				self.LastSmoke = CurTime()
				
				for i=1,#self.SmokeTubes do
				
					if( IsValid( self.SmokeTubes[i] ) ) then
						
						timer.Simple( i/4, 
						function()
						
							if( IsValid( self ) ) then
								
								local nade = ents.Create("sent_tank_smokegrenade")
								nade:SetPos( self.SmokeTubes[i]:GetPos() )
								nade:SetAngles( self.SmokeTubes[i]:GetAngles() )
								nade.Owner = self.Pilot
								nade:SetPhysicsAttacker( self.Pilot )
								nade:SetOwner( self.Pilot )
								nade:Spawn()
								nade:Fire("kill","",10)
								nade:GetPhysicsObject():ApplyForceCenter( nade:GetForward() * 600 )
								nade:EmitSound( "wot/is7/fire2.wav", 70, 60 )
								ParticleEffect( "microplane_mG_muzzleflash", nade:GetPos(), nade:GetAngles(), nade )
								
							end
							
						end )
						 
					end
					
					
				end
				
			
			end
			
			if( type( self.HeadLights ) == "table"  && TankHeadlights > 0  ) then
				
				if( self.Pilot:KeyDown( IN_SPEED ) && self.HeadLightsLast <= CurTime() ) then
					
					self:TankToggleHeadLights()
					
				end
				
			end

			local obj = self.Tower or self
			if( type(self.Tower) == "table" ) then
			
				obj = self.Tower[1]
			
			end
			
			// Ejection Situations.
			if ( IsValid( obj ) && obj:WaterLevel() > 1 ) then
			
				self:TankExitVehicle()
				self:Remove()
				
				return
				
			end
			
			-- Flamethrower
			if( IsValid( self.Flamethrower ) && self.Pilot:KeyDown( IN_WALK ) && self.Pilot:KeyDown( IN_DUCK ) && self.LastFlame + 0.5 <= CurTime() ) then
				
				if( !self.IsBurning ) then
					
					
					ParticleEffectAttach( self.FlamethrowerParticle, PATTACH_ABSORIGIN_FOLLOW, self.Flamethrower, 0 )
					
					self.IsBurning = true
				
				end
				if( !self.FlameTime ) then self.FlameTime = 0 end
				
				self.FlameTime = self.FlameTime + 5
				-- Consume our fuel reserve :v
				self.Fuel = self.Fuel - self.FuelRateHeavy
				
				local angvel = self:GetPhysicsObject():GetAngleVelocity()
				-- print(  )
				local kr,kl = self.Pilot:KeyDown( IN_MOVERIGHT ), self.Pilot:KeyDown( IN_MOVELEFT )
				
				local dir
				
				if( kr ) then
					
					dir = -1
				
				elseif( kl ) then
					
					dir = 1
				
				else
					
					dir = 0
				end
				
				local turnamount  = self:GetRight() *  math.Clamp( self.FlameTime/10, 0, 100 )*dir
				local flamelength =  math.Clamp( self.FlameTime, 0, 450 )
				local flamecone = math.Clamp( self.FlameTime/6, 0, math.sin(CurTime()/frameTime())*140 ) 
				
				
				local tr,trace = {},{}
					tr.start = self.Flamethrower:GetPos()
					tr.endpos = tr.start + self.Flamethrower:GetForward() * -flamelength + self.Flamethrower:GetUp() * math.sin(CurTime() / FrameTime())*flamecone/4 + self.Flamethrower:GetRight() * math.cos(CurTime()  / FrameTime() )*flamecone + turnamount
					tr.filter = { self, self.Tower, self.Barrel, self.Flamethrower, self.Pilot }
					tr.mask = MASK_SOLID
				trace = util.TraceLine( tr )
				
				self.Flamesound:Play()
				self.Flamesound2:Play()
					
				if( trace.Hit && IsValid( trace.Entity ) ) then
					
					if( !self.LastSplash ) then self.LastSplash = 0 end
					if( self.LastSplash + 3 <= CurTime() ) then
						self.LastSplash = CurTime()
						ParticleEffect( "neuro_gascan_explo", trace.HitPos, Angle(0,0,0), nil )
						-- util.BlastDamage( self, self.Pilot, trace.HitPos, math.random(15,25),math.random(15,25))
					end
					
					trace.Entity:Ignite( 10, 256 )
					self.Pilot:Neuro_DealDamage( DMG_BURN, math.random( 130, 254 ),trace.HitPos + Vector( 0,0, 32 ), 32, false, "" )
					
				end
				
				--debug
				-- self.Flamethrower:DrawLaserTracer( tr.start, trace.HitPos )
				
			
			else
				
				if( self.Flamethrower ) then
				
					self.Flamethrower:StopParticles() 
					self.IsBurning = false 
					self.FlameTime =  0
					self.Flamesound:FadeOut( 0.1 )
					self.Flamesound2:FadeOut( 0.5 )
					
				end
				
			end

			-- // Attack
			-- print(self.Pilot.MouseClick)
			if ( self.Pilot:KeyDown( IN_ATTACK ) ) then
				
				if( ( self.IsScudLauncher && !self.SCUDTransportMode ) ) then return end
				if( self.SCUDAngle && self.SCUDAngle < 87 ) then return end
				if(  self.SCUDRampAngle && self.SCUDAngle && math.abs( self.SCUDRampAngle - self.SCUDAngle ) < 35 ) then return end
				
				if( self.IsMineSweeper && self.LastLandMinePlacement + 2.0 <= CurTime() ) then
					
					self.LastLandMinePlacement = CurTime()
					
					local landmine = ents.Create("sent_land_mine")
					landmine:SetPos( self:LocalToWorld( self.MineDeployerPos ) )
					landmine:SetAngles( self:GetAngles() )
					landmine:Spawn()
					landmine.Spawner = self.Pilot
					landmine:Fire("kill","",1200)
				
				end
			
				if( self.CanAttack == false ) then return end
				
				if( self.BurstFire ) then
					local Cooldown = self.BurstCooldown or 0
					if( self.BulletDelay + ( self.PrimaryDelay * self.BurstSize ) + Cooldown <= CurTime() ) then
					
						self.BulletDelay = CurTime() + ( self.BurstSize * self.PrimaryDelay )
						
						self.LastAmmoSwap = CurTime() + 1.0
						
						for i=1,self.BurstSize do
							
							-- print( i * self.PrimaryDelay )
							timer.Simple( i * self.PrimaryDelay, function() if( IsValid( self ) ) then self:TankPrimaryAttack() end end )
						
						end
						-- timer.Simple( self.BurstSize * self.PrimaryDelay + 0.5, function() if ( self ) then self:EmitSound( self.ReloadSound, 511, 100 ) end end )
					else
					
						-- for i=1,self.BurstSize do
						
						-- timer.Simple( 0.1 , function() if ( self ) then self:EmitSound( self.ReloadSound, 511, 100 ) end end )
						
						-- end
						-- self.Pilot:PrintMessage( HUD_PRINTTALK, self.PrintName..": Reloading" )
					
					end
					
					
				else
					
			
					
					if  ( self.BulletDelay < CurTime() ) then	
				
						if( type(self.TowerPos) == "table" ) then
							
							self:TankMultiTowerAttack()
								
							return
							
						else
						
							self:TankPrimaryAttack()
							
							return
							
						end
					
					end
					
				end
				
			end
						
			if( self.HasStaticSecondaryGuns && self.Pilot:KeyDown( IN_WALK ) && self.Pilot:KeyDown( IN_ATTACK2 ) ) then
							
				self:TankStaticGunAttack()
				
			else
				
				if( self.IsScudLauncher ) then
					
					
					if( !self.LastModeSwap ) then self.LastModeSwap = CurTime() end
					if( self.Pilot:KeyDown( IN_ATTACK2 ) && self.LastModeSwap + 1 <= CurTime() ) then
						
						if( self.LastSCUDFire && self.LastSCUDFire + 7 >= CurTime() ) then return end
					
						self.LastModeSwap = CurTime()
						self.SCUDTransportMode = !self.SCUDTransportMode
						
					end
					
					if( self.SCUDTransportMode && self:GetVelocity():Length() > 50 ) then
						
						self.SCUDTransportMode = false
					
					end
				
				else
					
					if( IsValid( self.ATGM ) ) then
						
						if ( self.Pilot:KeyDown( IN_ATTACK2 ) ) then
							
							self:TankATGMAttack()
						
						end
					
					end
					
					if( self.HasMGun || IsValid( self.BMGun ) ) then
							
						if ( self.Pilot:KeyDown( IN_ATTACK2 ) && !IsValid( self.ATGM ) ) then
						
							self:TankSecondaryAttack( self.Pilot )

						end
						
						if( IsValid( self.Copilot ) && self.Copilot:KeyDown( IN_ATTACK ) ) then
							
							self:TankSecondaryAttack( self.Copilot )
						
						end
						
						
					end
					
				end
				
				
			end
			
			
		end
		
		
	end
	
	self:TankATGMController()
	--Toggling 3rd person view
	self:TankThirdPersonView()
	
end

function Meta:CheckFluids()

	if( self.EngineFluidCheck + 1.0 >= CurTime() ) then
		
		self.EngineFluidCheck = CurTime()
		
		if( self.GearBoxHealth <= 0 ) then
			
			self.GearBoxBroken = true
			self.EngineBroken = true
			-- self.MaxSpeed = 0
			
		end
			
		if( self.OilLeaking ) then
			
			self.OilLevel = self.OilLevel - 0.015
			-- print( self.OilLevel )
			self:SetNWFloat( "EngineOilLevel", self.OilLevel )
			
			if( self.OilLevel < 0 ) then
				
				self.OilPumpBroken = true
				self.OilLevel = 0
			
			else
				
				local fx = EffectData()
				fx:SetOrigin( self:GetPos() )
				fx:SetScale( 2.0 )
				util.Effect( "waterripple", fx )
			
			end
		
		end
		
		if( self.OilPumpBroken ) then
			
			self.EngineHeat = math.Approach( self.EngineHeat, self.EngineHeatBoiling, 0.25 )
			
		else
		
			self.EngineHeat = math.Approach( self.EngineHeat, self.EngineHeatIdle, 0.25 )
		
		end
		
		self:SetNetworkedInt( "EngineHeat", self.EngineHeat )
		
		-- Choke out engine if we're running too hot.
		if( self.EngineHeat >= self.EngineHeatBoiling && self.IsDriving ) then
			
			
			self.IsDriving = false
			self.TowerSound:Stop()
			self:SetNetworkedBool("IsStarted", false )
			--self:EmitSound( "sound/vehicles/digger_grinder_stop1.wav", 511, 100 )	
			self:EmitSound( "ambient/machines/spindown.wav", 100, 100 )
			
			if( self.TrackAnimationOrder != nil ) then

				local Mat = self.TrackAnimationOrder[1]
					
				for i=1,#self.TrackEntities do

					if( IsValid( self.TrackEntities[i] ) && !self.TrackEntities[i].Destroyed ) then
						
						self.TrackEntities[i]:SetMaterial( Mat )
						
					end
					
				end
				
			end
			
			for i=1,#self.EngineMux do
			
				self.EngineMux[i]:Stop()
				
			end
			
			if self.HasCVol then
			
				self.CEngSound:Stop()
				
			end
			
			if( type( self.HeadLights ) == "table"  && TankAllowHeadlights && TankAllowHeadlights > 0 ) then
			
				for i=1,#self.HeadLights.Lamps do
					
					if( IsValid( self.HeadLights.Lamps[i] ) ) then
					
						self.HeadLights.Lamps[i]:Fire("TurnOff","",0)
					
					end
					
				end
				
				self:RemoveHeadlightSprites()
				
			end
			
		end
		
		if( self.EngineHeat >= self.EngineHeatIdle && !self.IsDriving ) then
			
			self.EngineHeat = math.Approach( self.EngineHeat, 0, 0.2 )
			
		end
		
	end
end

function Meta:TankATGMController()
	
	if( IsValid( self.ATGMRocket ) && IsValid( self.Pilot ) ) then
		
		-- local pos = self.ATGM:GetPos()
		local pos = self.Pilot:GetShootPos()
		local tr,trace = {},{}
		tr.start = pos
		tr.endpos = pos + self.Pilot:GetAimVector() * 46500
		tr.filter = { self.ATGM, self, self.Barrel, self.Tower }
		tr.mask = MASK_SOLID
		trace = util.TraceLine( tr )
		
		debugoverlay.Line( tr.start, tr.endpos, 0.1, Color( 255, 0, 0, 0 ), true )
		self:DrawLaserTracer( tr.start, tr.endpos )
		self.ATGMRocket.DestPos = self.ATGMRocket:GetPos() + self.Pilot:GetAimVector() * 3200
		self.ATGMRocket:SetAngles( self.Pilot:EyeAngles() )
		self.ATGMRocket:SetVelocity( self.ATGMRocket:GetVelocity() * 1.25 )
		-- local tpos = ( self:GetPos() - trace.HitPos ):Angle()
		-- self.ATGMRocket:SetAngles( LerpAngle( 0.045, self.ATGMRocket:GetAngles(), self.Pilot:EyeAngles() ) )
		-- self.ATGMRocket:SetAngles( LerpAngle( 0.045, self.ATGMRocket:GetAngles(), tpos ) )
		
	end

end

function Meta:TankATGMAttack()
	
	if( self.LastATGMAttack + self.ATGMCooldown <= CurTime() ) then
		
		self.LastATGMAttack = CurTime()
		
		if( !IsValid( self.ATGMRocket ) && self.ATGMAmmoCount > 0 ) then
			
			self.ATGMAmmoCount = self.ATGMAmmoCount - 1
			self:SetNetworkedInt("ATGMAmmoCount", self.ATGMAmmoCount )
			
			self.ATGMRocket = ents.Create("sent_tank_atgm")
			self.ATGMRocket:SetPos( self.ATGM:GetPos() + self.ATGM:GetForward() * 50 )
			self.ATGMRocket:SetAngles( self.ATGM:GetAngles() )
			self.ATGMRocket:Spawn()
			self:SetNetworkedEntity("ATGMRocket", self.ATGMRocket )
			self.ATGMRocket:SetOwner( self )
			self.ATGMRocket.Owner = self.Pilot
			self.ATGMRocket.Creditor = self
			self.ATGMRocket:GetPhysicsObject():SetVelocity( self:GetVelocity() )
			self:SetNetworkedEntity("ATGM_projectile", self.ATGMRocket )
			
			local fx = EffectData()
			fx:SetOrigin( self.ATGM:GetPos() )
			fx:SetStart(  self.ATGM:GetPos() )
			fx:SetScale( 3.0 )
			util.Effect("tank_muzzlesmoke", fx)
			fx:SetNormal( self.ATGM:GetForward()*-1 )
			fx:SetScale( 50.05 )
			util.Effect("cball_explode", fx )
			util.Effect("ManhackSparks", fx )
			fx:SetScale( 1.15 )
			util.Effect("tank_muzzle", fx )

			self.ATGM:EmitSound( "bf2/tanks/tunguska_missile_fire.wav", 511, math.random( 90,110) )
			
		else
			
			if( self.ATGMAmmoCount <= 0 ) then
				
				self.Pilot:PrintMessage( HUD_PRINTCENTER, "Out of Ammo")
				
			else
			
				self.Pilot:PrintMessage( HUD_PRINTCENTER, "You can only control 1 ATGM at a time")
			
			end
			
		end
		
	end
	
end

function Meta:TankStaticGunAttack()
	
	if( self.LastStaticShot + self.StaticGunCooldown <= CurTime() ) then
		
		self.LastStaticShot = CurTime()
		
		for i=1,#self.StaticGunPositions do
				
			local gun = self.StaticGuns[i]
			
			local bullet = {} 
			bullet.Num 		= bulletcount
			bullet.Src = gun:LocalToWorld( Vector( 70, 0, 0 ) )
			bullet.Dir = gun:GetAngles():Forward()
			bullet.Filter = { self, self.Tower, self.Barrel, gun, self.Pilot }
			bullet.Attacker = self.Pilot
			bullet.Spread 	= Angle( .051, .051, .051 )
			bullet.Tracer	= 1
			bullet.Force	= 5
			bullet.Damage	= math.random( 5, 25 )
			bullet.AmmoType = "Ar2"
			bullet.TracerName 	= "Tracer"
			bullet.Callback    = function ( a, b, c ) self:TankMountedGunCallback( a, b, c ) end 

			gun:FireBullets( bullet )

			self:EmitSound( self.MGunSound, 100, math.random( 70, 100 ) )
			
			local shell2 = EffectData()
			shell2:SetStart( gun:GetPos() + gun:GetForward() * -4 + gun:GetRight() * 2 + gun:GetUp() * 8)
			shell2:SetOrigin( gun:GetPos() + gun:GetForward() * -4 + gun:GetRight() * 2 + gun:GetUp() * 8)
			util.Effect( "RifleShellEject", shell2 ) 
			
			local e2 = EffectData()
			e2:SetStart( gun:GetPos() + gun:GetForward() * 42 )
			e2:SetOrigin( gun:GetPos() + gun:GetForward() * 42 )
			e2:SetAngles( gun:GetAngles() )
			e2:SetEntity( gun )
			e2:SetAttachment( 1 )
			e2:SetScale( 1.5 )
			
			util.Effect( "tank_muzzlesmoke", e2 )
			util.Effect( "AirboatMuzzleFlash", e2 )
				
			//self:StopSound( self.MGunSound )

		end
		
	
	end

end

function Meta:TankSecondaryAttack( ply )
	
	if( !ply.ShellDelay ) then
		
		ply.ShellDelay = CurTime()
	
	end
	
	
	if ( !self ) then // silly timer errors.
		
		return
		
	end
	
	local gun = self.MGun
	if( !IsValid( gun ) ) then return end 
	
	local ghostgun = self.MGMuzzleReference
	local bulletcount = 1
	local bulletdamage = math.random( 5, 25 )
	local spread = Vector( 0.0055, 0.0055, 0.0055 )
	local muzzle = "AirboatMuzzleFlash"
	local muzzleScale = 1.2
    local delay = self.CMGunDelay or 0.088
	
	if( ply == self.Pilot && IsValid( self.BMGun ) ) then
			
		gun = self.BMGun
		ghostgun = self.BMGMuzzleReference
		bulletcount = 1
		damage = math.random( 6, 16 )
		spread = Vector( .001, .001, .001 )
		muzzle = "AirboatMuzzleFlash"
		muzzleScale = 2.2
		delay = self.PMGunDelay or 0.18
		
	end
	
	
	local bullet2 = {} 
	bullet2.Num 		= bulletcount
    bullet2.Src = gun:LocalToWorld( Vector( 70, 0, 0 ) )
	bullet2.Dir = gun:GetAngles():Forward()
	bullet2.Filter = { self, self.Tower, self.Barrel, gun }
	bullet2.Attacker = ply
	bullet2.Spread 	= spread
	bullet2.Tracer	= 0
	bullet2.Force	= 5
	bullet2.Damage	= math.random( 45, 75 )
	bullet2.AmmoType = "Ar2"
	bullet2.TracerName 	= "Tracer"
	bullet2.Callback    = function ( a, b, c ) self:TankMountedGunCallback( a, b, c ) end 

	if ( ply.ShellDelay < CurTime() ) then				
	
		ply.ShellDelay = CurTime() + delay
		gun:FireBullets( bullet2 )

		self:EmitSound( self.MGunSound or Sound( "bf2/tanks/m6_autocannon_3p.mp3" ), 100, math.random( 70, 100 ) )
		
		if( gun != self.BMGun ) then
			
			local shell2 = EffectData()
			shell2:SetStart( gun:GetPos() + gun:GetForward() * -4 + gun:GetRight() * 2 + gun:GetUp() * 2)
			shell2:SetOrigin( gun:GetPos() + gun:GetForward() * -4 + gun:GetRight() * 2 + gun:GetUp() * 2)
			shell2:SetNormal( self.MGun:GetUp() )
			util.Effect( "RifleShellEject", shell2 ) 
			
		end
		
		local e2 = EffectData()
        if self.HasCMGun then
            e2:SetStart( gun:LocalToWorld( self.CMGunPos ) + gun:GetForward() * 45  )
            e2:SetOrigin( gun:LocalToWorld( self.CMGunPos )  + gun:GetForward() * 45 )
        else
            e2:SetStart( gun:GetPos() + gun:GetForward() * 42 )
            e2:SetOrigin( gun:GetPos() + gun:GetForward() * 42 )
        end
		e2:SetAngles( ghostgun:GetAngles() )
		e2:SetEntity( ghostgun )
		e2:SetAttachment( 1 )
		e2:SetScale( 1.5 )
		util.Effect( "tank_muzzlesmoke", e2 )

		ParticleEffect(  "microplane_mG_muzzleflash", gun:GetPos() + gun:GetForward() * 42, ghostgun:GetAngles(), self.MGun )
		/*
		if self.MGunSoundLoop then
			self:StopSound( self.MGunSound )
		end
		*/
	end
	
end
function Meta:TankBulletHoseGunCallback( a, b, c )

	local divider = 1
	if( self.BarrelPorts ) then	
		divider = #self.BarrelPorts
	end
	
	local fx = EffectData()
	fx:SetStart( b.HitPos )
	fx:SetNormal( b.HitNormal )
	fx:SetOrigin( b.HitPos )
	fx:SetEntity( self )
	-- fx:SetScale( 50.0 )
	util.Effect( "AR2Impact", fx )
	-- ParticleEffect(  self.BulletImpact or "AirboatGunImpact", b.HitPos, ( b.HitPos - b.HitNormal ):Angle(), self )
	
	util.BlastDamage( self, self.Owner or self, b.HitPos, self.BlastRadius, math.random( self.MinDamage, self.MaxDamage )/divider )
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end

function Meta:TankMountedGunCallback( a, b, c )

	if ( IsValid( self.MGun ) ) then
	
		local e = EffectData()
		e:SetOrigin( b.HitPos )
		e:SetStart( b.HitPos )
		e:SetNormal( b.HitNormal )
		e:SetScale( 0.8 + math.Rand( .2, .9 ) )
		util.Effect("ImpactJeep", e)
		
		local e = EffectData()
		e:SetOrigin( b.HitPos )
		e:SetStart( b.HitPos )
		e:SetNormal( b.HitNormal )
		e:SetScale( 0.1 )
		e:SetMagnitude( 1 )
		util.Effect("sparks", e)
		
	end
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end
-- hook.Add("PlayerLeaveVehicle", "NeuroTanksBackupTankExti", function( ply, ent )
	
	

-- end )
if( table.HasValue( hook.GetTable(), "NeuroTanksEntRemove" ) ) then
	
	hook.Remove("EntityRemoved", "NeuroTanksEntRemove" )
	
end 

hook.Add("EntityRemoved", "NeuroTanksEntRemove", function( ent )
	
	if( ent.TankType && ent.HealthVal && IsValid( ent.Pilot ) ) then
		-- print( ent:GetClass() )
		ent:TankExitVehicle()
		
	end

end )

function CorrectPlayerObject( ply )
	
	if( !IsValid( ply ) ) then return end
	
	ply:ConCommand("jet_cockpitview 0")
	ply:SetColor( Color( 255,255,255,255 ) )
	ply:SetViewEntity( ply )
	ply:ExitVehicle()
	ply:SetHealth( 100 )
	ply:UnSpectate()
	ply:DrawViewModel( true )
	ply:DrawWorldModel( true )
	ply:SetNetworkedBool( "InFlight", false )
	ply:SetNetworkedEntity( "Tank", NULL ) 
	ply:SetNetworkedEntity( "Barrel", NULL )
	ply:SetNetworkedEntity( "Weapon", NULL )
	ply.ClientVector = nil 
	ply:SetScriptedVehicle( NULL )
	
	-- print( "fixed?")
	
end

function Meta:TankExitVehicle()
	
	if( !IsValid( self ) ) then return end
	
	if ( !IsValid( self.Pilot ) ) then 
	
		return
		
	end
	
	if( self.HoverRotorWashPoints ) then
		
		for i=1,#self.RotorWashPoints do
		
			if( IsValid( self.RotorWashPoints[i] ) ) then
		
				TankRemoveHoverDust( self.RotorWashPoints[i] )
				
			end
			
		end
		
	end
	
	CorrectPlayerObject( self.Pilot )
	
	-- self.Pilot:ConCommand("jet_cockpitview 0")
	-- self.Pilot.ClientVector = nil 
	
	-- self.Pilot:SetColor( Color( 255,255,255,255 ) )
	self:SetNetworkedEntity("Pilot", NULL )
	
	if( self.TowerSound ) then
	
		self.TowerSound:Stop()
		
	end
	
	if( self.Flamethrower ) then
		
		self.Flamethrower:StopParticles() 
		self.IsBurning = false 
		self.FlameTime =  0
		
	end
				
	self:SetNetworkedBool("IsStarted", false )
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end
    
    if self.HasCVol then
	
        self.CEngSound:Stop()
		
    end
	
	--[[ uncomment this if you want headlights to turn off when you exit the tank.
	if( type( self.HeadLights ) == "table"  && GetConVarNumber("tank_allowheadlights", 0 ) > 0 ) then
	
		for i=1,#self.HeadLights.Lamps do
			
			if( IsValid( self.HeadLights.Lamps[i] ) ) then
			
				self.HeadLights.Lamps[i]:Fire("TurnOff","",0)
			
			end
			
		end
		
		self:RemoveHeadlightSprites()
		
	end
	]]--
	
	self.Pilot:SetViewEntity( self.Pilot )
	self.Pilot:ExitVehicle()
	self.Pilot:Spawn()
	self.Pilot:SetHealth( 100 )
	
	self.Pilot:UnSpectate()
	-- self.Pilot:Spawn()
	self.Pilot:DrawViewModel( true )
	self.Pilot:DrawWorldModel( true )
-- */
	-- self.Pilot:SetNetworkedBool( "InFlight", false )
	-- self.Pilot:SetNetworkedEntity( "Tank", NULL ) 
	-- self.Pilot:SetNetworkedEntity( "Barrel", NULL )
	-- self.Pilot:SetNetworkedEntity( "Weapon", NULL )
	-- self:SetNetworkedEntity("Pilot", NULL )
	
	local tr, trace = {},{}
	tr.start = self:GetPos() + Vector( 0,0,250 )
	tr.endpos = self:GetPos()
	tr.mask = MASK_SOLID
	trace = util.TraceLine( tr )
	local p = trace.HitPos + trace.HitNormal * 50
	
	if( self.ExitPos ) then
		p = self:LocalToWorld( self.ExitPos  )
	end
	
	-- self.Pilot:SetColor( self.Pilot.Col ) 
	-- if( self.Pilot:Alive() ) then
		
		-- for i=1,#self.Pilot.Weapons do
			-- self.Pilot:Give(self.Pilot.Weapons[i])
		-- end
		
	-- end
	
	-- self.Pilot:GodEnable( false ) 
	-- self.Pilot:GodDisable()
	
	if( !self.AdvancedCommando ) then
	
		self.Pilot:SetPos( p )
		self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
		self.Owner = NULL
		
	end
	
	local ma = self:GetAngles()
	self.Pilot:SetEyeAngles( Angle( 0, ma.y, 0 ) )
	
	self.Pilot:SetScriptedVehicle( NULL )
	
    if( TankNeuroWar == 1 ) then
        
        self.Pilot:Kill()
        
    end
    
	self.Speed = 0
	self.IsDriving = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Yaw = 0
	self.Pilot = NULL

	local shtdwn = self.ShutDownSound or "vehicles/jetski/jetski_off.wav"

	if( self.Fuel >	 0 ) then
	
		self:EmitSound( shtdwn, 511, math.random( 95,100 ) )

	end

	
	if IsValid(  self.PilotModel ) then self.PilotModel:Remove() end
	
    self.PilotModel = NULL
	
end

CreateConVar("tank_friction",240,false,false)

function neuro_table_print(tt, indent, done)

  done = done or {}
  indent = indent or 0
  
  if type(tt) == "table" then
  
	local sb = {}
	-- print( "WALLA", neuro_table_print(value, indent + 2, done ) )
	for key, value in pairs (tt) do
	
	  table.insert(sb, string.rep (" ", indent)) -- indent it
	  
	  if type (value) == "table" and not done [value] then
	  
		done [value] = true
		table.insert(sb, "{\n");
		table.insert(sb, neuro_table_print(value, indent + 2, done ) )
		table.insert( sb, "," );
		table.insert(sb, string.rep (" ", indent)) -- indent it
		table.insert(sb, "};\n");
		
	  elseif "number" == type(key) then
	  
		table.insert(sb, string.format("%s\n", tostring(value)))
		
	  else
	  
		table.insert(sb, string.format( "%s = \"%s\"\n", tostring (key), tostring(value)))
		
	   end
	   
	end
	
	return table.concat(sb)
	
  else
  
	return tt .. "\n"
	
  end
  
end
 
function neuro_to_string( tbl )
	if  "nil" == type( tbl ) then
		return tostring(nil)
	elseif  "table" == type( tbl ) then
		return neuro_table_print(tbl)
	elseif  "string" == type( tbl ) then
		return tbl
	else
		return tostring(tbl)
	end
end
local function VecTableToString( tab ) 
	local str = ""
	for k,v in pairs( tab ) do
		local kind = string.lower(type(v))
		if( kind == "vector"  ) then
			str = str.."Vector( "..v.x..", "..v.y..", "..v.z.." )"
		elseif( kind == "angle" ) then
			str = str.."Angle( "..v.p..", "..v.y..", "..v.r.." )"
		elseif( kind == "color" ) then
			str = str.."Color( "..v.r..", "..v.g..", "..v.b..", "..v.a.." )"
		end
		if( k != #tab ) then
			str = str..","
		end
	end
	return str
end
local function StrTabToStr( tab )
	local str = ""
	for k,v in pairs ( tab ) do 
		str = str.."\""..v.."\""
		if( k!=#tab ) then str = str..", " end
	end
	return str
end
function Meta:DumpTankTable()
 
	print( "local tankName = \""..self.FolderName.."\"" )
	print( "local tank = {}" )
	print( "tank[\"PrintName\"] = \""..self.PrintName.."\"" ) 
	print( "tank[\"Author\"] = \""..string.Replace( self.Author, "\n", " " ).."\"" )
	print( "tank[\"Category\"] = \""..self.Category.."\"" )
	if( self.Description ) then
	print( "tank[\"Description\"] = \""..self.Description.."\"")
	end
	print( "tank[\"VehicleType\"] = "..self.VehicleType )
	print( "tank[\"TankType\"] = "..self.TankType )
	print( "tank[\"HasTower\"] = "..tostring(self.HasTower) )
	print( "tank[\"HasCockpit\"] = "..tostring(self.HasCockpit ) )
	print( "tank[\"HasMGun\"] = "..tostring( self.HasMGun ) )
	print( "tank[\"HasParts\"] = "..tostring(self.HasParts) )
	print( "tank[\"HasCVol\"] = "..tostring(self.HasCVol ) )
	if( self.TrackPos ) then
	print( "tank[\"TrackPos\"] = "..self.TrackPos )
	end
	if( self.TankTrackZ ) then
	print( "tank[\"TankTrackZ\"] = "..self.TankTrackZ )
	end
	if( self.TankTrackY ) then
	print( "tank[\"TankTrackY\"] = "..self.TankTrackY )
	end
	if( self.TankTrackX ) then
	print( "tank[\"TankTrackX\"] = "..self.TankTrackX )
	end
	if( self.TankNumWheels ) then
	
	print( "tank[\"TankNumWheels\"] = "..self.TankNumWheels )
	print( "tank[\"TankWheelTurnMultiplier\"] = "..self.TankWheelTurnMultiplier )
	print( "tank[\"TankWheelForceValFWD\"] = "..self.TankWheelForceValFWD )
	print( "tank[\"TankWheelForceValREV\"] = "..self.TankWheelForceValREV )
	
	end
	
	if( self.StartAngleVelocity ) then
	print( "tank[\"StartAngleVelocity\"] = "..self.StartAngleVelocity )
	end
	if( self.TankRecoilAngleForce ) then
	print( "tank[\"TankRecoilAngleForce\"] = "..self.TankRecoilAngleForce )
	end
	if( self.TrackPositions ) then
	print( "tank[\"TrackPositions\"] = {"..VecTableToString( self.TrackPositions ).."}" )
	end
	if( self.WheelPositions ) then
	print( "tank[\"WheelPositions\"] = {"..VecTableToString( self.WheelPositions ).."}" )
	end
	if( self.TrackModels ) then
	print( "tank[\"TrackModels\"] = { "..StrTabToStr( self.TrackModels ).." } " ) 
	end
	if( self.TrackAnimationOrder ) then
	print( "tank[\"TrackAnimationOrder\"] = { "..StrTabToStr( self.TrackAnimationOrder ).." }" )
	end
	
	print( "tank[\"SkinCount\"] = "..self:SkinCount() ) 
	if( self.BarrelMGunPos ) then
	print( "tank[\"BarrelMGunPos\"] = "..VecTableToString( { self.BarrelMGunPos } ) )
	print( "tank[\"BarrelMGunModel\"] = \""..self.BarrelMGunModel.."\"" )
	end
	print( "tank[\"CamDist\"] = "..self.CamDist )
	print( "tank[\"CamUp\"] = "..self.CamUp )
	print( "tank[\"CockpitPosition\"] = "..VecTableToString( { self.CockpitPosition } ) )
	print( "tank[\"SeatPos\"] = "..VecTableToString( { self.SeatPos } ) )
	print( "tank[\"SeatAngle\"] = "..VecTableToString( { self.SeatAngle } ) )
	if( self.TrackSound ) then
	print( "tank[\"TrackSound\"] = \""..self.TrackSound.."\"" )
	end
	print( "tank[\"StartupSound\"] = Sound( \""..self.StartupSound.."\")" )
	if( self.EngineSounds ) then
	print( "tank[\"EngineSounds\"] = {"..StrTabToStr( self.EngineSounds ).." } " )
	end
	print( "tank[\"StartupDelay\"] = "..self.StartupDelay ) 
	if( self.TowerStopSound ) then
	print( "tank[\"TowerStopSound\"] = \""..self.TowerStopSound.."\"")
	print( "tank[\"SoundTower\"] = \""..self.SoundTower.."\"")
	end
	print( "tank[\"ShootSound\"] = Sound(\""..self.ShootSound.."\")" )
	if( self.ReloadSound ) then
	print( "tank[\"ReloadSound\"] = Sound(\""..self.ReloadSound.."\")")
	end
	print( "tank[\"PrimaryAmmo\"] = \""..self.PrimaryAmmo.."\"" )
	print( "tank[\"PrimaryDelay\"] = "..self.PrimaryDelay )
	if( self.APDelay ) then
	print( "tank[\"APDelay\"] = "..self.APDelay )
	end
	if( self.PrimaryEffect ) then
	print( "tank[\"PrimaryEffect\"] = \""..self.PrimaryEffect.."\"" )
	end
	print( "tank[\"MaxDamage\"] = "..self.MaxDamage )
	print( "tank[\"MinDamage\"] = "..self.MinDamage )
	print( "tank[\"BlastRadius\"] = "..self.BlastRadius ) 
	print( "tank[\"HeadLightsToggle\"] = "..tostring( self.HeadLightsToggle ) )
	if( self.HeadLightsPos ) then
	print( "tank[\"HeadLightsPos\"] = { "..VecTableToString( self.HeadLightsPos ).. " }" ) --Vector( 105, -36.5, 57 ),Vector( 105, 37.5, 57 ) }
	print( "tank[\"HeadLightsAngles\"] = { "..VecTableToString( self.HeadLightsAngles ).." }" )
	print( "tank[\"HeadLightsColors\"] = { "..VecTableToString( self.HeadLightsColors ).." }" )
	end
	print( "tank[\"Model\"] = \""..self.Model.."\"" )
	print( "tank[\"TowerModel\"] = \""..self.TowerModel.."\"" )
	print( "tank[\"TowerPos\"] = "..VecTableToString( { self.TowerPos } ) )
	print( "tank[\"BarrelModel\"] = \""..self.BarrelModel.."\"" )
	print( "tank[\"BarrelPos\"] = "..VecTableToString( { self.BarrelPos } ) )
	print( "tank[\"BarrelLength\"] = "..self.BarrelLength )
	if( self.MGunModel && self.MGunPos ) then
	print( "tank[\"MGunModel\"] = \""..self.MGunModel.."\"" )
	print( "tank[\"MGunPos\"] = "..VecTableToString( { self.MGunPos } ) )
	print( "tank[\"MGunSound\"] = Sound(\""..self.MGunSound.."\")")
	end
	print( "tank[\"MaxVelocity\"] = "..self.MaxVelocity )
	print( "tank[\"MinVelocity\"] = "..self.MinVelocity )
	print( "tank[\"InitialHealth\"] = "..self.InitialHealth )
	-- other stuff
	-- ENT.FlamethrowerPos = Vector( 80, -11, 50 )
	-- ENT.FlamethrowerAng = Angle( -8, 180, 0 )
	-- ENT.FlamethrowerMdl = "models/weapons/w_smg1.mdl"
	-- ENT.FlamethrowerParticle = "flamethrower_initial"
	if( self.FlamethrowerPos ) then
	print( "tank[\"FlamethrowerPos\"] = "..VecTableToString( { self.FlamethrowerPos } ) )
	print( "tank[\"FlamethrowerAng\"] = "..VecTableToString( { self.FlamethrowerAng } ) )
	print( "tank[\"FlamethrowerMdl\"] = \""..self.FlamethrowerMdl.."\"" )
	print( "tank[\"FlamethrowerParticle\"] = \""..self.FlamethrowerParticle.."\"" )
	end
	if( self.RecoilForce ) then
	print( "tank[\"RecoilForce\"] = "..self.RecoilForce )
	end
	if( self.MaxBarrelYaw ) then
	print( "tank[\"MaxBarrelYaw\"] = "..self.MaxBarrelYaw )
	end
	if( self.MaxBarrelPitch ) then
	print( "tank[\"MaxBarrelYaw\"] = "..self.MaxBarrelPitch )
	end
	if( self.LimitView ) then
	print( "tank[\"LimitView\"] = "..self.LimitView )
	end
	if( self.SmokePos ) then
	print( "tank[\"SmokePos\"] = { "..VecTableToString( self.SmokePos ).."}" )
	end
	if( self.ChillSeatPositions ) then
	print( "tank[\"ChillSeatPositions\"] = { "..VecTableToString( self.ChillSeatPositions ).."}" )
	print( "tank[\"ChillSeatAngles\"] = { "..VecTableToString( self.ChillSeatAngles ).."}" )
	end
	if( self.BodygroupAmmo || self.AmmoTypes || self.AmmoStructure ) then
		if( type( self.BodygroupAmmo ) == "table" ) then
			print( "tank[\"BodygroupAmmo\"] = \n{\n"..neuro_table_print( self.BodygroupAmmo ).."}" )
		elseif( type( self.AmmoTypes ) == "table" ) then
			print( "tank[\"AmmoTypes\"] = \n{\n"..neuro_table_print( self.AmmoTypes ).."}" )
		elseif( type( self.AmmoStructure ) == "table" ) then
			print( "--used by tanks with tower/barrel dependant combos. ")
			print(  "tank[\"AmmoStructure\"] = \n{\n"..neuro_table_print( self.AmmoStructure ).."}" )
		end
	else
		
		print( "-- ///// NO GUNS FOR U ///// ")
		print( "-- YOU DIDNT DO THE AMMO TABLES RIGHT, PROBABLY AFTOKINITOS CODE LOL" )
		print( "-- dont hardcode ammo tables in the OnUse. create a 2D table instead and loop it on init.")
		
	end
	if( self.TankIcon ) then
	print( "tank[\"icon\"] = \""..self.TankIcon.."\"" )
	end
	print( "TankDB[tankName] = tank" )
	print( "print(\"Loaded:\",tankName)")
	
end	

function Meta:TanksDefaultInit()
			-- self.DriveWheels[v[1]]:GetPhysicsObject():SetBuoyancyRatio( 1.0 ) 
	
	if( self.BarrelPorts ) then
		
		self.BarrelPortIndex = 1
	
	end
	
	self.ValidSeats = { { self, "use" } }
	
	self:CallOnRemove("ManuelCaller", function(ent) hook.Call("TankExitVehicle", GAMEMODE, ent) end )
	-- self:CallOnRemove( "FixBrokenOnRemoveHook", function( ent ) CorrectPlayerObject( ent.Pilot ) end )
	local omi,oma = self:OBBMins(), self:OBBMaxs()
	self.BulletProof = true 
	
	if( self.CrewPositions ) then
		
		local TankDriver 	=  "icons/roles/big/driver.png"
		local TankGunner 	= "icons/roles/big/gunner.png"
		local TankCommander = "icons/roles/big/commander.png"
		local TankLoader	= "icons/roles/big/loader.png"
		local FacePath = "materials/icons/soldierFaces/"
		local faces, dirs = file.Find( FacePath.."*", "GAME" )
		self.CrewFaces = 
					{ 
						{ tostring( FacePath..faces[math.random(1,50)]), TankDriver },
						{ tostring( FacePath..faces[math.random(151,206)]), TankLoader },
						{  tostring( FacePath..faces[math.random(101, 150)]), TankCommander },
						{ tostring( FacePath..faces[math.random(51,100)]), TankGunner }
						
					}
		self.TankCrew = {}
		
		local length = ( omi - oma ):Length()
		local average = length/4
		-- print( length, omi.y, oma.y )
		
		local num = 2 
		if( type( self.CrewPositions ) == "table" ) then
			
			num = #self.CrewPositions
			
		end
		
		for i =1,num do
			
			self.TankCrew[i] = {}
			self.TankCrew[i].Health = 100
			self.TankCrew[i].Dead = false
			if( type( self.CrewPositions ) != "table" ) then
			
				self.TankCrew[i].SeatPos = Vector( omi.y*2.5 + ( i * average + 15 ), 0, omi.z+50 )
			
			else
				
				self.TankCrew[i].SeatPos = self.CrewPositions[i]
			
			end
			
			self.TankCrew.Faces = self.CrewFaces
			
		-- print( self.TankCrew[i].SeatPos )
		
		end
	
	end
	-- self:TankSyncronizeCrew()

	self.LastUse = CurTime()

	self.AmmoIndex = 1
	
	if( !self.CVol ) then
		
		self.CVol = 1.0
	
	end
	if( self.IsMineSweeper ) then
					
		self.LastLandMinePlacement = CurTime()			
				
	end

	self.Destroyed = false
	self.Burning = false
	self.Speed = 0
	self.DeathTimer = 0

	self.LastPrimaryAttack = nil
	self.LastSecondaryAttack = nil
	self.LastFireModeChange = nil
	self.HealthVal = nil
	self.CrosshairOffset = 0
	self.PrimaryCooldown = 200
	self.BulletDelay = CurTime()
	self.ShellDelay = CurTime()
	
	self.HealthVal = self.InitialHealth
	
	self.WheelForceValue = 0 
	
	self.LastReminder = 0
	self.IsOnGround = false
	self.UnUsed = true
	self.LastUsed = CurTime()	
	self.DefaultGearBoxHealth = 500
	self.GearBoxHealth = self.DefaultGearBoxHealth
	
	timer.Simple( .2, function() 
		
		if( IsValid( self ) ) then 
		
			self:SetNetworkedInt( "EngineGearBoxHealth", self.GearBoxHealth )
			self:SetNetworkedInt("health",self.HealthVal)
			self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
			self:SetNetworkedInt( "MaxSpeed",self.MaxVelocity)
			self:SetNWFloat( "EngineOilLevel", self.OilLevel )
			
		end 
		
	end )

	self.GearBoxBroken = false
	
	self.DefaultOilLevel = 100
	self.OilLevel = self.DefaultOilLevel

	self.OilPumpBroken = false
	self.OilLeaking = false
	
	self.EngineHeatCold = 0
	self.EngineHeatIdle = 100
	self.EngineHeatBoiling = 500
	self.EngineBoilingCooldown = 15
	
	self.EngineFluidCheck = CurTime()
	
	self.EngineHeat = self.EngineHeatCold
	
	self.DamageTakenFront = 0
	self.DamageTakenRear = 0
	self.DamageTakenRight = 0
	self.DamageTakenLeft = 0
	self.EngineBroken = false
	self.BrokenYaw = 0 -- Huurrr
	
	
	
	local Min,Max,Radius = self:TankAmmo_GetDamage( self.PrimaryAmmo )
	self.MinDamage = Min
	self.MaxDamage = Max
	self.BlastRadius = Radius
	
	self.LastAmmoSwap = CurTime()
	
	if( self.IsAutoLoader ) then
		
		self.Shots = self.MagazineSize
		self:SetNetworkedInt("AutoLoaderShots", self.Shots )
		self:SetNetworkedInt("AutoLoaderMax", self.MagazineSize )
		self.Reloading = false
		
	end
	
	// Misc
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	
		
	self.MaterialSoundTables = {}
	self.MaterialImpactTable = {}
	-- Driving over metal
	self.MaterialSoundTables[77] = { 	"physics/metal/metal_box_strain1.wav",
										"physics/metal/metal_box_strain2.wav",
										"physics/metal/metal_box_strain3.wav",
										"physics/metal/metal_box_strain4.wav",
										"physics/metal/metal_box_break2.wav" 
									}
	self.MaterialImpactTable[77] = { }
	self.LastMaterialBasedSoundFX = CurTime()
	
	// Sound
	local esound = {}
	esound[1] = "vehicles/diesel_loop2.wav"
	-- esound[2] = "vehicles/diesel_loop2.wav"
	-- esound[3] = "vehicles/diesel_loop2.wav"
	self.EngineMux = {}
	
	if( self.EngineSounds != nil ) then
		
		esound = self.EngineSounds
		
	end
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end

    if self.HasCVol then
        self.CEngSound = CreateSound(self, self.TrackSound)
    end
	
	self.TowerSound = CreateSound( self, self.SoundTower or "vehicles/tank_turret_loop1.wav" )
	self.Turning = false
	self.Pitch = SoundTowerPitch or 100
	
	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	self.Yaw = 0
	
	
	if( type(self.TowerPos) == "table" ) then
		
		self.Tower = {}
		self.TowerPhys = {}
		
		for i=1,#self.TowerPos do
				
			self.Tower[i] = ents.Create("prop_physics_override")
			self.Tower[i]:SetModel( self.TowerModel )
			self.Tower[i]:SetPos( self:LocalToWorld( self.TowerPos[i] ) )
			self.Tower[i]:SetParent( self )
			self.Tower[i]:SetSkin( self:GetSkin() )
			self.Tower[i]:SetAngles( self:GetAngles() )
			self.Tower[i]:Spawn()
			self.Tower[i]:SetSolid( SOLID_NONE )
			self.Tower[i]:PhysicsInit( SOLID_NONE )
			self.TowerPhys[i] = self.Tower[i]:GetPhysicsObject()
			
			
		end
		
	
	else
	
		
		self.Tower = ents.Create("prop_physics_override")
		self.Tower:SetModel( self.TowerModel )
		self.Tower:SetPos( self:LocalToWorld( self.TowerPos ) )
		self.Tower:SetSkin( self:GetSkin() )
		self.Tower:SetAngles( self:GetAngles() )
		self.Tower:PhysicsInit( SOLID_NONE )
		self.Tower:PhysicsDestroy()
		self.Tower:SetParent( self )
		self.Tower:Spawn()
		self.Tower:SetSolid( SOLID_NONE )

		self.Tower:SetMoveType( MOVETYPE_NONE )
		
		self.TowerPhys = self.Tower:GetPhysicsObject()
		self.TowerPhys:SetMass( 500 )
		
		if( !self.NoTowerProxy ) then
			
			self.TowerProxy = ents.Create("tank_tower")
			self.TowerProxy:SetModel( self.Tower:GetModel() )
			self.TowerProxy:SetPos( self.Tower:GetPos() )
			self.TowerProxy:SetAngles( self.Tower:GetAngles() )
			self.TowerProxy:Spawn()
			self.TowerProxy:SetOwner( self )
			self.TowerProxy:SetRenderMode( RENDERMODE_TRANSALPHA )
			self.TowerProxy:SetColor( Color( 0,0,0,0 ) )
			self.TowerProxy:SetBodygroup( 0, self.Tower:GetBodygroup(0) )
			self.TowerProxy.HealthVal = self.HealthVal
			self.TowerProxy.Owner = self
			
		end
		
		-- constraint.Weld( self, self.TowerProxy, 0, 0, 0, true, false )
		-- self.TowerAxis = constraint.Axis( self, self.Tower, 0, 0, self.Tower:GetPos() + Vector(0,1,0), self.TowerPos, 0, 0, 0, 1 )		-- börk
		-- print( self.TowerAxis:GetClass() )
		-- if self.HasParts then
			-- self.Tower:SetKeyValue("SetBodygroup", self.TowerPart)
		-- end
		
		self.Tower:SetOwner(self)
		
		if( !self.HasTower ) then
			
			self.Tower:SetColor( Color(  0,0,0,0 ) )
			self.Tower:SetRenderMode( RENDERMODE_TRANSALPHA )
			
		end
		
		if ( self.TowerPhys:IsValid() ) then
		
			self.TowerPhys:Wake()
			self.TowerPhys:EnableGravity( true )

		end
		
	end
	
	if( type(self.BarrelPos) == "table" ) then
		
		if self.BarrelOffset then
	
			local rand1 = math.random(self.TowerParts[1],self.TowerParts[#self.TowerParts])
			--print("Rand1: "..rand1)
			rand2 = math.random((self.BarrelParts[rand1-1] or self.BarrelParts[1]),self.BarrelParts[rand1])
			--print("Rand2: "..rand2)
			self.Tower:SetBodygroup(0,rand1-1)	
	
			self.Barrel = ents.Create("prop_physics_override")
			self.Barrel:SetModel( self.BarrelModel )
			self.Barrel:SetPos( self:LocalToWorld( self.BarrelPos[rand1] ) )
			self.Barrel:SetSolid( SOLID_NONE )
			self.Barrel:PhysicsInit( SOLID_NONE )
			self.Barrel:SetMoveType( MOVETYPE_NONE )
			self.Barrel:PhysicsDestroy()
			self.Barrel:SetParent( self.Tower )
			self.Barrel:SetSkin( self:GetSkin() )
			self.Barrel:SetAngles( self:GetAngles() )
			self.Barrel:Spawn()
			
			self.BarrelPhys = self.Barrel:GetPhysicsObject()	
			
			self.Barrel:SetOwner(self)	

			self.Barrel:SetBodygroup(0,rand2-1)
			--print("Tower: "..self.Tower:GetBodygroup(0))
			--print("Barrel 0: "..  tostring(self:WorldToLocal(self.Barrel:GetPos() ) ) )
			
		else
		
			self.Barrel = {}
			self.BarrelPhys = {}
			
			for i=1,#self.BarrelPos do 
				
				self.Barrel[i] = ents.Create("prop_physics_override")
				self.Barrel[i]:SetModel( self.BarrelModel )
				self.Barrel[i]:SetPos( self:LocalToWorld( self.BarrelPos[i] ) )
				
				if( type( self.TowerPos ) == "table" ) then
				
					self.Barrel[i]:SetParent( self.Tower[i] )
					
				else
					
					self.Barrel[i]:SetParent( self.Tower )
				
				end
				
				self.Barrel[i]:SetSkin( self:GetSkin() )
				self.Barrel[i]:SetAngles( self:GetAngles() )
				self.Barrel[i]:Spawn()
				self.Barrel[i]:SetSolid( SOLID_NONE )
				self.Barrel[i]:PhysicsInit( SOLID_NONE )
				self.BarrelPhys[i] = self.Barrel[i]:GetPhysicsObject()	
			
			end
		end
		
	else
	
		
		self.Barrel = ents.Create("prop_physics_override")
		self.Barrel:SetModel( self.BarrelModel )
		self.Barrel:SetPos( self:LocalToWorld( self.BarrelPos ) )
		self.Barrel:SetSolid( SOLID_NONE )
		-- self.Barrel:PhysicsInit( SOLID_NONE )
		self.Barrel:SetParent( self.Tower )
		self.Barrel:SetSkin( self:GetSkin() )
		self.Barrel:SetAngles( self:GetAngles() )
		self.Barrel:Spawn()
		
		self.BarrelPhys = self.Barrel:GetPhysicsObject()	
		
		self.Barrel:SetOwner(self)
		
	end    
	-- Used for smaller tanks that use Auto-Cannon
	if( self.BarrelMuzzleReferencePos ) then
		
		self.BarrelMuzzleReference = ents.Create("prop_physics_override")
		self.BarrelMuzzleReference:SetModel( "models/airboatgun.mdl" )
		self.BarrelMuzzleReference:SetPos( self.Barrel:LocalToWorld( self.BarrelMuzzleReferencePos ) )
		self.BarrelMuzzleReference:SetAngles( self.Barrel:GetAngles() )
		self.BarrelMuzzleReference:SetParent( self.Barrel )
		self.BarrelMuzzleReference:SetSolid( SOLID_NONE )
		self.BarrelMuzzleReference:Spawn()
		self.BarrelMuzzleReference:SetColor( Color( 0,0,0,0 ) )
		self.BarrelMuzzleReference:SetRenderMode( RENDERMODE_TRANSALPHA )
		
	
	end
	
	if ( type( self.BarrelPhys ) != "table" && self.BarrelPhys:IsValid() ) then
	
		self.BarrelPhys:Wake()
		self.BarrelPhys:EnableGravity( true )

	end
    
	
	if( self.FlamethrowerPos ) then
		
		self.LastFlame = CurTime()
		self.Flamethrower = ents.Create("prop_physics_override")
		self.Flamethrower:SetPos( self:LocalToWorld( self.BarrelPos )  + self.Barrel:GetForward() * self.BarrelLength * .85 )
		self.Flamethrower:SetAngles( self.Barrel:GetAngles() + Angle( 0, self.FlamethrowerAng.y, 0  ) )
 		self.Flamethrower:SetParent( self.Barrel )
		self.Flamethrower:SetSolid( SOLID_NONE )
		self.Flamethrower:SetRenderMode( RENDERMODE_TRANSALPHA )
		self.Flamethrower:SetColor( Color(0,0,0,0 ) )
		
		local s = "ambient/machines/city_ventpump_loop1.wav"
		local s2 = "ambient/fire/fire_big_loop1.wav"
		self.Flamesound = CreateSound( self.Flamethrower, Sound( s ) )
		self.Flamesound2 = CreateSound( self.Flamethrower, Sound( s2 ) )
		-- print( type( self.Flamesound ) )
		-- self.Flamesound:Play()
		if( self.FlamethrowerMdl ) then
			
			self.Flamethrower:SetModel( self.FlamethrowerMdl )
			
		else
		
			self.Flamethrower:SetModel( "models/weapons/w_smg1.mdl" )
	
		end
		
		self.Flamethrower:Spawn()
		
	
	end
	
    if( self.ComplexMGun ) then
    
		self.MgunTower = ents.Create("prop_physics_override")
		self.MgunTower:SetModel( self.MGunTowerModel )
		self.MgunTower:SetPos( self:LocalToWorld( self.MGunTowerPos ) )
		if( type( self.Tower ) == "table" ) then
		
			self.MgunTower:SetParent( self.Tower[1] )
			
		else
			
			self.MgunTower:SetParent( self.Tower )
			
		end
		
		self.MgunTower:SetSkin( self:GetSkin() )
		if( self.MGunAng ) then
			
			self.MgunTower:SetAngles( self.Tower:GetAngles() + self.MGunAng )
			
		else
		
			self.MgunTower:SetAngles( self.Tower:GetAngles() )
			
		end
		self.MgunTower:Spawn()   
    end
    
	if( self.HasMGun ) then
	
	--self:GetPos() + self:GetForward() * 8 + self:GetRight() * 35 + self:GetUp() * 98

		self.MGun = ents.Create("prop_physics_override")
		self.MGun:SetModel( self.MGunModel )
		self.MGun:SetPos( self:LocalToWorld( self.MGunPos ) )
		if( type( self.Tower ) == "table" ) then
		
			self.MGun:SetParent( self.Tower[1] )
			
		else
			
			self.MGun:SetParent( self.Tower )
			
		end
		
		self.MGun:SetSkin( self:GetSkin() )
		if( self.MGunAng ) then
			
			self.MGun:SetAngles( self.Tower:GetAngles() + self.MGunAng )
			
		else
		
			self.MGun:SetAngles( self.Tower:GetAngles() )
			
		end
		self.MGun:Spawn()
	
		self.MGMuzzleReference = ents.Create("prop_physics_override")
		self.MGMuzzleReference:SetModel("models/airboatgun.mdl")
        self.MGMuzzleReference:SetPos( self.MGun:GetPos() )
		self.MGMuzzleReference:SetParent( self.MGun )
		self.MGMuzzleReference:SetAngles( self.MGun:GetAngles() )
		self.MGMuzzleReference:Spawn()
		self.MGMuzzleReference:SetSolid( SOLID_NONE )
        if not self.MGunDebug then
            
			self.MGMuzzleReference:SetColor( Color( 0, 0, 0, 0 ) )
			self.MGMuzzleReference:SetRenderMode( RENDERMODE_TRANSALPHA )
			
        end

		-- self.MGunAxis = constraint.Axis( self.MGun, self.Tower, 0, 0, Vector(0,0,1) , self:LocalToWorld( self.MGunPos ), 0, 0, 1, 0 )
		-- constraint.NoCollide( self.Tower, self.MGun, 0, 0 )
		-- constraint.NoCollide( self.MGun, self, 0, 0 )
		-- constraint.NoCollide( self.MGun, self.Barrel, 0, 0 )
		
	end
	
	if( self.BarrelMGunPos ) then
		
		self.BMGun = ents.Create("prop_physics_override")
		self.BMGun:SetModel( self.BarrelMGunModel )
		
		if( type(self.Barrel) == "table" ) then
			
			self.BMGun:SetPos( self.Barrel[1]:LocalToWorld( self.BarrelMGunPos ) )	
			self.BMGun:SetParent( self.Barrel[1] )
			self.BMGun:SetAngles( self.Barrel[1]:GetAngles() )
			
		else
		
			self.BMGun:SetPos( self.Barrel:LocalToWorld( self.BarrelMGunPos ) )	
			self.BMGun:SetParent( self.Barrel )
			self.BMGun:SetAngles( self.Barrel:GetAngles() )
			
		end
		self.BMGun:SetSkin( self:GetSkin() )

		self.BMGun:SetSolid( SOLID_NONE )
		self.BMGun:Spawn()
		-- self.BMGun:SetColor( Color( 0,0,0,0 ) )
		self.BMGun:SetRenderMode( RENDERMODE_TRANSALPHA )
		
		self.BMGMuzzleReference = ents.Create("prop_physics_override")
		self.BMGMuzzleReference:SetModel("models/airboatgun.mdl")
		self.BMGMuzzleReference:SetPos( self.BMGun:GetPos() )
		self.BMGMuzzleReference:SetParent( self.BMGun )
		self.BMGMuzzleReference:SetAngles( self.BMGun:GetAngles() )
		self.BMGMuzzleReference:Spawn()
		self.BMGMuzzleReference:SetSolid( SOLID_NONE )
		-- self.BMGMuzzleReference:SetColor( Color( 0,0,0,0 ) )
		self.BMGMuzzleReference:SetRenderMode( RENDERMODE_TRANSALPHA )
		
	end
	
	-- Create copilot seat if the variable is set
	if( self.CopilotPos ) then
		
		self.CopilotSeat = ents.Create( "prop_vehicle_prisoner_pod" )
		self.CopilotSeat:SetPos( self:LocalToWorld( self.CopilotPos ) )
		if( self.StandByCoMGun == true ) then
			
			self.CopilotSeat:SetModel("models/props_c17/chair02a.mdl")
			
		else
		
			self.CopilotSeat:SetModel( "models/nova/jeep_seat.mdl" )
		
		end
		
		self.CopilotSeat:SetKeyValue( "LimitView", "60" )
		self.CopilotSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		local seq = ACT_DRIVE_AIRBOAT
		if( self.CopilotWeightedSequence != nil ) then
			
			seq = self.CopilotWeightedSequence
		
		end
		
		self.CopilotSeat.HandleAnimation = function( /*v, */p ) return p:SelectWeightedSequence( seq ) end
		
		
		if( self.CopilotAngle != nil ) then
			
			self.CopilotSeat:SetAngles( self:GetAngles() + self.CopilotAngle )
		
		else
		
			self.CopilotSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
		
		end
		
		-- self.CopilotSeat.IsTankCopilotGunnerSeat = true
		self.CopilotSeat.isChopperGunnerSeat = true
	
		
		if( self.HasTower ) then
		
			self.CopilotSeat:SetParent( self.Tower )
			
		else
			self.CopilotSeat:PhysicsDestroy()
			self.CopilotSeat:SetParent( self )
			
		end
			
		if( self.CopilotFollowBody == true ) then
			
			self.CopilotSeat:SetParent(self)
			
		end
		if( self.HasMGun ) then
			if( self.ComplexMGun) then
                self.MgunTower:SetParent( self.CopilotSeat )
            end
			self.MGun:SetParent( self.CopilotSeat )
			self.CopilotSeat.MountedWeapon = self.MGun
			
		end
		
		self.CopilotSeat:SetColor( Color( 0,0,0,0 ) )
		self.CopilotSeat:SetRenderMode( RENDERMODE_TRANSALPHA )
		self.CopilotSeat:SetSolid( SOLID_NONE )
		self.CopilotSeat:Spawn()
		table.insert( self.ValidSeats, { self.CopilotSeat, "enter" } )
		
	end
	
	--2493

	

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 100000 * self.TankType )
		self.PhysObj:SetDamping( 0.721, 0.721 ) -- assume linear because lazy
		
	end
	
	self.UpdateTransmitState = function() return TRANSMIT_aLWAYS end
	
	--Pilot seat
	local SeatPos
	
	if ( self.HasCockpit ) then
	
		SeatPos = self.SeatPos
		
	else
	
		SeatPos =  Vector(0,0,40)
		
	end
	
	self.PilotSeat = ents.Create( "prop_vehicle_prisoner_pod" )
	self.PilotSeat:SetPos( self:LocalToWorld( SeatPos) )
	self.PilotSeat:SetModel( "models/nova/jeep_seat.mdl" )
	self.PilotSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
	self.PilotSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_DRIVE_AIRBOAT ) end
	self.PilotSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
    self.PilotSeat:SetSolid( SOLID_NONE )
    self.PilotSeat:SetMoveType( MOVETYPE_NONE )
    -- self.PilotSeat:PhysicsInit( SOLID_NONE )
	
	self.PilotSeat:PhysicsDestroy()
	self.PilotSeat:SetParent( self )
	
	if( self.LimitView ) then
	
		self.PilotSeat:SetKeyValue( "LimitView", "1" )
	
	else
		
		self.PilotSeat:SetKeyValue( "LimitView", "0" )
	
	end
	
	self.PilotSeat:Fire("lock","",0)
	self.PilotSeat:SetColor( Color( 0,0,0,0 ) )
	self.PilotSeat:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.PilotSeat:Spawn() 

	--Artillery view camera
	-- if self.IsArtillery then
	-- self.ArtilleryCam = ents.Create("prop_physics")	 
	-- self.ArtilleryCam:SetModel("models/dav0r/camera.mdl")
	-- self.ArtilleryCam:SetColor(255,255,255,0)
	-- self.ArtilleryCam:SetPos( self:GetPos() + self:GetUp() * self.CamUp )
	-- self.ArtilleryCam:SetAngles( self.Tower:GetAngles() )
	-- self.ArtilleryCam:Spawn()
	
--	self.ArtilleryCam:SetSolid(SOLID_NONE) //else it go through the world. :/
	-- end
	
	if( !self.ArmorThicknessFront ) then
		
		self.ArmorThicknessFront = 0.17 + self.TankType/100
		self.ArmorThicknessRear = 0.1 + self.TankType/100
		self.ArmorThicknessSide = 0.14 + self.TankType/100
	
	end
	-- print( self.ArmorThicknessFront )
	
	if( type( self.HeadLights ) == "table"  && TankHeadlights > 0  ) then
		
		-- self.HeadLights.Lamps = {}
		self.HeadLightsToggle = true
		self.HeadLightsLast = CurTime()
		self.HeadLights.Lamps = {}
		
		for i=1,#self.HeadLights.Pos do
			
			local c = self.HeadLights.Colors[i]
			
			self.HeadLights.Lamps[i] = ents.Create("env_projectedtexture")
			self.HeadLights.Lamps[i]:SetParent( self )
			self.HeadLights.Lamps[i]:PhysicsDestroy()
			self.HeadLights.Lamps[i]:SetPos( self:LocalToWorld( self.HeadLights.Pos[i] ) )
			self.HeadLights.Lamps[i]:SetLocalAngles( self:GetAngles() + self.HeadLights.Angles[i] )
			self.HeadLights.Lamps[i]:SetAngles( self:GetAngles() /* + self.HeadLights.Angles[i] */ )
			self.HeadLights.Lamps[i]:SetKeyValue( "enableshadows", 1 )
			self.HeadLights.Lamps[i]:SetKeyValue( "farz", 2048 )
			self.HeadLights.Lamps[i]:SetKeyValue( "nearz", 8 )
			self.HeadLights.Lamps[i]:SetKeyValue( "lightfov", 65 )
			self.HeadLights.Lamps[i]:SetKeyValue( "lightcolor", tostring( c.r.." "..c.g.." "..c.b)  ) -- Yellowish to look worn
			self.HeadLights.Lamps[i]:SetKeyValue( "Appearance ", self.HeadLightProjectionPattern ) -- Slight flickering
			self.HeadLights.Lamps[i]:Spawn()

		end
		
		self.HeadLightSprites = {}
		self:CreateHeadlightSprites()
		self:SetNetworkedBool( "Tank_Headlights", self.HeadLightsToggle )
		
		self:TankToggleHeadLights()
		
		if( type(self.TubePos) == "table" && type(self.Tower) != "table" ) then
			
			self.LastSmoke = CurTime()
			self.SmokeTubes = {}
			for i=1,#self.TubePos do
				
				self.SmokeTubes[i] = ents.Create("prop_physics")
				self.SmokeTubes[i]:SetPos( self:LocalToWorld( self.TubePos[i] ) )
				self.SmokeTubes[i]:SetAngles( self:GetAngles() + self.TubeAng[i] )
				self.SmokeTubes[i]:SetModel( "models/airboatgun.mdl") -- I like this model mkay.
				self.SmokeTubes[i]:SetParent( self.Tower )
				self.SmokeTubes[i]:SetSolid( SOLID_NONE )
				self.SmokeTubes[i]:Spawn()
				self.SmokeTubes[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
				self.SmokeTubes[i]:SetColor( Color( 0,0,0,0 ) )
				
			
			end
			
			
		
		end
	
	end
	
	if( self.ComplexTracks ) then
	
			self.TrackEntities = {}
			self.TrackWelds  = {}
			self.TWheels = {}
			self.TWWelds = {}
			
			for i=1,#self.WheelPositions do
				
				self.TWheels[i] = ents.Create("tank_track_entity")
				self.TWheels[i]:SetModel( self.TrackWheels[i] )
				self.TWheels[i]:SetPos( self:LocalToWorld( self.WheelPositions[i] ) )
				if( self.HideTrucks ) then
					
					self.TWheels[i]:SetColor( Color ( 0,0,0,0 ) )
					
				else
				
					self.TWheels[i]:SetColor( Color ( 255,255,255,255 ) )
					
				end
				
				self.TWheels[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
				
				
				self.TWheels[i]:SetAngles( self:GetAngles() )
				self.TWheels[i].HealthVal = self.HealthVal/2
				self.TWheels[i].InitialHealth = self.InitialHealth/2
				self.TWheels[i]:SetOwner( self )
				self.TWheels[i]:Spawn()
				self.TWheels[i]:SetSolid( SOLID_VPHYSICS )
				self.TWheels[i].Weld = constraint.Weld( self.TWheels[i], self, 0, 0, 0, true )
				self.TWheels[i].Owner = self
				
				-- self.TrackEntities[i]:GetPhysicsObject():SetMass( 500000 )
			
				if( type( self.TrackEntities ) == "table" ) then
					
					self.TrackEntities[i] = ents.Create("prop_physics")
					self.TrackEntities[i]:SetModel( self.TrackModels[i] )
					self.TrackEntities[i]:SetPos( self:LocalToWorld( self.WheelPositions[i] - (self.TrackOffset or Vector( 0,0,4 ) ) ) )
					self.TrackEntities[i]:SetAngles( self:GetAngles() )
					self.TrackEntities[i]:SetOwner( self )
					self.TrackEntities[i]:Spawn()
					self.TrackEntities[i].Owner = self
					self.TrackEntities[i].Weld = constraint.Weld( self.TrackEntities[i], self.TWheels[i], 0, 0, 0, true )
					self.TrackEntities[i].HealthVal = self.HealthVal/2
					self.TrackEntities[i].InitialHealth = self.InitialHealth/2
					self.TrackEntities[i]:GetPhysicsObject():SetMass( 4000 )
					self.TrackEntities[i]:SetCustomCollisionCheck( true )
					-- self.TWheels[i]:GetPhysicsObject():SetMass( 0 )
					
				end
				
				
					
			-- print( "Adding Track #"..i, self.TrackEntities[i] )
			
			end
	
	else
	
		if( type( self.TrackPositions ) == "table" && #self.TrackPositions > 0 ) then
			
			self.TrackEntities = {}
			self.TrackWelds  = {}
			self.TWheels = {}
			self.TWWelds = {}
			
			for i=1,#self.TrackPositions do
				
				if( self.PrototypeSuspension ) then 
					
					self.TrackEntities[i] = ents.Create("prop_ragdoll")
				
				else
				
					self.TrackEntities[i] = ents.Create("tank_track_entity")
				
				end
			
				self.TrackEntities[i]:SetModel( self.TrackModels[i] )
				self.TrackEntities[i]:SetPos( self:LocalToWorld( self.TrackPositions[i] - Vector( 0,0,4 )) )
				self.TrackEntities[i]:SetCustomCollisionCheck( true )
				if( self.HideTrucks ) then
				
					self.TrackEntities[i]:SetColor( Color ( 0,0,0,0 ) )
					self.TrackEntities[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
				
				else
				
					self.TrackEntities[i]:SetColor( Color ( 255,255,255,255 ) )
					
				end
				if( self.TrackAngles ) then
				
					self.TrackEntities[i]:SetAngles( self:GetAngles() + self.TrackAngles[i] )
				
				else
				
					self.TrackEntities[i]:SetAngles( self:GetAngles() )
				
				end
				
				self.TrackEntities[i]:SetOwner( self )
				self.TrackEntities[i]:Spawn()
				self.TrackEntities[i].Owner = self
				self.TrackEntities[i].HealthVal = self.HealthVal/3
				self.TrackEntities[i].InitialHealth = self.InitialHealth/3
				self.TrackEntities[i].Weld = constraint.Weld( self.TrackEntities[i], self, 0, 0, 0, true )
				if( self.PrototypeSuspension ) then 
					
					
					
					local track = self.TrackEntities[i]
					-- track:GetPhysicsObject():SetMass( 111000 )
					timer.Simple( 0, function() 
							
							if( IsValid( track ) && IsValid( self ) ) then 
							-- constraint.Rope( track,
											-- track, 
											-- 8, 
											-- 23, 
											-- Vector(), 
											-- Vector(), 
											-- 45, 
											-- 0, 
											-- 0, 
											-- 1, 
											-- "cable/rope", 
											-- false )
								construct.SetPhysProp( track, track, 0, nil,  { GravityToggle = true, Material = "ice" } ) 
								-- local bone = track:TranslateBoneToPhysBone( 23 ) 
								-- local physbone = track:GetPhysicsObjectNum( bone )
								-- track.Weld2 = constraint.Weld( track, self, 23, 0, 0, false, false  )
								-- print( constraint.CanConstrain ( track, 23 ) )
								-- print("alllaaah akbarrr!!11")
								-- print( physbone:GetMass() )
								-- print( track:GetBoneName( 23 ))
							end 
						
					end )
					 
				 else 
				
					self.TrackEntities[i]:GetPhysicsObject():SetMass( 4000 )
					
					self.TrackEntities[i]:SetSolid( SOLID_NONE )
					-- self.TrackEntities[i]:PhysicsDestroy()
					
				end 
				
				-- self.TrackEntities[i]:GetPhysicsObject():SetMass( 500000 )
			
				if( type( self.TrackWheels ) == "table" ) then
					
					if( self.PrototypeSuspension ) then 
						
						-- self.TrackEntities[i] = ents.Create("prop_ragdoll")
						self.TWheels[i] = ents.Create("prop_ragdoll")
						
					else
					
						self.TWheels[i] = ents.Create("prop_physics")
						
					end 
					
					self.TWheels[i] = ents.Create("prop_physics")
					self.TWheels[i]:SetModel( self.TrackWheels[i] )
					self.TWheels[i]:SetPos( self:LocalToWorld( self.TrackPositions[i] - (self.WheelOffset or Vector( 0,0,4 ) ) ) )
					self.TWheels[i]:SetAngles( self:GetAngles() )
					self.TWheels[i]:SetOwner( self )
					self.TWheels[i]:Spawn()
					self.TWheels[i].Owner = self
					self.TWheels[i].Weld = constraint.Weld( self.TWheels[i], self.TrackEntities[i], 0, 0, 0, true )
					-- self.TWheels[i]:GetPhysicsObject():SetMass( 0 )
					
				end
				
				
					
			-- print( "Adding Track #"..i, self.TrackEntities[i] )
			
			end

			
		end
	
	end
	if( self.PrototypeSuspension ) then
		
	
	end 
	
	
	if( self.WheelAxles ) then
		
		self.DriveWheels = {}
		self.WheelSockets = {}
		-- local count = 
		for i=1,#self.WheelAxles do
			
			-- local pos =
			-- pos.x = pos.x/2
			-- if( i <= count/2 ) then
				-- pos.x = -10
			-- end
			
			self.WheelSockets[i] = ents.Create("prop_physics")
			self.WheelSockets[i]:SetPos( self:LocalToWorld(  self.WheelAxles[i] ) )
			self.WheelSockets[i]:SetAngles( self:GetAngles() + self.WheelAngles[i] )
			self.WheelSockets[i]:SetModel( "models/dav0r/hoverball.mdl" )
			self.WheelSockets[i]:Spawn()
			self.WheelSockets[i]:SetOwner( self )
			-- self.WheelSockets[i]:SetRenderMode( RENDERMODE_NONE )
			self.WheelSockets[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
			self.WheelSockets[i]:SetColor( Color( 0,0,0,0 ) )
			
			
			self.WheelSockets[i].Weld = constraint.Weld( self, self.WheelSockets[i] ,0,0, 0, true, true )
			-- print( self.WheelSockets[i].Weld )
			self.DriveWheels[i] = ents.Create("tank_car_wheel")
			self.DriveWheels[i]:SetPos( self:LocalToWorld(  self.WheelAxles[i] ) )
			self.DriveWheels[i]:SetAngles( self:GetAngles() + self.WheelAngles[i] )
			self.DriveWheels[i]:SetModel( self.WheelMdls[i] )

			self.DriveWheels[i]:Spawn()
			self.DriveWheels[i].Owner = self
			self.DriveWheels[i].Socket = self.WheelSockets[i]
			self.DriveWheels[i]:SetFriction( 100 )
			-- if(  ) then
			

			
			-- print( self.DriveWheels[i].InitialHealth  )
			self.DriveWheels[i].BulletProof = ( self.TankType != TANK_TYPE_CAR )
			
			-- end
			
			self.DriveWheels[i]:SetOwner( self )
			local Radius = ( self.DriveWheels[i]:OBBMaxs() - self.DriveWheels[i]:OBBMins() ):Length()  / math.pi
			
			self.DriveWheels[i]:PhysicsInitSphere( Radius, self:GetMaterial() )
			self.DriveWheels[i]:SetCollisionBounds( Vector( -Radius, -Radius, -Radius ), Vector( Radius, Radius, Radius ) )
			
			local wp = self.DriveWheels[i]:GetPhysicsObject()
			local wp2 = self.WheelSockets[i]:GetPhysicsObject()
			-- avoid complete black hole effect spazz out.
			wp:SetMass( self.WheelMass or 6000 )
			wp2:SetMass( self.WheelHubMass or 8500 )
			-- the axis offsets
			local LPos1 = wp:WorldToLocal( self.DriveWheels[i]:GetPos() )
			local LPos2 = wp2:WorldToLocal( self.WheelSockets[i]:GetPos() )--self.WheelAxles[i] + Vector( 0, 1, 0 )
			
			-- phys attributes
			self.DriveWheels[i].Axis = constraint.Axis( self.DriveWheels[i], self.WheelSockets[i], 0, 0, LPos1, LPos2+Vector(0,1,0), 0, 0, 500, 1 )
			construct.SetPhysProp( self, self.DriveWheels[i], 0, nil,  { GravityToggle = false, Material = "phx_tire_normal" } ) 
			constraint.NoCollide( self.WheelSockets[i], self, 0, 0)	
			constraint.NoCollide( self.DriveWheels[i], self, 0, 0)	
			constraint.NoCollide( self.WheelSockets[i], self.DriveWheels[i], 0, 0)	
						
			if( self.TankType == TANK_TYPE_CAR ) then
				
				self.DriveWheels[i].InitialHealth = self.InitialHealth / 8
				self.DriveWheels[i].HealthVal = self.InitialHealth / 8
				
			else
			
				self.DriveWheels[i].InitialHealth = self.InitialHealth / 4
				self.DriveWheels[i].HealthVal = self.InitialHealth / 4
			
			end 
			
		end
		-- try and imitate axles by welding the two centre props. 
		-- this only works because we group the vectors in WheelAxles like if they were wheels attached to an axle.
		local _max = #self.WheelSockets
		local a,b
		for i=1,_max do
			
			local new = i+1
			a,b =  self.WheelSockets[i], self.WheelSockets[new]
			-- a:SetParent( self )
			if( new <= _max && IsValid( a ) && IsValid( b ) ) then
				
				local weld = constraint.Weld( a, b, 0, 0, 0, true, true )
			-- self.WheelSockets[i].Weld = constraint.Weld( self, self.WheelSockets[i] ,0,0, 0, true, true )
			end
		
		end
		self:SetNetworkedEntity("NT_DWheel1", self.DriveWheels[1] )
		self:SetNetworkedEntity("NT_DWheel2", self.DriveWheels[2] )
	
	end
	
	-- Use wheel based physics instead of shadow controls.
	if( self.TankNumWheels ) then
	
		local omi,oma = self:OBBMins(), self:OBBMaxs()	
		local MyWidth = ( Vector( 0, oma.x, 0 ) - Vector( 0, omi.x, 0 ) ):Length() / 5
		
		omi.y,oma.y = 0,0
		omi.z,oma.z = 0,0
		
		local MySize = ( omi - oma ):Length()
		if( self.TankTrackY ) then
			
			MyWidth = self.TankTrackY
			
		end
		
		local MyExtraX = 0
		if( self.TankTrackX ) then	
			
			MyExtraX = self.TankTrackX
			
		end
		
		self.PhysWheelPositions = {}
		
		local space = self.TankWheelSpace or 37
		for i=1,self.TankNumWheels/2 do
			
			table.insert( self.PhysWheelPositions, Vector( ( -MySize/2.5 + ( i * space ) ) + MyExtraX, -MyWidth, self.TankTrackZ )  )
			table.insert( self.PhysWheelPositions, Vector( ( -MySize/2.5 + ( i * space ) ) + MyExtraX, MyWidth, self.TankTrackZ )  )
			
		end
			
				
		
		
		self.TankRecoilAngleForce = 0.5
		self.Wheels = {}
		
		local numwheels = #self.PhysWheelPositions
		
		local wang = Angle( 0,0,-90 ) -- lol
		
		for i=1,numwheels do
			
			self.Wheels[i] = ents.Create("prop_physics_override")
			-- self.Wheels[i]:SetModel( "models/props_vehicles/apc_tire001.mdl" )
			self.Wheels[i]:SetModel( "models/combine_Helicopter/helicopter_bomb01.mdl" )
			-- self.Wheels[i]:SetModel( "models/props_phx/wheels/drugster_back.mdl" )
			if( i > numwheels/2 ) then
				
				wang = Angle( 0,0,90 )
			
			end
			
			self.DebugWheels = Developer >= 1
			local Radius = self.TankWheelRadius or  ( self.Wheels[i]:OBBMaxs() - self.Wheels[i]:OBBMins() ):Length()  / math.pi
			
			self.Wheels[i]:SetAngles( self:GetAngles() + wang )	
			self.Wheels[i]:SetPos( self:LocalToWorld( self.PhysWheelPositions[i] ) )

			self.Wheels[i]:SetOwner( self )
			self.Wheels[i].Owner = self
			self.Wheels[i]:Spawn()
			
			self.Wheels[i]:GetPhysicsObject():SetMass( self:GetPhysicsObject():GetMass()  )
			self.Wheels[i]:SetMaterial( "models/debug/debugwhite" )
			-- print( Radius )
			-- Radius = Radius
			self.Wheels[i]:PhysicsInitSphere( Radius, self:GetMaterial() )
			self.Wheels[i]:SetCollisionBounds( Vector( -Radius, -Radius, -Radius ), Vector( Radius, Radius, Radius ) )
			if( self.WheelWeight ) then
			
				self.Wheels[i]:GetPhysicsObject():SetMass( self.WheelWeight )
			
			else
			
				self.Wheels[i]:GetPhysicsObject():SetMass( 900 )
				
			end
			if( !self.DebugWheels ) then
			
				self.Wheels[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
				self.Wheels[i]:SetColor( Color( 0,255,0,0 ) )
			
			end
			
			-- disable physgunning
			self.Wheels[i].IsDriving = true
			
			local LPos1 = self.Wheels[i]:GetPhysicsObject():WorldToLocal( self.Wheels[i]:GetPos() )
			local LPos2 = self.PhysWheelPositions[i]
			
			constraint.NoCollide( self.Wheels[i], self, 0, 0)	
			constraint.NoCollide( self.Wheels[i], self.Tower, 0, 0)	
			constraint.NoCollide( self.Wheels[i], self.Barrel, 0, 0)

			self.Wheels[i].Axis = constraint.Axis( self.Wheels[i], self, 0, 0, LPos1 + Vector( 0, 0, 1 ), LPos2, 0, 0, GetConVarNumber("tank_friction",200), 1 )
			-- print( self.Wheels[i].Axis:GetClass()  )
			construct.SetPhysProp( self, self.Wheels[i], 0, nil,  { GravityToggle = false, Material = "phx_tire_normal" } ) 
																										
			if( self.TrackEntities ) then																							
																									
				for i=1,#self.TrackEntities do
				
					timer.Simple( 0.25, function()
						
						if( IsValid( self ) && IsValid( self.TrackEntities[i] ) ) then
							
							self.TrackEntities[i]:GetPhysicsObject():SetMass( 1000 ) 
									
							constraint.NoCollide( self.Wheels[i], self.TrackEntities[i], 1, 1 )
							
						end
					
					end )
					-- print( e )
					
					-- self.TrackEntities[i]:SetSolid( SOLID_NONE )
					self.TrackEntities[i].Owner = self
					if( self.TWheels != nil ) then
						
						if( IsValid( self.TWheels[i] ) ) then
							
							self.TWheels[i].Owner = self
							-- timer.Simple( 0, function()
						
								-- if( IsValid( self.TWheels[i] ) ) then
									
									-- self.TWheels[i]:GetPhysicsObject():SetMass( 100 ) 
									
									constraint.NoCollide( self.Wheels[i], self.TWheels[i], 1, 1 )
									constraint.NoCollide( self.TrackEntities[i], self.TWheels[i], 1, 1 )
									
								-- end
							
							-- end )
							self.TWheels[i]:SetSolid( SOLID_NONE )
							
						end
						
					
					end
					
				end

			end
			
		end
		
	end
	
	-- it generally a bad idea to run a couple of thousand lines of code when we spawn this thingy, we better delay the spawning of some of the parts.
	timer.Simple( 0.1, function()
		if( !IsValid( self ) ) then return end
		
		if( self.MicroTurretPositions != nil ) then
		
			self.MicroTurrets = {}
			self.MicroBarrels = {}
			
			
			for i=1,#self.MicroTurretPositions do
				
				if( type( self.MicroTurretEnt ) == "table" ) then
					
					self.MicroTurrets[i] = ents.Create( self.MicroTurretEnt[i] )
					
				else
				
					self.MicroTurrets[i] = ents.Create( self.MicroTurretEnt )
					
				end
				
				self.MicroTurrets[i]:SetPos( self:LocalToWorld( self.MicroTurretPositions[i] ) )
				self.MicroTurrets[i]:SetAngles( self:GetAngles() + self.MicroTurretAngles[i] )
				-- self.MicroTurrets[i]:SetModel( self.MicroTurretModels[i] )
				self.MicroTurrets[i]:SetMoveType( MOVETYPE_NONE )
				self.MicroTurrets[i]:SetSolid( SOLID_NONE)
				self.MicroTurrets[i]:PhysicsInit( SOLID_NONE )
				if( self.MicroTurretFollowParentTower ) then
					
					self.MicroTurrets[i]:SetParent( self.Tower )
					
				else
				
					self.MicroTurrets[i]:SetParent( self )
					
				end
				
				
				
				self.MicroTurrets[i]:PhysicsDestroy()
				self.MicroTurrets[i]:SetOwner( self )
				self.MicroTurrets[i].Owner = self
				if( !self.MicroTurretUseOwnHealth ) then
				
					self.MicroTurrets[i].HealthVal = self.HealthVal
					self.MicroTurrets[i].InitialHealth = self.InitialHealth
					
				end
				
				self.MicroTurrets[i]:Spawn()
				
				-- Fucking Turret-Ception right here. 
				timer.Simple( 1, function()
					-- no errors plis
					if( !IsValid( self ) ) then return end
					if( !self.MicroTurrets ) then return end
					
					if( self.MicroTurrets[i].MicroTurrets ) then -- turret-ception
						
						-- we need to go deeper
						local t = self.MicroTurrets[i].MicroTurrets -- Turret....ceptionn
						for i=1,#t do --- turret-ception-ception
							
							-- print( t[1], i  )
							if( IsValid( t[i] ) ) then
								
								table.insert( self.ValidSeats, { t[i], "use" } ) -- somebody stop me
								t[i].ValidSeats = self.ValidSeats
								
							end
							
						end
						
						-- if( self.MicroTurrets[i].ValidSeats ) then
							
							-- table.Merge( self.MicroTurrets[i].ValidSeats, self.ValidSeats )
						
						-- end
					end
					
				end )
				
				self.MicroTurrets[i].ValidSeats = self.ValidSeats
				table.insert( self.ValidSeats, { self.MicroTurrets[i], "use" } )
			
			end
		  
		end
			
			
	end )
	
	timer.Simple( 0.1, function() 
		if( !IsValid( self ) ) then return end
			
		if( self.ATGMPos ) then
			
			-- ENT.ATGMPos = Vector( 0,0,0 )
			-- ENT.ATGMmdl = "models/aftokinito/cod4/american/bradley_atgm.mdl"
			-- ENT.ATGMCooldown = 2.0
			
			self.ATGM = ents.Create("prop_physics")
			self.ATGM:SetPos( self.Tower:LocalToWorld( self.ATGMPos ) )
			self.ATGM:SetAngles( self.Tower:GetAngles() )
			self.ATGM:SetMoveType( MOVETYPE_NONE )
			self.ATGM:SetParent( self.Tower )
			self.ATGM:SetModel( self.ATGMmdl )
			self.ATGM:SetSolid( SOLID_NONE )
			self.ATGM:Spawn()
			
			self.LastATGMAttack = CurTime()
			self:SetNetworkedEntity( "TankATGM", self.ATGM )
			self:SetNetworkedInt("ATGMAmmoCount", self.ATGMAmmoCount )
			
		end
		-- Static Secondary Machineguns
		-- ENT.HasStaticSecondaryGuns = true
		-- ENT.StaticGunPositions = { Vector( -62, -44, 21 ),Vector( -62, 44, 21 ) }
		-- ENT.StaticGunParentObject = 2 -- 1 = body, 2 = tower, 3 = barrel
		-- ENT.StaticGunCooldown = 0.25
		
		if( self.HasStaticSecondaryGuns ) then
			
			self.StaticGuns = {}
			self.LastStaticShot = CurTime()
			
			for i=1,#self.StaticGunPositions do
				
				self.StaticGuns[i] = ents.Create("prop_physics_override")
				self.StaticGuns[i]:SetPos( self.Tower:LocalToWorld( self.StaticGunPositions[i] ) )
				self.StaticGuns[i]:SetAngles( self.Tower:GetAngles() + self.StaticGunAngles[i] ) 
				self.StaticGuns[i]:SetParent( self.Tower )
				self.StaticGuns[i]:SetModel( "models/airboatgun.mdl" )
				self.StaticGuns[i]:SetColor( Color( 0,0,0,0 ) )
				self.StaticGuns[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
				self.StaticGuns[i]:SetSolid( SOLID_NONE )
				self.StaticGuns[i]:SetMoveType( MOVETYPE_NONE )
				self.StaticGuns[i]:Spawn()
				self.StaticGuns[i]:SetParent( self.Tower )
				
			end
			
		end 
		
		-- used for rocket carriers that have a visual payload
		-- that should animate with the firing sequence.
		if( self.VisualShells ) then
			
			self.ShellProxies = {}
			for i=1,#self.VisualShells do
				
				self.ShellProxies[i] = ents.Create("prop_physics_override")
				self.ShellProxies[i]:SetPos( self.Barrel:LocalToWorld( self.BarrelPorts[i] ) )
				self.ShellProxies[i]:SetAngles( self.Barrel:GetAngles() )
				self.ShellProxies[i]:SetModel( self.VisualShells[i] )
				self.ShellProxies[i]:SetSolid( SOLID_NONE )
				self.ShellProxies[i]:SetMoveType( MOVETYPE_NONE )
				self.ShellProxies[i]:SetParent( self.Barrel )
				self.ShellProxies[i]:Spawn()
			
			end
		
		
		end
		
		if( self.ChillSeatPositions ) then
			
			self.ChillSeats = {}
			-- print( "WALLA" )
			for i=1,#self.ChillSeatPositions do
				
				self.ChillSeats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
				self.ChillSeats[i]:SetPos( self:LocalToWorld( self.ChillSeatPositions[i] ) )
				self.ChillSeats[i]:SetModel( "models/nova/jeep_seat.mdl" )
				self.ChillSeats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
				self.ChillSeats[i].HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_DRIVE_AIRBOAT ) end
				self.ChillSeats[i]:SetAngles( self:GetAngles() + self.ChillSeatAngles[i] )
				self.ChillSeats[i]:PhysicsDestroy()
				self.ChillSeats[i]:SetParent( self )
				self.ChillSeats[i]:SetSolid( SOLID_NONE )
				self.ChillSeats[i]:SetMoveType( MOVETYPE_NONE )
				
				self.ChillSeats[i]:SetKeyValue( "LimitView", "0" )
				self.ChillSeats[i]:Fire( "lock", "",0 )
				if( GetConVarNumber("developer",0) == 0 ) then
					
					self.ChillSeats[i]:SetColor( Color( 0,0,0,0 ) )
					self.ChillSeats[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
					
				end
				
				self.ChillSeats[i]:Spawn() 
				table.insert( self.ValidSeats, { self.ChillSeats[i], "enter" } )
				
			end
		
		end
		
		if( !self.TankType ) then self.TankType = 1 end
		
		self.MaxFuel = 5000
		self.Fuel = 5000
		self.FuelRate = 0.00025 + self.TankType / 15
		self.FuelRateHeavy = 0.00045 + self.TankType / 20
		self:SetNetworkedInt("TankFuel", self.Fuel )
		self:SetNetworkedInt("TankMaxFuel", self.MaxFuel )
		self.LastFuelUpdate = CurTime()

		if( self.RocketFramePositions ) then
			
			self.RocketFrames = {}
			self.RocketObjects = {}
			self.LastRocketLaunch = CurTime()
			
			for i=1,#self.RocketFramePositions do
				
				self.RocketFrames[i] = ents.Create("prop_physics_override")
				self.RocketFrames[i]:SetPos( self:LocalToWorld( self.RocketFramePositions[i] ) )
				self.RocketFrames[i]:SetAngles( self:GetAngles() + self.RocketFrameAngles[i] )
				self.RocketFrames[i]:SetModel( self.RocketFrameModels[i] )
				self.RocketFrames[i]:PhysicsDestroy()
				self.RocketFrames[i]:SetParent( self )
				self.RocketFrames[i]:SetSolid( SOLID_NONE )
				self.RocketFrames[i]:Spawn()
				
			end
		
			self:ReloadRocketFrame( self.RocketAmmo )
		
		end

		if( self.AmmoStructure ) then
			
			local a,b
			-- generate random tower+barrel but make sure they match
			local rand = table.Random( self.AmmoStructure )
			a = rand.Barrel
			b = rand.Tower
			-- print( a, b )
			-- self.LastBarrel = a
			-- self.LastTower = b
			self.Tower:SetBodygroup(0, b )
			self.Barrel:SetBodygroup( 0, a )
			
			self:UpdateTankAmmoStruct()
		
		end
		
		if( self.CanFloat ) then
			
			local floatval = self.FloatRatio or 4.0
			self:GetPhysicsObject():SetBuoyancyRatio( floatval ) 
			
			if( self.Wheels ) then
				
				-- self:GetPhysicsObject():SetBuoyancyRatio( floatval*10 ) 
			
				for i=1,#self.Wheels do
					
					if( IsValid( self.Wheels[i] ) ) then
						
						self.Wheels[i]:GetPhysicsObject():SetBuoyancyRatio( floatval ) 
						
					end
			
				
				end
				
			end
		end
		
		if( self.HoverRotorWashPoints ) then
			
			self.RotorWashPoints = {}
			
			for k,v in pairs( self.HoverRotorWashPoints ) do
				
				self.RotorWashPoints[k] = ents.Create("prop_physics")
				self.RotorWashPoints[k]:SetPos( self:LocalToWorld( v[2] ) )
				self.RotorWashPoints[k]:SetModel( v[1] )
				self.RotorWashPoints[k]:SetParent( self )
				self.RotorWashPoints[k]:Spawn()
				if( GetConVarNumber("developer",0) == 0 ) then
				
					self.RotorWashPoints[k]:SetRenderMode( RENDERMODE_TRANSALPHA )
					self.RotorWashPoints[k]:SetColor( Color( 0,0,0,0 ) )
					
				end
				
			end
			
			
		end
		
	end )
	
	-- PrintTable( self.ValidSeats  )
	
	if( Developer >= 1 ) then
		
		timer.Simple(1, function() if(IsValid( self ) ) then self:DumpTankTable() end  end )
	
	end
end
-- /*********************************************************************/
-- /*																 	 */																															
-- /*  Entity:DealDamage - Deals Damage to Surrounding Entities.		 */
-- /*  Returns: Nothing												 */
-- /*  Arguments:														 */
-- /*  Damage Type, Damage Amount, Damage Epicenter, 					 */
-- /*  Damage Radius, Do Custom Effect, Effect Name                     */
-- /*                                                                   */
-- /*********************************************************************/
-- function Meta:Neuro_DealDamage( Type, Damage, Pos, Radius, DoEffect, Effect )

function Meta:TankDefaultCollision( data, physobj )
	
	local vel = math.floor(physobj:GetVelocity():Length())
	local he = data.HitEntity
	local delta = data.DeltaTime
	-- print( data.HitEntity:GetClass(), math.floor(data.Speed), data.DeltaTime, vel )
	-- if( data.Speed > 400 && delta >= .7 ) then

		-- self:EmitSound( self.MaterialSoundTables[77][math.random(1,#self.MaterialSoundTables[77])], 511, 100 )
	
	-- end
	if( IsValid( he ) && he.Owner == self ) then return end
	if( IsValid( he ) && IsValid( he:GetParent() ) && he:GetParent().Owner == self ) then return end
	
	if( data.Speed > 470 && delta >= .9 && he:GetClass() == "worldspawn" && !self.IsHoverTank ) then
		
		if( !self.LastImpactSound ) then self.LastImpactSound = CurTime()-1 end
		
		self.BothTracksBroken = true
		self.GearBoxBroken = true
		self:SetNetworkedInt( "EngineGearBoxHealth", 0 )
		self.HealthVal = self.HealthVal - self.InitialHealth * math.Rand(0.19, 0.38 ) 
		
		if( self.LastImpactSound + 1 <= CurTime() ) then
			
			self.LastImpactSound = CurTime()
			self:EmitSound( "wot/global/death"..math.random(1,3)..".wav", 511, 100 )
		
		end
		-- if( self.TankCrew ) then
			
			-- for k,v in pairs( self.TankCrew ) do 
				
				-- if( !v.IsDead ) then
					
					-- v.HealthVal = v.Hea
			
			-- end
		
		-- end
		-- print( "bork2" )
		-- local LT = self.TrackEntities[1]
		-- local RT = self.TrackEntities[2]
		-- local LW = self.TWheels[1]
		-- local RW = self.TWheels[2]
		-- PrintTable( self.TWheels )
		-- print( LT, RT, LW, RW )
		-- if( IsValid( LT ) && IsValid( RT ) && IsValid( LW ) && IsValid( RW  ) ) then
			-- print( "bork3" )
			-- RW:SetParent( RT )
			-- LW:SetParent( LT )
			-- LT:SetSolid( SOLID_VPHYSICS )
			-- RT:SetSolid( SOLID_VPHYSICS )
			
			-- local Lweld, Rweld = self.TrackEntities[1].Weld, self.TrackEntities[2].Weld
			-- Lweld:Remove()
			-- Rweld:Remove()
		
		-- end
		
	end
	
	if( data.DeltaTime < 0.55 ) then return end
	
	-- print( math.floor(self.Speed), math.floor(data.Speed) )
	if( IsValid( data.HitEntity ) ) then
		
		if( data.HitEntity.VehicleType && data.HitEntity.VehicleType == VEHICLE_TANK && data.Speed > 50 ) then
			
			local mi,ma = self:WorldSpaceAABB()
			local damage = (  ( self.Speed + data.Speed + ( ( 4 * ( mi - ma ):Length() ) + self:GetVelocity():Length() )) / 2 ) / 4
			-- damage = math.Clamp( damage, 0, data.HitEntity.InitialHealth * 0.85 )
			-- print( math.floor( damage ) )
			
			if( data.HitEntity.HealthVal <= damage ) then 
				
				data.HitEntity.DontCook = true
							
			end
			
			if( IsValid( self.Pilot ) ) then
				
				-- self.Pilot:Neuro_DealDamage( DMG_VEHICLE, 1, data.HitPos, 128, true, "ManhackSparks" )
				util.BlastDamage( self, self.Pilot, data.HitPos, 64, damage )
			
			else
		
				util.BlastDamage( self, self, data.HitPos, 64, damage )
				
			end
		
		elseif( data.HitEntity:IsPlayer() && data.Speed > 500 && IsValid( self.Pilot ) ) then
			
			util.BlastDamage( self, self.Pilot, data.HitEntity:GetPos(), 1, data.HitEntity:Health()+data.HitEntity:Armor() )
			
		end
		
	
	end
	
end

function Meta:RemoveHeadlightSprites()

	if( self.HeadLightSprites != nil ) then
		
		for i=1,#self.HeadLightSprites do
			
			if( IsValid( self.HeadLightSprites[i] ) ) then
				
				self.HeadLightSprites[i]:Remove()
				
			end
			
		end

	end
	
	if( self.HeadLights.TPos ) then
	
		self:RemoveTaillightSprites()
	
	end
	
	self.HeadLightSprites = {}
	
end


function Meta:RemoveTaillightSprites()

	if( self.TailLightSprites != nil ) then 
		
		for i=1,#self.TailLightSprites do
			
			if( IsValid( self.TailLightSprites[i] ) ) then
				
				self.TailLightSprites[i]:Remove()
				
			end
				
		end
		
	end
	
	self.TailLightSprites = {}

end
	
function Meta:CreateTaillightSprites()
	
	if( !self.HeadLights.TPos ) then return end
		
	self:RemoveTaillightSprites()

	for i=1,#self.HeadLights.TPos do
	
		self.TailLightSprites[i] = ents.Create( "env_sprite" )
		self.TailLightSprites[i]:SetParent( self )	
		self.TailLightSprites[i]:SetPos( self:LocalToWorld( self.HeadLights.TPos[i] ) ) -----143.9 -38.4 -82
		self.TailLightSprites[i]:SetAngles( self:GetAngles() )
		self.TailLightSprites[i]:SetKeyValue( "spawnflags", 1 )
		self.TailLightSprites[i]:SetKeyValue( "renderfx", 0 )
		self.TailLightSprites[i]:SetKeyValue( "scale", 0.48 )
		self.TailLightSprites[i]:SetKeyValue( "rendermode", 9 )
		self.TailLightSprites[i]:SetKeyValue( "HDRColorScale", .75 )
		self.TailLightSprites[i]:SetKeyValue( "GlowProxySize", 2 )
		self.TailLightSprites[i]:SetKeyValue( "model", "sprites/redglow3.vmt" )
		self.TailLightSprites[i]:SetKeyValue( "framerate", "10.0" )
		self.TailLightSprites[i]:SetKeyValue( "rendercolor", " 255 0 0" )
		self.TailLightSprites[i]:SetKeyValue( "renderamt", 255 )
		self.TailLightSprites[i]:Spawn()
	
	end
	
end

function Meta:CreateHeadlightSprites()
	
	self:RemoveHeadlightSprites()
	
	for i=1,#self.HeadLights.Colors do
		
		local c = self.HeadLights.Colors[i]
			
		self.HeadLightSprites[i] = ents.Create( "env_sprite" )
		self.HeadLightSprites[i]:SetParent( self )	
		self.HeadLightSprites[i]:SetPos( self:LocalToWorld( self.HeadLights.Pos[i] ) ) -----143.9 -38.4 -82
		self.HeadLightSprites[i]:SetAngles( self:GetAngles() )
		self.HeadLightSprites[i]:SetKeyValue( "spawnflags", 1 )
		self.HeadLightSprites[i]:SetKeyValue( "renderfx", 0 )
		self.HeadLightSprites[i]:SetKeyValue( "scale", 0.4 )
		self.HeadLightSprites[i]:SetKeyValue( "rendermode", 9 )
		self.HeadLightSprites[i]:SetKeyValue( "HDRColorScale", .75 )
		self.HeadLightSprites[i]:SetKeyValue( "GlowProxySize", 2 )
		self.HeadLightSprites[i]:SetKeyValue( "model", "sprites/light_glow02.vmt" )
		self.HeadLightSprites[i]:SetKeyValue( "framerate", "10.0" )
		self.HeadLightSprites[i]:SetKeyValue( "rendercolor", tostring( c.r.." "..c.g.." "..c.b ) )
		self.HeadLightSprites[i]:SetKeyValue( "renderamt", 255 )
		self.HeadLightSprites[i]:Spawn()
	
	end
	
	if( self.HeadLights.TPos ) then
	
		self:CreateTaillightSprites()
		
	end
	
end

local GPSx,GPSy,GPSz = 0,0,500
function Meta:TankThirdPersonView()
	
	if true then return end
	
	if ( !IsValid( self.Pilot ) ) then 	
		return		
	end
	
	if( !IsValid( self.Tower ) ) then return end
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local tang = self.Tower:GetAngles()
	local pang = self.Pilot:EyeAngles()
	local angspd = self:GetPhysicsObject():GetAngleVelocity()
	
	if ( self.Pilot:GetViewEntity():GetClass() == gmod_cameraprop ) then
		self.Pilot:SetNetworkedBool("UsingCamera", true)
	else
		self.Pilot:SetNetworkedBool("UsingCamera", false)
	end
	
	if  (JetCockpitView == 0 ) then
		if not( self.Pilot:GetViewEntity():GetClass() == gmod_cameraprop ) then
		self.ThirdCam:SetNWString("owner", self.Pilot:Nick())
		self.ThirdCam:SetLocalPos( Vector( -self.CamDist, 2*angspd.z, self.CamUp-2*angspd.y) )
		self.Pilot:SetViewEntity( self.ThirdCam )
	--	self.Pilot:SetMoveType(MOVETYPE_NOCLIP)	
		end 

		if  ( GetConVarNumber("jet_arcadeview") == 1 ) then
		self.ThirdCam:SetAngles( Angle(tang.p, tang.y, 0) )
		else
		self.ThirdCam:SetAngles( tang )		
		end
	else
		if self.HasCockpit then
			if ( self.Pilot:GetViewEntity() == self.ThirdCam ) then
//			self.Pilot:SetViewEntity( self.Pilot )
			end
		else
		self.ThirdCam:SetPos( self:GetPos() + self:GetForward() * -self.CamDist + self:GetUp() * self.CamUp )
		self.ThirdCam:SetAngles( Angle( tang ) )
//		self.Pilot:SetViewEntity( self.ThirdCam )
		end
	self.ThirdCam:SetNWString("owner", self)
	end	

	if  (GetConVarNumber("tank_artilleryview") == 1 ) then
		self:TankArtilleryView()		//Really need to fix all camera's problems :/
	else
		if IsValid(self.ArtilleryCam) then 
			self.ArtilleryCam:SetPos( self:GetPos() + self:GetUp() * self.CamUp )
		end
	GPSx,GPSy,GPSz = pos.x,pos.y,pos.z+500
		self.Pilot:SetViewEntity( self.Pilot )
	end
	

end

function Meta:TankArtilleryView()
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local pang = self.Pilot:EyeAngles()
	
	self.Speed = 0
	self.Yaw = 0
	if self.Pilot:KeyDown(IN_FORWARD) then
	GPSx = GPSx - 50 
	end
	if self.Pilot:KeyDown(IN_BACK) then
	GPSx = GPSx + 50
	end	
	if self.Pilot:KeyDown(IN_MOVELEFT) then
	GPSy = GPSy - 50
	end
	if self.Pilot:KeyDown(IN_MOVERIGHT) then
	GPSy = GPSy + 50
	end
	if self.Pilot:KeyDown(IN_SPEED) then
	GPSz = GPSz + 40	
	end
	if self.Pilot:KeyDown(IN_WALK) then
	GPSz = GPSz - 40
	end
		
	if IsValid(self.ArtilleryCam) then 
		if not( self.Pilot:GetViewEntity():GetClass() == gmod_cameraprop ) then
		self.ArtilleryCam:SetNWString("owner", self.Pilot:Nick())
//		self.ArtilleryCam:SetLocalPos( self:WorldToLocal(Vector( GPSx, GPSy, GPSz) ) )
		self.ArtilleryCam:SetPos( self.ArtilleryCam:GetUp()*-GPSx +self.ArtilleryCam:GetRight()*GPSy + self.ArtilleryCam:GetForward()*GPSz  )
		self.ArtilleryCam:SetAngles( Angle(90,pang.y,0) )
		self.Pilot:SetViewEntity( self.ArtilleryCam )
		end 
	end

end

function Meta:ArtilleryStrike()

-- local g = GetConVar( "sv_gravity" ) // or self:GetGravity()?
-- local v = 500
-- local theta = math.atan( ( v^2+math.sqrt(v^4-g*(g*x^2+2*y*v^2)) )/(g*x) )

	local theta = self:CalculateTrajectory()
	-- local ang = self:GetAngles()
	local ang = self.Pilot:EyeAngles()
	ang.p = theta
	-- ang.y = -ang.y // why does the barrel aim at the opposite???
	if IsValid( self.Barrel) then
	self.Barrel:SetAngles(ang)
	end
end

function Meta:TankAddLiquidsBase()

	self.DefaultGearBoxHealth = 450
	self.GearBoxHealth = self.DefaultGearBoxHealth
	self:SetNetworkedInt( "EngineGearBoxHealth", self.GearBoxHealth )
	self.GearBoxBroken = false
	
	self.DefaultOilLevel = 100
	self.OilLevel = self.DefaultOilLevel
	self:SetNWFloat( "EngineOilLevel", self.OilLevel )
	self.OilPumpBroken = false
	self.OilLeaking = false
	
	self.EngineHeatCold = 0
	self.EngineHeatIdle = 100
	self.EngineHeatBoiling = 500
	self.EngineBoilingCooldown = 15
	
	self.EngineFluidCheck = CurTime()
	self.EngineHeat = self.EngineHeatCold
	
	self.MaxFuel = 5000
	self.Fuel = 5000
	self.FuelRate = 0.105
	self.FuelRateHeavy = 0.215
	self:SetNetworkedInt("TankFuel", self.Fuel )
	self:SetNetworkedInt("TankMaxFuel", self.MaxFuel )
	self.LastFuelUpdate = CurTime()
	
end

print( "[NeuroTanks] neurotanksglobal.lua loaded!" )