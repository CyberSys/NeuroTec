AddCSLuaFile()

SWEP.HoldType = "shotgun"
SWEP.IronSightHoldType = "smg"

if CLIENT then
   SWEP.PrintName = "PKM"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - MGs"

SWEP.Spawnable = true

SWEP.Primary.Damage = 45
SWEP.Primary.Delay = 0.075 -- 800rpm cyclic rof
SWEP.Primary.Cone = 0.024

SWEP.Primary.ClipSize = 150
SWEP.Primary.ClipMax = 150
SWEP.Primary.DefaultClip = 150

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AirboatGun"
SWEP.Primary.Recoil = 1.9
SWEP.Primary.Sound = Sound("pkm.Single")

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_mach_russ_pkm.mdl"
SWEP.WorldModel = "models/weapons/w_mach_russ_pkm.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-2.215, -2.116, 2.36)
SWEP.IronSightsAng = Vector(-0.13, 0.054, 0)
