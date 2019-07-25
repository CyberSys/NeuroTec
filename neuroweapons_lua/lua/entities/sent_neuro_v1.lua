AddCSLuaFile()

ENT.PrintName = "V-2"
ENT.Author = "Hoffa & The Doctor & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_MISSILE

ENT.HealthVal = 100 -- missile health
ENT.Damage = 7512 -- missile damage
ENT.Radius = 3012 -- missile blast radius
ENT.NozzlePos = Vector( -12, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = Sound("bf4/rockets/pods_rocket_engine_wave 2 0 0_2ch.wav") -- Engine sound, precached or string filepath.
ENT.Model = "models/thedoctor/v2.mdl" -- 3d model
ENT.VEffect = "fireball_explosion" -- The effect we call with ParticleEffect()
ENT.DrawBigSmoke = true

ENT.SpawnPos = Vector( 0, 0, 30 )
ENT.SpawnAngle = Angle( -90, 0, 0 )