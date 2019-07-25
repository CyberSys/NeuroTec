AddCSLuaFile()
if CLIENT then
   SWEP.PrintName = "Sticky Grenade"
   SWEP.Slot = 3
end
SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Equipment"
SWEP.PrimaryAnim = ACT_VM_THROW
SWEP.HoldType = "grenade"
SWEP.Spawnable = false
SWEP.Thrown = true 
SWEP.ThrownObject = "sent_neuro_stickynade"
SWEP.ThrowForce = 5000
SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 50
SWEP.ViewModel = "models/weapons/c_stickynade.mdl"
SWEP.WorldModel	= "models/weapons/w_stickynade.mdl"
SWEP.HeadshotMultiplier = 3.5
SWEP.Primary.Damage = 250
SWEP.Primary.Delay = 1
SWEP.Primary.Cone = 0.0
SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 999
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "grenade"
SWEP.Primary.Recoil = 0
SWEP.Primary.Sound = Sound( "Grenade.Throw" )
