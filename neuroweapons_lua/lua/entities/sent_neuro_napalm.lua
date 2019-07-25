AddCSLuaFile()

ENT.PrintName = "Napalm"
ENT.Author = "Hoffa & The Doctor & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = true
ENT.AdminSpawnable = false

ENT.WeaponType = WEAPON_BOMB

ENT.HealthVal = 100 -- missile health
ENT.Damage = 512 -- missile damage
ENT.Radius = 3012 -- missile blast radius
ENT.NozzlePos = Vector( -83, 0, 0 ) -- smoke effect local position
ENT.EngineSoundPath = "" -- Engine sound, precached or string filepath.
ENT.Model = "models/thedoctor/500lb.mdl" -- 3d model
ENT.VEffect = "napalm_explosion" -- The effect we call with ParticleEffect()
ENT.VEffectAir = "napalm_air"

-- Additional code to run on Think / Explode. In this case, ignite.
ENT.ThinkCallback = function( a )  end  
ENT.ExplodeCallback = function( a )
	for k, v in pairs( ents.FindInSphere( a:GetPos(), a.Radius  ) ) do
		if ( IsValid( v ) && v:GetModel() != nil ) then
			v:Ignite( 7, 7 )
		end
	end
end
