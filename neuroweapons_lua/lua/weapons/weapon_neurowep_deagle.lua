AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.IronSightHoldType = "revolver"

if CLIENT then
   SWEP.PrintName = "Deagle"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Pistols"

SWEP.Spawnable = true

SWEP.Primary.Damage = 75
SWEP.Primary.Delay = 0.25
SWEP.Primary.Cone = 0.010

SWEP.Primary.ClipSize = 7
SWEP.Primary.ClipMax = 21
SWEP.Primary.DefaultClip = 7

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 5.3
SWEP.Primary.Sound = Sound( "Weapon_Deagle.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 40
SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel	= "models/weapons/w_pist_deagle.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-6.361, 0, 4.118)
SWEP.IronSightsAng = Vector(0, 0, 0)