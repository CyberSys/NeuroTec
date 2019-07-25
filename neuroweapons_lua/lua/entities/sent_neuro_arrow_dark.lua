AddCSLuaFile()

ENT.PrintName = "Dark Matter Arrow"
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
		
		self.TempShit = {}
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:GetPhysicsObject():SetMass( 25 )
		-- self:SetNoDraw( true )
		self:Fire("Kill","",12)
		self:SetAngles( self:GetAngles() + AngleRand() * .0015 )

		util.SpriteTrail( self, 0, Color( 255,247,180, 255 ), true, 6, 0, .5, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
		
		self.ESound = CreateSound( self, "ambient/atmosphere/tone_quiet.wav" )
		self.ESound:Play()
		
		-- local Glow = ents.Create("env_sprite")				
		-- Glow:SetKeyValue("model","particles/refract_ring.vmt")
		-- Glow:SetKeyValue("rendercolor","0 0 0")
		-- Glow:SetKeyValue("scale",tostring(.05))
		-- Glow:SetKeyValue("renderfx", "16")
		-- Glow:SetKeyValue("rendermode", "5")
		-- Glow:SetPos(self:GetPos())
		-- Glow:SetParent(self)
		-- Glow:Spawn()
		-- Glow:Activate()
		local Glow = ents.Create("env_sprite")				
		Glow:SetKeyValue("model","sprites/light_glow01.vmt")
		Glow:SetKeyValue("rendercolor","255 255 255")
		Glow:SetKeyValue("scale",tostring(.5))
		Glow:SetKeyValue("renderfx", "3")
		Glow:SetKeyValue("rendermode", "3")
		Glow:SetPos(self:GetPos())
		Glow:SetParent(self)
		Glow:Spawn()
		Glow:Activate()
		-- local Shine = ents.Create("env_sprite")
		-- Shine:SetPos(self:GetPos())
		-- Shine:SetKeyValue("renderfx", "1")
		-- Shine:SetKeyValue("rendermode", "3")
		-- Shine:SetKeyValue("renderamt", "100")
		-- Shine:SetKeyValue("rendercolor", "0 0 0")
		-- Shine:SetKeyValue("framerate12", "20")
		-- Shine:SetKeyValue("model", "light_glow01.spr")
		-- Shine:SetKeyValue("scale", tostring( .75 ) )
		-- Shine:SetKeyValue("GlowProxySize", tostring( 1 ))
		-- Shine:SetParent(self)
		-- Shine:Spawn()
		-- Shine:Activate()
		
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
	util.Effect("neuro_darkmatter", edata)
	
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 255,255,255, 255 ) --Color( 100+math.sin(CurTime()*100)*150,100+math.cos(CurTime()*100)*150,100+math.sin(CurTime()*100)*150, 255 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 1 
		dlight.Decay = 2
		dlight.Size = 128+math.sin(CurTime()*4)*48
		dlight.DieTime = CurTime() + 0.5

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
	-- self:EmitSound("HL1/fvox/radiation_detected.wav",511,100)
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

	-- timer.Simple( 0, function() if (IsValid( self ) ) then self:SetSolid( SOLID_NONE ) end end )
	timer.Simple( 0, function() if (IsValid( self ) ) then 
		self:SetSolid( SOLID_NONE ) 
		-- self:SetMoveType( MOVETYPE_NONE )
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
		self.ESound:FadeOut(1,1)
		self.ESound:Stop()
	end 
	
	if( SERVER && #self.TempShit > 0 ) then 
		for k,v in pairs( self.TempShit ) do 
			if( IsValid( v ) && IsValid( v:GetPhysicsObject() ) ) then 
				
				v:GetPhysicsObject():EnableGravity( true )
			end 
		end 
		
	end 

end 

function ENT:Think()
	if( SERVER ) then 
		
		if( self:WaterLevel() > 0 ) then self:Remove() return end 
		
		if( IsValid( self:GetOwner() ) && self:GetOwner():IsPlayer( ) ) then 
			
			for k,v in pairs( ents.FindInSphere( self:GetPos(), 72 ) ) do 
				
				if( IsValid( v ) && v != self ) then 
					local vp = v:GetPhysicsObject() 
					
					if( v:GetClass() == "prop_physics" && IsValid( vp ) && vp:IsGravityEnabled() ) then 
						v:GetPhysicsObject():EnableGravity( false )
						v:GetPhysicsObject():SetVelocity( v:GetPhysicsObject():GetVelocity() + Vector(0,0,1 ) )
						if( !table.HasValue( self.TempShit, v ) ) then 
							table.insert( self.TempShit, v )
						end 
					end 
					
					local p = v:GetPos() + Vector(0,0,math.random(0,16))
					-- v:EmitSound("player/geiger1.wav",72,100)
					local dmgi = DamageInfo()
					dmgi:SetAttacker( self.Owner )
					dmgi:SetInflictor( self )
					dmgi:SetDamage( 1 )
					dmgi:SetDamageType( DMG_DISSOLVE )
					-- dmgi:SetDamageType( DMG_SONIC )
					dmgi:SetDamagePosition( p  )
					dmgi:SetDamageForce( ( v:GetPos() - self:GetPos() ):GetNormalized() * 50 )
					util.BlastDamageInfo( dmgi, p, 8  )
	
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

