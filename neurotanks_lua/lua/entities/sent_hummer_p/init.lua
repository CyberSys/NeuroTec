

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "Hummer"
ENT.Model = "models/humvee/humvee.mdl"

ENT.InitialHealth = 2500
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.DeathTimer = 0

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 180,0)
	local ent = ents.Create( "sent_hummer_p" )
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
	
	// Misc
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.PhysObj = self:GetPhysicsObject()
	
	self.Hummer = ents.Create("prop_vehicle_jeep")
	self.Hummer:SetPos( self:GetPos() )
	self.Hummer:SetAngles( self:GetAngles() )
	self.Hummer:SetModel(self.Model)
	self.Hummer:SetKeyValue("vehiclescript", "scripts/vehicles/nnhumvee.txt")
	self.Hummer:Spawn()
	self.Hummer:Activate()
	self.Hummer:Fire("turnon",0,0)
	self.Hummer:Fire("Lock",0,0)
	self.Hummer:Fire("handbrakeoff",0,0)
	self.Hummer.IsNeuroGroundVehicle = true
	
	-- self.Pod = ents.Create("prop_physics_override")
	-- self.Pod:SetModel( "models/airboatgun.mdl" )
	-- self.Pod:SetPos( self.Hummer:LocalToWorld( Vector( 0,25,83 ) ) )
	-- self.Pod:SetAngles( self.Hummer:GetAngles() + Angle( -3,90,0 ) )
	-- self.Pod:SetParent( self.Hummer )
	-- self.Pod:Spawn()
	
	
	self:SetColor( Color ( 0,0,0,0 ) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:SetParent( self.Hummer )
	
	self.SeatPos = { Vector( 22, 9, 30 ), Vector( 22, -26,30 ), Vector( -23, -29, 30 )}
	self.Seats = {}
	
	for i=1,#self.SeatPos do
		
		self.Seats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
		self.Seats[i]:SetPos( self.Hummer :LocalToWorld( self.SeatPos[i] ) )
		self.Seats[i]:SetModel( "models/nova/jeep_seat.mdl" )
		self.Seats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.Seats[i]:SetKeyValue( "limitview", "0" )
		self.Seats[i].HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
		self.Seats[i]:SetAngles( self:GetAngles() )
		self.Seats[i]:SetParent( self.Hummer )
		self.Seats[i]:SetColor( Color( 0,0,0,0) )
		self.Seats[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
		self.Seats[i]:Spawn()
	
	end
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 10000 )
		
	end
	
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
	
	self.Hummer:Remove()
	
end

function ENT:PhysicsCollide( data, physobj )

end

function ENT:Use(ply,caller)

end


function ENT:Think()
	
	self.Pilot = self.Hummer:GetDriver()
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:Remove()
		
		end
		
	end
	
	

	local dr = self.Seats[2]:GetDriver()
		
	if( IsValid( dr ) ) then
			
		self.Pod:SetAngles( dr:EyeAngles() )

		if( dr:KeyDown( IN_ATTACK ) && self.LastAttack + 0.11 <= CurTime() ) then
			
			self.LastAttack = CurTime()
			
			local bullet2 = {} 
			bullet2.Num 		= bulletcount
			bullet2.Src 		= self.Pod:LocalToWorld( Vector( 70, 0, 0 ) )
			bullet2.Dir 		= self.Pod:GetAngles():Forward()
			bullet2.Filter = { self, self.Hummer, self.Seats[1], self.Seats[2],self.Pod }
			bullet2.Attacker = dr
			bullet2.Spread 	= spread
			bullet2.Tracer	= 1
			bullet2.Force	= 5
			bullet2.Damage	= math.random( 5, 25 )
			bullet2.AmmoType = "Ar2"
			bullet2.TracerName 	= "Tracer"
			bullet2.Callback    = function ( a, b, c ) self:TankMountedGunCallback( a, b, c ) end 

			self.Pod:FireBullets( bullet2 )

			self:EmitSound( self.MGunSound, 511, math.random( 70, 100 ) )
	
			local shell2 = EffectData()
			shell2:SetStart( self.Pod:GetPos() + self.Pod:GetForward() * -4 + self.Pod:GetRight() * 2 + self.Pod:GetUp() * 8)
			shell2:SetOrigin( self.Pod:GetPos() + self.Pod:GetForward() * -4 + self.Pod:GetRight() * 2 + self.Pod:GetUp() * 8)
			util.Effect( "RifleShellEject", shell2 ) 
	
			
			local e2 = EffectData()
			e2:SetStart( self.Pod:GetPos() + self.Pod:GetForward() * 72 )
			e2:SetOrigin( self.Pod:GetPos() + self.Pod:GetForward() * 72 )
			e2:SetAngles( self.Pod:GetAngles() )
			e2:SetEntity( self.Pod )
			e2:SetAttachment( 1 )
			e2:SetScale( 1.5 )
			util.Effect( "tank_muzzlesmoke", e2 )
			util.Effect( "AirboatMuzzleFlash", e2 )
				
			self:StopSound( self.MGunSound )

	
			
		end
		
		
	end
	
	
	for i=1,#self.Seats do
		
		local dr = self.Seats[i]:GetDriver()
		
		if( IsValid( dr ) )then
			
			if( dr:KeyDown( IN_RELOAD) && self.LastSeatChange + 0.5 <= CurTime() ) then
								
				self.LastSeatChange = CurTime()
				
				if( !IsValid( self.Hummer:GetDriver() ) ) then
					
					dr:ExitVehicle()
					dr:EnterVehicle( self.Hummer )
					
					return
					
				end
				
				if( i == 1 && !IsValid( self.Seats[2]:GetDriver() ) ) then
					
					dr:ExitVehicle()
					dr:EnterVehicle( self.Seats[2] )
					
				elseif( i == 2 && !IsValid( self.Seats[1]:GetDriver() ) ) then
					
					dr:ExitVehicle()
					dr:EnterVehicle( self.Seats[1] )
					
				end	
			
			end
		
		end
	
	
	end
	
	local dr = self.Hummer:GetDriver()
	
	if( IsValid( dr ) && dr:KeyDown( IN_RELOAD ) && self.LastSeatChange + 0.5 <= CurTime() ) then
			
		local d = self.Seats[2]:GetDriver()
		if( !IsValid( d ) ) then
			
			dr:ExitVehicle()
			dr:EnterVehicle( self.Seats[2] )
			self.LastSeatChange = CurTime()

		end
		
	end
	
	for k,v in pairs( player.GetAll() ) do
		
		if( v:GetPos():Distance( self:GetPos() ) < 119 && v:KeyDown( IN_USE ) ) then
			
			if( v.LastUseKeyDown == nil ) then
				-- d
				v.LastUseKeyDown = CurTime() - 1.5
				
			end
			
			if( v.LastUseKeyDown && v.LastUseKeyDown + 1.5 > CurTime() ) then return end
			
			local tr,trace = {},{}
			tr.start = v:GetShootPos()
			tr.endpos = tr.start + v:GetAimVector() * 82
			tr.filter = v
			trace = util.TraceLine( tr )
			
			if( trace.Hit && ( trace.Entity == self || trace.Entity == self.Hummer ) ) then
				
				if( !IsValid( dr ) ) then
					
					v:EnterVehicle( self.Hummer )
					v.LastUseKeyDown = CurTime()
					self.Pilot = v
					
				else
					
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


-- function ENT:PhysicsUpdate()
	
	
	
	-- if ( IsValid( self.Pilot ) ) then

		-- self:GetPhysicsObject():Wake()
		
		-- local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
		-- local ta = ( self:GetPos() - a ):Angle()
		-- local ma = self:GetAngles()

		-- local pilotAng = self.Pilot:EyeAngles()
		-- local _t = self.Pod:GetAngles()
		-- local barrelpitch = math.Clamp( pilotAng.p, -45, 3 )

		-- self.offs = self:VecAngD( ma.y, ta.y )
		-- self.pitchoffs = self:VecAngD( ma.p, ta.p )
		
		-- local angg = self.Hummer:GetAngles()
		-- local angb = self.Hummer:GetAngles()
		
		-- angg:RotateAroundAxis( self:GetUp(), -self.offs + 180 )
		-- //angb:RotateAroundAxis( self:GetForward(), -self.pitchoffs + 180 )
		
		-- self.Pod:SetAngles( LerpAngle( 0.1, _t, Angle( angg.p, angg.y, angg.r ) ) )

	-- end
	
-- end
