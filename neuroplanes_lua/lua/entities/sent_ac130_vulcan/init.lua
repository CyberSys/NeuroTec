AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sound = "ah64fire.wav"
ENT.Model = "models/ac-130/vulcan20mm.mdl"

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
	local b
	if( self.Target && self.Target:GetVelocity():Length() > 0 ) then
	
		b = Target:GetPos() + Target:GetVelocity() * self:GetVelocity():Length()
		
		if ( DEBUG ) then
			debugoverlay.Cross( Target:GetPos() + Target:GetVelocity() * self:GetVelocity():Length(), 128, 0.2, Color( 255,255,255,255 ), false )
		end
		
	else
		
		b = Target:GetPos() + Vector(math.random(-90,90),math.random(-90,90),math.random(-90,90))
		
	end
	
	local c = Vector( a.x - b.x, a.y - b.y, a.z - b.z )
	local e = math.sqrt( ( c.x ^ 2 ) + ( c.y ^ 2 ) + (c.z ^ 2 ) ) 
	local target = Vector( -( c.x / e ), -( c.y / e ), -( c.z / e ) )

	self:SetAngles( LerpAngle( 0.05, target:Angle(), self:GetAngles() ) )	
	
end

function ENT:OnUse(activator, caller)
	
	self:FireShell()
	
end

function ENT:OnTakeDamage(dmginfo)

	//self:FireShell()

end

function ENT:FireShell()
	
	self:LerpAim( self.Target )
	
	self.Shell = ents.Create("sent_ac130_20mm_shell")
	self.Shell:SetPos( self:GetPos() + self:GetForward() * 100 )
	self.Shell:SetAngles( self:GetAngles() )
	self.Shell:SetOwner( self:GetOwner() or self )
	self.Shell:SetPhysicsAttacker( self:GetOwner() or self )
	self.Shell:Spawn()
	self.Shell:Activate()
	self.Shell:GetPhysicsObject():ApplyForceCenter( self.Shell:GetForward() * 50000000 )
	
	self:GetOwner():PlayWorldSound("ac-130/ac-130_40mm_Fire.wav")
	
	local sm = EffectData()
	sm:SetStart( self:GetPos() )
	sm:SetOrigin( self:GetPos() )
	sm:SetScale( 10.5 )
	util.Effect( "a10_muzzlesmoke", sm )
	ParticleEffect( "apc_muzzleflash", self:GetPos() + self:GetForward() * 130,  self:GetAngles(), self )
	

	
end

function ENT:Think()
	
	if ( self.ShouldAttack ) then

		local burstsize = math.random(3,12)
		
		for i=1, burstsize do
			
			local vx = i / ( 4 + math.Rand(0.1,0.5) )
				
			timer.Simple( vx, function() if ( IsValid( self ) ) then self:FireShell() end  end )
			
			if ( i >= burstsize ) then
				
				self.ShouldAttack = false
				//self:SetNWBool("Attack",false) 
			end
			
		end
		
	end
	
end


