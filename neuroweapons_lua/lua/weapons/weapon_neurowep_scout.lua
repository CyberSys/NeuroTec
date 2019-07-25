AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "Steyr Scout"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Snipers"

SWEP.Spawnable = true
SWEP.Scoped = true
SWEP.Secondary.ScopeZoom = 7
SWEP.ScopeTexture = Material( "scope/screenoverlay.png" )
SWEP.ScopeTexture2 = Material( "scope/sniper.png" )

SWEP.Primary.Damage = 85
SWEP.Primary.Delay = 1.0
SWEP.Primary.Cone = 0.0

SWEP.Primary.ClipSize = 10
SWEP.Primary.ClipMax = 30
SWEP.Primary.DefaultClip = 10

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "xbowbolt"
SWEP.Primary.Recoil = 2
SWEP.Primary.Sound = Sound( "Scout.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 60
SWEP.ViewModel = "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel	= "models/weapons/w_snip_scout.mdl"

SWEP.HeadshotMultiplier = 5.65

SWEP.IronSightsPos = Vector(-7.5, -10, 4)
SWEP.IronSightsAng = Vector(2.625, 0, 0)