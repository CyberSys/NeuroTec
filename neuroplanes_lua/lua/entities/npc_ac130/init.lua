
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Destroyed 		= false
ENT.Burning 		= false
ENT.Target 			= nil
ENT.HealthVal 		= 5150
ENT.LagCompensate 	= 450
ENT.DeathTimer 		= 0
ENT.RollVal 		= 0
ENT.YawVal 			= 0


local pilots = {
					{"models/player/t_phoenix.mdl"};
					{"models/player/ct_sas.mdl"};
					{"models/player/ct_urban.mdl"};
					{"models/humans/charple02.mdl"};
					{"models/humans/charple04.mdl"};
				}
local CrashDebris = {
					{"models/military2/air/air_130_r.mdl"};
					{"models/military2/air/air_130_r.mdl"};
					{"models/military2/air/air_130_r.mdl"};
					{"models/military2/air/air_130_r.mdl"};
					{"models/props_wasteland/laundry_washer003.mdl"};
					{"models/props_pipes/concrete_pipe001d.mdl"};
					{"models/props_pipes/concrete_pipe001c.mdl"};
					{"models/props_citizen_tech/steamengine001a.mdl"};
					}
local filter = {
					"sent_ac130_105mm_shell",
					"sent_ac130_40mm_shell",
					"sent_ac130_20mm_shell",
					"sent_ac130_howitzer",
					"sent_ac130_vulcan",
					"sent_ac130_gau12a",
					"env_rockettrail",
					"weapon_rpg"
				}
				
for k,v in pairs(CrashDebris) do
	util.PrecacheModel(tostring(v))
end

for k,v in pairs(pilots) do
	util.PrecacheModel(tostring(v))
end

function ENT:Initialize()
	
	self.Guardians = {}
	self.LastAttacked = CurTime()
	self.LastGuardianCall = 0
	
	self.seed = math.random( 0, 1000 )
	self.SpawnPos = self:GetPos()
    self:SetModel( "models/military2/air/air_130_l.mdl")		
    self:PhysicsInit( SOLID_VPHYSICS )  	
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
	-- self:SetHullType( HULL_LARGE )	
    self:SetHealth( self.HealthVal )	
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.HealthVal)
	self:SetAngles( Angle(0,0,0) )
	
	self:SetColor( Color ( 45,45,45,255 ) )
	
	self.LastFlare = CurTime()
	self.LastAttack = CurTime()
	self.LastCheck = CurTime()
	
	// Place us in the skybox
	local tr,trace = {},{}
	tr.start = Vector(0,8000,4000)
	tr.endpos = tr.start + Vector(0,8000,45000)
	tr.filter = self
	tr.mask = MASK_SOLID
	trace = util.TraceLine( tr )
	
	if( trace.HitSky ) then
		
		self:SetPos( Vector( 0, 0, ( 45000 * trace.Fraction ) - 256 )  )
	
	elseif ( !trace.Hit ) then
		
		self:SetPos( Vector( 0, 0, 15000 ) )
	
	elseif( trace.HitNonWorld ) then
			
		print ( "Failed to position AC-130" )
	
	end
	
	
	local cname = {}
	cname[1] 	= "105mm Howitzer"
	cname[2] 	= "20mm Vulcan"
	cname[3] 	= "7.62mm Minigun"
	//cname[2] 	= "40mm Bofors" // Used to have cannons on both sides. Obsolete now.
	//cname[4] 	= "20mm Vulcan"
	//cname[6] 	= "7.62mm Minigun"

	local cpos  = {}
	cpos[1] 	= Vector( -242, 100, 40) // 1× 105 mm M102 howitzer, Left
	cpos[2] 	= Vector( -135, 110, 61) // Vulcan 20mm rear, Left
	cpos[3] 	= Vector( 186, 80, 70 ) // GAU-2/A 7.62mm Gatling gun front, Left
	//cpos[2] 	= Vector( -242, -110, 40) // //Bofors 40mm rear, Right
	//cpos[4] 	= Vector( -135, -105, 61) // Vulcan 20mm rear, Right
	//cpos[6] 	= Vector( 186, -95, 45 ) // GAU-2/A 7.62mm Gatling gun front, Right

	// Weapon Angle
	local cang  = {}
	cang[1] 	= Angle(20,90,0)
	cang[2] 	= Angle(20,90,0)
	cang[3] 	= Angle(20,90,0)
	//cang[2] 	= Angle(20,-90,0)
	//cang[4] 	= Angle(20,-90,0)
	//cang[6] 	= Angle(20,-90,0)

	// Cooldown in seconds
	local cd  	= {}
	cd[1] 		= 2.5
	cd[2] 		= 8
	cd[3] 		= 6
	//cd[2] 		= 3.5
	//cd[4] 		= 8
	//cd[6] 		= 6

	self.Cannons = {}
	self.Cannons.Type = {}
	
	self.Cannons.Type[1] = "sent_ac130_howitzer"
	self.Cannons.Type[2] = "sent_ac130_vulcan"
	self.Cannons.Type[3] = "sent_ac130_gau2a"
	//self.Cannons.Type[2] = "sent_ac130_bofors"
	//self.Cannons.Type[4] = "sent_ac130_vulcan"
	//self.Cannons.Type[6] = "sent_ac130_gau2a"
	
	for i=1, #self.Cannons.Type do
		
		self.Cannons[i] = ents.Create( self.Cannons.Type[ i ] )
		self.Cannons[i]:SetPos( self:GetPos() + cpos[ i ] )
		self.Cannons[i]:SetAngles( self:GetAngles() + cang[ i ] )
		self.Cannons[i]:SetSolid( SOLID_NONE )
		self.Cannons[i]:Spawn()
		self.Cannons[i]:SetParent( self )
		self.Cannons[i]:SetOwner( self )
		self.Cannons[i]:SetPhysicsAttacker( self )
		self.Cannons[i].Cooldown = cd[ i ]
		self.Cannons[i].PrintName = cname[ i ]
		self.Cannons[i].Owner = self
	
	end
	
	self.prop = {}
	local pos = {}
	pos[1] = self:GetPos() + self:GetRight() * 400 + self:GetForward() * 100 + self:GetUp() * 150
	pos[2] = self:GetPos() + self:GetRight() * 190 + self:GetForward() * 100 + self:GetUp() * 150
	pos[3] = self:GetPos() + self:GetRight() * -190 + self:GetForward() * 100 + self:GetUp() * 150
	pos[4] = self:GetPos() + self:GetRight() * -400 + self:GetForward() * 100 + self:GetUp() * 150
	
	for i = 1, 4 do
		
		self.prop[i] = ents.Create("sent_ac130_rotor")
		self.prop[i]:SetAngles( self:GetAngles() )
		self.prop[i]:SetPos(pos[i])
		self.prop[i]:SetSolid( SOLID_NONE )
		self.prop[i]:SetParent( self )
		self.prop[i]:Spawn()
		
	end

	self.CycleTarget = ents.Create("sent_neurotarget")
	self.CycleTarget.Owner = self
	self.CycleTarget:SetPos( Vector( 0, 0, 2048 ) + self:GetRight() * -2048 )
	self.CycleTarget:Activate()
	self.CycleTarget:SetMoveType( MOVETYPE_VPHYSICS )
	self.CycleTarget:Spawn()
	
	self.PhysObj = self:GetPhysicsObject()  	
	
	if (self.PhysObj:IsValid()) then 		
	
		self.PhysObj:Sleep()  
		self.PhysObj:EnableGravity( false ) 
		
	end 
	
	
	// funky random features.
	/*
	 TODO: Inflight view.
	// cockpit view
	
	local pilotpos = {}
	pilotpos[1] = self:GetPos() + self:GetForward() * 325 + self:GetRight() * 20 + self:GetUp() * 125
	pilotpos[2] = self:GetPos() + self:GetForward() * 325 + self:GetRight() * -20 + self:GetUp() * 125
	
	self.Cameras = {}
	
	for i=1,2 do
		
		self.Cameras[i] = ents.Create("prop_physics_override")
		self.Cameras[i]:SetPos( pilotpos[i] )
		self.Cameras[i]:SetAngles( self:GetAngles() )
		self.Cameras[i]:SetParent( self )
		self.Cameras[i]:SetModel( "models/Tools/camera/camera.mdl" )
		self.Cameras[i]:Spawn()
		
	end
	*/
	// Lanterns
	local ShouldDraw = string.find(game.GetMap(),"night") != nil
	if( ShouldDraw )then

		local lpos,lcol = {},{}
		lpos[1] = self:GetPos() + self:GetUp() * 175 + self:GetRight() * 798 + self:GetForward()*-48
		lpos[2] = self:GetPos() + self:GetUp() * 175 + self:GetRight() * -798 + self:GetForward()*-48
		lcol[1] = "255 10 10"
		lcol[2] = "10 255 10"

		for i=1,2 do

			local s = ents.Create( "env_projectedtexture" )
			s:SetPos(lpos[i])
			s:SetAngles(self:GetAngles())
			s:SetParent(self )
			s:SetKeyValue( "enableshadows", 0 )
			s:SetKeyValue( "farz", 600 )
			s:SetKeyValue( "nearz", 8 )
			s:SetKeyValue( "lightfov", 90 )
			s:SetKeyValue( "SpotlightTexture", "effects/flashlight001" )
			s:SetKeyValue( "lightcolor", lcol[i] )
			s:Spawn()
			
		end
	
	end
	
	// Causes NPCs to panic when the AC-130 fires.
	self.Ai_sound = ents.Create("ai_sound")
	self.Ai_sound:SetPos( self:GetPos() )
	self.Ai_sound:SetParent( self )
	self.Ai_sound:SetKeyValue("soundtype","8")
	self.Ai_sound:SetKeyValue("volume","15000")
	self.Ai_sound:SetKeyValue("duration","15")
	self.Ai_sound:Spawn()
	self.Ai_sound:Fire("EmitAISound","",0)
	
	// Let people know the party has arrived.
	player.GetAll()[math.random(1,#player.GetAll())]:EmitSound( "ac-130/US_1mc_enemy_ac130_01.wav", 400, 100 )

	local d = -1
	
	for i=1,4 do
		
		if( i>2 ) then d = 1 end
		
		self.Guardians[i] = ents.Create("npc_ac130_guardian_f16")
		self.Guardians[i]:SetPos( self:GetPos() + self:GetForward() * -math.random( 2000, 6000 ) + self:GetRight()*d*4500 + VectorRand() * 5400 )
		self.Guardians[i]:SetAngles( self:GetAngles() )
		self.Guardians[i]:Spawn()
		self.Guardians[i].Owner = self
		-- if( i == 1 ) then
		
			self.Guardians[i].CycleTarget = self
			self.Guardians[i].Target = self
			
		-- else
			
			-- self.Guardians[i].CycleTarget = self.CycleTarget
			-- self.Guardians[i].Target = self
			
		-- end
		
		
		self.Guardians[i]:SetNetworkedEntity( "Guardian_Object", self )
		
		
	end
	
	self.Owner = self
	
end

function ENT:ScanForEnemiesSpecial()
	
	local Ai_ignoreplayers = GetConVarNumber("ai_ignoreplayers") > 0 // hurr durr testers wanted this.
	local dist = dist or 105000
	local tempd = tempd or 0
	local t = t or self.CycleTarget
	local plrLogic
	
	for k,v in pairs( ents.GetAll() ) do
	
		if ( Ai_ignoreplayers ) then
		
			plrLogic = !v:IsPlayer()
		
		else
		
			plrLogic = v:IsPlayer()
		
		end
		
		if ( v != self && v:GetClass() != self:GetClass() && v:GetClass() != "npc_missile_homer" && self:Visible( v ) ) then
		
			if ( v:IsNPC() || plrLogic || ( v:IsVehicle() && v:GetVelocity():Length() > 10 ) || string.find( v:GetClass(), "npc_" ) != nil  || v.HealthVal )  then
			
				if( v.Destroyed ) then 
				
					return 
				
				end
				
				tempd = self:GetPos():Distance( v:GetPos() )
				
				local ta = ( self:GetPos() - v:GetPos() ):Angle()
				local ma = self:GetAngles()
				local offs = self:VecAngD( ma.y, ta.y )
				
				if ( tempd < dist && v.Coldblooded != true && offs >= 35 && offs <= 120 ) then
					
					dist = tempd
					t = v
					
				end
				
				self.Target = t
				
				if ( DEBUG ) then
				
					debugoverlay.Cross( t:GetPos()+Vector(0,0,128), 64, 1, Color( 25,255,25,185*math.sin(CurTime())*60 ), false )
			
				end
				
			end
			
		end
		
		if ( self.Target == nil || self.Target == NULL || !self.Target ) then //better safe than sorry
		
			self.Target = self.CycleTarget
			
		end
		
	end
	
end

function ENT:CreateBomb( isBunkerBuster, hotspot )

	local bombType = "sent_bunker_buster"

	/*if ( isBunkerBuster ) then
	
		bombType = "sent_bunker_buster"

	else
	
		bombType = "sent_mk82"
	
	end */
	
	local bomb = ents.Create( bombType )
	bomb:SetPos( self:GetPos() + self:GetForward() * -320 + self:GetUp() * -45 )
	bomb:SetAngles( self:GetAngles() )
	bomb:SetOwner( self )
	bomb.Owner = self
	bomb:SetPhysicsAttacker( self )
	bomb.HotSpot = hotspot + self:GetRight() * math.random( -1024, 1024 ) + self:GetForward() * math.random( -1024, 1024 )
	bomb:Spawn()
	bomb:SetVelocity( self:GetVelocity() )
	
	//debugoverlay.Line(self:GetPos(),self:GetPos() + self:GetUp() * -512, 5, Color(255,0,0))
	
end


function ENT:SelectWeapon()

	if( !IsValid( self.Target ) ) then 
		
		return
		
	end
	
	local LEFT,RIGHT,INFRONT,VERYINFRONT = 1,2,3,4
	local ta = ( self:GetPos() - self.Target:GetPos() ):Angle()
	local ma = self:GetAngles()
	local offs = self:VecAngD( ma.y, ta.y )
	local enemyLocation = 0
	
	if ( offs >= 35 && offs <= 120 ) then
		
		enemyLocation = 1 // Left
	
	elseif ( offs <= -35 && offs > -120 ) then
	
		enemyLocation = 2 // Right
		
	elseif ( offs >= -15 && offs <= 15 ) then
	
		enemyLocation = 3 // Infront
	
	else
	
		enemyLocation = 0 // Misc
	
	end
	
	if ( offs >= 150 || offs < -150 ) then
		
		enemyLocation = 4
		
	end
	
	if ( DEBUG ) then
	
		local a = {{1,"Left Side"};{2,"Right Side"};{3,"Infront"};{4,"Very Infront"};{0,"Misc"}}
		local b = "Unknown"
		for k,v in pairs(a) do
			if ( v[1] == enemyLocation ) then
				b = v[2].." ["..v[1].."]"
			end
		end
		print( "\n------------------------------------------\nEnemy Location: "..b )
		
	end

	local count = 0
	-- local BoneIndx = self.Target:LookupBone("ValveBiped.Bip01_Head1") // Head
 	local BoneIndx = 1 // Head
   local HeadPos, BoneAng = self.Target:GetBonePosition( BoneIndx )
	
	local tr,trace = {},{}
	tr.start = self:GetPos() + self:GetUp() * -400 + self:GetForward() * 400
	tr.endpos = HeadPos
	tr.filter = self
	tr.mask = MASK_SOLID
	trace = util.TraceLine( tr )
	
	if ( trace.Hit ) then
		
		for k,v in pairs( ents.FindInSphere( trace.HitPos, 2080 ) ) do
		
			if ( self:Visible( v ) && v:IsNPC() || v:IsPlayer() && v.Coldblooded != true || ( v:IsVehicle() && v:GetVelocity():Length() > 10 ) ) then
			
				count = count + 1
			
			end
	
		end
	
	end
	
	local p = self:GetPos()
	local rdist = math.floor( Vector( p.x, p.y, 0 ):Distance( Vector( self.Target:GetPos().x, self.Target:GetPos().y, 0 ) ) )
	local m = math.floor( p:Distance( Vector( p.x, p.y, self.Target:GetPos().z ) ) )
	local td = math.floor( m * 0.7 ) // Desired Target Distance
	local dist = ( rdist >= td )
	
	if ( DEBUG ) then	
		
		print( "Vaild Targets: "..count.."\n" )	
		print( "Z TDistance: "..tostring(math.floor(m*0.01905)).." meters / "..tostring(m).." units" )
		print( "TDistance: "..tostring(math.floor(rdist*0.01905)).." meters / "..tostring(rdist).." units" )
		print( "Desired TDistance: "..tostring(math.floor(td*0.01905)).." meters / "..tostring(td).." units\n" )
		
	end
	
	if ( count >= 1 && count <= 2 ) then
		
		// special case, moving vehicles needs big bombs.
		if( self.Target:IsVehicle() && self.Target:GetVelocity():Length() > 10 && math.random(1,20) > 17 ) then
			
			if( enemyLocation == LEFT && dist ) then
			
				self:HandleAttack( self.Cannons[1] ) // Howitzer
				
			elseif( enemyLocation == RIGHT && dist  ) then // Obsolete, but it might be useful for something else.
			
			--//	self:HandleAttack( self.Cannons[2] ) // Bofors
			
			end
			
			return
			
		end
		
		if ( enemyLocation == LEFT && dist ) then
			
			if( math.random(1,2) == 2 ) then
			
				self:HandleAttack( self.Cannons[2] ) // Vulcan
			
			else
			
				self:HandleAttack( self.Cannons[3] ) // Minigun
			
			end
			
		elseif( enemyLocation == RIGHT && dist ) then
			
			--//if( math.random(1,2) == 2 ) then
			
			--	//self:HandleAttack( self.Cannons[4] ) // Vulcan
				
			--//else
			
			--	//self:HandleAttack( self.Cannons[6] ) // Minigun
				
			--//end
			
		end
			
	elseif ( count >= 3 ) then
		
		if ( enemyLocation == LEFT && dist ) then
		
			self:HandleAttack( self.Cannons[1] )
			
			--//self:HandleAttack( self.Cannons[6] ) // Minigun
			
		elseif ( enemyLocation == RIGHT && dist ) then
		
			--//self:HandleAttack( self.Cannons[2] )
		
		end
	
	end
	
end

function ENT:HandleAttack(wep)
	
	if( !IsValid( wep ) ) then
	
		return
		
	end
	
	if ( self:GetPos().z < self.Target:GetPos().z ) then 
		
		return
		
	end
	
	if( DEBUG ) then
	
		print("Selected Weapon: "..wep.PrintName.."\n------------------------------------------")

		debugoverlay.Cross( wep:GetPos(), 48, 0.1, Color( 25,25,255,185*math.sin(CurTime())*60 ), false )

	end
	
	for k,v in pairs( self.Cannons ) do
		
		if ( v == wep ) then
			
			if ( self.LastAttack + v.Cooldown <= CurTime() ) then
			
				local tr,trace = {}, {}
				tr.start = wep:GetPos() + wep:GetForward() * 250
				tr.endpos = self.Target:GetPos()
				tr.mask = MASK_SOLID
				tr.filter = self
				trace = util.TraceLine( tr )
				
				if ( trace.HitNonWorld && trace.Entity == self.Target ) then

					v.ShouldAttack = true
					v.Target = self.Target
					self.LastAttack = CurTime()
					
				elseif ( trace.HitWorld && CurTime() - self.LastAttack > 30 ) then // haven't hit anything for 30 seconds, blindfire inc.
					
					v.ShouldAttack = true
					v.Target = self.Target
					self.LastAttack = CurTime()
					
				end
			
			else
				
				v.ShouldAttack = false
				
			end
		
		else
		
			v.ShouldAttack = false
			
		end
		
	end
	
end

local function death(ent)

	if (ent == nil) then 
		
		return 
		
	end
	
	local explo = EffectData()
	explo:SetOrigin(ent:GetPos())
	util.Effect("Explosion", explo)
	
end

function ENT:OnTakeDamage(dmginfo)

	-- print( dmginfo:GetInflictor() )
	for i=1,2 do
		
		if( IsValid( self.Guardians[i] ) ) then
	
			if( self.Guardians[i].Target == self ) then
				
				-- //print( "AC130 is the target" )
				
				if( dmginfo:GetInflictor().HealthVal || dmginfo:GetInflictor():IsPlayer() || dmginfo:GetInflictor():IsNPC() ) then
						
					-- //print("Passed first logic" )
					
					self.LastAttacker = dmginfo:GetInflictor()
					
				elseif( IsValid( dmginfo:GetInflictor().Owner ) ) then
					
					-- //print( "Second logic" )
					self.LastAttacker = dmginfo:GetInflictor().Owner
					
				end
			
			-- //print( self.LastAttacker, self.Guardians[i].Target )
			end
				
			self.Guardians[i].Target = self.LastAttacker 
		
		end
		
		self.LastAttacked = CurTime()
		
	
	end
	if ( self.Destroyed ) then
		
		return 
		
	end
	
	self:TakePhysicsDamage(dmginfo)

	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	
	if ( self.HealthVal < 200 && self.Burning == false ) then
	
		self.Burning = true
		
		for i = 1, 4 do
			
			local engineFlame = ents.Create("env_Fire_trail")
			engineFlame:SetPos( self.prop[ i ]:GetPos() + self.prop[ i ]:GetUp() * math.random( -16, 16 ) )
			engineFlame:SetParent( self.prop[ i ] )
			engineFlame:Spawn()
		
		end
		
	end
		
	if ( self.HealthVal < 5 ) then
	
		self.Destroyed = true
		
		for i = 1, 10 do
		
			local vx = i / 4
			timer.Simple( vx, function() if (IsValid( self ) ) then death( self ) end end )
	
		end
	
	end

end

function ENT:PhysicsSimulate( pobj, delta)

	pobj:Wake()
	local CSC = {}
	CSC.secondstoarrive	= 0.5
	CSC.pos					= self:GetPos() + self:GetForward() * self.LagCompensate + 100
	CSC.angle				= ( self.Target:GetPos() - self:GetPos() ):Angle()
	CSC.maxangular			= 50000
	CSC.maxangulardamp		= 80000
	CSC.maxspeed			= 1000000
	CSC.maxspeeddamp		= 10000
	CSC.dampfactor			= 0.99
	CSC.teleportdistance	= 6000
	CSC.deltatime			= delta
	pobj:ComputeShadowControl(pr)
	
end

function ENT:PlayWorldSound(snd)

	for k, i in pairs( player.GetAll() ) do //I don't know why, but the k, i in pairs somehow fixed an error for me. However, the error might have just been me.
		
		local tr,trace = {}, {}
		tr.start = self:GetPos() + self:GetUp() * -512
		tr.endpos = i:GetPos()
		tr.mask = MASK_SOLID
		tr.filter = self
		trace = util.TraceLine( tr )
	
		if ( trace.HitNonWorld ) then
		
			local norm = ( self:GetPos() - i:GetPos() ):Normalize()
			local d = self:GetPos():Distance( i:GetPos() )
			
			if ( DEBUG ) then
			
				debugoverlay.Cross( i:GetPos() + norm * ( d / 10 ), 32, 0.1, Color( 255,255,255,255 ), false )
			
			end
			
			if( d > 4500 ) then
				
				WorldSound( snd, i:GetPos() + norm * ( d / 10 ), 211, 100   ) // Crappy Sauce Engine can't handle a couple of hundred meters of sound. Hackfix for doppler effect.
			
			else
			
				self:EmitSound( snd, 211, 100 )
			
			end
			
		end
		
	
	end

end

function ENT:GuardianLogic()

	for i=1,#self.Guardians do
		
		if( IsValid( self.Guardians[i] ) ) then
			
			
			self.Guardians[i].CycleOffset = self:GetPos() + self:GetRight() * ( -4000 + ( 4000 * i ) )
			
			if( !IsValid( self.Guardians[i].Target ) ) then self.Guardians[i].Target = self end 
			
			if( self.Guardians[i].Target == self || self.Guardians[i].Target:GetClass() == "npc_ac130_guardianf_16" ) then
				
				self.Guardians[i].Target = self 
				
				if( IsValid( self.LastAttacker ) ) then
					
					self.Guardians[i].Target = self.LastAttacker
					
				end
				
				self.Guardians[i].Speed = 700
			
			end
			
		
			if( IsValid( self.LastAttacker ) ) then	
				
				if( self.LastAttacked + 15 <= CurTime() && IsValid( self.LastAttacker ) ) then
						
					self.LastAttacker = NULL
					self.Guardians[i].Target = self
					
				end
				
				if( IsValid( self.Guardians[i].Target ) && self:GetPos():Distance( self.Guardians[i].Target:GetPos() ) > 9500 ) then	
					
					self.Guardians[i].Target = self
					
				end
			
			elseif( !IsValid( self.LastAttacker ) ) then
				
				if( IsValid( self.Target ) ) then
					
					self.Guardians[i].Target = self.Target
					
				else
				
					self.Guardians[i].Target = self
					
				end
			
			end
			
		end
		
	end
		
end

function ENT:Think()
	
	if ( self.Destroyed == true ) then 
	
		for i = 1, 3 do
		
			local effectdata = EffectData()
			effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-102,102) + self:GetForward() * math.random(-102,102)  )
			util.Effect( "immolate", effectdata )
			self.DeathTimer = self.DeathTimer + 1
	
		end
		
		self:GetPhysicsObject():ApplyForceCenter(self:GetForward()*350 * self:GetUp() * -700 )
		
		if ( self.DeathTimer > 1 ) then
		
			self:DeathFX()
			
		end
		
	end
	
	
	-- self:GuardianLogic()
	
	-- if( !IsValid( self.Guardians[1] ) && !IsValid( self.Guardians[2] ) && self.LastGuardianCall + 300 <= CurTime() ) then
		
		-- self.LastGuardianCall = CurTime()
	
		-- self:EmitSound( "lockon/voices/copyRejoin.mp3", 511, 100 )
		
		-- local d = -1
		
		-- for i=1,2 do
			
			-- if( i>1 ) then d = 1 end
			
			-- self.Guardians[i] = ents.Create("npc_ac130_guardian_f16")
			-- self.Guardians[i]:SetPos( self:GetPos() + self:GetForward() * -3000 + self:GetRight()*d*4300 )
			-- self.Guardians[i]:SetAngles( self:GetAngles() )
			-- self.Guardians[i]:Spawn()
			-- self.Guardians[i].Owner = self
			-- self.Guardians[i].CycleTarget = self
			-- self.Guardians[i].Target = self
			-- self.Guardians[i]:SetNetworkedEntity( "Guardian_Object", self )
			
			
		-- end
		
		-- return 
		
	-- end
		
	local Ai_disabled = GetConVarNumber("ai_disabled") > 0
	
	if( !Ai_disabled ) then
	
		self:ScanForEnemiesSpecial()
	
	end
	
	//self:PlayWorldSound("npc/combine_gunship/dropship_engine_distant_loop1.wav") // Hacky
	
	self.LagCompensate = math.floor( self.PhysObj:GetVelocity():Length() / 2 + 100 )
	self.mVel = self.PhysObj:GetVelocity()
	self.gAng = ( self.CycleTarget:GetPos() - self:GetPos() ):Angle()
	self.mAng =  Angle( 0, self:GetPhysicsObject():GetAngles().y, 0 )
	self.mYaw = self:VecAngD( self.gAng.y, self.mAng.y )

	if ( self.mYaw > 5 ) then

		self.RollVal = self.RollVal - 0.1
		
		if self.RollVal <= -27 then
		
			self.RollVal = -27
		
		end
		
	elseif ( self.mYaw < -5 ) then
		
		self.RollVal = self.RollVal + 0.1
		
		if self.RollVal >= 27 then
		
			self.RollVal = 27
		
		end
		
	elseif ( self.mYaw > -5 && self.mYaw < 5 ) then
		
		self.RollVal = self.RollVal *10
	
	end
		
	local ang = Angle( math.sin( CurTime() - self.seed ) * 2, self:GetPhysicsObject():GetAngles().y, self.RollVal + math.sin( CurTime() - self.seed ) * 3 )
	local p = p or 0
	
	if (self.mYaw > 1.5) then
			
		p = 1.395153
		
	elseif (self.mYaw < -1.5) then
		
		p = -1.395153
		
	end
	
	self.PhysObj:SetAngles( ang + Angle( 0, p, 0 ) )
	self.PhysObj:SetVelocity( self.mVel )
	self.PhysObj:SetVelocity( self:GetForward() * 1500 )
	
	if ( self.LastCheck + 0.5 <= CurTime() && !Ai_disabled ) then
		
		self:SelectWeapon()
		self.LastCheck = CurTime()
		self.Ai_sound:Fire("EmitAISound","",0)
		
	end
	
	local shouldFlare = false
	local validTargets = {}
	local i = 0
	
	for k,v in pairs( ents.GetAll() ) do
	
		if ( v:GetPos():Distance( self:GetPos() ) < 4500 && !table.HasValue( filter, v:GetClass() ) && v:GetOwner() != self && !Ai_disabled && v.Flared != true ) then
			
			if( string.find( v:GetClass(), "missile") 		 != nil || 
				string.find( v:GetClass(), "rocket" ) 		 != nil || 
				string.find( v:GetClass(), "homing" )		 != nil || 
				string.find( v:GetClass(), "heatseaking" )	 != nil || 
				string.find( v:GetClass(), "stinger" ) 		 != nil || 
				string.find( v:GetClass(), "rpg" ) 			 != nil ) then
				
				i = i + 1
				validTargets[i] = v
				
				shouldFlare = true
				
				if ( DEBUG ) then
					
					local p = v:GetPos()
					local b = Vector(128, 128, 128)
					local c = Vector(-128, -128, -128)
					debugoverlay.Text( v:GetPos(), "Locked On", 0.01)
					debugoverlay.Box( p, p + c, p + b,0.01, Color( 255,25,25,255 ), false )
			
				end
				
			end
			
		end
		
	end
	
	if ( shouldFlare ) then
		
		if ( self.LastFlare + 10 <= CurTime() ) then
		
			self.LastFlare = CurTime()
			shouldFlare = false
			
			for i=1,math.random(7,8) do
			
				local x = i/1.95
				timer.Simple( x, function() if( IsValid( self ) ) then self:SpawnFlareSpecial(1, validTargets, i) end end )
			
			end
			
			for i=1,math.random(7,9) do
			
				local x = i/2.4
				timer.Simple( x, function() if( IsValid( self ) ) then self:SpawnFlareSpecial(2, validTargets, i) end end )
			
			end
			
			for i=1,7 do
			
				local x = i/2.2
				timer.Simple( x, function() if( IsValid( self ) ) then self:SpawnFlareSpecial(3, validTargets, i) end end )
			
			end
			
			
		end
		
	end
	
end

function ENT:SpawnFlareSpecial(direction, _ents, i)
	
	local dir = {}
	dir[1] = self:GetPos() + self:GetRight() * math.random(12000,20000) + self:GetUp() * 6000
	dir[2] = self:GetPos() + self:GetRight() * math.random(-20000,-12000) + self:GetUp() * 6000
	dir[3] = self:GetPos() + self:GetUp() * -200
	
	local d = dir[direction]
	
	local fx = EffectData()
	fx:SetOrigin( self:GetPos() + self:GetRight() * ( math.sin( CurTime() - self.seed ) * 100 ) + self:GetUp() * math.random( -50, -10 ) )
	fx:SetScale( 3.0 )
	util.Effect( "HelicopterMegaBomb", fx ) 
	
	local fx = EffectData()
	fx:SetOrigin( self:GetPos() + self:GetRight() * ( math.sin( CurTime() - self.seed ) * 100 ) + self:GetUp() * math.random( -50, -10 ) )
	fx:SetScale( 3.0 )
	util.Effect( "AngelWings", fx ) 

	local f = ents.Create( "nn_flare" )
	f:SetPos( self:GetPos() + self:GetUp() * - 100 + self:GetForward() * -256 )
	f:Spawn()
	f:GetPhysicsObject():ApplyForceCenter( d )
	f:Fire( "kill","", 4.5 )
	f:SetVelocity( self.PhysObj:GetVelocity() )
	
	local num = #_ents
	
	if ( i > 4 ) then
		
		for j = 1, num do
		 
			if ( IsValid( _ents[j] ) ) then
			
				if ( math.random( 1, 5 ) > 4 ) then
				
					_ents[j]:ExplosionImproved()
					_ents[j]:Remove()
					
				else
				
					_ents[j].Target = nil
					_ents[j].Flared = true
					
				end
			
			end
			
		end
	
	end
		
	/*if( i != 3 ) then
		
		implode( self:GetPos() + self:GetUp() * -100 + self:GetRight() * math.random( -2, 2 ), 5, 64, -50000000 )
	
	end*/

end

function ENT:DeathFXSpecial()

	
	// Spawn gibs
	for k, v in pairs( CrashDebris ) do
	
		local cdeb = ents.Create( "prop_physics" )
		cdeb:SetModel( tostring( v[1] ) )
		cdeb:SetPos( self:GetPos() + Vector( math.random( -64, 64 ), math.random( -64, 64 ), math.random( 128, 256 ) ) )
		cdeb:SetSolid( 6 )
		cdeb:SetMaterial("models/props_pipes/GutterMetal01a")
		cdeb:Spawn()
		cdeb:Fire("ignite","",0)
		cdeb:Fire("kill","",15)
		cdeb:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 200000 )
	end
	
	// Spawn dead crew members
	for k,v in pairs( pilots ) do
	
		local p = ents.Create( "prop_ragdoll" )
		p:SetModel( tostring( v[1] ) )
		p:SetPos( self:GetPos() + Vector( math.random( -50, 50 ), math.random( -50, 50 ), 0 ) )
		p:Spawn()
		p:Ignite( 60, 60 )
		p:Fire( "kill", "", 15 )
	
	end
	
	local f1 = EffectData()
	f1:SetOrigin( self:GetPos() )
	util.Effect( "immolate", f1 )
	
	ParticleEffect( "AP_impact_wall", self:GetPos() + self:GetForward() * math.random(-1000,1000), self:GetAngles(), nil )
	
	implode( self:GetPos(), 128, 512, -600000000 ) // blow away the debris
	
	self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav", 511, 100)
	
	self:NeuroTec_Explosion( self:GetPos(), 1024, 3500, 5500, "arty_muzzleflash" )

end

// Cleanup
function ENT:OnRemove()
	
	for i=1,#self.Guardians do
		
		if( IsValid( self.Guardians[i] ) ) then
			
			self.Guardians[i]:DeathFX()
			
		end
	
	end
	
	self.CycleTarget:Remove()
	self:Remove()

end

