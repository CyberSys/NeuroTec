AddCSLuaFile()

SWEP.HoldType = "shotgun"
SWEP.IronSightHoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "XM-1014"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Shotguns"

SWEP.Spawnable = true
SWEP.SequentialReload = true 
SWEP.NoRicochet = true 

SWEP.Primary.Damage = 9
SWEP.Primary.Delay = 0.25
SWEP.Primary.Cone = 0.05
SWEP.Primary.NumShots = 10
SWEP.Primary.ClipSize = 7
SWEP.Primary.ClipMax = 70
SWEP.Primary.DefaultClip = 7

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Recoil = 3
SWEP.Primary.Sound = Sound( "m3.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 55
SWEP.ViewModel = "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel	= "models/weapons/w_shot_xm1014.mdl"

SWEP.HeadshotMultiplier = 1.5

SWEP.IronSightsPos = Vector(-6.85, -9.28, 4.65)
SWEP.IronSightsAng = Vector( 0, 0, 0)