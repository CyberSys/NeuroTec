AddCSLuaFile()

SWEP.HoldType = "smg"

if CLIENT then
   SWEP.PrintName = "CAR-101"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
end

local soundData = {
    name                = "Weapon_car101.Magout" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "weapons/car101/clipout.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Weapon_car101.Magin" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "weapons/car101/clipin.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Weapon_car101.Grip" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "weapons/car101/grip.wav"
}
sound.Add(soundData)

local soundData = {
    name                = "Weapon_car101.Lever" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "weapons/car101/lever.wav"
}
sound.Add(soundData)

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - SMG"

SWEP.Spawnable = true

SWEP.Primary.Damage = 30
SWEP.Primary.Delay = 0.08
SWEP.Primary.Cone = 0.01

SWEP.Primary.ClipSize = 35
SWEP.Primary.ClipMax = 175
SWEP.Primary.DefaultClip = 35

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Recoil = 1.25
SWEP.Primary.Sound = "weapons/car101/shoot.wav"

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 45
SWEP.ViewModel = "models/killstr3aks/c_car101.mdl"
SWEP.WorldModel	= "models/killstr3aks/w_car101.mdl"

SWEP.HeadshotMultiplier = 2.6

SWEP.IronSightsPos = Vector(-7.075, -8, 2.8)
SWEP.IronSightsAng = Vector(-1, 0, 0)