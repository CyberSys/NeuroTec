AddCSLuaFile()

ENT.PrintName = "Land Mine"
ENT.Author = "Hoffa / Sillirion"
ENT.Category = "NeuroTec Weapons"
ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_MINE

ENT.Description = "Spawns a mine that explodes in the vicinity of an enemy"

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end

if SERVER then
	function ENT:SpawnFunction( ply, tr)
		local SpawnPos = tr.HitPos
		local ent = ents.Create( "sent_land_mine" )
		ent:SetPos( SpawnPos + tr.HitNormal * 5 )
		ent:Spawn()
		ent:Activate()
		ent.Spawner = ply

		return ent
	end

	function ENT:Initialize()
		self:SetModel( "models/landmine.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )		
		self:SetSolid( SOLID_VPHYSICS )

		self.PhysObj = self:GetPhysicsObject()
		if (self.PhysObj:IsValid()) then
			self.PhysObj:Wake()
			self.PhysObj:SetMass(50)
		end
		-- Despawn after 10 minutes.
		self:Fire( "kill", "", 600 )
	end

	function ENT:Think()
		local tr, trace = {},{}
		tr.start = self:GetPos()
		tr.endpos = tr.start + self:GetUp() * 16
		tr.filter = self
		trace = util.TraceLine( tr ) 
		
		if( trace.Hit && IsValid( trace.Entity ) && !trace.HitWorld && trace.Entity.Owner && trace.Entity.Owner != self ) then
			local expl = ents.Create("env_explosion")
			expl:SetKeyValue("spawnflags",128)
			expl:SetPos( self:GetPos() )
			expl:Spawn()
			expl:Fire("explode","",0)
			
			ParticleEffect( "ap_impact_dirt", self:GetPos(), Angle(0,0,0), nil )

			util.BlastDamage( self, self, self:GetPos(), 128, math.random( 500, 1000 ) )
			
			self:Remove()
		end
	end

	function ENT:StartTouch( ent )
		if( self.Destroyed ) then return end
		if ( !IsValid( ent ) or ( !IsValid( self.Spawner ) ) ) then return end

		if( ent:IsPlayer() && self.Spawner:IsPlayer() ) then
			
			for k,v in pairs( player.GetAll() ) do
				
				if( self.Spawner == ent ) then
					net.Start( "NeuroTec_MissileBase_Text" )
						net.WriteInt( 3, 32 )
						net.WriteString( ent:Name() )
					net.Send( v )
				else
					net.Start( "NeuroTec_MissileBase_Text" )
						net.WriteInt( 4, 32 )
						net.WriteString( ent:Name() )
						net.WriteString( self.Spawner:Name() )
					net.Send( v )
				end
			end
		end
		
		self:EmitSound( "ambient/machines/catapult_throw.wav", 100, math.random(97,104) )
		self:EmitSound("ambient/explosions/explode_1.wav",511,100)
				
		local spawner = self.Spawner

		local p = self:GetPos() + Vector( 0,0,32 )

		if( !spawner ) then self:Remove() return end
		
		local expl = ents.Create("env_explosion")
		expl:SetKeyValue("spawnflags",128)
		expl:SetPos( p )
		expl:Spawn()
		expl:Fire("explode","",0)
		
		ParticleEffect( "ap_impact_dirt", self:GetPos(), Angle(0,0,0), nil )
		
		if ( IsValid( spawner ) ) then
			util.BlastDamage( spawner, spawner, p, 512, math.random( 500, 1512 ) )
		end
		
		self.Destroyed = true
		
		self:Remove()
		
		return
	end
end