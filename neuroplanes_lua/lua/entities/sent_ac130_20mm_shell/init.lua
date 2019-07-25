AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	self:SetModel( "models/items/ar2_grenade.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.pitch = math.random(100,130)
	self.PhysObj = self:GetPhysicsObject()
	if (self.PhysObj:IsValid()) then
		self.PhysObj:Wake()
		self.PhysObj:EnableGravity(false)
	end
	util.SpriteTrail(self, 0, Color(255,255,255,math.random(70,90)), false, 17, 1, 4, math.sin(CurTime()) / (math.pi+5) * 0.5, "trails/smoke.vmt");  

	self.Owner = self:GetOwner()
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if ( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	
	if (data.Speed > 50 && data.DeltaTime > 0.2 ) then 

		util.BlastDamage( self.Owner, self.Owner, data.HitPos, 768, math.random(45,64))

		self:SpreadFire()
		
		self:EmitSound( "ambient/fire/gascan_ignite1.wav",211,100 )

		self:NeuroTec_Explosion( data.HitPos, 256, 500, 950, "ap_impact_wall" )
		
	end
	
end

function ENT:SpreadFire()

	local numFire = math.random(2,5)
	
	for i=0, numFire do

		local tr,trace = {},{}
		tr.start = self:GetPos() + Vector( 0, 0, 72 )
		tr.endpos = self:GetPos() + self:GetRight() * math.random( -1024, 1024 ) + self:GetForward() * math.random( -1024, 1024 ) + Vector( 0, 0, -256 ) 
		trace = util.TraceLine( tr )
		
		if ( trace.Hit && !trace.HitSky && math.acos( trace.HitNormal:Dot( Vector( 0, 0, 0 ) ) ) < 45 ) then
			
			if ( trace.Entity ) then
				
				trace.Entity:Ignite(15,5)
			
			end
			
			local fire = ents.Create("env_Fire")
			fire:SetPos( trace.HitPos )
			fire:SetKeyValue( "firesize", math.random( 128, 256 ) )
			fire:SetKeyValue("fireattack",5)
			fire:SetKeyValue("damagescale", math.random( 35, 55 ) )
			fire:Spawn()
			fire:Fire("kill","",15)
			fire:Fire("StartFire","",0)
			
		
		end
	
	end
	
end

function ENT:Think()
	
	if( self:WaterLevel() > 0 ) then
	
		self:Remove()
	
	end
	
	if ( DEBUG ) then
				
		debugoverlay.Cross( self:GetPos(), 64, 1, Color( 255,255,255,185*math.sin(CurTime())*60 ), false )
			
	end
	
	self:EmitSound("weapons/mortar/mortar_shell_incomming1.wav",511,110)
	self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 200000 )

end
