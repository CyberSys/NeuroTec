AddCSLuaFile()
if( SERVER ) then 
	resource.AddFile("materials/sprites/poison/")
end 
ENT.PrintName = "Love Arrow"
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
		-- self:SetNoDraw( true )
		self:Fire("Kill","",10)
		self:SetAngles( self:GetAngles() + AngleRand() * .0015 )
		
		util.SpriteTrail( self, 0, Color( 255,5,0, 255 ), true, 4, 0, 1, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
		
		-- self.ESound = CreateSound( self, "ambient/levels/citadel/citadel_ambient_scream_loop1.wav" )
		-- self.ESound:Play()
		
		local Glow = ents.Create("env_sprite")				
		Glow:SetKeyValue("model","sprites/poison/cross2.vmt")
		Glow:SetKeyValue("rendercolor","255 5 5")
		Glow:SetKeyValue("scale",tostring(.01))
		Glow:SetPos(self:GetPos())
		Glow:SetParent(self)
		Glow:Spawn()
		Glow:Activate()
	
		local Shine = ents.Create("env_sprite")
		Shine:SetPos(self:GetPos())
		Shine:SetKeyValue("renderfx", "13")
		Shine:SetKeyValue("rendermode", "3")
		Shine:SetKeyValue("renderamt", "100")
		Shine:SetKeyValue("rendercolor", "255 5 5")
		Shine:SetKeyValue("framerate12", "20")
		Shine:SetKeyValue("model", "light_glow01.spr")
		Shine:SetKeyValue("scale", tostring( .75 ) )
		Shine:SetKeyValue("GlowProxySize", tostring( 1 ))
		Shine:SetParent(self)
		Shine:Spawn()
		Shine:Activate()
		
	end 
	if( CLIENT ) then 
		
		-- timer.Simple( 0.1, function()
	
			
		-- end )
	
	end 
	
end 
function ENT:Draw()

	self:DrawModel()
	
	local edata = EffectData()
	edata:SetEntity(self)
	edata:SetOrigin( self:GetPos() )
	edata:SetStart( self:GetPos() )
	edata:SetMagnitude(10)
	edata:SetScale(10)
	util.Effect("neuro_health", edata)
	
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 255,5,5, 255 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = math.Rand( 0.25, 1 )
		dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
		dlight.Size = math.random(64,128)
		dlight.DieTime = CurTime() + 0.1

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
	
	self.Phys = self:GetPhysicsObject();
	if(self.Phys and self.Phys:IsValid()) then
		self.Phys:SetMass(5);
	end
	self:PhysicsInitSphere(1,"metal");
	self:SetCollisionBounds(-1*Vector(1,1,1),Vector(1,1,1));
	self:SetPos( data.HitPos ) 
	if( data.HitEntity == game.GetWorld() ) then 
		self:EmitSound("weapons/crossbow/hit1.wav", 511, 100 )
		-- timer.Simple( 0, function() 
		self:SetMoveType( MOVETYPE_NONE )
		-- end )
		
	elseif ( data.HitEntity )  then 
		
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
		
		if( IsValid( self:GetOwner() ) && self:GetOwner():IsPlayer( ) ) then 
			
			for k,v in pairs( ents.FindInSphere( self:GetPos(), 32 ) ) do 
				
				if( IsValid( v ) && v != self && ( v:IsPlayer() || v:IsNPC() ) ) then 
					
					if( v:Health() < 500 ) then 
					
						v:SetHealth( v:Health() + 1 )
					
					end 
					if( v:IsPlayer() && v:Armor() < 250 ) then 
						v:SetArmor( v:Armor() + 1 ) 
					end 
					-- local p = v:GetPos() + Vector(0,0,math.random(0,72))
					
					-- local dmgi = DamageInfo()
					-- dmgi:SetAttacker( self.Owner )
					-- dmgi:SetInflictor( self )
					-- dmgi:SetDamage( math.random(1,3) )
					-- dmgi:SetDamageType( DMG_POISON )
					-- dmgi:SetDamagePosition( p  )
					-- dmgi:SetDamageForce( ( v:GetPos() - self:GetPos() ):GetNormalized() * 50 )
					-- util.BlastDamageInfo( dmgi, p, 16  )
	
				end 
				
			end 
		
		end 
		
		local par = self:GetParent()
		if( IsValid( par ) && par:IsPlayer() && !par:Alive( ) ) then 
			
			self:Remove()
			
			return
			
		end 
		
	end 

end 
function ENT:Use( ply, act, a, b )
	
	if( ply:IsPlayer() ) then 
		
		ply:Give( 1, "AirboatGun", false )
		self:Remove()
		
	end 

end 

