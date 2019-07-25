

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = "models/volvo.mdl"

ENT.InitialHealth = 2000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.DeathTimer = 0

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 180,0)
	local ent = ents.Create( "sent_240_p" )
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
	self.LastDamageTick = CurTime()
	self:SetNetworkedInt( "MaxSpeed", self.MaxVelocity )
	// Misc
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.PhysObj = self:GetPhysicsObject()
	
	self.Volvo = ents.Create("prop_vehicle_jeep")
	self.Volvo:SetPos( self:GetPos() )
	self.Volvo:SetAngles( self:GetAngles() )
	self.Volvo:SetModel(self.Model)
	self.Volvo:SetKeyValue("vehiclescript", "scripts/vehicles/volvo_test.txt")
	
	self.Volvo:SetSkin( math.random(1,9) )
	self.Volvo:Spawn()
	self.Volvo:Activate()
	self.Volvo:Fire("turnon",0,0)
	self.Volvo:Fire("Lock",0,0)
	self.Volvo:Fire("handbrakeoff",0,0)
	self.Volvo.IsNeuroGroundVehicle = true
	
	self.VolvoProxy = ents.Create( "prop_vehicle_prisoner_pod" )
	self.VolvoProxy:SetPos( self.Volvo:LocalToWorld(  Vector( 13, 8, 13 ) ) )
	self.VolvoProxy:SetModel( "models/nova/jeep_seat.mdl" )
	self.VolvoProxy:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
	self.VolvoProxy:SetKeyValue( "limitview", "0" )
	self.VolvoProxy.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
	self.VolvoProxy:SetAngles( self:GetAngles() + Angle( 0, 0,16 ) )
	self.VolvoProxy:SetParent( self.Volvo )
	self.VolvoProxy.isChopperGunnerSeat = true
	
	self.VolvoProxy:SetColor(Color(0,0,0,0))
	-- self.VolvoProxy:SetMaterial( "models/wireframe" )
	self:SetMaterial( "models/wireframe" )
	self.VolvoProxy:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.VolvoProxy:Spawn()


	
	self:SetColor(Color( 0, 0,0,0 ))
	self:SetNoDraw( true )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )

	-- self:SetParent( self.Volvo )
	
	self.BoostSound = CreateSound( self, Sound( "HL1/ambience/steamburst1.wav" ) )
	
	self.Volvo:SetOwner( self )
	
	local weld = constraint.Weld( self, self.Volvo, 0,0,0 )
	
	self.SeatPos = { Vector( -13, 8, 13 ), Vector( 13, -28, 13 ), Vector( -13, -28, 13 ) }
	self.Seats = {}
	
	for i=1,#self.SeatPos do
		
		self.Seats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
		self.Seats[i]:SetPos( self.Volvo :LocalToWorld( self.SeatPos[i] ) )
		self.Seats[i]:SetModel( "models/nova/jeep_seat.mdl" )
		self.Seats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.Seats[i]:SetKeyValue( "limitview", "0" )
		self.Seats[i].HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
		self.Seats[i]:SetAngles( self:GetAngles() + Angle( 0, 0, 16 ) )
		self.Seats[i]:SetParent( self.Volvo )
		self.Seats[i]:SetColor( Color( 0,0,0,0) )
		self.Seats[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
		self.Seats[i]:Spawn()
		self.Seats[i]:Fire("Lock",0,0)
	
	end
	
	local taillights = { Vector( 22,-93,31 ), Vector( -22, -93, 31 ) }
	self.TailLightSprites = {}
	
	for i=1,#taillights do
	
		self.TailLightSprites[i] = ents.Create( "env_sprite" )
		self.TailLightSprites[i]:SetParent( self )	
		self.TailLightSprites[i]:SetPos( self:LocalToWorld( taillights[i] ) ) -----143.9 -38.4 -82
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
	
	self.LastHonk = CurTime()
	self.HonkSound = "ambient/alarms/klaxon1.wav"

		
	self.FartCannon = ents.Create("prop_physics")
	self.FartCannon:SetModel( "models/weapons/w_rocket_launcher.mdl" )
	self.FartCannon:SetPos( self.VolvoProxy:LocalToWorld( Vector( -29, -97, 40 ) ) )
	self.FartCannon:SetAngles( self:GetAngles() + Angle( 5, 90, 180 ) )
	-- self.FartCannon:SetMaterial( "models/shiny" )
	self.FartCannon:SetParent( self )
	self.FartCannon:SetSolid( SOLID_NONE )
	self.FartCannon:Spawn()
	self:SetNetworkedEntity( "FartCannon", self.FartCannon )
	
	self.Speed = 0
	
	self.Gears = { 
					{ Min = 10, Max = 400, _Sound = Sound("vehicles/v8/first.wav") };
					{ Min = 400, Max = 700,_Sound =  Sound("vehicles/v8/second.wav") };
					{ Min = 700, Max = 900, _Sound = Sound("vehicles/v8/third.wav") };
					{ Min = 900, Max = 10000, _Sound =  Sound("vehicles/v8/v8_turbo_on_loop1.wav") };
					
					};
	
	self.Sounds = {}
	
	for k,v in pairs( self.Gears ) do
		
		self.Sounds[k] = CreateSound( self, v._Sound )
		
	end
	
	
	self.Wing = ents.Create("prop_physics")
	self.Wing:SetPos( self:LocalToWorld( Vector( 0, -85, 45 ) ) )
	self.Wing:SetAngles( self:GetAngles() + Angle( -80, 90, -90 ) )
	self.Wing:SetModel( "models/props_lab/lockerdoorleft.mdl" )
	self.Wing:SetMaterial( self.Volvo:GetMaterial() )
	self.Wing:SetColor( Color( 15,15,15,255 ) )
	self.Wing:SetSkin( self.Volvo:GetSkin() )
	self.Wing:SetParent( self )
	self.Wing:Spawn()

	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 500 )
		
	end
	
end

function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)

	-- if( self.HealthVal < 0 ) then
		
		-- self:GibFest()
		
		-- return
		
	-- end
	
	if ( self.HealthVal < 100 ) then
	
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass(2000)
		self:Ignite(60,100)
		
	end
	
end

function ENT:OnRemove()
				
	for i=1,#self.Sounds do
		
		self.Sounds[i]:Stop()
	
	end
	
	-- if( self.HealthVal < 100 ) then
		
		-- self:GibFest()
	
	-- end
	
	self.Volvo:Remove()
	
end

function ENT:DoExplosion()
	
	
	if( !IsValid( self.Owner ) ) then self.Owner = self end
	if( math.random( 1,4 ) == 3  && self.Owner:IsPlayer() ) then 
		
		self.Owner:PrintMessage( HUD_PRINTTALK, "Something didn't go quite as expected" ) 
		self.Target = self.Owner
		
		return
		
	end
	
	self:EmitSound( "ambient/explosions/exp2.wav", 150, 100 )
	util.BlastDamage( self, self, self:GetPos(), 712, math.random( 1500, 5500 ))
	
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
	
	ParticleEffect( fx, self:GetPos() + Vector( 0,0,100) , self:GetAngles(), nil )
	
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
	
	self:Remove()
	
end


function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
	-- print( data.Speed )
	if( data.DeltaTime > 0.2 ) then
		
		if( data.Speed > 50 ) then
			
			if( math.random(1,3) == 1 ) then
				
				self:EmitSound("physics/metal/metal_large_debris2.wav",511,100)
			
			end
			
		end
		
		if( data.Speed > 1050 ) then
		
			self:DoExplosion()
		
		end
		
		
	end
	end)
	
end


function ENT:Think()
		
	local speed = (self:GetVelocity():Length() * 0.75 * 0.0833333333 * 1.46666667)
	self:SetNetworkedInt( "SpeedMPH", speed )
	
	-- if( self:GetVelocity():Length() > 1050 ) then 
		
		-- if( IsValid( self.Pilot ) ) then self.Pilot:PrintMessage( HUD_PRINTCENTER, "BOMB ARMED" ) end
		
	-- end
	-- local d = self.Volvo:GetDriver()
	
	-- if( IsValid( d ) && !IsValid( self.Driver ) ) then
		
		-- self.Driver = d
		
		-- if( !IsValid( d:GetScriptedVehicle() ) ) then
			
			-- d:SetScriptedVehicle( self )
			
		-- end
		
	-- end
	-- for i=1,#self.SeatPos do
		
		-- local p = self.SeatPos[i]
		-- debugoverlay.Text( self:LocalToWorld( p ), p.x.." "..p.y.." "..p.z, 1 ) 
	
	-- end
	
	-- self.Pilot = self.VolvoProxy:GetDriver()
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 535 then
			
			self:DoExplosion()
			self:Remove()
		
		end
		
	end
	
		
	
	if( IsValid( self.Pilot ) && self.Pilot:KeyDown( IN_ATTACK ) && self.LastHonk + 1.0 <= CurTime() ) then
		
		self.LastHonk = CurTime()
		self:EmitSound( self.HonkSound, 511, 100 )
		
	end

	local dr = self.VolvoProxy:GetDriver()
	self.Speed = math.Approach( self.Speed, self:GetVelocity():Length(), 1 )
	
	-- print( dr )
	if( IsValid( dr ) ) then
		
		-- dr:PrintMessage( HUD_PRINTCENTER, math.floor( self:GetVelocity():Length() ) )
		dr:SetScriptedVehicle( self )

		self.Volvo:Fire("turnon","",0)
			
		
			
		if( dr:KeyDown( IN_FORWARD ) ) then
		
			self.Volvo:Fire("throttle","1",0)
			
		elseif( dr:KeyDown( IN_BACK ) ) then
			
			self.Volvo:Fire("throttle","-1",0)
			
		else
			
			self.Volvo:Fire("throttle","",0)
		
		end
		
		-- print( self:OnGround() )
		if( dr:KeyDown( IN_MOVELEFT ) ) then
			
			self.Volvo:Fire( "steer", "-1", 0 )
			if( self:GetVelocity():Length() > 150 ) then
			
				self.Volvo:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, 7 ) )
			
			end
			
		elseif( dr:KeyDown( IN_MOVERIGHT) ) then
			
			self.Volvo:Fire("steer","1",0 )
			
			if( self:GetVelocity():Length() > 150 ) then
			
				self.Volvo:GetPhysicsObject():AddAngleVelocity( Vector( 0, 0, -7 ) )
			
			end
			
		else
			
			self.Volvo:Fire("steer","0",0)
		
		end
		
		if( dr:KeyDown( IN_JUMP ) ) then
			
			self.Volvo:Fire("handbrakeon","",0)
		
		else
			
			self.Volvo:Fire("handbrakeoff","",0)
		
		
		end

		
		local keydown = ( dr:KeyDown( IN_FORWARD ) || dr:KeyDown( IN_BACK ) )
		
		if( keydown ) then
				
			if( dr:KeyDown( IN_SPEED ) ) then
			
				if( self:GetVelocity():Length() < 300 ) then
			
				self.Volvo:GetPhysicsObject():AddAngleVelocity( Vector( 0, -15, 0 ) )
			
				end
				
				local tr,trace = {},{}
				tr.start = self:GetPos() + self:GetUp() * 32
				tr.endpos = self:GetPos() + self:GetUp() * -128
				tr.filter = { self, self.VolvoProxy, self.Volvo }
				tr.mask = MASK_SOLID
				
				trace = util.TraceLine( tr )
				if( trace.Hit ) then
					
					dr:PrintMessage( HUD_PRINTCENTER, "Ludicrous Speed" )
					
					self.LastBoost = CurTime()
					self:GetPhysicsObject():ApplyForceCenter( self:GetRight() * -29000 )
					self.BoostSound:PlayEx( 511, 200 )
					
					local fx = EffectData()
					fx:SetOrigin( self:GetPos() + self:GetRight() * 100 + Vector( 0, 0, 10 ) )
					fx:SetStart(  self:GetPos() + self:GetRight() * 100 + Vector( 0, 0, 10 ) )
					fx:SetEntity( self )
					fx:SetScale( 0.25 )
					util.Effect("Launch2", fx )
					
				end
				
			else
				
				if( self.LastBoost && self.LastBoost + 0.5 <= CurTime() ) then
				
					self.BoostSound:Stop()
				
				end
				
			end
			
			local sp = self.Speed
			
			for k,v in pairs( self.Gears ) do
				
				if (  sp > v.Min && sp < v.Max ) then
					
					
					self.Sounds[k]:PlayEx( 500, 100 + math.Clamp( self:GetVelocity():Length()/15, 0, 60 ) )
					
				else
					
					self.Sounds[k]:Stop()
				
				end
				
			end
			
		else
		
			for i=1,#self.Sounds do
				
				self.Sounds[i]:Stop()
			
			end
	
		end

	end
	
	for k,v in pairs( player.GetAll() ) do
		
		if( v == self.Pilot && v != dr ) then self.Pilot:SetNetworkedEntity("Tank",NULL) self.Pilot:SetScriptedVehicle( NULL ) self.Pilot = NULL return end 
		if( v:GetPos():Distance( self:GetPos() ) < 72 && v:KeyDown( IN_USE ) ) then
			
			if( v.LastUseKeyDown && v.LastUseKeyDown + 1.5 > CurTime() ) then return end
			
			local tr,trace = {},{}
			tr.start = v:GetShootPos()
			tr.endpos = tr.start + v:GetAimVector() * 72
			tr.filter = v
			trace = util.TraceLine( tr )
			
			if( trace.Hit && ( trace.Entity == self || trace.Entity == self.Volvo ) ) then
				
				if( !IsValid( dr ) ) then
					
					
					-- v:EnterVehicle( self.Volvo )
					v:EnterVehicle( self.VolvoProxy )
					v:SetNetworkedEntity("Tank", self )
					v.LastUseKeyDown = CurTime()
					self.Pilot = v
					-- self.Pilot:Spectate( OBS_MODE_CHASE )
					-- self.Pilot:SpectateEntity( self )
					
					return
					
				else
					
					if( v == self.Pilot ) then return end
					
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
		
	end

	self:NextThink( CurTime() )
	
	return true
	
end


function ENT:PhysicsUpdate()
	
	if ( IsValid( self.Pilot ) ) then

		
	
	end
	
end
