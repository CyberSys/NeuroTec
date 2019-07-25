AddCSLuaFile()

if CLIENT then
   SWEP.Slot = 4
   SWEP.ViewModelFlip = false
end

SWEP.PrintName = "M24A2"
    
SWEP.Author = "Hoffa"
SWEP.Contact = "neurotec@no.email.for.u"
SWEP.Purpose = "FOR USE ON PEOPLE ONLY - NOT SUITED FOR SMALL GAME HUNTING"
SWEP.Instructions = "Point and Shoot"

SWEP.Category = "NeuroTec Weapons - Snipers"

SWEP.UseHands = true
SWEP.HoldType = "Ar2" 
SWEP.FiresUnderwater = false
SWEP.DrawAmmo = true
SWEP.ReloadSound = ""
SWEP.Base = "weapon_neurowep_base"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true

SWEP.Scoped = true
SWEP.Secondary.ScopeZoom = 7
SWEP.ScopeTexture = Material( "scope/screenoverlay.png" )
SWEP.ScopeTexture2 = Material( "scope/sniper.png" )
SWEP.ViewModelFOV = 50
SWEP.ViewModel = "models/weapons/v_snip_lwolf.mdl" 
SWEP.WorldModel	= "models/weapons/w_m24.mdl"
-- SWEP.WorldModel = "models/weapons/w_snip_lwolf.mdl" -- Killstr3aks rig this pleeeese
SWEP.ViewModelFlip = true

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.HeadshotMultiplier = 3

SWEP.IronSightsPos = Vector(4.9,-1, 3.5 )
SWEP.IronSightsAng = Vector( 0, 0, 0)

SWEP.Primary.Sound = Sound("m24.single") 
SWEP.Primary.Damage = 150
SWEP.Primary.Cone = 0.0
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 10 
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Spread = 0.02
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = false	
SWEP.Primary.Recoil = 2
SWEP.Primary.Delay = 1.0
SWEP.Primary.Force = 40

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.CSMuzzleFlashes = true

