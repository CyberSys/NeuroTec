AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "P-90"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - SMG"

SWEP.Spawnable = true

SWEP.Primary.Damage = 19
SWEP.Primary.Delay = 0.05
SWEP.Primary.Cone = 0.01

SWEP.Primary.ClipSize = 50
SWEP.Primary.ClipMax = 90
SWEP.Primary.DefaultClip = 50

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Recoil = 0.75	
SWEP.Primary.Sound = Sound( "P90.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 55
SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel	= "models/weapons/w_smg_p90.mdl"

SWEP.HeadshotMultiplier = 2.5

SWEP.IronSightsPos = Vector(-5.329, -9.28, 4.02)
SWEP.IronSightsAng = Vector(1.162, 0, 0)