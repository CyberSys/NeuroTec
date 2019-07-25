AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sound = "ah64fire.wav"
ENT.Model = "models/ac-130/howitzer.mdl"

function ENT:Initialize()

	self:SetModel( self.Model )
	self:SetMaterial("models/props_pipes/GutterMetal01a")
	self:SetColor(  Color( 0, 94, 8, 255 ) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:PhysicsInit( SOLID_NONE )
	self:SetMoveType( MOVETYPE_NONE )	
	self:SetSolid( SOLID_NONE )

	if self:GetOwner() == nil then
		
		return

	end
	self:SetUseType( SIMPLE_USE )
	self:SetPhysicsAttacker(self:GetOwner() or self)

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

function ENT:OnTakeDamage(dmginfo)

	//self:FireShell()

end

function ENT:FireShell()

	if( !IsValid( self.Target ) ) then 
		
		return
		
	end
	
	self:GetOwner():PlayWorldSound("ac-130/ac-130_105mm_Fire.wav")
	
	local Shell = ents.Create("sent_ac130_105mm_shell")
	Shell:SetPos( self:GetPos() + self:GetForward() * 195 )
	Shell:SetAngles( self:GetAngles() )
	Shell.Owner = self.Owner
	Shell:SetPhysicsAttacker( self:GetOwner() or self )
	Shell:Spawn()
	Shell:Activate()
	Shell:GetPhysicsObject():ApplyForceCenter( Shell:GetForward() * 5000 )
	
	ParticleEffect( "arty_muzzleflash", self:GetPos(), self:GetAngles() + Angle( 0, 0, 0 ), nil )

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

