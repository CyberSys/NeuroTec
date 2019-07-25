AddCSLuaFile()

ENT.PrintName = "Little Boy"
ENT.Author = "Hoffa & The Doctor & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_BOMB

ENT.HealthVal = 100 -- missile health
ENT.Damage = 7512 -- missile damage
ENT.Radius = 2012 -- missile blast radius
ENT.NozzlePos = Vector( -83, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = "" -- Engine sound, precached or string filepath.
ENT.Model = "models/thedoctor/littleboy.mdl" -- 3d model
ENT.VEffect = "v1_impact" -- The effect we call with ParticleEffect()