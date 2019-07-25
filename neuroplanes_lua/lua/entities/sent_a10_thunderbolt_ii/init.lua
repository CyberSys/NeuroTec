
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( "sent_a10_Thunderbolt_II" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
	construct.SetPhysProp( ply, ent, 0, nil,  { GravityToggle = true, Material = "rubber" } ) 
	
	return ent
	
end

function ENT:Initialize()
	
	self:NeuroJets_Init()
	self:SetSkin( math.random( 0, self.NbSkins ) )
	
	self:StartMotionController()

end

function ENT:OnTakeDamage(dmginfo)

	self:NeuroJets_DamageScript(dmginfo)
	
end

function ENT:OnRemove()
	
	self:NeuroJets_Remove()
		
end

function ENT:PhysicsCollide( data, physobj )

	self:NeuroJets_Collision( data, physobj )

end

function ENT:Use(ply,caller)

	self:NeuroJets_DefaultUseStuff( ply, caller )
	
end


function ENT:Think()

	self:NextThink( CurTime() )
	
	self:NeuroJets_movementScript(ply)
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		self:NeuroJets_Systems()		
	end
	
	return true
	
end

function ENT:PrimaryAttack()
	
	self:NeuroJets_PrimaryAttack(  self.MachineGunMuzzle, self.MachineGunTracer, self.MachineGunImpactFX )
	
end

function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end
