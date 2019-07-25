local Meta = FindMetaTable("Entity")
resource.AddSingleFile("crit_hit.wav")
resource.AddSingleFile("crit_received1.wav")
resource.AddSingleFile( "materials/overlays/scope_lens.vmt" )
resource.AddSingleFile( "materials/overlays/scope_lens.vtf" )
resource.AddSingleFile( "materials/scope/sniper.png" )
resource.AddSingleFile( "materials/neuroheadshoticon.vmt")
resource.AddSingleFile( "materials/neuroheadshoticon.vtf")
resource.AddSingleFile("materials/neurogore/blood1.png")
resource.AddSingleFile("materials/neurogore/blood2.png")
resource.AddSingleFile("materials/neurogore/blood3.png")
resource.AddSingleFile("materials/neurogore/blood4.png")
resource.AddFile("models/weapons/v_chainsaw.mdl")
resource.AddFile("models/weapons/w_chainsaw.mdl")
resource.AddFile("materials/models/weapons/v_chainsaw/body.vmt")
resource.AddFile("materials/models/weapons/v_chainsaw/chainsaw.vmt")
resource.AddFile("materials/models/weapons/v_chainsaw/parts.vmt")
resource.AddFile("materials/models/weapons/w_chainsaw/parts.vmt")
resource.AddFile("materials/models/weapons/w_chainsaw/chainsaw_chain.vmt")
resource.AddFile("materials/models/weapons/w_chainsaw/chainsaw.vmt")
resource.AddFile("materials/models/weapons/w_chainsaw/body.vmt")
resource.AddFile("sound/weapons/arch_chainsaw/chainsaw_attack.wav")
resource.AddFile("sound/weapons/arch_chainsaw/chainsaw_die_01.wav")
resource.AddFile("sound/weapons/arch_chainsaw/chainsaw_idle.wav")
resource.AddFile("sound/weapons/arch_chainsaw/chainsaw_start_01.wav")
resource.AddFile("sound/weapons/arch_chainsaw/chainsaw_start_02.wav")
resource.AddFile("materials/scope/")
resource.AddFile("models/killstr3aks/")
resource.AddFile("materials/models/killstr3aks/neuroweapons/acr10/")

CreateConVar("neuroweapons_headshotsound", 1 )

-- hook.Add("PlayerDeathThink", "NeuroWeps_HeadshotGore", function( ply )
	
	-- local rag = ply:GetRagdollEntity()
	-- if(ply.LastHeadshot && ply.LastHeadshot + 5 >= CurTime() && IsValid( rag ) ) then 
		
		-- print( rag, rag:GetPos() )

		-- print( BonePos )
		-- local fx = EffectData()
		-- fx:SetStart( BonePos )
		-- fx:SetOrigin( BonePos )
		-- fx:SetEntity( rag )
		-- fx:SetNormal( Vector(0,0,1) )
		-- fx:SetScale( .1 )
		-- util.Effect( "micro_he_blood", fx )
		
		-- print("sploshie")

	-- end 
	

-- end ) 


function Meta:NeuroWepsDetonatePhysics()
	for k,v in ipairs( ents.FindInSphere( self:GetPos(),( self.Radius or 256 ) / 4 ) ) do 
				
		if( !v.HealthVal ) then 
			
			local vp = v:GetPhysicsObject()
			if( IsValid( vp ) ) then 
				
				--vp:Wake() -- all of this disables unwelding for neurotec weapons
				--vp:EnableMotion( true )
				--vp:EnableGravity( true )
				--vp:EnableDrag( true )
				
			end 
			
			--constraint.RemoveConstraints( v, "Weld" )
			--constraint.RemoveConstraints( v, "Axis" )
		
		end 
			
	end 
	
end 


function Meta:NWFireBullet( ply )
	
	if ( !self ) then // silly timer errors.
		
		return
		
	end
	
	local gun = self.BarrelGhost
	local bulletcount = 1
	local bulletdamage = math.random( 5, 25 )
	local spread = Vector( 0.055, 0.055, 0.055 )
	local muzzle = "MuzzleEffect"
	local muzzleScale = 1.2
    local delay = self.CMGunDelay or 0.018

	local bullet2 = {} 
	bullet2.Num 		= bulletcount
    bullet2.Src = gun:LocalToWorld( Vector( 70, 0, 0 ) )
	bullet2.Dir = gun:GetAngles():Forward()
	bullet2.Filter = { self, self.Tower, self.Barrel, gun }
	bullet2.Attacker = ply
	bullet2.Spread 	= spread
	bullet2.Tracer	= 1
	bullet2.Force	= 5
	bullet2.Damage	= math.random( 5, 25 )
	bullet2.AmmoType = "Ar2"
	bullet2.TracerName 	= "Tracer"
	bullet2.Callback    = function ( a, b, c ) self:TankMountedGunCallback( a, b, c ) end 

	gun:FireBullets( bullet2 )

	self:EmitSound( self.ShootSound, 511, math.random( 70, 100 ) )

	local shell2 = EffectData()
	shell2:SetStart( gun:GetPos() + gun:GetForward() * -4 + gun:GetRight() * 2 + gun:GetUp() * 8)
	shell2:SetOrigin( gun:GetPos() + gun:GetForward() * -4 + gun:GetRight() * 2 + gun:GetUp() * 8)
	util.Effect( "RifleShellEject", shell2 ) 

	
	local e2 = EffectData()
	e2:SetStart( gun:GetPos() + gun:GetForward() * self.BarrelLength )
	e2:SetOrigin( gun:GetPos() + gun:GetForward() *  self.BarrelLength  )
	e2:SetAngle( ghostgun:GetAngles() )
	e2:SetEntity( ghostgun )
	e2:SetAttachment( 1 )
	e2:SetScale( 1.5 )
	util.Effect( "tank_muzzlesmoke", e2 )
	util.Effect( muzzle, e2 )
		
	self:StopSound( self.MGunSound )

	
end

function Meta:NWBulletCallback( a, b, c )

	if ( IsValid( self.MGun ) ) then
	
		local e = EffectData()
		e:SetOrigin( b.HitPos )
		e:SetNormal( b.HitNormal )
		e:SetScale( 0.8 + math.Rand( .2, .9 ) )
		util.Effect("MetalSpark", e)

	end
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end

function Meta:NWeaponsRotation()

	if( !IsValid( self.Tower ) ) then return end
	
	if ( IsValid( self.Pilot ) ) then
		
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

		
		local angg = self:GetAngles()
		angg:RotateAroundAxis( self:GetUp(), -self.offs + 180 )
		self.Tower:SetAngles( LerpAngle( 0.0195, _t, angg ) )
		_t = self.Tower:GetAngles()
		self.Barrel:SetAngles( Angle( barrelpitch, _t.y, _t.r ) )
		
	end

end
function Meta:NWeaponsDefaultInit()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self.LastReminder = CurTime()
	self.IsOnGround = false
	
	self.LastAmmoSwap = CurTime()
	
	if( self.IsAutoLoader ) then
		
		self.Shots = self.MagazineSize
		self:SetNetworkedInt("AutoLoaderShots", self.Shots )
		self:SetNetworkedInt("AutoLoaderMax", self.MagazineSize )
		
	end
	
	// Misc
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	-- // Sound
	-- local esound = {}
	-- esound[1] = "vehicles/diesel_loop2.wav"
	-- esound[2] = "vehicles/diesel_loop2.wav"
	-- esound[3] = "vehicles/diesel_loop2.wav"
	-- self.EngineMux = {}
	
	-- if( self.EngineSounds != nil ) then
		
		-- esound = self.EngineSounds
		
	-- end
	
	-- for i=1, #esound do
	
		-- self.EngineMux[i] = CreateSound( self, esound[i] )
		
	-- end
    -- if self.HasCVol then
        -- self.CEngSound = CreateSound(self, self.TrackSound)
    -- end
	
	-- self.TowerSound = CreateSound( self, self.SoundTower or "vehicles/tank_turret_loop1.wav" )
	self.Turning = false
	self.Pitch = SoundTowerPitch or 100
	
	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	
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
			self.TowerPhys[i] = self.Tower[i]:GetPhysicsObject()
		
		end
		
	
	else
	
		
		self.Tower = ents.Create("prop_physics_override")
		self.Tower:SetModel( self.TowerModel )
		self.Tower:SetPos( self:LocalToWorld( self.TowerPos ) )
		self.Tower:SetParent( self )
		self.Tower:SetSkin( self:GetSkin() )
		self.Tower:SetAngles( self:GetAngles() )
		self.Tower:Spawn()
		self.TowerPhys = self.Tower:GetPhysicsObject()
		if self.HasParts then
			self.Tower:SetKeyValue("SetBodygroup", self.TowerPart)
		end
		
		self.Tower:SetOwner(self)
		
		if( !self.HasTower ) then
			
			self.Tower:SetNoDraw( true )
			
		end
		
		if ( self.TowerPhys:IsValid() ) then
		
			self.TowerPhys:Wake()
			self.TowerPhys:EnableGravity( true )

		end
		
	end
	
	if( type(self.BarrelPos) == "table" ) then
		
		self.Barrel = {}
		self.BarrelPhys = {}
		self.BarrelGhost = {}
		
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
			self.BarrelPhys[i] = self.Barrel[i]:GetPhysicsObject()	
			self.BarrelGhost[i] = ents.Create("prop_physics")
			self.BarrelGhost[i]:SetModel( "models/airboatgun.mdl")
			self.BarrelGhost[i]:SetPos( self.Barrel[i]:GetPos() )
			self.BarrelGhost[i]:SetAngles( self.Barrel[i]:GetAngles() )
			self.BarrelGhost[i]:SetParent( self.Barrel[i] )
			self.BarrelGhost[i]:Spawn()
			self.BarrelGhost[i]:SetNoDraw( true )
			
			
		end
	
	else
	
		
		self.Barrel = ents.Create("prop_physics_override")
		self.Barrel:SetModel( self.BarrelModel )
		self.Barrel:SetPos( self:LocalToWorld( self.BarrelPos ) )
		self.Barrel:SetParent( self.Tower )
		self.Barrel:SetSkin( self:GetSkin() )
		self.Barrel:SetAngles( self:GetAngles() )
		self.Barrel:Spawn()
		self.BarrelPhys = self.Barrel:GetPhysicsObject()	
		self.BarrelGhost = ents.Create("prop_physics")
		self.BarrelGhost:SetModel( "models/airboatgun.mdl")
		self.BarrelGhost:SetPos( self.Barrel:GetPos() )
		self.BarrelGhost:SetAngles( self.Barrel:GetAngles() )
		self.BarrelGhost:SetParent( self.Barrel )
		self.BarrelGhost:Spawn()
		self.BarrelGhost:SetNoDraw( true )
		
		if self.HasParts then
		
			self.Barrel:SetKeyValue("SetBodygroup", self.BarrelPart)
			
		end      
		
		self.Barrel:SetOwner(self)
		
	end    

	if ( type( self.BarrelPhys ) != "table" && self.BarrelPhys:IsValid() ) then
	
		self.BarrelPhys:Wake()
		self.BarrelPhys:EnableGravity( true )

	end
	
	-- Create copilot seat if the variable is set
	if( self.CopilotPos ) then
		
		self.CopilotSeat = ents.Create( "prop_vehicle_prisoner_pod" )
		self.CopilotSeat:SetPos( self:LocalToWorld( self.CopilotPos ) )
		self.CopilotSeat:SetModel( "models/nova/jeep_seat.mdl" )
		self.CopilotSeat:SetKeyValue( "LimitView", "60" )
		self.CopilotSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.CopilotSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_DRIVE_AIRBOAT ) end
		self.CopilotSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
		-- self.CopilotSeat.IsTankCopilotGunnerSeat = true
		self.CopilotSeat.isChopperGunnerSeat = true
		
		if( self.HasTower ) then
		
			self.CopilotSeat:SetParent( self.Tower )
			
		else
		
			self.CopilotSeat:SetParent( self )
			
		end
		
		if( self.HasMGun ) then
			
			self.MGun:SetParent( self.CopilotSeat )
			self.CopilotSeat.MountedWeapon = self.MGun
			
		end
		
		self.CopilotSeat:SetNoDraw( true )
		self.CopilotSeat:Spawn()
	
	end
	
	--2493

	

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 10000 )
		
	end

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
    self.PilotSeat:SetParent( self )
	self.PilotSeat:SetKeyValue( "LimitView", "0" )
	self.PilotSeat:SetNoDraw( true )
	self.PilotSeat:Spawn()  

	self.UnUsed = true
	
	
end

print( "[NeuroWeapons] NeuroWeaponsGlobal.lua loaded!" )