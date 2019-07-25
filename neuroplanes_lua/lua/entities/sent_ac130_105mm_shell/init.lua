AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	
	self.Entity:SetModel( "models/items/ar2_grenade.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )	
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.pitch = math.random(80,110)
	self.PhysObj = self.Entity:GetPhysicsObject()
	if (self.PhysObj:IsValid()) then
		self.PhysObj:Wake()
		self.PhysObj:EnableGravity(false)
		self.PhysObj:EnableDrag(true)
	end
	
	util.SpriteTrail(self, 0, Color(255,255,255,math.random(100,130)), false, 42, 1, 6, math.sin(CurTime()) / (math.pi+5) * 0.5, "trails/tube.vmt");
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if (data.Speed > 50 && data.DeltaTime > 0.2 ) then 
		
		if( !IsValid( self.Owner ) ) then self.Owner = self end
		
		self:EmitSound( "ambient/explosions/explode_1.wav", 511, 100 )
		self:NeuroTec_Explosion( data.HitPos, 2000, 3500, 5500, "VBIED_b_explosion" )
		
		return
		
	end
	
end

function ENT:Think()

	if( self:WaterLevel() > 0 ) then
	
		self:Remove()
	
	end
	
	if ( DEBUG ) then
				
		debugoverlay.Cross( self:GetPos(), 64, 1, Color( 255,255,255,185*math.sin(CurTime())*60 ), false )
			
	end
	
	self:EmitSound("weapons/mortar/mortar_shell_incomming1.wav",100, 100 )
	
	self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 5000 )
	
end