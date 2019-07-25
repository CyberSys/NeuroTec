AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "G3SG1"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Snipers"

SWEP.Spawnable = true
SWEP.Scoped = true
SWEP.Secondary.ScopeZoom = 5
SWEP.ScopeTexture = Material( "scope/screenoverlay.png" )
SWEP.ScopeTexture2 = Material( "scope/sniper.png" )

SWEP.Primary.Damage = 65
SWEP.Primary.Delay = 0.35
SWEP.Primary.Cone = 0.0

SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 30
SWEP.Primary.DefaultClip = 20

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "xbowbolt"
SWEP.Primary.Recoil = 1.75
SWEP.Primary.Sound = Sound( "g3sg1.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 45
SWEP.ViewModel = "models/weapons/cstrike/c_snip_g3sg1.mdl"
SWEP.WorldModel	= "models/weapons/w_snip_g3sg1.mdl"

SWEP.HeadshotMultiplier = 3.5

SWEP.IronSightsPos = Vector(-6.2, -10, 3.75)
SWEP.IronSightsAng = Vector(2.625, 0, 0)