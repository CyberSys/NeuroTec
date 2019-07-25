AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.IronSightHoldType = "revolver"
if CLIENT then
   SWEP.PrintName = "Sig Sauer P228"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Pistols"

SWEP.Spawnable = true

SWEP.Primary.Damage = 35
SWEP.Primary.Delay = 0.125
SWEP.Primary.Cone = 0.03

SWEP.Primary.ClipSize = 13
SWEP.Primary.ClipMax = 13*5
SWEP.Primary.DefaultClip = 13

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1.3
SWEP.Primary.Sound = Sound( "P228.Single" )

SWEP.UseHands	= true
-- SWEP.ViewModelFlip = true
SWEP.ViewModelFOV	= 60
SWEP.ViewModel = "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"

SWEP.HeadshotMultiplier = 2.5

SWEP.IronSightsPos = Vector( -6, -3, 4.65)
SWEP.IronSightsAng = Vector(0, 0, 0)