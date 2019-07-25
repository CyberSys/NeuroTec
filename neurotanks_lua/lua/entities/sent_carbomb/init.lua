
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.HealthVal = 150
ENT.Destroyed = false

function ENT:SpawnFunction( ply, tr)
	
	if( !IsValid( ply.CarBomb ) ) then
	
		local SpawnPos = tr.HitPos + tr.HitNormal * 40
		local vec = ply:GetAimVector():Angle()
		local newAng = Angle(0,vec.y,0)
		local ent = ents.Create( "sent_carbomb" )  
		ent:SetPos( SpawnPos )
		ent:SetAngles( newAng )
		ent:Spawn()
		ent:Activate()
		ent:GetPhysicsObject():Wake()
		ent.Owner = ply
		
		ply.CarBomb = ent
		
		ply:PrintMessage( HUD_PRINTCENTER, "Press Undo to detonate or Use to launch." )
		
		return ent
		
	else
		
		ply:PrintMessage( HUD_PRINTCENTER, "Don't be a mingebag." )
	
	end
	
	return NULL

end

function ENT:Initialize()
	
	self.WheelCoords = { 
						{ Vector( 53, 30, -3 ),Vector( -62, 30, -3 ), Vector( 53, -33, 0 ),Vector( -62, -30, -3 ) },
						{ Vector( 59, 31, -17 ), Vector( -62, 31, -17 ) ,  Vector( 59, -31, -17 ), Vector( -62, -31, -17 ) },
						{ Vector( 50, 31, -15 ), Vector( -54, 31, -15 ), Vector( 51, -30, -15 ), Vector( -54, -31, -15 ) },
						{ Vector( 49, 27, -18 ), Vector( -45, 27, -18 ),  Vector( 49, -27, -18 ), Vector( -45, -27, -18 ) },
						{ Vector( 48, 28, -18 ), Vector( -64, 28, -18 ), Vector( 48, -30, -18 ), Vector( -64, -30, -18 ) },
						{ Vector( 47, 39, -27 ), Vector( -79, 39, -25 ), Vector( 47, -42, -27 ), Vector( -79, -42, -25 ) }
					}
	self.TailLightCoords = {
							{ Vector( -76, 30, -2 ), Vector( -76, -30, -2 ) },
							{ Vector( -110, 29, 5 ), Vector( -110, -29, 5 ) },
						{ Vector( -101, -24, 2 ) },
							{ Vector( -82, 30, -1 ), Vector( -82, -28, -1 ) },
							{ Vector( -111, 17, 3 ), Vector( -111, -25, 1 ) },
							{ Vector( -120, -34, -2 ), Vector( -120, 29, 4 ) }
						}

	local seatpositions = { 
						Vector( 0, 16, 10 ), -- first car
						Vector( 0, 13, -13 ), -- 2nd car
						Vector( 0, 14, -15 ), -- 3rd car
						Vector( -0, 10, -14 ), -- 4th car
						Vector( -11, 16, -10 ), -- 5th car
						Vector( 40, 15, -7 ) -- 6th car
						
						}
	local models = {
					"models/sillirion/carbomb.mdl",
					"models/props_vehicles/car004a_physics.mdl",
					"models/props_vehicles/car003a_physics.mdl",
					"models/props_vehicles/car002b_physics.mdl",
					"models/props_vehicles/car005b_physics.mdl",
					"models/props_vehicles/van001a_physics.mdl"
					}
					
	local Donk = {
	"models/mechanics/wheels/bmw.mdl", 
	-- "models/mechanics/wheels/rim_1.mdl",
	-- "models/mechanics/wheels/wheel_race.mdl",
	"models/props_phx/normal_tire.mdl",
	-- "models/props_vehicles/carparts_wheel01a.mdl"
	}

	
	self.ModelType = math.random( 1, #models )
					
	self:SetModel( models[self.ModelType]  )
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
        
	
	self.Wheels = {}
	
	local donk_as_fuck = Donk[math.random(1,#Donk)]
	
	print( self:GetModel() )
	
	for i=1,#self.WheelCoords[self.ModelType] do
		
		self.Wheels[i] = ents.Create("prop_physics")
		self.Wheels[i]:SetPos( self:LocalToWorld( self.WheelCoords[self.ModelType][i] ) )
		self.Wheels[i]:SetModel( donk_as_fuck )
		if( i < 3 ) then
		
			self.Wheels[i]:SetAngles( self:GetAngles() + Angle( 0,0,-90 ))
		
		else
		
			self.Wheels[i]:SetAngles( self:GetAngles() + Angle( 0,0,90 ))	

		end
		
		self.Wheels[i]:Spawn()
		constraint.Axis( self.Wheels[i], self,  0, 0, Vector( 0,0,1),self.WheelCoords[self.ModelType][i], 0, 0, 1, 0 )
	
	end
	
	self.Seat = ents.Cre
	
	--

	self.PilotSeat = ents.Create( "prop_vehicle_prisoner_pod" )
	self.PilotSeat:SetPos( self:LocalToWorld( seatpositions[self.ModelType] ) )
	self.PilotSeat:SetModel( "models/nova/jeep_seat.mdl" )
	self.PilotSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
	self.PilotSeat:SetKeyValue( "LimitView", "0" )
	self.PilotSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_DRIVE_AIRBOAT ) end
	self.PilotSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
    self.PilotSeat:SetParent( self )
	self.PilotSeat:Fire("lock","",0)
	-- self.PilotSeat:SetColor( Color( 0,0,0,0 ) )
	-- self.PilotSeat:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.PilotSeat:Spawn() 
	
	self:GetPhysicsObject():SetMass( 350 )
	self.Speed = 0
	self.ESound = CreateSound( self, "JNK_firstgear_noshift" )
	
end

function ENT:Use( ply, ent )
	
	if( !self.Started ) then
		
		-- self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 500000 )
		
		self.Owner = ply

		self:EmitSound( "vehicles/jetski/jetski_no_gas_start.wav", 511, 100 )
		
		timer.Simple( 1.5, 
			function() 
			
			if( IsValid( self ) ) then
			
				self.Started = true
				self:SetNetworkedBool("Started", true )
				
				self.TailLightSprites = {}
				
				for i=1,#self.TailLightCoords[self.ModelType] do
				
					self.TailLightSprites[i] = ents.Create( "env_sprite" )
					self.TailLightSprites[i]:SetParent( self )	
					self.TailLightSprites[i]:SetPos( self:LocalToWorld( self.TailLightCoords[self.ModelType][i] ) ) -----143.9 -38.4 -82
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
					self.TailLightSprites[i]:SetKeyValue( "renderamt", 55 )
					self.TailLightSprites[i]:Spawn()
				
				end
			
				self.ESound:Play()
				
			end
			
		end )
	
	else
		
		local the_d = self.PilotSeat:GetDriver()
		
		if( !IsValid( the_d ) && ply != self.Driver ) then
			-- give it to her
			ply:EnterVehicle( self.PilotSeat )
			self.Driver = ply
			self.TimeSinceEntered = CurTime()
			
		end
	
	end
	

end

function ENT:OnRemove()
	
	self:DoExplosion()


end

function ENT:Think()

	local tr, trace = {},{}
	tr.start = self:GetPos()
	tr.endpos = self:GetPos() + Vector( 0,0,-42 )
	tr.filter = self
	trace = util.TraceLine( tr )

	local d = self.PilotSeat:GetDriver()
				
	if( self.Started && trace.Hit ) then
		
		if( IsValid( d ) ) then
			
			local ta = d:EyeAngles() --( d:GetPos() - self:GetPos() ):Angle()
			local ma = self:GetAngles()
			local offs = self:VecAngD( ma.y, ta.y )	
			offs = math.Clamp( offs, -90, 90 )
			-- print( offs )
			if( self:GetVelocity():Length() > 25 ) then
				
				self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -offs ) )
				
			end
		
		end
		
		if( !IsValid( self.Target ) && !IsValid( d )  ) then
			
			for k,v in pairs( ents.FindInSphere( self:GetPos(), 2048 ) ) do
				
				if( ( v:IsNPC() || v:IsPlayer() ) && v != self.Driver ) then
					
					local ta = ( v:GetPos() - self:GetPos() ):Angle()
					local ma = self:GetAngles()
					local offs = self:VecAngD( ma.y, ta.y )	
					
					if ( offs > -45 && offs < 45 ) then
						
						self.Target = v
						break
						
						
					end
			
			
				end
				
			end
			
			self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, math.sin(CurTime())*15 ) )
			
		elseif( IsValid( self.Target ) && !IsValid( d ) ) then
		
			-- if( self.Target == NULL ) then self.Target = d end
			if( !self.Target:OnGround() ) then self.Target = NULL return end
			
			local ta = ( self.Target:GetPos() - self:GetPos() ):Angle()
			local ma = self:GetAngles()
			local offs = self:VecAngD( ma.y, ta.y )	
			
			-- print( offs )
			
			-- self.Wheels[1]:SetAngles( LerpAngle( 0.1, self.Wheels[1]:GetAngles(), self:GetAngles() + Angle( 0, 90 + offs / 45, 0 ) ) )
			-- self.Wheels[4]:SetAngles( LerpAngle( 0.1, self.Wheels[1]:GetAngles(), self:GetAngles() + Angle( 0, -90 + offs / 45, 0 ) ) )
			
			if( self:GetVelocity():Length() > 25 ) then
				
				self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -offs*5 ) )
				
			end
			-- if ( offs > -85 && offs < 85 ) then
				
				
				
				
			-- end
			
		end
		
		for i=1,#self.Wheels do
			
		
			local fx = EffectData()
			fx:SetStart( self.Wheels[i]:GetPos() )
			fx:SetOrigin( self.Wheels[i]:GetPos() )
			fx:SetEntity( self.Wheels[i] )
			fx:SetScale( 2.0 )
			util.Effect("WheelDust", fx)
			
		
		end
		
		if( IsValid( self.Driver ) ) then
			
			if( self.TimeSinceEntered >= CurTime() + 1.0 && self.Driver:KeyDown( IN_USE ) ) then
					
				self.Driver:PrintMessage( HUD_PRINTCENTER, "Nope" )
				self.Driver:EnterVehicle( self.PilotSeat )
			
			end
			
			if( IsValid( self.Driver ) && self.PilotSeat:GetDriver() == NULL ) then
				
				self.Driver:EnterVehicle( self.PilotSeat )
				self.Driver:PrintMessage( HUD_PRINTCENTER, "This is a one way ride" )
			
			end
			
		end
			
		
		self:GetPhysicsObject():AddAngleVelocity( self:GetAngles():Forward() * 1.5 )
		
		self.Speed = math.Clamp( self.Speed + 2500, 0, 4500 * 100 )
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * self.Speed )
		
		for i=1,#self.Wheels do
			
			if( IsValid( self.Wheels[i] ) ) then
				-- spinning the wheeeeel
				self.Wheels[i]:GetPhysicsObject():AddAngleVelocity( self:GetUp() * 250 )
				
			end
			
		
		end
		
	
	end

end

function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end

	if( self.HealthVal > 0 ) then
	
		self.HealthVal = self.HealthVal - dmginfo:GetDamage()
		self.Owner = dmginfo:GetAttacker()
		
	else
	
		self:Remove()
		
	end
	
end

function ENT:DoExplosion()
	
	
	if( !IsValid( self.Owner ) ) then self.Owner = self end
	if( math.random( 1,4 ) == 3  && self.Owner:IsPlayer() ) then 
		
		self.Owner:PrintMessage( HUD_PRINTTALK, "Something didn't go quite as expected" ) 
		self.Target = self.Owner
		
		return
		
	end
	
	self:EmitSound( "ambient/explosions/exp2.wav", 150, 100 )
	util.BlastDamage( self, self.Owner, self:GetPos(), 512, math.random( 1500, 5500 ))
	
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

	local fx = "VBIED_explosion"
	if( math.random( 1,3 ) == 1 ) then
		
		fx = "VBIED_b_explosion"
		
	end
	
	ParticleEffect( fx, self:GetPos(), self:GetAngles(), nil )
	
	local junkparts = {
	"models/props_vehicles/carparts_axel01a.mdl",
	"models/props_vehicles/carparts_door01a.mdl",
	"models/props_vehicles/carparts_muffler01a.mdl",
	"models/props_c17/TrapPropeller_engine.mdl",
	"models/props_c17/tools_wrench01a.mdl",
	"models/props_canal/mattpipe.mdl",
	"models/gibs/helicopter_brokenpiece_01.mdl"
	}
	
	for i=1,#junkparts do
		
		local junk = ents.Create("prop_physics")
		junk:SetModel( junkparts[i] )
		junk:SetPos( self:GetPos() + Vector( math.random( -32,32 ), math.random( -32,32 ), 0 ) )
		junk:SetAngles( Angle( math.random( 0,360 ),math.random( 0,360 ),math.random( 0,360 ) ) )
		junk:Spawn()
		junk:SetVelocity( self:GetVelocity() )
		junk:SetColor( Color( 0,0,0,0 ) )
		
		if( math.random(1,4 ) == 3 ) then
		
			junk:Ignite( 32,32 )
		
		end
		
		junk:Fire("kill","",10 )
		junk:GetPhysicsObject():ApplyForceCenter( Vector( math.Rand(-1,1),math.Rand(-1,1),math.Rand(-1,1) ) * 250000 )
		
	end
	
	self.ESound:Stop()
	
	for i=1,#self.Wheels do
		
		if( IsValid( self.Wheels[i] ) ) then
		
			self.Wheels[i]:Fire("kill","",10)
			self.Wheels[i]:Ignite( 32,32 )
			
		end
		
	end
	
	self:Remove()
	
end


function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime > 0.2 && self.Started ) then
		
		if( data.Speed > 50 ) then
			
			if( math.random(1,3) == 1 ) then
				
				self:EmitSound("physics/metal/metal_large_debris2.wav",511,100)
			
			end
			
		end
		
		if( data.Speed > 250 ) then
		
			self:DoExplosion()
		
		end
		
		
	end
	
end
