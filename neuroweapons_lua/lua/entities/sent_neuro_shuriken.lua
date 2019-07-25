AddCSLuaFile()

ENT.PrintName = "Shuriken"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Equipment Stuff"
ENT.Base = "base_anim"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.InitialHealth = 75
ENT.Model = "models/scav/shuriken.mdl" 

function ENT:Initialize()

	self.HealthVal = self.InitialHealth 
	self:SetNWInt("HealthVal", math.floor( self.HealthVal ) )
	
	if SERVER then
	
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:GetPhysicsObject():SetMass( 2 )
		-- self:SetNoDraw( true )
		self:Fire("Kill","",10)
		self:SetAngles( self:GetAngles() + AngleRand() * .0015 )
		 self:EmitSound("npc/zombie/claw_miss1.wav")
		util.SpriteTrail( self, 0, Color( 255,5,0, 255 ), true, 4, 0, 1, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
				
	end 
	if( CLIENT ) then 
		
		-- timer.Simple( 0.1, function()
	
			
		-- end )
	
	end 
	
	
end 

function ENT:Draw()

	self:DrawModel()
	
end 



function ENT:PhysicsCollide( data )

local Ent = data.HitEntity
	local damager
	
	if  IsValid(self.Owner) then
		damager = self.Owner
		else
		damager = self.Entity
		return
	end
	
	if (Ent:IsPlayer() or Ent:IsNPC()) then
	Ent:TakeDamage(30, damager, self.Entity)
	end
	
	local dot = self:GetForward():Dot( data.HitNormal )
	if( self.LastBounce && self.LastBounce + .25 >= CurTime() ) then return end 
	
		self.LastBounce = CurTime()
		self.Bounced = true 
		self:GetPhysicsObject():SetVelocity( data.OurOldVelocity * .9 )
		local effectdata = EffectData()
		effectdata:SetOrigin( data.HitPos + data.HitNormal )
		effectdata:SetStart( data.HitPos + data.HitNormal )
		effectdata:SetNormal( data.HitNormal )
		effectdata:SetMagnitude( 2 )
		effectdata:SetScale( 1 )
		effectdata:SetRadius( 4 )
		util.Effect( "Sparks", effectdata )
	
	if( self.Collided ) then return end 
	self.Collided = true 
	
	self.Phys = self:GetPhysicsObject();
	if(self.Phys and self.Phys:IsValid()) then
		self.Phys:SetMass(5);
	end
	
	self:PhysicsInitSphere(1,"metal");
	self:SetCollisionBounds(-1*Vector(1,1,1),Vector(1,1,1));
	self:SetPos( data.HitPos ) 
	
	if( data.HitEntity == game.GetWorld() ) then 
		self:EmitSound("physics/metal/sawblade_stick2.wav", 511, 100 )
		-- timer.Simple( 0, function() 
		self:SetMoveType( MOVETYPE_NONE )
		-- end )
		
	else
	self:SetPos( data.HitPos + data.HitNormal * 8 ) 
		
		self:PhysicsDestroy()
		self:SetMoveType( MOVETYPE_NONE )
		self:SetParent( data.HitEntity ) 
		self:EmitSound("weapons/crossbow/hitbod"..math.random(1,2)..".wav", 511, 100 )
		
	end 

	timer.Simple( 0, function() if (IsValid( self ) ) then 
		self:SetSolid( SOLID_NONE ) 
		self:SetMoveType( MOVETYPE_NONE )
	-- local w = constraint.Weld( self, data.HitEntity, 0,0, 0, true, false )
	end end )
	
	local effectdata = EffectData()
	effectdata:SetOrigin( data.HitPos )
	effectdata:SetStart( data.HitNormal )
	effectdata:SetNormal( data.HitNormal )
	effectdata:SetMagnitude( 1 )
	effectdata:SetScale( 1.1 )
	effectdata:SetRadius( 1 )
   if data.HitWorld and data.MatType == MAT_METAL then
		util.Effect( "micro_he_impact_plane", effectdata )
	elseif( data.HitEntity && ( data.HitEntity.IsBodyPart || data.HitEntity:IsPlayer() || data.HitEntity:IsNPC() ) && data.MatType != MAT_METAL ) then 
		effectdata:SetScale( 0.8 )
		util.Effect( "micro_he_blood", effectdata )
	else
		util.Effect( "micro_he_impact", effectdata )
	end
end

function ENT:OnRemove()
	
	if( self.ESound ) then 	
		self.ESound:Stop()
	end 

end 

function ENT:Think()
	if( SERVER ) then 
		
		if( self:WaterLevel() > 0 ) then self:Remove() return end 
		
	
		
		local par = self:GetParent()
		if( IsValid( par ) && par:IsPlayer() && !par:Alive( ) ) then 
			
			self:Remove()
			
			return
			
		end 
		
	end 

end 
