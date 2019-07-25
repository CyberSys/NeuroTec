

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = "models/60footboxcar.mdl"

ENT.InitialHealth = 10000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.DeathTimer = 0


function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 90,0)
	local ent = ents.Create( "sent_test_traincar" )
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
	self.IsTrainCar = true
	self.DockingSlots = { Vector( 357, 0, 29 ), Vector( -357, 0, 29 ) }
	self.DockedCars = {}
	self.DockBallsockets = {}
	
	self.Bogey = {}
	self.BogeyPos = {}
	
	// Misc
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	// Sound
	local esound = {}
	self.EngineMux = {}
	esound[1] = "vehicles/diesel_loop2.wav"
	esound[2] = "vehicles/diesel_loop2.wav"
	esound[3] = "vehicles/diesel_loop2.wav"

	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 100
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:PlayEx( 511 , self.Pitch )
	
	end
	
	self.PhysObj = self:GetPhysicsObject()
	
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
		
	end
	
	if ( self.HealthVal < 50 ) then
	
		self.Destroyed = true
		self:Ignite(60,100)
		
	end
	
end

function ENT:OnRemove()

	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end

end

function ENT:PhysicsCollide( data, physobj )

	
end

function ENT:Touch( ent )
	
	if true then return end
	 
	local hitent = ent
	
	if( IsValid( hitent ) && hitent.IsTrainCar && type(hitent.DockedCars) == "table" ) then
		
		local dockedcars = hitent.DockedCars
		local docks = #hitent.DockingSlots
		local closest = nil
		local d = 1024

		for i=1,#docks do
			
			for j=1,#self.DockingSlots do
				
				local a = hitent:LocalToWorld( hitent.DockingSlots[i] ):Distance( hitent:LocalToWorld( hitent.Dockingslots[j] ) ) 
				if( a < d ) then
					
					d = a
					
				end
				
			end
		
		end
		
		if( #dockedcars < docks /* && d < 128 */ ) then
			
			for i=1,docks do
				
				if( !IsValid( dockedcars[i] ) ) then
					
					//self:SetPos( hitent:LocalToWorld( hitent.DockingSlots[i]  ) + self.DockingSlots[i] )
					hitent.DockBallsockets[#self.DockBallsockets+1] = constraint.Ballsocket( self, hitent, 0,0, hitent:LocalToWorld( hitent.DockingSlots[i] ), 0, 0, 1 )
					hitent.DockedCars[#hitent.DockedCars+1] = self
					self.DockedCars[#self.DockedCars+1] = hitent
					
					--//constraint.Ballsocket( Entity Ent1, Entity Ent2, Number Bone1, Number Bone2, Vector LPos, Number forcelimit, Number torquelimit, Number nocollide )
				
					break
				
				end
				
			end
					
		end
		
	end

end

function ENT:Use(ply,caller)

end


function ENT:Think()


	self.Pitch = math.Clamp( math.floor( ( 200 * ( 1 / 100 ) ) + ( self:GetVelocity():Length() / 7 ) ), 140,255 )

	for i = 1,#self.EngineMux do
	
		self.EngineMux[i]:ChangePitch( self.Pitch - ( i * 5 ) )
		
	end
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 55 then

			self:Remove()
		
		end
		
	end
	
	
	
		
	self:NextThink( CurTime() )
	
	return true
	
end

function ENT:PhysicsUpdate()
	
end

