AddCSLuaFile()

SWEP.HoldType = "pistol"

if CLIENT then
   SWEP.PrintName = "MAC-10"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - SMG"

SWEP.Spawnable = true

SWEP.Primary.Damage = 17
SWEP.Primary.Delay = 0.04
SWEP.Primary.Cone = 0.025

SWEP.Primary.ClipSize = 32
SWEP.Primary.ClipMax = 96
SWEP.Primary.DefaultClip = 32

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 2.3
SWEP.Primary.Sound = Sound( "Weapon_MAC10.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 55
SWEP.ViewModel = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-9.465, -2.0, -0.95)
SWEP.IronSightsAng = Vector(5, 12.5, -90)