AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.IronSightHoldType = "revolver"
if CLIENT then
   SWEP.PrintName = "H&K USP .45"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Pistols"

SWEP.Silenced = true 

SWEP.Spawnable = true
SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK_SILENCED
SWEP.Primary.Damage = 30
SWEP.Primary.Delay = 0.1
SWEP.Primary.Cone = 0.020

SWEP.Primary.ClipSize = 12
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 12

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1
SWEP.Primary.Sound = Sound( "USP.Single" )
SWEP.Primary.SoundSilenced = Sound( "USP.Silenced")

SWEP.UseHands	= true
-- SWEP.ViewModelFlip = true
SWEP.ViewModelFOV	= 55
SWEP.ViewModel = "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel = "models/weapons/w_pist_usp_silencer.mdl"

SWEP.HeadshotMultiplier = 2.5

-- SWEP.IronSightsPos = Vector( -5.9, -3, 4.65)
-- SWEP.IronSightsAng = Vector(0, 0, 0)