
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.explodeDel = NULL
ENT.explodeTime = 10

function ENT:Initialize()

	self:SetModel("models/items/AR2_Grenade.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
	phys:Wake()
	phys:SetMass( 10 )
	phys:SetVelocity( self:GetForward() * self.ShellVelocity  )
	end
	
	local ft = ents.Create("env_Fire_trail")
	ft:SetPos( self:GetPos() )
	ft:SetParent( self )
	ft:SetAngles( self:GetAngles() )
	ft:Spawn()
	
	self.explodeDel = CurTime() + self.explodeTime
end


function ENT:Think()

	self:NextThink( CurTime() + 0.1 )

	self:GetPhysicsObject():ApplyForceCenter( self:GetAngles():Forward() * 3000 )
	-- self:GetPhysicsObject():AddAngleVelocity( Angle( 1000, 0, 0 ) ) --spinning shell :D

end

function ENT:PhysicsUpdate()
		
	if( self:WaterLevel() > 1 ) then
		
		self:NeuroPlanes_SurfaceExplosion()
		
		self:Remove()
		
		return
		
	end

end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime > 0.2 ) then
		
		if( self:WaterLevel() > 0 ) then self:Remove() return end
		
		if ( IsValid( data.HitEntity ) && data.HitEntity:GetOwner() == self:GetOwner() ) then // Plox gief support for SetOwner ( table )
			
			return
			
		end
		if( !IsValid( self.Owner ) ) then self.Owner = self end
		if( !IsValid( self.Creditor ) ) then self.Creditor = self end
		
					
		if (data.Speed > 50 && data.DeltaTime > 0.1 ) then 
		
			self:Explode( data )
			
		end


	end
	
end

function ENT:Explode( data )

	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	
	if( IsValid( data.HitEntity ) ) then
		
		data.HitEntity:Ignite( 3, 32 )
	
	end
	
	for k,v in pairs( ents.FindInSphere( data.HitPos, 128 ) ) do
		
		v:Ignite( 3, 32 )
		
	end
	
	-- local expl = ents.Create("env_explosion")
	-- expl:SetKeyValue("spawnflags",128)
	-- expl:SetPos(self:GetPos())
	-- expl:Spawn()
	-- expl:Fire("explode","",0)
	local fx = EffectData()
	fx:SetStart( data.HitPos )
	fx:SetOrigin( data.HitPos )
	fx:SetNormal( data.HitNormal )
	fx:SetScale( 60.0 )
	util.Effect("Firecloud", fx )
	
	self:EmitSound( "bf2/weapons/lw155_artillery_Fire.mp3", 511, 100 )
	
	if( self.MinDamage && self.MaxDamage ) then
		
		local dmg = math.random( self.MinDamage, self.MaxDamage )
		
		if( dmg > self.MaxDamage * 0.9 && self.Owner:IsPlayer() ) then
			
			self.Owner:PrintMessage( HUD_PRINTCENTER, "CRIT!" )
		
		end
		
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos(), 128, dmg )
	
	else
	
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos(), 128, math.random( 100, 450 ) )

	end
	
	self:Remove()
end
