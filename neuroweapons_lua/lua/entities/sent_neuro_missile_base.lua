AddCSLuaFile()

ENT.PrintName = "Missile Base"
ENT.Author = "Hoffa & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Type = "anim"

ENT.Spawnable = false
ENT.AdminSpawnable = false

local matHeatWave = Material( "sprites/heatwave" )
local matFire = Material( "effects/fire_cloud1" )

function ENT:Draw()
	if CLIENT then
		self.Entity:DrawModel()
		self.OnStart = self.OnStart or CurTime()
		
		if ( self:GetNetworkedBool( "Started", false ) ) then
			if ( self.DrawBigSmoke ) then
				self:MissileEffectDraw_FireBig()
			else
				self:MissileEffectDraw_Fire()
			end
		end
	end
end

function ENT:Initialize()
	if SERVER then
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )

		self.PhysObj = self:GetPhysicsObject()
		
		if ( self.PhysObj:IsValid() ) then
			self.PhysObj:Wake()
			self.PhysObj:SetMass( 500 )
			self.PhysObj:EnableDrag( false )
			self.PhysObj:EnableGravity( true )
		end

		self.Speed = 0
		self.Destroyed = false
		self.EngineSound = CreateSound( self, self.EngineSoundPath )

		if ( self.NeuroAdminOnly ) then
			if ( IsValid( self.Owner ) && !self.Owner:IsAdmin() ) then
				net.Start( "NeuroTec_MissileBase_Text" )
					net.WriteInt( 1, 32 )
				net.Send( self.Owner )

				self:Remove()
			end
		end

		if ( self.LaunchEffect == true ) then
			local nozzle = ents.Create( "prop_physics" )
			nozzle:SetPos( self:GetPos() + self:GetForward() * -250 )
			nozzle:SetAngles( self:GetAngles() * -1 )
			nozzle:SetModel( "models/error.mdl" )
			nozzle:SetRenderMode( RENDERMODE_TRANSALPHA )
			nozzle:SetColor( Color( 0, 0, 0, 0 ) )
			nozzle:SetParent( self )
			nozzle:Spawn()

			print(tostring(nozzle))

			ParticleEffectAttach( "scud_trail", PATTACH_ABSORIGIN_FOLLOW, nozzle, 0 )
			ParticleEffect( "scud_launch", self:GetPos() + self:GetForward() * -200, self:GetAngles() * -1, self )
		end

	elseif CLIENT then
		local pos = self:LocalToWorld( self.NozzlePos or Vector( 0, 0, 0 ) )

		self.Emitter = ParticleEmitter( pos , false )
		self.Seed = math.Rand( 0, 10000 )
	end
end

if SERVER then
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos = ( tr.HitPos + ( tr.HitNormal * 12 ) )
		local vec = ply:GetAimVector():Angle()
		local newAng = Angle( 0, vec.y, 0 )
		local ent = ents.Create( class )

		if ent.SpawnPos then
			ent:SetPos( SpawnPos + ent.SpawnPos )
		else
			ent:SetPos( SpawnPos )
		end

		if ent.SpawnAngle then
			ent:SetAngles( ent.SpawnAngle )
		else
			ent:SetAngles( newAng )
		end

		ent:Spawn()
		ent:Activate()
		ent.Owner = ply
		
		return ent		
	end

	function ENT:PhysicsCollide( data, physobj )
		if ( self.Destroyed ) then return end
		
		if ( ( data.Speed > 450 && data.DeltaTime > 0.2 && self.Started ) ) then 
			self:MissileDoExplosion()
		end
	end

	function ENT:PhysicsUpdate()
		if self.WeaponType == WEAPON_MISSILE then
			if ( self.Started ) then
				self.Speed = self.Speed + 550
				self.PhysObj:ApplyForceCenter( self:GetForward() * self.Speed )
			end
		end
	end

	function ENT:Use( activator, caller, var1, var2 )
		if ( !self.Started ) then
			self.EngineSound:Play()
			self.Owner = activator

			net.Start( "NeuroTec_MissileBase_Text" )
				net.WriteInt( 2, 32 )
				net.WriteString( self.PrintName )
			net.Send( self.Owner )

			self.Started = true
			self:SetNetworkedBool( "Started", true )
			self.PhysObj:EnableMotion( true )
			self.PhysObj:Wake()
		end
	end

	function ENT:OnTakeDamage( dmginfo )
		if ( self.Destroyed ) then return end
		
		if ( self.HealthVal >= 0 ) then
			self.HealthVal = self.HealthVal - dmginfo:GetDamage()
			self.Owner = dmginfo:GetAttacker()
		else
			self:MissileDoExplosion()
		end
	end

	function ENT:Think()
		if ( self.ThinkCallback ) then
			self.ThinkCallback( )
		end

		if CLIENT and self.LaunchEffect == true then
			local dlight = DynamicLight( self:EntIndex() )

			if ( dlight ) then
				local c = Color( 250+math.random(-5,5), 170+math.random(-5,5), 0, 100 )
				dlight.Pos = self:GetPos()
				dlight.r = c.r
				dlight.g = c.g
				dlight.b = c.b
				dlight.Brightness = 1
				dlight.Decay = 0.1
				dlight.Size = 2048
				dlight.DieTime = CurTime() + 0.15
			end
		end
	end 

	function ENT:OnRemove()
		if( self.EngineSound ) then 
		
			self.EngineSound:Stop()
			
		end 
		
	end

	-- function ENT:PhysicsUpdate() self:DefaultMissilePhysUpdate() end

	function ENT:MissileDoExplosion()
		if ( self.ExplodeCallback ) then
			self.ExplodeCallback( self )
		end
		
		self.Destroyed = true
		
		if( self.ExplosionSound ) then 
			
			self:PlayWorldSound( self.ExplosionSound )
			self:EmitSound( self.ExplosionSound, 511, 100 )
			
		end 
		
		-- local explo = EffectData()
		-- explo:SetOrigin( self:GetPos() )
		-- util.Effect( "Explosion", explo )
		
		self:NeuroWepsDetonatePhysics()
		
		local pe = ents.Create( "env_physexplosion" )
		pe:SetPos( self:GetPos() )
		pe:SetKeyValue( "Magnitude", ( 5 * self.Damage ) )
		pe:SetKeyValue( "radius", self.Radius )
		pe:SetKeyValue( "spawnflags", 19 )
		pe:Spawn()
		pe:Activate()
		pe:Fire( "Explode", "", 0 )
		pe:Fire( "Kill", "", 0.5 )
		
		ParticleEffect( self.VEffect, self:GetPos(), self:GetAngles(), nil )
		
		local own = self.Owner
		if ( !IsValid( own ) ) then
			own = self
		end
		
		-- print( self.Damage, self.Radius )
		util.BlastDamage( self, own, self:GetPos()+  Vector(0,0,50), self.Radius, self.Damage )
		
		self:Remove()
	end

elseif CLIENT then
	function ENT:MissileEffectDraw_Fire()
		if self.WeaponType != WEAPON_MISSILE then return end

		local pos = self:LocalToWorld( self.NozzlePos ) -- self:GetPos() + self:GetForward() * -200
		
		for i=1,3 do
			local particle = self.Emitter:Add( "particle/smokesprites_000" .. math.random( 1, 9 ), pos )

			if ( particle ) then
				particle:SetVelocity( (self:GetVelocity()/10) *-1 + Vector( math.Rand( -2.5,2.5),math.Rand( -2.5,2.5),math.Rand( 2.5,15.5)  ) + self:GetForward()*-280 )
				particle:SetDieTime( math.Rand( 0.42, .725 ) )
				particle:SetStartAlpha( math.Rand( 35, 65 ) )
				particle:SetEndAlpha( 0 )
				-- particle:EnableCollisions( true )
				particle:SetStartSize( math.Rand( 12, 14 ) )
				particle:SetEndSize( math.Rand( 25, 35 ) )
				particle:SetRoll( math.Rand( 0, 360 ) )
				particle:SetRollDelta( math.Rand( -1, 1 ) )
				particle:SetColor( math.Rand( 185, 205 ), math.Rand( 185, 205 ), math.Rand( 180, 205 ) ) 
				particle:SetAirResistance( 100 ) 
				particle:SetGravity( self:GetForward() * -500 + VectorRand():GetNormalized()*math.Rand(-140, 140)+Vector(0,0,math.random(-15, 15)) ) 	
			end
		end
		
		local vOffset = self:LocalToWorld( self.NozzlePos )
		local vNormal = ( vOffset - self:GetPos() ):GetNormalized()
		local scroll = ( self.Seed + ( CurTime() * -10 ) )
		local Scale = 0.5 -- math.Clamp( (CurTime() - self.OnStart) * 5, 0, 1 )
			
		render.SetMaterial( matFire )
		
		render.StartBeam( 3 )
			render.AddBeam( vOffset, 32 * Scale, scroll, Color( 0, 0, 255, 128) )
			render.AddBeam( vOffset + vNormal * 60 * Scale, 16 * Scale, scroll + 1, Color( 255, 255, 255, 128) )
			render.AddBeam( vOffset + vNormal * 148 * Scale, 16 * Scale, scroll + 3, Color( 255, 255, 255, 0) )
		render.EndBeam()
		
		scroll = scroll * 0.5
		
		render.UpdateRefractTexture()
		render.SetMaterial( matHeatWave )
		render.StartBeam( 3 )
			render.AddBeam( vOffset, 45 * Scale, scroll, Color( 0, 0, 255, 128) )
			render.AddBeam( vOffset + vNormal * 16 * Scale, 16 * Scale, scroll + 2, Color( 255, 255, 255, 255) )
			render.AddBeam( vOffset + vNormal * 64 * Scale, 24 * Scale, scroll + 5, Color( 0, 0, 0, 0) )
		render.EndBeam()
		
		scroll = scroll * 1.3

		render.SetMaterial( matFire )
		render.StartBeam( 3 )
			render.AddBeam( vOffset, 8 * Scale, scroll, Color( 0, 0, 255, 128) )
			render.AddBeam( vOffset + vNormal * 32 * Scale, 8 * Scale, scroll + 1, Color( 255, 255, 255, 128) )
			render.AddBeam( vOffset + vNormal * 108 * Scale, 8 * Scale, scroll + 3, Color( 255, 255, 255, 0) )
		render.EndBeam()
	end

	function ENT:MissileEffectDraw_FireBig()
		if self.WeaponType != WEAPON_MISSILE then return end

		local pos = self:LocalToWorld( self.NozzlePos ) -- self:GetPos() + self:GetForward() * -200
		
		for i=1,3 do
			local particle = self.Emitter:Add( "particle/smokesprites_000" .. math.random( 1, 9 ), pos )

			if ( particle ) then
				particle:SetVelocity( (self:GetVelocity()/10) *-1 + Vector( math.Rand( -2.5,2.5),math.Rand( -2.5,2.5),math.Rand( 2.5,15.5)  ) + self:GetForward()*-280 )
				particle:SetDieTime( math.Rand( 1.42, 3.725 ) )
				particle:SetStartAlpha( math.Rand( 35, 65 ) )
				particle:SetEndAlpha( 0 )
				-- particle:EnableCollisions( true )
				particle:SetStartSize( math.Rand( 42, 54 ) )
				particle:SetEndSize( math.Rand( 125, 135 ) )
				particle:SetRoll( math.Rand( 0, 360 ) )
				particle:SetRollDelta( math.Rand( -1, 1 ) )
				particle:SetColor( math.Rand( 185, 205 ), math.Rand( 185, 205 ), math.Rand( 180, 205 ) ) 
				particle:SetAirResistance( 100 ) 
				particle:SetGravity( self:GetForward() * -500 + VectorRand():GetNormalized()*math.Rand(-140, 140)+Vector(0,0,math.random(-15, 15)) ) 	
			end
		end
		
		local vOffset = self:LocalToWorld( self.NozzlePos )
		local vNormal = ( vOffset - self:GetPos() ):GetNormalized()
		local scroll = ( self.Seed + ( CurTime() * -10 ) )
		local Scale = 2.5 -- math.Clamp( (CurTime() - self.OnStart) * 5, 0, 1 )
			
		render.SetMaterial( matFire )
		
		render.StartBeam( 3 )
			render.AddBeam( vOffset, 32 * Scale, scroll, Color( 0, 0, 255, 128) )
			render.AddBeam( vOffset + vNormal * 60 * Scale, 16 * Scale, scroll + 1, Color( 255, 255, 255, 128) )
			render.AddBeam( vOffset + vNormal * 148 * Scale, 16 * Scale, scroll + 3, Color( 255, 255, 255, 0) )
		render.EndBeam()
		
		scroll = scroll * 0.5
		
		render.UpdateRefractTexture()
		render.SetMaterial( matHeatWave )
		render.StartBeam( 3 )
			render.AddBeam( vOffset, 45 * Scale, scroll, Color( 0, 0, 255, 128) )
			render.AddBeam( vOffset + vNormal * 16 * Scale, 16 * Scale, scroll + 2, Color( 255, 255, 255, 255) )
			render.AddBeam( vOffset + vNormal * 64 * Scale, 24 * Scale, scroll + 5, Color( 0, 0, 0, 0) )
		render.EndBeam()
		
		
		scroll = scroll * 1.3
		render.SetMaterial( matFire )
		render.StartBeam( 3 )
			render.AddBeam( vOffset, 8 * Scale, scroll, Color( 0, 0, 255, 128) )
			render.AddBeam( vOffset + vNormal * 32 * Scale, 8 * Scale, scroll + 1, Color( 255, 255, 255, 128) )
			render.AddBeam( vOffset + vNormal * 108 * Scale, 8 * Scale, scroll + 3, Color( 255, 255, 255, 0) )
		render.EndBeam()
	end
end