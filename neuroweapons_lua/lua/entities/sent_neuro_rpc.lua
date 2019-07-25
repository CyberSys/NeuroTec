AddCSLuaFile()

ENT.PrintName = "NeuroTec Rocket Propelled Chainsaw"
ENT.Author = "Hoffa & Jaanus"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_MISSILE

ENT.HealthVal = 16 -- missile health
ENT.Damage = 250 -- missile damage
ENT.Radius = 200 -- missile blast radius
ENT.NozzlePos = Vector( -12, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = Sound("weapons/arch_chainsaw/chainsaw_attack.wav") -- Engine sound, precached or string filepath.
ENT.Model = "models/jaanus/rpc.mdl" -- 3d model
ENT.VEffect = "rt_impact_tank" -- The effect we call with ParticleEffect()
ENT.DrawBigSmoke = false
ENT.ExplosionSound = Sound( "wt/misc/bomb_explosion_"..math.random(1,6)..".wav" ) 
ENT.SpawnPos = Vector( 0, 0, 30 )
ENT.SpawnAngle = Angle( -90, 0, 0 )

-- if CLIENT then 
local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )


-- end 


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
			self.PhysObj:SetMass( 5000 )
			self.PhysObj:EnableDrag( true )
			self.PhysObj:EnableGravity( true )
		end

		self.Speed = 0
		self.Destroyed = false
		self.EngineSound = CreateSound( self, self.EngineSoundPath )
		self.EngineSound:Play()
		self:SetPos( self:GetPos() + self:GetRight() * 8 + self:GetForward() * 4 + self:GetUp() * 2 )
		
		self.PhysObj:SetVelocityInstantaneous( self:GetForward() * 108450 )
		self.PhysObj:SetVelocity( self:GetForward() * 108450 )

		self:FireEngine() 
		
	end 
	
	self.Bounces = 0 
	self.StartTime = CurTime() 
	
	-- self:SetPos( self:GetPos() + self:GetForward() * 16 )
	-- ParticleEffect( "navalgun_muzzleflash_3", self:GetPos(), a, nil ) --[[
																  -- Watch how smithy forgets this 
																  -- particle in the workshop version
																  -- then watch how he forgets the textures
																  -- and materials. 
															-- ]]

	self.HealthVal = 50 
	
end 

function ENT:FireEngine( ) 
	-- print("why")
	self.Damage = math.random(2500,4500)
	self.Radius = math.random(512,760)
	self.EngineSound:PlayEx(511,100)
	self.ActivatedAlmonds = true 
	self:SetNWBool("EngineStarted", true )
	local a = self:GetAngles()
	a:RotateAroundAxis( self:GetUp(), 180 )
	
	local prop = ents.Create("prop_physics")
	prop:SetPos( self:LocalToWorld( Vector( -0,0,0 ) ) )
	prop:SetAngles( a )
	prop:SetParent( self )
	prop:SetModel( "models/items/ar2_grenade.mdl" )
	prop:Spawn()
	prop:SetRenderMode( RENDERMODE_TRANSALPHA )
	prop:SetColor( Color (0,0,0,0 ) )
	local what = ParticleEffectAttach( "scud_trail", PATTACH_ABSORIGIN_FOLLOW, prop, 0 )
	self.Shell = prop 
	
	ParticleEffect( "tank_muzzleflash", self:GetPos(), a, nil ) --[[
																  Watch how smithy forgets this 
																  particle in the workshop version
																  then watch how he forgets the textures
																  and materials. 
															]]
end 
function ENT:PhysicsCollide( data ) 
	
	self.Bounces = self.Bounces + 1 
	self.SpeedValue = 0 
	self.TargetEntity = NULL 
	
	if( self.Bounces > 2 ) then 
	
		self:MissileDoExplosion()
		
	end 

end 
local speedCap = 4800

function ENT:PhysicsUpdate()
	if( !self.ActivatedAlmonds ) then return end 
	if( SERVER ) then 
		if( self.StartTime + 15 <= CurTime() ) then self.Bounces = 3 return end 
		
		if( !self.Target ) then return end 
		
		if( self:GetVelocity():Length() < speedCap ) then 
		
			self.SpeedValue = self.SpeedValue + 55
		
		end 
		
		if( IsValid( self.TargetEntity ) ) then
		
			self:SetAngles( LerpAngle( 0.9, self:GetAngles(), (self.TargetEntity:GetPos()- self:GetPos() ):GetNormalized():Angle() ) )
		
		end 
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * self.SpeedValue + VectorRand() * 50 )
			
	end 

end 

function ENT:Think()
	
	if( SERVER ) then 
		
		-- if( IsValid( self.TargetEntity ) && ( self:GetPos() - self.TargetEntity:GetPos() ):Length() < 32 ) then 
			
			-- self:MissileDoExplosion()
			
			-- return 
		
		-- end 
		
		local tr,trace={},{}
		tr.start = self:GetPos()
		tr.endpos = tr.start + self:GetForward() * 150 + VectorRand() * 16
		tr.filter = { self, self.Owner, self.Shell  }
		tr.mask = MASK_SOLID
		trace = util.TraceLine( tr )
		debugoverlay.Line( tr.start, trace.HitPos, .1, Color(5,255,5,255), true )
		
		if( trace.Hit ) then 
	
			local damage = DamageInfo()
			damage:SetAttacker( self.Owner )
			damage:SetDamage( math.random( 55, 75 ) )
			damage:SetDamageForce( self:GetVelocity() )
			damage:SetInflictor( self )
			damage:SetDamageType( DMG_BLAST + DMG_SLASH + DMG_aLWAYSGIB )
			damage:SetDamagePosition( trace.HitPos ) 
				
			util.BlastDamageInfo( damage, trace.HitPos , 16 )

			local effectdata = EffectData()
			effectdata:SetOrigin( trace.HitPos )
			effectdata:SetStart( trace.HitNormal )
			effectdata:SetNormal( trace.HitNormal )
			effectdata:SetMagnitude( 1 )
			effectdata:SetScale( 0.85 )
			effectdata:SetRadius( 1 )

			local mat = trace.MatType
			if( mat == MAT_FlESH || mat == MAT_ALIENFLESH || mat == MAT_BLOODYFLESH ) then 
				
				for i=1,5 do 
					local dir = VectorRand()*128
					util.Decal( "Blood",trace.HitPos + dir, trace.HitPos - dir )
					
				end 
				
				self.Owner:EmitSound("npc/manhack/grind_flesh"..math.random(1,3)..".wav", 511, 50 )
				effectdata:SetScale( 0.9 )
				util.Effect( "micro_he_blood", effectdata )
			
			elseif( mat == MAT_METAL || mat == MAT_CONCRETE || mat == MAT_COMPUTER || mat == MAT_TILE || mat == MAT_GRATE ) then 
			
				util.Decal( "ManhackCut",trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal )
				self.Owner:EmitSound("npc/manhack/grind"..math.random(1,5)..".wav", 511, 100 )
				effectdata:SetScale( .25 )
				util.Effect( "micro_he_impact", effectdata )
				effectdata:SetScale( 2 )
				util.Effect( "ManhackSparks", effectdata )
			
			else
				
				util.Decal( "ManhackCut",trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal )
				self.Owner:EmitSound("npc/manhack/grind"..math.random(1,5)..".wav", 511, 100 )
				effectdata:SetScale( .5 )
				util.Effect( "micro_he_impact", effectdata )
			
			end 
				
		end 
		
	end 
	
end 
function ENT:Draw()
	self:DrawModel()

		if( !self.Emittime ) then self.Emittime = 0 end 

		if( !self.Emitter ) then 
		
			self.Emitter = ParticleEmitter( self:GetPos() , false )
			self.Seed = math.Rand( 0, 10000 )
			
		end 

				
		self:NextThink(CurTime())
		
		if (self.Emittime < CurTime()) then
			
			local dist = 45
		
			if( !self:GetNWBool("EngineStarted" ) ) then 
			
				local smoke = self.Emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
				smoke:SetVelocity(self:GetForward()*-800)
				smoke:SetDieTime(math.Rand(.9,1.2))
				smoke:SetStartAlpha(math.Rand(11,25))
				smoke:SetEndAlpha(0)
				smoke:SetStartSize(math.random(14,18))
				smoke:SetEndSize(math.random(66,99))
				smoke:SetRoll(math.Rand(180,480))
				smoke:SetRollDelta(math.Rand(-2,2))
				smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
				smoke:SetAirResistance(60)
			
			
				return 
			
			end 
				
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then

			local c = Color( 250+math.random(-5,5), 170+math.random(-5,5), 0, 100 )

			dlight.Pos = self:GetPos() + self:GetForward() * -25
			dlight.r = c.r
			dlight.g = c.g
			dlight.b = c.b
			dlight.Brightness = 1
			dlight.Decay = 0.1
			dlight.Size = 128
			dlight.DieTime = CurTime() + 0.15

		end
		
		local fire = self.Emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
		fire:SetVelocity(self:GetForward()*-10)
		fire:SetDieTime(math.Rand(.05,.1))
		fire:SetStartAlpha(math.Rand(222,255))
		fire:SetEndAlpha(0)
		fire:SetStartSize(math.random(4,5))
		fire:SetEndSize(math.random(20,33))
		fire:SetAirResistance(150)
		fire:SetRoll(math.Rand(180,480))
		fire:SetRollDelta(math.Rand(-3,3))
		fire:SetStartLength(15)
		fire:SetColor(255,100,0)
		fire:SetEndLength(math.Rand(100, 150))

		local fire = self.Emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
		fire:SetVelocity(self:GetForward()*-10)
		fire:SetDieTime(math.Rand(.05,.1))
		fire:SetStartAlpha(math.Rand(222,255))
		fire:SetEndAlpha(0)
		fire:SetStartSize(math.random(3,6))
		fire:SetEndSize(math.random(20,33))
		fire:SetAirResistance(150)
		fire:SetRoll(math.Rand(180,480))
		fire:SetRollDelta(math.Rand(-3,3))
		fire:SetColor(255,110,0)

		local fire = self.Emitter:Add("effects/yellowflare", self:GetPos() + self:GetForward()*-dist)
		fire:SetVelocity(self:GetForward()*-10)
		fire:SetDieTime(math.Rand(.03,.05))
		fire:SetStartAlpha(math.Rand(222,255))
		fire:SetEndAlpha(0)
		fire:SetStartSize(math.random(1,5))
		fire:SetEndSize(math.random(99,100))
		fire:SetAirResistance(150)
		fire:SetRoll(math.Rand(180,480))
		fire:SetRollDelta(math.Rand(-3,3))
		fire:SetColor(255,120,0)
		
		-- self.Emitter:Finish()
		
	end

		
end 

function ENT:Use( p,o,_o,_p ) return end 
