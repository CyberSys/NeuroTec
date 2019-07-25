AddCSLuaFile()

ENT.PrintName = "Fuel Air Bomb Mk. II"
ENT.Author = "Hoffa & The Doctor & The Vman & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_BOMB

ENT.HealthVal = 100 -- missile health
ENT.Damage = 5512 -- missile damage
ENT.Radius = 2521 -- missile blast radius
ENT.NozzlePos = Vector( -83, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = "" -- Engine sound, precached or string filepath.
ENT.Model = "models/thedoctor/napalm_bomb.mdl" -- 3d model
ENT.VEffect = "FAB_Explosion" -- The effect we call with ParticleEffect()

ENT.SpawnPos = Vector( 0, 0, 30 )