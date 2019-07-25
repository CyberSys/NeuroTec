AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self:SetModel( "models/items/ar2_grenade.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.pitch = math.random(80,110)
	self.PhysObj = self:GetPhysicsObject()
	if (self.PhysObj:IsValid()) then
		self.PhysObj:Wake()
		self.PhysObj:EnableGravity(false)
	end
	
	util.SpriteTrail(self, 0, Color(255,255,255,7), false, 32, 1, 1, math.sin(CurTime()) / (math.pi+5) * 0.5, "trails/tube.vmt");
	
	self.Owner = self:GetOwner()
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > 5 && data.DeltaTime > 0.2 ) then 
		
		if ( !IsValid( self.Owner ) ) then
			
			self.Owner = self
			
		end
		
		self:EmitSound( "ambient/explosions/explode_2.wav", 511, 90 )
	
		self:NeuroTec_Explosion( data.HitPos, 512, 1500, 2500, "HE_impact_dirt" )
		
	end
	
end

function ENT:Think()
	
	if( self:WaterLevel() > 0 ) then
	
		self:Remove()
		
		return
		
	end

	self:EmitSound("weapons/mortar/mortar_shell_incomming1.wav",511,80 )
	self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 15000 )
	
end
