local Cat = "NeuroTec Aircrafts" //meow
local Cat2 = "NeuroTec Spacecrafts"
local ents = {
{Name = "A-10 Thunderbolt II",							Class = "npc_a10thunderbolt",		 Category = Cat};
{Name = "AH-64 Apache",									Class = "npc_ah60",		 Category = Cat};
{Name = "UCAV",											Class = "npc_helidrone", Category = Cat};
{Name = "AC-130H Spectre",								Class = "npc_ac130", 	 Category = Cat};
{Name = "F/A-22 Raptor",								Class = "npc_f22raptor", 	 Category = Cat};
{Name = "ADF-01 Falken",								Class = "npc_adf01falken", 	 Category = Cat};
{Name = "X-45A UCAV",									Class = "npc_x45a_ucav", 	 Category = Cat};
{Name = "Pilotfish UCAV",								Class = "npc_pilotfish",	Category = Cat};
{Name = "TS HK Aerial",								Class = "npc_hunterkiller",	Category = Cat};
{Name = "ALIENS D:",									Class = "npc_ohmygodaliensareattacking", Category = Cat2};
}

//{Name = "Lockheed Martin AV-8B Harrier",				Class = "npc_harrier",	 Category = Cat};
//{Name = "ADF-01 Falken",								Class = "npc_falken", 	 Category = Cat};
//{Name = "Boeing F-15 Eagle",							Class = "npc_f15",		 Category = Cat};
//{Name = "Extreme Deep Invader (BETA)",					Class = "npc_edi",		 Category = Cat};
//{Name = "F-117 Stealth Bomber",							Class = "npc_f117",		 Category = Cat};
//{Name = "SU-47 Berkut",									Class = "npc_su47",		 Category = Cat};
//{Name = "B-52H Stratofortress (BETA)",					Class = "npc_b52h",		 Category = Cat};
//{Name = "Combine Helicopter",							Class = "npc_hl2heli",	 Category = Cat};
//{Name = "Stardestroyer MKI",							Class = "npc_stardestroyer", Category = Cat2};
//{Name = "Battle Cruiser",								Class = "npc_stardestroyer_2", Category = Cat2};
//{Name = "Galaxydestroyer",								Class = "npc_galaxydestroyer", Category = Cat2};
for k,planes in pairs(ents) do
	list.Set("NPC",planes.Class,planes)
end

print( "[NeuroPlanes] npcinit.lua loaded!" )