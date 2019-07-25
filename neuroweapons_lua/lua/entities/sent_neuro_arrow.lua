AddCSLuaFile()

ENT.PrintName = "HE Arrow"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Equipment Stuff"
ENT.Base = "base_anim"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.InitialHealth = 75
ENT.Model = "models/ml/explosive_arrow.mdl" 

function ENT:Initialize()

	self.HealthVal = self.InitialHealth 
	self:SetNWInt("HealthVal", math.floor( self.HealthVal ) )
	
	if SERVER then
		
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:GetPhysicsObject():SetMass( 50 )
		self:Fire("Kill","",30)
		self:SetAngles( self:GetAngles() + AngleRand() * .0015 )

		self:Ignite(30,30)
		
		util.SpriteTrail( self, 0, Color( 191+math.random(-5,5), 64+math.random(-5,5), 0, 255 ), true, 4, 0, 1, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
		
		local Glow = ents.Create("env_sprite")				
		Glow:SetKeyValue("model","sprites/orangeflare1.vmt")
		Glow:SetKeyValue("rendercolor","191 64 0")
		Glow:SetKeyValue("scale",tostring(.35))
		Glow:SetKeyValue("renderfx", "10")
		Glow:SetPos(self:GetPos())
		Glow:SetParent(self)
		Glow:Spawn()
		Glow:Activate()
	
		local Shine = ents.Create("env_sprite")
		Shine:SetPos(self:GetPos())
		Shine:SetKeyValue("renderfx", "10")
		Shine:SetKeyValue("rendermode", "3")
		Shine:SetKeyValue("renderamt", "50")
		Shine:SetKeyValue("rendercolor", "191 64 0")
		Shine:SetKeyValue("framerate12", "20")
		Shine:SetKeyValue("model", "sprites/fire.spr")
		Shine:SetKeyValue("scale", tostring( 2.1 ) )
		Shine:SetKeyValue("GlowProxySize", tostring( .5 ))
		Shine:SetParent(self)
		Shine:Spawn()
		Shine:Activate()
		
	end 
	
	if( CLIENT ) then 
		
	end 
	
end 
function ENT:Draw()

	self:DrawModel()
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 191+math.random(-5,5), 64+math.random(-5,5), 0, 100 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = .5
		dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
		dlight.Size = math.random(64,128)
		dlight.DieTime = CurTime() + 0.025

	end
	
	self.LastPos = self:GetPos()
	
end 

function ENT:OnRemove()
	
	if( CLIENT && self.LastPos ) then 
	
		-- if( !self.LastPos ) then return end 
		local dlight = DynamicLight( self:EntIndex().."_2" )
		if ( dlight ) then

			local c = Color( 191+math.random(-5,5), 64+math.random(-5,5), 0, 100 )

			dlight.Pos = self.LastPos
			dlight.r = c.r
			dlight.g = c.g
			dlight.b = c.b
			dlight.Brightness = 2 + math.Rand( 0, 1 )
			dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.1

		end
		
	end 

end 

function ENT:PhysicsCollide( data )
	
	local dot = self:GetForward():Dot( data.HitNormal )
	if( self.LastBounce && self.LastBounce + .25 >= CurTime() ) then return end 
	
	if( dot <= .45 && !self.Bounced ) then 

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
		
		return 
		
	end 
	
	if( self.Collided ) then return end 
	self.Collided = true 
	timer.Simple( 0, function() if (IsValid( self ) ) then 
		self:SetSolid( SOLID_NONE ) 

	-- local w = constraint.Weld( self, data.HitEntity, 0,0, 0, true, false )
	end end )
	
	self.Phys = self:GetPhysicsObject();
	if(self.Phys and self.Phys:IsValid()) then
		self.Phys:SetMass(5);
	end
	self:PhysicsInitSphere(1,"metal");
	self:SetCollisionBounds(-1*Vector(1,1,1),Vector(1,1,1));
	self:SetPos( data.HitPos ) 
	if( data.HitEntity == game.GetWorld() ) then 
		self:EmitSound("weapons/crossbow/hit1.wav", 511, 100 )
		self:SetMoveType( MOVETYPE_NONE )
	elseif ( data.HitEntity )  then 
		self:PhysicsDestroy()
		self:SetMoveType( MOVETYPE_NONE )
		self:SetParent( data.HitEntity ) 
		self:EmitSound("weapons/crossbow/hitbod"..math.random(1,2)..".wav", 511, 100 )
		
	end 
	
	local effectdata = EffectData()
	effectdata:SetOrigin( data.HitPos )
	effectdata:SetStart( data.HitNormal )
	effectdata:SetNormal( data.HitNormal )
	effectdata:SetMagnitude( 1 )
	effectdata:SetScale( 1.1 )
	effectdata:SetRadius( 1 )
	self.HitEntity = data.HitEntity 
	
   if data.HitWorld and data.MatType == MAT_METAL then
		util.Effect( "micro_he_impact_plane", effectdata )
	elseif( data.HitEntity && ( data.HitEntity.IsBodyPart || data.HitEntity:IsPlayer() || data.HitEntity:IsNPC() ) && data.MatType != MAT_METAL ) then 
		effectdata:SetScale( 0.8 )
		util.Effect( "micro_he_blood", effectdata )
	else
		util.Effect( "micro_he_impact", effectdata )
	end
end

function ENT:Think()
	if( SERVER ) then 
		
		if( self:WaterLevel() > 0 ) then self:Remove() return end 
		
		if( IsValid( self:GetOwner() ) && self:GetOwner():IsPlayer( ) ) then 
			
			local kd = self:GetOwner():KeyDown( IN_RELOAD )
			if( kd ) then 
				local snd = "weapons/hegrenade/explode"..math.random(3,5)..".wav"
				self:EmitSound( snd, 511, 100 )
				util.BlastDamage( self, self:GetOwner(), self:GetPos(), 72, 100  )
				
				-- if( IsValid( self.HitEntity ) ) then 
					-- ParticleEffectAttach( "microplane_midair_explosion", PATTACH_ABSORIGIN_FOLLOW, self.HitEntity, 0 )
				-- else 
					ParticleEffect( "microplane_midair_explosion", self:GetPos(), self:GetAngles(), nil )
				-- end 
				
				self:Remove()
				
				return 
			end 
		
		end 
		
		local par = self:GetParent()
		if( IsValid( par ) && par:IsPlayer() && !par:Alive( ) ) then 
			
			self:Remove()
			
			return
			
		end 
		
	else 

	end 

end 

function ENT:Use( ply, act, a, b )
	
	if( ply:IsPlayer() ) then 
		
		ply:Give( 1, "AirboatGun", false )
		self:Remove()
		
	end 

end 

