AddCSLuaFile()

ENT.PrintName = "AP Arrow"
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

		util.SpriteTrail( self, 0, Color( 5+math.random(-5,5), 255+math.random(-5,5), 0, 100 ), true, 4, 0, 1, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
		self.LaunchTime = CurTime()
		
		local Glow = ents.Create("env_sprite")				
		Glow:SetKeyValue("model","sprites/orangeflare1.vmt")
		Glow:SetKeyValue("rendercolor","5 255 5")
		Glow:SetKeyValue("scale",tostring(.2))
		Glow:SetPos(self:GetPos())
		Glow:SetParent(self)
		Glow:Spawn()
		Glow:Activate()
	
		local Shine = ents.Create("env_sprite")
		Shine:SetPos(self:GetPos())
		Shine:SetKeyValue("renderfx", "16")
		Shine:SetKeyValue("rendermode", "3")
		Shine:SetKeyValue("renderamt", "100")
		Shine:SetKeyValue("rendercolor", "255 255 255")
		Shine:SetKeyValue("framerate12", "20")
		Shine:SetKeyValue("model", "light_glow01.spr")
		Shine:SetKeyValue("scale", tostring( .2 ) )
		Shine:SetKeyValue("GlowProxySize", tostring( .25 ))
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

		local c = Color( 5+math.random(-5,5), 255+math.random(-5,5), 0, 100 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = .5
		dlight.Decay = 0.1
		dlight.Size = 128
		dlight.DieTime = CurTime() + 0.025

	end
	
	self.LastPos = self:GetPos()
	
end 

function ENT:OnRemove()
	
	if( CLIENT && self.LastPos ) then 
	
		-- if( !self.LastPos ) then return end 
		local dlight = DynamicLight( self:EntIndex().."_2" )
		if ( dlight ) then

			local c = Color( 125+math.random(-5,5), 155+math.random(-5,5), 255, 100 )

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
	local snd = "wt/sounds/tank_hit_small2_0"..math.random(1,5)..".wav"	
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
	
	if( self.LastBounce && self.LastBounce + .25 >= CurTime() ) then return end 
	
	if( dot <= .3 && !self.Bounced ) then 

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
	
	elseif( dot > .3 && !self.Bounced ) then 
		
		self.Bounced = true 
		self:EmitSound(snd,100,100)
		local tr,trace={},{}
		tr.start = data.HitPos + self:GetForward() * 64
		tr.endpos = tr.start - self:GetForward() * 32
		tr.mask = MASK_SOLID
		tr.filter = self 
		trace = util.TraceLine( tr )
		if( !trace.Hit ) then 
			
			self:SetPos( data.HitPos + self:GetForward() * 32 )
			self:GetPhysicsObject():SetVelocity( data.OurOldVelocity * .25 )
			
			return 
			
		end 
		
		
		
	end 
	
	if( self.Collided ) then return end 
	self.Collided = true 
	self.CollisionTime = CurTime()
	timer.Simple( 0, function() if (IsValid( self ) ) then 
		self:SetSolid( SOLID_NONE ) 
		self:SetMoveType( MOVETYPE_NONE )
	-- local w = constraint.Weld( self, data.HitEntity, 0,0, 0, true, false )
	end end )
	self.Phys = self:GetPhysicsObject();
	if(self.Phys and self.Phys:IsValid()) then
		self.Phys:SetMass(5);
	end
	self:PhysicsInitSphere(1,"metal");
	self:SetCollisionBounds(-1*Vector(1,1,1),Vector(1,1,1));
	self:SetPos( data.HitPos ) --+ self:GetForward() * 24 
	
	if( data.HitEntity == game.GetWorld() ) then 
	
		-- timer.Simple( 0, function() 
		self:SetMoveType( MOVETYPE_NONE )
		-- end )
		
	elseif ( data.HitEntity )  then 
		
		self:PhysicsDestroy()
		self:SetMoveType( MOVETYPE_NONE )
		self:SetParent( data.HitEntity ) 

	end 
	
	self:EmitSound(snd, 511, 100 )


	
end

function ENT:Think()
	if( SERVER ) then 
		
		if( self:WaterLevel() > 0 ) then self:Remove() return end 
		
		if( IsValid( self:GetOwner() ) && self:GetOwner():IsPlayer( ) ) then 
			
			local kd = ( ( self.CollisionTime && self.CollisionTime + .75 <= CurTime() ) || ( self.LaunchTime && self.LaunchTime + 2.75 <= CurTime() ) )
			
			if( self.CollisionTime && self.CollisionTime + .55 <= CurTime() && !self.ClickSound ) then 	
				self.ClickSound = true 
				self:EmitSound("weapons/smg1/switch_burst.wav", 511, 100 )
			end 
			
			if( kd ) then 
				-- local snd = "wt/sounds/tank_hit_small2_0"..math.random(1,5)..".wav"
				local snd = "weapons/hegrenade/explode"..math.random(3,5)..".wav"
				local dmg = 150 
				if( IsValid( self.HitEntity ) && self.HitEntity.HealthVal ) then 
					dmg = 550 
				end 
				
				self:EmitSound( snd, 511, 130 )
				util.BlastDamage( self, self:GetOwner(), self:GetPos(), 32, 500  )
				
				ParticleEffect( "microplane_midair_explosion", self:GetPos(), self:GetAngles(), nil )
			
				local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos() )
				effectdata:SetStart( self:GetPos() )
				effectdata:SetNormal( self:GetForward() * -1  )
				effectdata:SetMagnitude( 45 )
				effectdata:SetScale( 1 )
				effectdata:SetRadius( 1 )
				util.Effect( "Sparks", effectdata )
				
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

