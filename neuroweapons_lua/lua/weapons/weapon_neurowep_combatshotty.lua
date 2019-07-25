AddCSLuaFile()

SWEP.HoldType = "shotgun"
SWEP.IronSightHoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "FO3 - Combat Shotgun"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Shotguns"

SWEP.Spawnable = true
SWEP.SequentialReload = false 
SWEP.NoRicochet = true 
SWEP.CSMuzzleFlashes = true 
SWEP.CSMuzzleX = true 
SWEP.Primary.Damage = 4
SWEP.Primary.Delay = 0.22
SWEP.Primary.Cone = 0.035
SWEP.Primary.NumShots = 7
SWEP.Primary.ClipSize = 15
SWEP.Primary.ClipMax = 120
SWEP.Primary.DefaultClip = 15

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Recoil = 2	
SWEP.Primary.Sound = Sound( "weapons/fo3shotty/fire.wav" )

SWEP.UseHands	= false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 55
SWEP.ViewModel = "models/weapons/v_combatshotgun.mdl"
SWEP.WorldModel	= "models/weapons/w_shot_m3super90.mdl"

SWEP.HeadshotMultiplier = 1.5

SWEP.IronSightsPos = Vector(-6, -10.28, 4.0)
SWEP.IronSightsAng = Vector(0, 0, 0)