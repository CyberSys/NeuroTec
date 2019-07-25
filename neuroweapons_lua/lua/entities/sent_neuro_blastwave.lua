AddCSLuaFile()

ENT.PrintName = "Shockwave"
ENT.Author = "Hoffa & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_MINE

ENT.HealthVal = 100 -- missile health
ENT.Damage = 75 -- missile damage
ENT.Radius = 2800 -- missile blast radius
ENT.NozzlePos = Vector( 0, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = "" -- Engine sound, precached or string filepath.
ENT.Model = "models/magnet/submine/submine.mdl" -- 3d model
ENT.VEffect = "FAB_groundwave" -- The effect we call with ParticleEffect()