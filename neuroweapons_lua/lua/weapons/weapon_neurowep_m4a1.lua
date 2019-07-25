AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "M4A1"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Rifles"

SWEP.Spawnable = true

SWEP.Primary.Damage = 25
SWEP.Primary.Delay = 0.09
SWEP.Primary.Cone = 0.01

SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1.375
SWEP.Primary.Sound = Sound( "Weapon_M4A1.Single" )
SWEP.Primary.SoundSilenced = Sound( "M4.Silenced" )
SWEP.Silenced = true 
SWEP.CSMuzzleFlashes = true 
SWEP.CSMuzzleX = true 
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 64
SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-7.98, -8.2, 2.55)
SWEP.IronSightsAng = Vector(2.599, -3.3, -3.6)
