AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end
SWEP.PrintName = ".50 Cal AP"
   
SWEP.Author = "Hoffa"
SWEP.Contact = ""
SWEP.Purpose = ".50 Caliber Armor Piercing"
SWEP.Instructions = "Left click to dank 360 n0sk0pez"

SWEP.Category = "NeuroTec Weapons - Snipers"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.NoLines = false 
SWEP.Scoped = true
SWEP.Secondary.ScopeZoom = 10
SWEP.ScopeTexture = Material( "scope/screenoverlay.png" )
SWEP.ScopeTexture2 = Material( "scope/sniper.png" )
SWEP.ViewModelFOV = 50
SWEP.ViewModel = "models/weapons/v_snip_hex.mdl"
SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"
SWEP.ViewModelFlip = true
SWEP.ImpactScale = 1.2
SWEP.Tracer = "ar2tracer"
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.HeadshotMultiplier = 3

SWEP.IronSightsPos = Vector(3.2, -3, 4 )
SWEP.IronSightsAng = Vector( 0, 0, 0)

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.UseHands = true
SWEP.HoldType = "Ar2" 
SWEP.FiresUnderwater = false
SWEP.DrawAmmo = true
SWEP.ReloadSound = ""
SWEP.Base = "weapon_neurowep_base"
SWEP.Primary.Sound = Sound("weapons/barrett_m82.mp3") 
SWEP.Primary.Damage = 200
SWEP.Primary.Cone = 0.0
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 10 
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Spread = 0.2
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = false	
SWEP.Primary.Recoil = 4
SWEP.Primary.Delay = 1.0
SWEP.Primary.Force = 100

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.CSMuzzleFlashes = true

