
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.explodeDel = NULL
ENT.explodeTime = 10

function ENT:Initialize()
	
	self.Ticker = 0
	
	self:SetModel("models/props_phx/misc/soccerball.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetColor( Color( 0, 55, 0, 255 ) )
    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
	phys:Wake()
	phys:SetMass( 1 )
	phys:SetVelocity( self:GetForward() * self.ShellVelocity  )
	end
	 
	ParticleEffectAttach( "poison_gas_large_air", PATTACH_ABSORIGIN_FOLLOW, self, 0 ) 
	self.EmissionPos = {}
	self.DmgCocktail = { DMG_NERVEGAS, DMG_POISON, DMG_RADIATION }
end
function ENT:PhysicsCollide( data )
	
	if( !self.Active && data.DeltaTime > 0.1 && data.Speed > 50 ) then
		self.Active = true
		
		-- ParticleEffect( "poison_gas_main", self:GetPos(), Angle(0,0,0), self )
		-- ParticleEffect( "poison_gas_main", self:GetPos(), Angle(0,0,0), nil )
		
		ParticleEffectAttach( "poison_gas_large_ground", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
		self:EmitSound( "explosion3.wav", 511, 100 )
	
	
	end
	
end
function ENT:Think()
	self:NextThink( CurTime()+.25)

	-- if( self.Ticker > 1 && !self.Active ) then
		
	
		-- return
		
	-- end
	
	if( self.Active ) then
		
		self.Ticker = self.Ticker + 1
		self:Neuro_DealDamage( self.DmgCocktail[math.random(1,#self.DmgCocktail)], math.random( 1, 2 ), self:GetPos(), 128, false, "" )
		if( self.Ticker < 6 ) then
		
			ParticleEffect( "poison_gas_large_ground", self:GetPos(), Angle(0,0,0), nil )
			
			table.insert( self.EmissionPos, self:GetPos() )
			-- print( self.Ticker )
			
		end
		-- debugoverlay.Line( tr.start, trace.HitPos, 0.1, Color( 255,0,0,255 ), true  )
		
		for k,v in pairs( self.EmissionPos ) do
			
			debugoverlay.Line( v, self:GetPos(), 0.1, Color( 255,0,0,255 ), true  )
			-- for i=1,2 do
			
			local tr,trace={},{}
			tr.start=v+Vector(0,0,155)
			tr.endpos=v+Vector( math.random(-self.Ticker*8, self.Ticker*8 ),math.random(-self.Ticker*8, self.Ticker*8 ),-self.Ticker*5)
			tr.filter = { self, self.Owner }
			tr.mask = MASK_SOLID
			trace = util.TraceLine( tr ) 
			if( !IsValid( self.Owner ) ) then
				self.Owner = self
			end
			self.Owner:Neuro_DealDamage( self.DmgCocktail[math.random(1,#self.DmgCocktail)], math.random( 2, 4 ), trace.HitPos, self.Ticker*3, false, "" )
			
			debugoverlay.Cross( trace.HitPos, 32, 0.1, Color( 255,255,255,255 ), false )
				-- debugoverlay.Text( trace.HitPos, math.floor( self:GetPos():Distance( trace.HitPos ) ), 0.1, Color( 255, 0, 0, 0 ) )
			-- end
		
		end
		
		
	end
	if( self.Active && self.Ticker > 400 ) then
	
		self:StopParticles()
		self:Remove()
		
	end
	
end

