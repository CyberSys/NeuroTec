AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "AW/m PSG-90"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end

local soundData = {
    name                = "Weapon_aCR10.Magout" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "weapons/pkm/pkm_boxout.mp3"
}
sound.Add(soundData)

local soundData = {
    name                = "Weapon_aCR10.Magin" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "weapons/pkm/pkm_boxin.mp3"
}
sound.Add(soundData)

SWEP.PrintName = "ACR-10"
    
SWEP.Author = "Killstr3aKs"
SWEP.Contact = "ak471@hotmail.es"
SWEP.Purpose = "Tacticool sn1pr r1fle"
SWEP.Instructions = "Left click to dank 360 n0sk0pez"

SWEP.Category = "NeuroTec Weapons - Snipers"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.NoLines = true 
SWEP.Scoped = true
SWEP.Secondary.ScopeZoom = 10
SWEP.ScopeTexture = Material( "scope/screenoverlay.png" )
SWEP.ScopeTexture2 = Material( "scope/arc10scope.png" )
SWEP.ViewModelFOV = 50
SWEP.ViewModel = "models/killstr3aks/v_acr10.mdl" 
SWEP.WorldModel = "models/killstr3aks/w_acr10.mdl"
SWEP.ViewModelFlip = false

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.HeadshotMultiplier = 3

SWEP.IronSightsPos = Vector(-4.3, -17, 3.15 )
SWEP.IronSightsAng = Vector( 0, 0, 0)

SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.UseHands = true
SWEP.HoldType = "Ar2" 
SWEP.FiresUnderwater = false
SWEP.DrawAmmo = true
SWEP.ReloadSound = ""
SWEP.Base = "weapon_neurowep_base"
SWEP.Primary.Sound = Sound("weapons/barrett_m82") 
SWEP.Primary.Damage = 70
SWEP.Primary.Cone = 0.0
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 10 
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Spread = 0.2
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = false	
SWEP.Primary.Recoil = 1.2
SWEP.Primary.Delay = 0.6
SWEP.Primary.Force = 40

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.CSMuzzleFlashes = true

