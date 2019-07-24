AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.AutoDetonateTimer = 0

function ENT:Initialize()

	self:SetModel( "models/items/AR2_Grenade.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_BSP )
	self.MaxTime = math.random(8,16)
	self.PhysObj = self:GetPhysicsObject()
	
	if (self.PhysObj:IsValid()) then
	
		self.PhysObj:Wake()
		self.PhysObj:EnableGravity( true )
		self.PhysObj:SetMass( 10 )
		
	end
	
	self.BurnTimer = 0
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if( self.Activated ) then return end
	
	if ( data.Speed > 150 && data.DeltaTime > 0.2 ) then 
		
		if( !IsValid( self.Owner ) ) then self.Owner = self end
		if( !IsValid( self.Creditor ) ) then self.Creditor = self end
		
		util.BlastDamage( self.Creditor, self.Owner, data.HitPos, 512, math.random( 55, 155 ) )
		
		
		ParticleEffect( "neuro_gascan_explo", self:GetPos(), Angle(0,0,0), nil )
		ParticleEffect( "neuro_gascan_explo_air", self:GetPos(), Angle(0,0,0), nil )
			
		self:EmitSound( "ambient/fire/gascan_ignite1.wav",211,100 )
		self:SetColor( Color( 0,0,0,0 ) )
		self:SetRenderMode( RENDERMODE_TRANSALPHA )
		
		-- self:Remove()
		self.Activated = true
		self.ImpactPos = data.HitPos
		
	end
	
end

function ENT:Think()
	
	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
	
	end
	
	if( self:WaterLevel() > 0 ) then self:Remove() return end
	
	if( self.Activated ) then
		
		self.BurnTimer = self.BurnTimer + 1
		-- print( self.BurnTimer )
		if( self.BurnTimer >= 40 ) then self:Remove() return end 
		
		for k,v in pairs( ents.FindInSphere( self.ImpactPos, 128 ) ) do
			
			if( string.find( v:GetClass(), "prop*") || string.find( v:GetClass(), "sent*") || v:IsPlayer() || v:IsNPC() ) then
				
				if( v != self && v:GetClass() != self:GetClass() ) then
				
					v:Ignite( 10,10 )
				
				end
				
			end
		
		end
		
	end
	
end
