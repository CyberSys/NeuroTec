AddCSLuaFile()

ENT.PrintName = "NeuroTec Flechette"
ENT.Author = "Hoffa & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false
-- ENT.AdminOnly = true 

ENT.WeaponType = WEAPON_MISSILE

ENT.HealthVal = 1000000 -- missile health
ENT.Damage = 95 -- missile damage
ENT.Radius = 65 -- missile blast radius
ENT.NozzlePos = Vector( -12, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = Sound("bf4/rockets/pods_rocket_engine_wave 2 0 0_2ch.wav") -- Engine sound, precached or string filepath.
ENT.Model = "models/items/ar2_grenade.mdl" -- 3d model
ENT.VEffect = "v1_impact" -- The effect we call with ParticleEffect()
ENT.DrawBigSmoke = false
ENT.ExplosionSound = Sound( "wt/misc/bomb_explosion_"..math.random(1,6)..".wav" ) 
ENT.SpawnPos = Vector( 0, 0, 30 )
ENT.SpawnAngle = Angle( -90, 0, 0 )

function ENT:Initialize()
	if SERVER then
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		self.SpeedValue = 0 
		
		self.PhysObj = self:GetPhysicsObject()
		
		if ( self.PhysObj:IsValid() ) then
			self.PhysObj:Wake()
			self.PhysObj:SetMass( 1 )
			self.PhysObj:EnableDrag( true )
			self.PhysObj:EnableGravity( true )
		end

		self.Speed = 0
		self.Destroyed = false
		
		util.SpriteTrail( self, 0, Color( 255,5,5,45 ), true, 4, 10, .45, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
		
		local sprite = ents.Create("env_sprite")
		sprite:SetPos(self:LocalToWorld( Vector( -5,0,1 ) ) )
		sprite:SetKeyValue("renderfx", "0")
		sprite:SetKeyValue("rendermode", "5")
		sprite:SetKeyValue("renderamt", "255")
		sprite:SetKeyValue("rendercolor", "255 5 5")
		sprite:SetKeyValue("framerate12", "20")
		sprite:SetKeyValue("model", "light_glow03.spr")
		sprite:SetKeyValue("scale", "0.05")
		sprite:SetKeyValue("GlowProxySize", "16")
		sprite:SetParent(self)
		sprite:Spawn()
		sprite:Activate()
	end 
	

	-- 
	-- ParticleEffect( "microplane_bomber_explosion", self:GetPos() + Vector(0,0,16), self:GetAngles(), nil )
end 

function ENT:TakeDamage() return end 


function ENT:PhysicsCollide( data ) 
	if( !self.Stuck  ) then
		self.Stuck = true 

		self.Phys = self:GetPhysicsObject();
		if(self.Phys and self.Phys:IsValid()) then
			self.Phys:SetMass(1);
		end
		self:PhysicsInitSphere(1,"metal");
		self:SetCollisionBounds(-1*Vector(1,1,1),Vector(1,1,1));
		
		timer.Simple( 0, function()
				
				self:ImpactDust()
					
				self:EmitSound( "npc/antlion/shell_impact"..math.random(1,4)..".wav", 70, 80 )
				self:SetPos( data.HitPos  )
				if( data.HitEntity:IsPlayer() ) then 
					
					self:SetParent( data.HitEntity )
					
				else 
				
					local weld = constraint.Weld( self, data.HitEntity, 0,0, 0, true )
		
				end 
		end )
	
	end 
	
end 
function ENT:PhysicsUpdate()
	
	local tr,trace={},{}
	tr.start = self:GetPos()
	tr.endpos = tr.start + self:GetForward() * 50
	tr.filter = { self, self.Owner }
	tr.mask = MASK_SOLID 
	trace = util.TraceLine( tr )
	if( trace.Hit && trace.HitGroup == HITGROUP_HEAD && !self.Shot ) then 
		
		-- self.Shot = true 
		
		-- timer.Simple( 0,function() 
		
			-- local ang = ( self:GetPos() - b.HitPos ):Normalize()
			-- local bullet = {} 
			-- bullet.Num 		= 1
			-- bullet.Src 		= self:GetPos() + self:GetForward()*6.5
			-- bullet.Dir 		= self:GetForward()
			-- bullet.Attacker = self.Owner
			-- bullet.Spread 	= Vector() 
			-- bullet.Tracer	= 0
			-- bullet.Force	= 50
			-- bullet.Damage	= math.random(75,85)
			-- bullet.HullSize = 1	
			-- bullet.TracerName 	= "tracer"
			
			-- self:FireBullets( bullet  ) 
			
			self:PopFlechette()
			
		-- end ) 
		
		return 
		
	end 
	
	-- cuustom callback
	if( !self.Stuck && trace.Hit && !trace.HitWorld ) then
		self.Stuck = true 
		timer.Simple( 0, function()
				
				self:ImpactDust()
				self:EmitSound( "npc/antlion/shell_impact"..math.random(1,4)..".wav", 70, 80 )
				self:SetPos( trace.HitPos + trace.HitNormal * -2 )
				self:SetOwner( trace.Entity )
				self:SetParent( trace.Entity )
				self.HitEntity = trace.Entity 
				
				
		end )
	
	end 
	
end 

function ENT:PopFlechette()
	
	-- if( IsValid( self.Owner ) ) then 
		
		-- self.Owner:EmitSound("weapons/slam/mine_mode.wav", 100, 100 )
	
	-- end 
	local newPos = self:LocalToWorld( Vector( -5,0,1 ) )

	local snd = "weapons/hegrenade/explode"..math.random(3,5)..".wav"
	local blastpos = self:GetPos()
	
	if( self:WaterLevel() > 0 ) then 
		
		local tr,trace = {},{}
		tr.start = self:GetPos() + Vector( 0,0,100 )
		tr.endpos = tr.start + Vector( 0,0,-120)
		tr.mask = MASK_SOLID + MASK_WATER
		tr.filter = self 
		trace = util.TraceLine( tr ) 
		blastpos = trace.HitPos 
		
		ParticleEffect( "water_impact_big_mini", trace.HitPos, self:GetForward()*-1, nil )
		snd = "misc/shel_hit_water_"..math.random(1,3)..".wav"
	else 
		
		if( self.Stuck ) then 
		
			ParticleEffect( "microplane_bomber_explosion", newPos, self:GetAngles(), nil )
			ParticleEffect( "Explosion", newPos, self:GetAngles()*-1, nil )

		else 
		
			ParticleEffect( "microplane_midair_explosion", newPos, self:GetAngles(), nil )
					
		end 
			
	end 
	
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 16 ) ) do 
		
		if( !v.HealthVal && v != self ) then 
			
			local vp = v:GetPhysicsObject()
			if( IsValid( vp )  )  then 
				
				--vp:Wake()
				--vp:EnableMotion( true )
				--vp:EnableGravity( true )
				--vp:EnableDrag( true )
				
			end 
			
			--if( v:GetClass() == "prop_physics" ) then 
			
				--constraint.RemoveConstraints( v, "Weld" )
				--constraint.RemoveConstraints( v, "Axis" )
			
			--end 
			
		end 
			
	end 
			
	local pe = ents.Create( "env_physexplosion" )
	pe:SetPos( newPos )
	pe:SetKeyValue( "Magnitude", 500 )
	pe:SetKeyValue( "radius", 64 )
	pe:SetKeyValue( "spawnflags", 19 )
	pe:Spawn()
	pe:Activate()
	pe:Fire( "Explode", "", 0 )
	pe:Fire( "Kill", "", 0.25 )
			
	self:PlayWorldSound( snd )
	self:EmitSound( snd, 511, 100 )
	
	local tr,trace = {},{}
	tr.start = self:GetPos() + self:GetForward() * -16
	tr.endpos = tr.start + self:GetForward() * 40
	tr.mask = MASK_SOLID
	tr.filter = self 
	trace = util.TraceLine( tr ) 
	
	local a,b = trace.HitPos + trace.HitNormal * 4, trace.HitPos - trace.HitNormal * 4
	util.Decal("Scorch", a, b )
	
	local own = self.Owner
	if ( !IsValid( own ) ) then
		own = self
	end
	
	util.BlastDamage( self, own, newPos, self.Radius, self.Damage  )
	
	self:Remove()

end 

function ENT:ImpactDust()
		
	local normal = self:GetAngles()
	normal:RotateAroundAxis( self:GetUp(), 180 )
	-- local ang = normal:Angle()
	
	local effectdata = EffectData()
	effectdata:SetOrigin( self:GetPos() )
	effectdata:SetStart( self:GetPos() )
	effectdata:SetNormal( normal:Forward() )
	effectdata:SetMagnitude( 1 )
	effectdata:SetScale( .5 )
	effectdata:SetRadius( 1 )
	util.Effect( "micro_he_impact", effectdata )
		
end 

function ENT:Think()
	if( !SERVER ) then return end 
	if( !IsValid( self.Owner ) ) then return end 
	if( !self.Owner:IsPlayer() ) then return end 
	if( !self.Owner.LastDetonation ) then self.Owner.LastDetonation = 0 end 
	
	if( self.Owner:KeyDown( IN_ATTACK2 ) && self.Owner.LastDetonation + 0.25 <= CurTime() ) then 
		
		self.Owner.LastDetonation = CurTime()
		self.Owner:EmitSound("items/nvg_on.wav", 511, 200 )
		self:EmitSound("buttons/blip2.wav", 511, 200 )
		
		timer.Simple( 0.25, function() 
			if( !IsValid( self ) ) then return end 
			self:PopFlechette()
		
		end )
		-- self:Remove()
		
	end 
	
	
end 
function ENT:Draw()
-- 
	self:DrawModel()
					
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 250+math.random(-5,5), 5+math.random(-5,5), 0, 100 )
		dlight.Pos = self:LocalToWorld( Vector( -5,0,1 ) )
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = math.abs( math.sin(CurTime()*100) * 2 )
		dlight.Decay = FrameTime()*2
		dlight.Size = 10
		dlight.DieTime = CurTime() + 0.15

	end
		
end 

function ENT:Use( p,o,_o,_p ) return end 
