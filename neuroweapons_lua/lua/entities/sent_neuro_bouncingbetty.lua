AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Bouncing Betty"
ENT.Author = "Hoffa & Smithy285"
ENT.Description = ""
ENT.Category = "NeuroTec Weapons"
ENT.WeaponType = WEAPON_MINE
ENT.Spawnable = true
ENT.AdminSpawnable = false

if SERVER then
	ENT.Model = "models/weapons/w_eq_flashbang_thrown.mdl"
	ENT.Bounce = false

	function ENT:SpawnFunction( ply, tr, ClassName )
		local SpawnPos = tr.HitPos
		
		local ent = ents.Create( ClassName )
		ent:SetPos( SpawnPos - Vector( 0, 0, -3 ) )
		ent:Spawn()
		ent:Activate()
		ent:SetOwner( ply )
		return ent	
	end

	function ENT:Initialize()
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_NONE )	
		self:SetSolid( SOLID_VPHYSICS )
		self.PhysObj = self:GetPhysicsObject()
		
		if ( self.PhysObj:IsValid() ) then
			self.PhysObj:Wake()
		end
	end

	local function boom( ent, victim )
		if ( !IsValid( ent ) ) then return end
		if ( !IsValid( ent.Owner ) ) then
			ent.Owner = ent
		end

		if victim == ent.Owner then
			net.Start( "NeuroTec_MissileBase_Text" )
				net.WriteInt( 6, 32 )
			net.Send( ent.Owner )
		
		elseif victim != ent.Owner && !victim:IsNPC() then
				local victim_name = victim:Name() 

				net.Start( "NeuroTec_MissileBase_Text" )
					net.WriteInt( 5, 32 )
					net.WriteString( victim_name )
				net.Send( ent.Owner )
			
			elseif victim != ent.Owner && victim:IsNPC() then
				local victim_name = victim:GetClass() 

				net.Start( "NeuroTec_MissileBase_Text" )
					net.WriteInt( 5, 32 )
					net.WriteString( victim_name )
				net.Send( ent.Owner )
		end

		local explo1 = EffectData()
		explo1:SetOrigin( ent:GetPos() + Vector( 0, 0, -10 ) )
		explo1:SetScale( 2.25 )
		explo1:SetNormal( Vector( 0, 0, 1 ) )
		util.Effect( "ManhackSparks", explo1 )
		
		local explo = EffectData()
		explo:SetOrigin( ent:GetPos() )
		util.Effect( "Explosion", explo )
		
		util.BlastDamage( ent.Owner, ent.Owner, ent:GetPos(), 85, math.random( 300, 600 ) )
		
		ent:Remove()
	end

	function ENT:Think()
		for k, v in pairs( ents.FindInSphere( self:GetPos(), 64 ) ) do
			if not IsValid( v ) then return end
			
			--if ( v:IsNPC() or v:IsPlayer() and self.Bounce == false and v != self:GetOwner() ) then
			if ( v:IsNPC() or v:IsPlayer() and self.Bounce == false ) then
				self:SetMoveType( MOVETYPE_VPHYSICS )
				self:SetPos( self:GetPos() + self:GetUp() * 9 )
				self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * 500 )
				self.Bounce = true

				timer.Simple( 0.3, function() boom( self, v ) end )
			end
		end
	end
elseif CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
