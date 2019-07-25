AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "AUG"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Rifles"

SWEP.Spawnable = true
SWEP.Scoped = true
SWEP.Secondary.ScopeZoom = 2

SWEP.Primary.Damage = 40
SWEP.Primary.Delay = 0.08
SWEP.Primary.Cone = 0.005

SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Sound = Sound( "AUG.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 50
SWEP.ViewModel = "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel	= "models/weapons/w_rif_aug.mdl"

SWEP.HeadshotMultiplier = 3.5

SWEP.IronSightsPos = Vector(-8, 0, 17)
SWEP.IronSightsAng = Vector(2.625, 0, 0)