AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Claymore"
ENT.Author	= "Hoffa & Sillirion & Smithy285"
ENT.Description = ""
ENT.Category = "NeuroTec Weapons"
ENT.WeaponType = WEAPON_MINE
ENT.Spawnable = false
ENT.AdminSpawnable = false

if SERVER then
	function ENT:SpawnFunction( ply, tr, ClassName )
		local SpawnPos = tr.HitPos

		local ent = ents.Create( ClassName )
		ent:SetPos( SpawnPos - Vector( 0, 0, -5 ) )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		ent.Spawner = ply
		return ent
	end

	function ENT:Initialize()
		self:SetModel( "models/claymore.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_NONE )	
		self:SetSolid( SOLID_VPHYSICS )

		self.PhysObj = self:GetPhysicsObject()
		if ( self.PhysObj:IsValid() ) then
			self.PhysObj:Wake()
			self.PhysObj:SetMass( 5000 )
		end
		
		self:Fire( "kill", "", 600 )
	end

	function ENT:OnTakeDamage( dmginfo )
		if ( self.Destroyed ) then return end

		local douchebag = dmginfo:GetInflictor()
		if( douchebag == self ) then return end
		
		self.Destroyed = true
		
		local p = self:GetPos()
			
		local expl = ents.Create( "env_explosion" )
		expl:SetKeyValue( "spawnflags", 128 )
		expl:SetPos( p )
		expl:Spawn()
		expl:Fire( "explode", "", 0 )
		
		util.BlastDamage( self, self, p, 72, math.random( 300, 600 ) )
			
		self:Remove()
	end

	function ENT:Think()
		if ( self.Destroyed ) then return end

		local tracedata = {}
		tracedata.start = self:GetPos() + self:GetUp() * 8
		tracedata.endpos = self:GetPos() + self:GetUp() * 8 + self:GetForward() * 250 + self:GetRight() * ( math.sin( CurTime() ) * 32 )
		tracedata.filter = self
		trace = util.TraceLine( tracedata )
		
		--self:DrawLaserTracer( tracedata.start, tracedata.endpos )
		
		local te = trace.Entity

		if ( IsValid( te ) and te != self.Spawner and ( te:IsNPC() or te:IsPlayer() or te:IsVehicle() or te.HealthVal ) ) then
			self.Destroyed = true
			self:EmitSound( "ambient/machines/catapult_throw.wav", 511, math.random( 97, 104 ) )
			
			local spawner = self.Spawner
			if ( !IsValid( self.Spawner ) ) then
				self.Spawner = self
			end

			local p = self:GetPos() + Vector( 0, 0, 32 )
				
			local expl = ents.Create( "env_explosion" )
			expl:SetKeyValue( "spawnflags", 128 )
			expl:SetPos( p )
			expl:Spawn()
			expl:Fire( "explode", "", 0 )

			if spawner then									
				util.BlastDamage( spawner, spawner, p, 100, math.random( 300, 600 ) )
			else
				util.BlastDamage( self, self, p, 100, math.random( 300, 600 ) )
			end
			
			local bullet = {} 
			bullet.Num 		= 16
			bullet.Src 		= self:GetPos() + self:GetForward() * 5 + self:GetUp() * 5
			bullet.Dir 		= self:GetAngles():Forward()
			bullet.Spread 	= Vector( .2,.2, .2  )
			bullet.Tracer	= 1
			bullet.Force	= 50
			bullet.Damage	= math.random( 70, 90 )
			bullet.AmmoType = "Ar2" 
			bullet.TracerName 	= "AR2Tracer"
			bullet.Attacker = spawner
			
			self:FireBullets( bullet )
			self.Destroyed = true
			self:Remove()
			
			return
			
		end
	end 
	
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
