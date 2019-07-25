
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


ENT.HealthVal = 2000
ENT.Destroyed = false

function ENT:Initialize()
	

	-- self:SetModel( "models/props_junk/gascan001a.mdl" )
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.VehicleType = VEHICLE_TANK
	-- self.LeakPos = {}
	

end

function ENT:Think()
	
	if( self.Destroyed ) then return end
	
	
end

function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end
		
	local dt = dmginfo:GetDamageType()
	local bitwise = ( bit.bor( dt, DMG_BLAST_SURFACE ) == DMG_BLAST_SURFACE ) || ( bit.bor(dt, DMG_BLAST )  == DMG_BLAST ) || ( bit.bor( dt, DMG_BURN ) == DMG_BURN  )
	local dmg = dmginfo:GetDamage()
	
	if( bitwise ) then
		
		self.HealthVal = self.HealthVal - dmg/1.5
		
	else
		
		return
	
	end
	
	
	if(	self.HealthVal < 0 ) then
		
		self.Destroyed = true
		
		if( math.random( 0,1 ) > 0 ) then
		
			self:EmitSound( "ambient/explosions/explode_4.wav", 511, 200 )
			timer.Simple( 1, function() if ( IsValid( self ) ) then self:EmitSound( "ambient/explosions/explode_3.wav", 511, 200 ) end end )
			timer.Simple( 2, function() if ( IsValid( self ) ) then self:EmitSound( "ambient/explosions/explode_5.wav", 511, 200 ) end end )
			timer.Simple( 4, function() if ( IsValid( self ) ) then self:EmitSound( "ambient/explosions/explode_2.wav", 511, 200 ) end end )
			-- self.Tower:EmitSound( "ambient/explosions/explode_2.wav", 511, 200 )
			
			if( IsValid( self.Pilot ) ) then

				self.Pilot:Fire("Ignite",2,2)
				self:TankExitVehicle()

			end
		

			ParticleEffect( "tank_cookoff", self:GetPos() + Vector( 0,0,16 ), self:GetAngles(), self )
			timer.Simple( 4, function() if( IsValid( self ) ) then self.Owner:TankDeathFX() end end )
			
		else
				
			self.Owner:TankDeathFX()
			
		end
		
	end
	
end


function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
	if( data.DeltaTime > 0.2 && data.Speed > 400 ) then
	
	
	end
	end)
end
