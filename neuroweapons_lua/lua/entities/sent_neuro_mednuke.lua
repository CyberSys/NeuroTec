AddCSLuaFile()

ENT.PrintName = "Fat Boy (Nuclear)"
ENT.Author = "Hoffa & The Doctor & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.NeuroAdminOnly = true

ENT.WeaponType = WEAPON_BOMB

ENT.HealthVal = 100 -- missile health
ENT.Damage = 15512 -- missile damage
ENT.Radius = 7012 -- missile blast radius
ENT.NozzlePos = Vector( -83, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = "" -- Engine sound, precached or string filepath.
ENT.Model = "models/thedoctor/fatman.mdl" -- 3d model
ENT.VEffect = "trinity_air" -- The effect we call with ParticleEffect()
ENT.FalloutRadius = 6500