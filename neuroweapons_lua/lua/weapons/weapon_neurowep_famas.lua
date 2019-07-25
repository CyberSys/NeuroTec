AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "FAMAS"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Rifles"

SWEP.Spawnable = true

SWEP.Primary.Damage = 27
SWEP.Primary.Delay = 0.10
SWEP.Primary.Cone = 0.014

SWEP.Primary.ClipSize = 25
SWEP.Primary.ClipMax = 75
SWEP.Primary.DefaultClip = 25

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Sound = Sound( "Weapon_FAMAS.Single" )

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/cstrike/c_rif_Famas.mdl"
SWEP.WorldModel = "models/weapons/w_rif_Famas.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-2.681, -3.332, 1.44)
SWEP.IronSightsAng = Vector(0, 0, 0)
