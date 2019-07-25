AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "AK47"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Rifles"

SWEP.Spawnable = true

SWEP.Primary.Damage = 45
SWEP.Primary.Delay = 0.10
SWEP.Primary.Cone = 0.018

SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 20

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1.45
SWEP.Primary.Sound = Sound( "Weapon_aK47.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 50
SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel	= "models/weapons/w_rif_ak47.mdl"

SWEP.HeadshotMultiplier = 4.2

SWEP.IronSightsPos = Vector(-6.615, -10.563, 4.417)
SWEP.IronSightsAng = Vector(2.625, 0, 0)