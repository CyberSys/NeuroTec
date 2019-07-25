AddCSLuaFile()

SWEP.HoldType = "crossbow"

if CLIENT then
   SWEP.PrintName = "Gau-8"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base_ent"
SWEP.Category = "NeuroTec Weapons - MGs"
SWEP.ComplexSound = false
SWEP.Primary.CustomMuzzle = "MG_muzzleflash"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.AdminOnly = true 
SWEP.PhysBulletEnable = true 
SWEP.Primary.PhysAmmoType = "sent_mini_shell"
SWEP.PhysBulletBlastRadius = 80
SWEP.DrawCrosshair		= true
SWEP.BulletForce = 99999999999999999999999

SWEP.Primary.Damage = 55
SWEP.Primary.Delay = 0.05
SWEP.Primary.Cone = 0.05

SWEP.Primary.ClipSize = 500
SWEP.Primary.ClipMax = 500
SWEP.Primary.DefaultClip = 500

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Recoil = 1.9
SWEP.Primary.PhysRecoil = 100

SWEP.Primary.Sound = Sound("micro/gau8_humm2.wav")
SWEP.Primary.EndSound = Sound("micro/gau8_end_test.wav")

SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 64
SWEP.ViewModel = "models/minigun_model/weapons/c_minigun.mdl"
SWEP.WorldModel = "models/minigun_model/weapons/w_minigun.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(-1.96, -5.119, 4.349)
SWEP.IronSightsAng = Vector(0, 0, 0)
