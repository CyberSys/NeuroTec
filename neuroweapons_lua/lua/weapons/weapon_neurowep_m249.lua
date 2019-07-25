AddCSLuaFile()

SWEP.HoldType = "shotgun"
SWEP.IronSightHoldType = "smg"

if CLIENT then
   SWEP.PrintName = "M249"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - MGs"

SWEP.Spawnable = true

SWEP.Primary.Damage = 38
SWEP.Primary.Delay = 0.075 -- 800rpm cyclic rof
SWEP.Primary.Cone = 0.01

SWEP.Primary.ClipSize = 150
SWEP.Primary.ClipMax = 150
SWEP.Primary.DefaultClip = 150

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AirboatGun"
SWEP.Primary.Recoil = 1.1
SWEP.Primary.Sound = Sound("Weapon_m249.Single")

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-5.96, -5.119, 4.349)
SWEP.IronSightsAng = Vector(0, 0, 0)