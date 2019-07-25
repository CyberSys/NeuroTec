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
		local c = Color( 239,0,255, 255 )
		util.SpriteTrail( self, 0, c, true, 8, 0, 0.15, .1, "trails/plasma.vmt")
		self.LaunchTime = CurTime()
		-- local Glow = ents.Create("env_sprite")				
		-- Glow:SetKeyValue("model","sprites/light_glow01.vmt")
		-- Glow:SetKeyValue("rendercolor","255 255 255")
		-- Glow:SetKeyValue("scale",tostring(.25))
		-- Glow:SetPos(self:GetPos())
		-- Glow:SetParent(self)
		-- Glow:Spawn()
		-- Glow:Activate()
	
		-- local Shine = ents.Create("env_sprite")
		-- Shine:SetPos(self:GetPos())
		-- Shine:SetKeyValue("renderfx", "11")
		-- Shine:SetKeyValue("rendermode", "3")
		-- Shine:SetKeyValue("renderamt", "100")
		-- Shine:SetKeyValue("rendercolor", "239 0 255")
		-- Shine:SetKeyValue("framerate12", "20")
		-- Shine:SetKeyValue("model", "light_glow01.spr")
		-- Shine:SetKeyValue("scale", tostring( .2 ) )
		-- Shine:SetKeyValue("GlowProxySize", tostring( .25 ))
		-- Shine:SetParent(self)
		-- Shine:Spawn()
		-- Shine:Activate()
		
	end 
	if( CLIENT ) then 
		
	end 
	
end

function ENT:Draw()

	self:DrawModel()
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 255, 5+math.random(-5,5), 0, 100 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = .5
		dlight.Decay = 0.1
		dlight.Size = 128
		dlight.DieTime = CurTime() + 0.025

	end

end 

function ENT:OnRemove()

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
	
	-- timer.Simple( 0, function() if (IsValid( self ) ) then self:SetSolid( SOLID_NONE ) end end )
	
	
	self.CollisionTime = CurTime()
	self:Fire("kill","",5)
	self.Phys = self:GetPhysicsObject();
	if(self.Phys and self.Phys:IsValid()) then
		self.Phys:SetMass(5);
	end
	self:PhysicsInitSphere(1,"metal");
	self:SetCollisionBounds(-1*Vector(1,1,1),Vector(1,1,1));
	self:SetPos( data.HitPos ) --+ self:GetForward() * 24 
	
	timer.Simple( 0, function() if (IsValid( self ) ) then 
		self:SetSolid( SOLID_NONE ) 
		self:SetMoveType( MOVETYPE_NONE )
	-- local w = constraint.Weld( self, data.HitEntity, 0,0, 0, true, false )
	end end )
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

function ENT:PhysicsUpdate()
	
	if( self.Fired ) then return end 
	
	local tr,trace = {},{}
	tr.start = self:GetPos()
	tr.endpos = tr.start + self:GetForward() * 512 
	tr.filter = { self, self.Owner }
	tr.mask = MASK_SOLID
	trace = util.TraceLine( tr )
	if( trace.Hit ) then 
		self.Fired = true 
		local bullet = {} 
		bullet.Num 		= 15
		bullet.Src 		= self:GetPos() + self:GetForward() * 38
		bullet.Dir 		= self:GetAngles():Forward()
		bullet.Spread 	= Vector( math.Rand( -.3, .3 ), math.Rand( -.3, .3 ), math.Rand( -.3, .3 ) ) --Vector( .1, .1, .1 )*math.Rand(-1,1)
		bullet.Tracer	= 1
		bullet.Force	= 15
		bullet.filter = { self, self.Owner }
		bullet.Attacker = self.Owner
		bullet.Inflictor = self
		bullet.Damage	= math.random( 10, 15 )
		bullet.AmmoType = "Ar2" 
		bullet.TracerName 	= "Tracer"
		bullet.Callback    = function ( a, b, c )
								
								local effectdata = EffectData()
									effectdata:SetOrigin( b.HitPos )
									effectdata:SetStart( b.HitNormal )
									effectdata:SetNormal( b.HitNormal )
									effectdata:SetMagnitude( 1 )
									effectdata:SetScale( 0.5 )
									effectdata:SetRadius( 1 )
								-- if( math.random(1,2) == 1 ) then 
								-- util.Effect( "micro_he_impact", effectdata )
								-- else
								if( b.Entity && ( b.Entity:IsNPC() || b.Entity:IsPlayer() ) ) then 
								effectdata:SetScale( .85 )
								util.Effect( "micro_he_blood", effectdata )
								else
								util.Effect( "micro_he_impact_plane", effectdata )
								util.Effect( "micro_flak", effectdata )
								end 
								
								return { damage = true, effects = DoDefaultEffect } 
								
						end 

		local sm = EffectData()
		sm:SetStart(  self:GetPos() + self:GetForward()*1 )
		sm:SetOrigin( self:GetPos() + self:GetForward()*1  )
		sm:SetEntity( self )		
		sm:SetAttachment( 0 )
		sm:SetNormal( self:GetForward() )
		sm:SetScale( .51 )
		util.Effect( "micro_he_impact", sm )
		util.Effect( "micro_flak", sm )
		 
		ParticleEffect( "mg_muzzleflash", self:GetPos(), self:GetAngles(), nil )
			
		-- util.Effect( "ManhackSparks", sm )
		-- util.Effect( "AirboatMuzzleFlash", sm )

		self:EmitSound( "weapons/m3/m3-1.wav", 511, 100 )
		self:FireBullets( bullet )
		
		self:Fire("kill","",.1)
		-- self:GetPhysicsObject():Set
		
		return 
		-- self:GetPhysicsObject():SetVelocity( self:GetForward() * -5  )
		-- self:Fire("kill","",5)
	
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
		
	else 

	end 

end 

function ENT:Use( ply, act, a, b )
	
	if( ply:IsPlayer() ) then 
		
		ply:Give( 1, "AirboatGun", false )
		self:Remove()
		
	end 

end 

