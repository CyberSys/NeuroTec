AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.IronSightHoldType = "revolver"
if CLIENT then
   SWEP.PrintName = "Glock-18"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Pistols"

SWEP.Spawnable = true

SWEP.Primary.Damage = 17
SWEP.Primary.Delay = 0.035
SWEP.Primary.Cone = 0.020

SWEP.Primary.ClipSize = 18
SWEP.Primary.ClipMax = 54
SWEP.Primary.DefaultClip = 18

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1.8
SWEP.Primary.Sound = Sound( "Weapon_Glock.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 45
SWEP.ViewModel = "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-5.781, 0, 4.88)
SWEP.IronSightsAng = Vector(0, 0, 0)