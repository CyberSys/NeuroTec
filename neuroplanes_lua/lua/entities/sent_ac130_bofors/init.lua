AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sound = "ah64fire.wav"
ENT.Model = "models/torpedotube.mdl"

function ENT:Initialize()

	self.Entity:SetModel( self.Model )
	self.Entity:PhysicsInit( SOLID_NONE )
	self.Entity:SetMoveType( MOVETYPE_NONE )	
	self.Entity:SetSolid( SOLID_NONE )
	
	if self.Entity:GetOwner() == nil then
		
		return

	end
	self:SetUseType( SIMPLE_USE )
	self.Entity:SetPhysicsAttacker(self:GetOwner() or self)

end

function ENT:LerpAim(Target)

	if ( Target == nil ) then

		return

	end
	
	if (!Target:IsValid()) then
			
		return
		
	end
	
	local a = self:GetPos() 
	local b = Target:GetPos() 
	local c = Vector( a.x - b.x, a.y - b.y, a.z - b.z )
	local e = math.sqrt( ( c.x ^ 2 ) + ( c.y ^ 2 ) + (c.z ^ 2 ) ) 
	local target = Vector( -( c.x / e ), -( c.y / e ), -( c.z / e ) )
	
	self:SetAngles( LerpAngle( 0.005, target:Angle(), self:GetAngles() ) )
	
end

function ENT:OnUse(activator, caller)
	
	self:FireShell()
	
end

function ENT:FireShell()
	
	
	self:GetOwner():PlayWorldSound("ac-130/ac-130_40mm_Fire.wav")
	
	self.Shell = ents.Create("sent_ac130_40mm_shell")
	self.Shell:SetPos( self:GetPos() + self:GetForward() * 60 )
	self.Shell:SetAngles( self:GetAngles() )
	self.Shell:SetOwner( self:GetOwner() or self )
	self.Shell:SetPhysicsAttacker( self:GetOwner() or self )
	self.Shell:Spawn()
	self.Shell:Activate()
	self.Shell:GetPhysicsObject():ApplyForceCenter( self.Shell:GetForward() * 500000 )
	
	ParticleEffect( "tank_muzzleflash", self:GetPos(), self:GetAngles() + Angle( 0, 0, 0 ), nil )

		
	self.ShouldAttack = false
	
end

function ENT:Think()

	self:NextThink( CurTime() + 0.25 )
	
	if ( self.ShouldAttack ) then
	
		self:GunAim( self.Target )
	
		self:FireShell()
		
	end
	
end

function ENT:OnRemove()

	
end

