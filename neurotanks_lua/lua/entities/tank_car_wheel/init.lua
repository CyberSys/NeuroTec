
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

-- ENT.InitialHealth = 500
ENT.Destroyed = false
ENT.PhysgunDisabled  = true 

function ENT:Initialize()
	
	
	-- self:SetModel( "models/props_junk/gascan001a.mdl" )
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.VehicleType = VEHICLE_CAR
	-- self.LeakPos = {}
	self.Sound = CreateSound( self, "ambient/gas/steam2.wav", 511, 100 )
	
	self.Flattyness = 1.0
	-- self.HealthVal = self.InitialHealth
	
end

function ENT:Think()
	
	if( self.Destroyed ) then return end
	
	
end

function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end
		
	local dt = dmginfo:GetDamageType()
	local bitwise = ( bit.bor( dt, DMG_BLAST_SURFACE ) == DMG_BLAST_SURFACE ) || ( bit.bor(dt, DMG_BLAST )  == DMG_BLAST ) || ( bit.bor( dt, DMG_BURN ) == DMG_BURN  )
	local dmg = dmginfo:GetDamage()
	
	self:EmitSound( "physics/rubber/rubber_tire_impact_bullet"..math.random(1,3)..".wav", 511, 100 )
	if( self.BulletProof ) then	
	
		if( bitwise ) then
			
			self.HealthVal = self.HealthVal - dmg/3
			
		else
			
			return
		
		end
		
	else
		
		self.HealthVal = self.HealthVal - dmg
		
		if( self.HealthVal <= self.InitialHealth * 0.15 ) then
			
			-- print( "yep 0.5" )
			
	
			
			if( IsValid( self.Socket ) && !self.Popped ) then
				
				self.Popped = true
						
				self:SetNetworkedBool("Disabled", true )
				
			
				-- if( math.random( 1, 5 ) == 3 ) then
				
					-- self:SetParent( self.Socket )
					-- self.Destroyed = true
			
			
				-- else
					
					-- construct.SetPhysProp( self, self, 0, nil,  { GravityToggle = true, Material = "phx_rubbertire2" } ) 
					-- local LPos1 = self:GetPhysicsObject():WorldToLocal( self:GetPos() )
					-- local LPos2 = self.Socket:GetPhysicsObject():WorldToLocal( self.Socket:GetPos() )
					-- local avel = self:GetPhysicsObject():GetAngleVelocity()
					
					local mass = self:GetPhysicsObject():GetMass()
					local a = self:GetAngles()
					local Radius =  ( ( self:OBBMaxs() - self:OBBMins() ):Length()  / math.pi  ) / math.Rand( 1.5, 1.7 )
					self:PhysicsInitSphere( Radius, self:GetMaterial() )
					self:SetCollisionBounds( Vector( -Radius, -Radius, -Radius ), Vector( Radius, Radius, Radius ) )
					-- self:SetPos( self:GetPos() + self.Owner:GetUp() * -4 )
					-- constraint.AdvBallsocket( self, self.Socket, 0, 0,Vector( 0,0,0 ),Vector(0,1,0),0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 )
					self:GetPhysicsObject():SetMass( mass/4 )
					self:SetAngles( a )
					-- local v = Vector(0,0,0)
					local w = constraint.Weld( self, self.Socket, 0, 0, 0, 1 )
					
					local fx = EffectData()
					fx:SetOrigin( self.Socket:GetPos() )
					fx:SetStart( self:GetPos() )
					fx:SetScale( 2.0 )
					util.Effect("ImpactJeep", fx )
					-- self:EmitSound( "HL1/ambience/steamburst1.wav", 511, math.random(180,220) ) 
					self.Sound:PlayEx( 511, math.random(180,200) )
					timer.Simple( 1, function() if( IsValid( self ) ) then self.Sound:FadeOut( 2.0 ) end  end )
					-- self.Axis2 = constraint.Axis( self, self.Socket, 0, 0, Vector(0,-1,0), Vector(0,1,0), 0, 0, 500, 1 )
					-- phx_rubbertire2
					
					-- self:GetPhysicsObject():AddAngleVelocity( avel )
					
				
				-- end

			end
			
			-- if( IsValid( self.Owner ) ) then
			
				-- constraint.Weld( self, self.Owner, 0, 0, 0, true )
			
			-- end
			
		end
		

	end
	
	
	-- print( dmg, self.HealthVal )
	
	
	if(	self.HealthVal <= 0 ) then
		
		self.Destroyed = true
		-- print( "yep 1 " )
		-- self:Remove()
		-- if( IsValid( self.Socket ) ) then
			
			-- self.Socket:Remove()
			
		-- end
		
		if( IsValid( self.Owner ) ) then
			-- print( "yep 2" )
			-- self:SetParent( self.Owner )
			
			local pilot = self.Owner.Pilot
			if( IsValid( pilot ) && self.Owner.HealthVal && self.Owner.HealthVal > 750 ) then
				
				pilot:PrintMessage( HUD_PRINTCENTER, "You lost a wheel!" )
				
			end
			
		end
		
		return
	
	end
	
end


function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime > 0.2 && data.Speed > 400 ) then
		
		
	end
	
end
