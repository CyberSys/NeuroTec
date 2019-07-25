AddCSLuaFile()

SWEP.HoldType = "grenade"

if CLIENT then
   SWEP.PrintName = "Smoke Grenade"
   SWEP.Slot = 3
   -- SWEP.ViewModelFlip = true
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Equipment"
SWEP.PrimaryAnim = ACT_VM_THROW

SWEP.Spawnable = true
SWEP.Thrown = true 
SWEP.ThrownObject = "sent_tank_smokegrenade"
SWEP.ThrowForce = 3000
SWEP.ForceModel = "models/weapons/w_eq_smokegrenade_thrown.mdl"

SWEP.Primary.Damage = 150
SWEP.Primary.Delay = 2
SWEP.Primary.Cone = 0.0

SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 999
SWEP.Primary.DefaultClip = 1

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "grenade"
SWEP.Primary.Recoil = 0
SWEP.Primary.Sound = Sound( "Grenade.Throw" )

SWEP.UseHands	= false
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV	= 50
SWEP.ViewModel = "models/weapons/v_eq_smokegrenade.mdl"
SWEP.WorldModel	= "models/weapons/w_eq_smokegrenade.mdl"

SWEP.HeadshotMultiplier = 3.5
