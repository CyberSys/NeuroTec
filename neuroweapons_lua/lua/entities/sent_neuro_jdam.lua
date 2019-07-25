AddCSLuaFile()

ENT.PrintName = "JDAM"
ENT.Author = "Hoffa & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_BOMB

ENT.HealthVal = 100 -- missile health
ENT.Damage = 1500 -- missile damage
ENT.Radius = 750 -- missile blast radius
ENT.NozzlePos = Vector( -83, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = "" -- Engine sound, precached or string filepath.
ENT.Model = "models/hawx/weapons/gbu-32 jdam.mdl" -- 3d model
ENT.VEffect = "carpet_explosion" -- The effect we call with ParticleEffect()