AddCSLuaFile()

ENT.PrintName = "Tomahawk BGM-109"
ENT.Author = "Hoffa & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_MISSILE

ENT.HealthVal = 100 -- missile health
ENT.Damage = 7512 -- missile damage
ENT.Radius = 3012 -- missile blast radius
ENT.NozzlePos = Vector( -225, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = "missile.accelerate" -- Engine sound, precached or string filepath.
ENT.Model = "models/military2/missile/missile_tomahawk3.mdl" -- 3d model
ENT.VEffect = "scud_explosion" -- The effect we call with ParticleEffect()
ENT.DrawBigSmoke = true
ENT.LaunchEffect = false

ENT.SpawnPos = Vector( 0, 0, 230 )
ENT.SpawnAngle = Angle( -90, 0, 0 )