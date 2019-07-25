AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "SG550"
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

SWEP.Primary.Damage = 55
SWEP.Primary.Delay = 0.3
SWEP.Primary.Cone = 0.0

SWEP.Primary.ClipSize = 25
SWEP.Primary.ClipMax = 30
SWEP.Primary.DefaultClip = 25

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "xbowbolt"
SWEP.Primary.Recoil = 1
SWEP.Primary.Sound = Sound( "sg550.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 45
SWEP.ViewModel = "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel	= "models/weapons/w_snip_sg550.mdl"

SWEP.HeadshotMultiplier = 3.5

SWEP.IronSightsPos = Vector(-7.5, -10, 3 )
SWEP.IronSightsAng = Vector(2.625, 0, 0)