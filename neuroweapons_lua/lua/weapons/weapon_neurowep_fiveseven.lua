AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.IronSightHoldType = "revolver"
if CLIENT then
   SWEP.PrintName = "FN Five-seven"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Pistols"

SWEP.Spawnable = true

SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.15
SWEP.Primary.Cone = 0.020

SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 20

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Sound = Sound( "Weapon_FiveSeven.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 55
SWEP.ViewModel = "models/weapons/cstrike/c_pist_Fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_Fiveseven.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-5.941, 0, 4.839)
SWEP.IronSightsAng = Vector(0, 0, 0)