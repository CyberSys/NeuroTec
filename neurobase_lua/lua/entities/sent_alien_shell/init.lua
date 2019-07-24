AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sauce = 100
ENT.Delay = 0
ENT.Speed = 8000

function ENT:Initialize()
	
	self.seed = math.random( 0, 1000 )

--//Need a better bullet model! Using the hl2 AR2 grenade until the new model...	
--	self:SetModel( "models/Shells/shell_large.mdl" )
	self:SetModel( "models/items/AR2_Grenade.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.Radius = self.Radius or 32
	self:SetPos( self:GetPos() + self:GetForward() * 16 )
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 50 )
		
	end
	local TrailDelay = math.Rand( .25, .5 ) / 25
	local TraceScale1 = .35
	local TraceScale2 = .35
	local GlowProxy = 1
	-- print( "GlowProxy: ", GlowProxy, self.TracerGlowProxy )
	-- if( self.TinyTrail ) then
		
	-- self.SpriteTrail = util.SpriteTrail( self, 0, Color( math.random(245,255), math.random(245,255), math.random(245,255), math.random(25,45) ), false, 4,0, TrailDelay + 0.85, 1/(1)*0.55, "trails/smoke.vmt");  
	-- self.SpriteTrail2 = util.SpriteTrail( self, 0, Color( 255, 255, 100, 255 ), false, 4, 4, TrailDelay + 0.05, 1/(0+4)*0.55, "sprites/smokez");  
	
	-- self.SpriteTrail = util.SpriteTrail( 
						-- self, 
						-- 0, 
						-- Color( 255, 
						-- 123, 
						-- 0, 
						-- 255 ), 
						-- false,
						-- 6, 
						-- 6, 
						-- TrailDelay, 
						 -- 1 / ( 0 + 6) * 0.5, 
						-- "trails/smoke.vmt" );
						
	self.SpriteTrail2 = util.SpriteTrail( 
						self, 
						0, 
						Color( 0, 
						0, 
						255, 
						15 ), 
						true,
						8, 
						2, 
						TrailDelay*11, 
						 1 / ( 0 + 48 ) * 0.5, 
						"trails/smoke.vmt" );
						
	local Glow = ents.Create("env_sprite")				
	Glow:SetKeyValue("model","sprites/orangeflare1.vmt")
	Glow:SetKeyValue("rendercolor","5 5 255")
	Glow:SetKeyValue("scale",tostring(.5))
	Glow:SetPos(self:GetPos())
	Glow:SetParent(self)
	Glow:Spawn()
	Glow:Activate()

	local Shine = ents.Create("env_sprite")
	Shine:SetPos(self:GetPos())
	Shine:SetKeyValue("renderfx", "6")
	Shine:SetKeyValue("rendermode", "5")
	Shine:SetKeyValue("renderamt", "100")
	Shine:SetKeyValue("rendercolor", "255 255 255")
	Shine:SetKeyValue("framerate12", "20")
	Shine:SetKeyValue("model", "light_glow01.spr")
	Shine:SetKeyValue("scale", tostring( .5 ) )
	Shine:SetKeyValue("GlowProxySize", tostring( GlowProxy ))
	Shine:SetParent(self)
	Shine:Spawn()
	Shine:Activate()

	self:DeleteOnRemove( self.SpriteTrail2 )
	self:SetAngles( self:GetAngles() + AngleRand() * .01 )
	self.Started = CurTime() 
	self.DetonationTime  = math.Rand( 0.65, 1.25 )
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.HitEntity && data.HitEntity:GetClass() == self:GetClass() ) then return end 
	
	self.Phys = self:GetPhysicsObject();
	if(self.Phys and self.Phys:IsValid()) then
		self.Phys:SetMass(4);
	end
	self:PhysicsInitSphere(1,"metal");
	self:SetCollisionBounds(-1*Vector(1,1,1),Vector(1,1,1));
	
	self.LastPos = data.HitPos
	self.HitNormal =  data.HitNormal*-1
	self.CollideObject = data.HitEntity
	if( IsValid( data.HitEntity ) && ( data.HitEntity.HealthVal != nil || data.HitEntity.Health != nil ) ) then
		
		self.HitObject = true
		local edata = EffectData()
		edata:SetEntity(data.HitEntity)
		edata:SetMagnitude(10)
		edata:SetScale(10)
		util.Effect("TeslaHitBoxes", edata)
		
		if( data.HitEntity:IsNPC() || data.HitEntity:IsPlayer() ) then
			
			self.HitSquishy = true
		
		end
		
	end

	self:Remove()

end

function ENT:Think( )

	self:NextThink(CurTime())
	
	if( IsValid( self ) ) then 
		self:GetPhysicsObject():Wake()
	end 
	
	if( self.Started && self.Started + self.DetonationTime < CurTime() ) then 
	
		self:Remove()
		
		
	end 
	
	return true 
	
end 

function ENT:PhysicsUpdate()
	-- self:GetPhysicsObject():SetVelocity( self:GetForward() * 5000000000 )
	if(  self:WaterLevel() > 0 ) then
		
		self:Remove()
		
		return
		
	end

end

-- function ENT:PhysicsUpdate()
	
	-- local tr,trace ={},{}
	-- tr.start = self:GetPos()
	-- tr.endpos = tr.start + self:GetForward() * 20
	-- tr.filter = { self, self.Owner }
	-- tr.mask = MASK_SHOT_HULL
	-- trace = util.TraceLine( tr )
	-- self:DrawLaserTracer( tr.start, tr.endpos )
	-- if( trace.Hit ) then
		
		-- self:GetPhysicsObject():Sleep()
		-- self:Remove()
		
		-- return
		
	-- end
	
-- end

function ENT:OnRemove()
	
	-- print( self.Owner )
	if ( !IsValid( self.Owner ) ) then
	
		self.Owner = self
		
	end
	if( !self.LastPos ) then self.LastPos = self:GetPos() end 
	
	local ImpactSound = "misc/AA_shot_big_"..math.random(1,4)..".wav"
	-- self:PlayWorldSound( ImpactSound )
	self:EmitSound( ImpactSound, 511, 50 )
	if( self:WaterLevel() == 0 ) then
	
		local impact = EffectData()
		impact:SetOrigin( self:GetPos() + Vector( 0,0,2))
		impact:SetStart( self:GetPos()  + Vector( 0,0,2))
		impact:SetScale( .75 )
		impact:SetNormal( self.HitNormal or self:GetForward()*-1 )
		util.Effect("alien_splosion", impact )
		
		if( self.HitSquishy ) then
			
			util.Effect("micro_he_blood", impact)
			self:EmitSound( "Bullet.Flesh", 511, 80 )
					
		end 
		
	else
		
		local impact = EffectData()
		impact:SetOrigin( self:GetPos() + Vector( 0,0,2))
		impact:SetStart( self:GetPos()  + Vector( 0,0,2))
		impact:SetScale( 1 )
		impact:SetNormal( self.HitNormal or self:GetForward()*-1 )
		-- impact:SetScale( .5 )
	
		util.Effect("WaterSurfaceExplosion", impact)

	end

	local dmg = 400
	local radius = self.Radius or 50
	if( self.MinDamage && self.MaxDamage ) then
		
		dmg = math.random( self.MinDamage, self.MaxDamage )
		
	end
	
	if( IsValid( self.Owner ) && IsValid( self.Owner.Pilot ) ) then -- how the fuck is this happening?
		
		self.Owner = self.Owner.Pilot
		
	end
	
	local dmgi = DamageInfo()
	dmgi:SetAttacker( self.Owner )
	dmgi:SetInflictor( self )
	dmgi:SetDamage( dmg )
	dmgi:SetDamageType( DMG_DISSOLVE )
	dmgi:SetDamagePosition( self.LastPos  )
	dmgi:SetDamageForce( self.Owner:GetAimVector() * 50 )
	util.BlastDamageInfo( dmgi,self.LastPos , radius  )
	-- util.BlastDamage( self, self.Owner, self:GetPos()+Vector(0,0,8), radius, dmg )
	-- print( self.Owner, radius, dmg, self.CollideObject )
	if( self:WaterLevel() == 0 ) then
	
		-- if( self.TracerScale1 && self.TracerScale1 >= 1 ) then
		
			-- util.Decal( "scorch", self:GetPos(), self.HitNormal && self.HitNormal * -32 or self:GetPos() + self:GetForward() *16 )

		-- else
		
		util.Decal( "SmallScorch", self:GetPos(), self.HitNormal && self:GetPos() + self.HitNormal * -32 or self:GetPos() + self:GetForward() * 16 )

		
		-- end
		
	end
	
	-- self:Remove()
	
end
