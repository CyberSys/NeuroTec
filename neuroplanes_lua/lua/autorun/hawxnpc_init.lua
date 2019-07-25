local Cat3 = "NeuroTec Aircrafts"
local ents = {
{Name = "F-15C Eagle",							Class = "npc_f-15c",		 Category = Cat3};
{Name = "F-15E StrikeEagle",							Class = "npc_f-15e",		 Category = Cat3};
}

for k,planes in pairs(ents) do
	list.Set("NPC",planes.Class,planes)
end

print( "[NeuroPlanes] hawxnpc_init.lua loaded!" )