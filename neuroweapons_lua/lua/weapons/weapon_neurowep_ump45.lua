AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "H&K UMP45"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - SMG"

SWEP.Spawnable = true

SWEP.Primary.Damage = 55
SWEP.Primary.Delay = 0.075
SWEP.Primary.Cone = 0.015

SWEP.Primary.ClipSize = 25
SWEP.Primary.ClipMax = 125
SWEP.Primary.DefaultClip = 25

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1.85
SWEP.Primary.Sound = Sound( "UMP45.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 70
SWEP.ViewModel = "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.WorldModel	= "models/weapons/w_smg_ump45.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-8.7, -10.4, 6.075)
SWEP.IronSightsAng = Vector(-1.5, 0, 0)