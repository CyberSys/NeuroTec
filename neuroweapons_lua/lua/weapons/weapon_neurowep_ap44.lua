AddCSLuaFile()

SWEP.HoldType = "pistol"
SWEP.IronSightHoldType = "revolver"

if CLIENT then
   SWEP.PrintName = "Wingman AP .44"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Pistols"
SWEP.Author = "Smithy285, Hoffa & Killstr3aKs"
SWEP.Spawnable = true
SWEP.ImpactScale = .8

SWEP.Primary.Damage = 75
SWEP.Primary.Delay = 0.15
SWEP.Primary.Cone = 0.0025

SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 24
SWEP.Primary.DefaultClip = 6

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 6
SWEP.Primary.Sound = Sound( "Weapon_Deagle.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 50
SWEP.ViewModel = "models/killstr3aks/c_wingman.mdl"
SWEP.WorldModel	= "models/killstr3aks/w_wingman.mdl"

SWEP.HeadshotMultiplier = 4

SWEP.IronSightsPos = Vector(-3.55, 0, 2.5 )
SWEP.IronSightsAng = Vector(0, 0, 0)