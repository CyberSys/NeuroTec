AddCSLuaFile()

SWEP.HoldType = "shotgun"
SWEP.IronSightHoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "Benelli M3"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Shotguns"

SWEP.Spawnable = true
SWEP.SequentialReload = true 
SWEP.NoRicochet = true 

SWEP.Primary.Damage = 10
SWEP.Primary.Delay = 0.75
SWEP.Primary.Cone = 0.05
SWEP.Primary.NumShots = 15
SWEP.Primary.ClipSize = 8
SWEP.Primary.ClipMax = 72
SWEP.Primary.DefaultClip = 8

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Recoil = 2	
SWEP.Primary.Sound = Sound( "m3.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 65
SWEP.ViewModel = "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel	= "models/weapons/w_shot_m3super90.mdl"

SWEP.HeadshotMultiplier = 1.5

SWEP.IronSightsPos = Vector(-7.7, -9.28, 5.0)
SWEP.IronSightsAng = Vector(1.162, 0, 0)