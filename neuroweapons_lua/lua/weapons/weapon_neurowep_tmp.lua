AddCSLuaFile()

SWEP.HoldType = "pistol"

if CLIENT then
   SWEP.PrintName = "TMP-S"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - SMG"

SWEP.Spawnable = true

SWEP.Primary.Damage = 17
SWEP.Primary.Delay = 0.045
SWEP.Primary.Cone = 0.020

SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 54
SWEP.Primary.DefaultClip = 30

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1.3
SWEP.Primary.Sound = Sound( "TMP.Single" )

SWEP.UseHands	= true
-- SWEP.ViewModelFlip = true
SWEP.ViewModelFOV	= 55
SWEP.ViewModel = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel = "models/weapons/w_smg_tmp.mdl"

SWEP.HeadshotMultiplier = 2.5

SWEP.IronSightsPos = Vector(-7, -1, 4.55)
SWEP.IronSightsAng = Vector(0, 0, 0)