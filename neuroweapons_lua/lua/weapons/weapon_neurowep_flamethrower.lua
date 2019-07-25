AddCSLuaFile()

SWEP.HoldType = "shotgun"
SWEP.IronSightHoldType = "smg"

if CLIENT then
   SWEP.PrintName = "FO3 - Flamethrower"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Launchers"

SWEP.Spawnable = false

SWEP.Primary.Damage = 1
SWEP.Primary.Delay = 0.075 -- 800rpm cyclic rof
SWEP.Primary.Cone = 0.024

SWEP.Primary.ClipSize = 500
SWEP.Primary.ClipMax = 500
SWEP.Primary.DefaultClip = 500

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Recoil = 1.9
SWEP.Primary.Sound = Sound("pkm.Single")

SWEP.UseHands = false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 64
SWEP.ViewModel = "models/weapons/v_flamer.mdl"
SWEP.WorldModel = "models/weapons/w_flamer.mdl"

SWEP.HeadshotMultiplier = 2.2

-- SWEP.IronSightsPos = Vector(-2.215, -2.116, 2.36)
-- SWEP.IronSightsAng = Vector(-0.13, 0.054, 0)

function SWEP:Think()
	if( IsValid( self.Owner ) ) then 
		
		if( self:CanPrimaryAttack() && self.Owner:KeyDown( IN_ATTACK ) && !self.Flaming ) then 
			-- print( self )
			self.Flaming = true 
			ParticleEffectAttach( "flamethrower_initial", PATTAch_POINT, self, 1 )
		
		else
			
			if( !IsValid( self.Owner ) || !self.Owner:KeyDown( IN_ATTACK )  ) then 
			
				self.Flaming = false 
				self:StopParticles()
			end 
			
		end 
	
	end 

end 

function SWEP:PrimaryAttack(worldsnd)

   self:SetNextSecondaryFire( CurTime() + ( self.Secondary.Delay or 0 ) )
   self:SetNextPrimaryFire( CurTime() + ( self.Primary.Delay or 0 ) )
   
   if not self:CanPrimaryAttack() then return end

	if SERVER then

		sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
		
   end 

   self:TakePrimaryAmmo( 1 )
	self.LastAttack = CurTime()

end