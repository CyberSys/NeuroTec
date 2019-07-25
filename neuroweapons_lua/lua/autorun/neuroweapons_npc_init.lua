local Cat = "Neuro Weapons"
local ents = {
	{ Name = "Phalanx CIWS", Class = "npc_phalanx", Category = Cat },
	{ Name = "RIM-116 RAM", Class = "npc_typhoon", Category = Cat },
	{ Name = "Flak 88mm", Class = "npc_flak18", Category = Cat },
        { Name = "Terrorist", Class = "npc_Taliban", Category = Cat },
	{ Name = "Anti-Air Vehicle", Class = "npc_aa_vehicle", Category = Cat },
}

for k, weap in pairs( ents ) do
	list.Set( "NPC", weap.Class, weap )
end

print( "[NeuroWeapons] neuroweapons_npc_init.lua loaded!" )