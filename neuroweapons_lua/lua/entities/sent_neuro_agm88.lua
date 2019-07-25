AddCSLuaFile()

ENT.PrintName = "AGM-88"
ENT.Author = "Hoffa & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_MISSILE

ENT.HealthVal = 100 -- missile health
ENT.Damage = 512 -- missile damage
ENT.Radius = 512 -- missile blast radius
ENT.NozzlePos = Vector( -83, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = "missile.accelerate" -- Engine sound, precached or string filepath.
ENT.Model = "models/military2/missile/missile_agm88.mdl" -- 3d model
ENT.VEffect = "rocket_impact_dirt" -- The effect we call with ParticleEffect()

ENT.SpawnPos = Vector( 0, 0, 73 )
ENT.SpawnAngle = Angle( -90, 0, 0 )