AddCSLuaFile()

SWEP.HoldType = "Ar2"

if CLIENT then
   SWEP.PrintName = ".50 Cal HE"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base_ent"
SWEP.Category = "NeuroTec Weapons - Snipers"

SWEP.Spawnable = true

SWEP.Primary.Damage = 78
SWEP.Primary.Delay = 1.7
SWEP.Primary.Cone = 0.05

SWEP.Primary.ClipSize = 10
SWEP.Primary.ClipMax = 30
SWEP.Primary.DefaultClip = 10

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Recoil = 8
SWEP.Primary.Sound = Sound("weapons/barrett_m82.mp3")

SWEP.PhysBulletPropType      = "sent_mini_shell"
SWEP.PhysBulletMinDamage     = 650
SWEP.PhysBulletMaxDamage     = 950
SWEP.PhysBulletBlastRadius   = 72

SWEP.Scoped = true
SWEP.Secondary.ScopeZoom = 9

SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/v_snip_hex.mdl"
SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector(3.24, 0, 3.919)
SWEP.IronSightsAng = Vector(0, 0, 0)