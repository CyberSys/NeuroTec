--Different speeds for each ammo type:
AMMO_VELOCITY_aP_SHELL = 9050 -- 1000 m/s (not used yet)
AMMO_VELOCITY_aPCR_SHELL = 9050 -- 1500 m/s
AMMO_VELOCITY_HE_SHELL = 8000--850 m/s
AMMO_VELOCITY_HEAT_SHELL = 6040--1050 m/s (not used yet)

TANK_RANGE_aRTILLERY_SHELL = 16500
TANK_RANGE_HE_SHELL = 16500

AMMO_VELOCITY_aPHE_SHELL = 7050  -- 950m/s
AMMO_VELOCITY_INCENDIARY_SHELL = 5050-- 900m/s 
AMMO_VELOCITY_CLUSTER_SHELL = 10050 -- 1500 ft/s
AMMO_VELOCITY_flAK_SHELL =  17050-- 800 m/s
AMMO_VELOCITY_aRTILLERY_SHELL = 3050 --4956 --Use low value to prevent the shell from hitting the skybox ceiling.
AMMO_VELOCITY_aUTOCANNON_SHELL = 22560

TANK_aMMO_RANGE = {}
-- TANK_aMMO_RANGE["sent_tank_shell"] = TANK_RANGE_HE_SHELL 

TANK_aMMO_SPEEDS = {}
TANK_aMMO_SPEEDS["sent_tank_apshell"]		 = AMMO_VELOCITY_aPCR_SHELL
TANK_aMMO_SPEEDS["sent_tank_kinetic_shell"]  = AMMO_VELOCITY_aPCR_SHELL
TANK_aMMO_SPEEDS["sent_tank_missile"]			 = AMMO_VELOCITY_HE_SHELL
TANK_aMMO_SPEEDS["sent_tank_shell"]			 = AMMO_VELOCITY_HE_SHELL
TANK_aMMO_SPEEDS["sent_mini_naval_shell"]			 = AMMO_VELOCITY_HE_SHELL
TANK_aMMO_SPEEDS["sent_tank_armorpiercing"]	 = AMMO_VELOCITY_aPHE_SHELL
TANK_aMMO_SPEEDS["sent_tank_incendiary"]	 = AMMO_VELOCITY_INCENDIARY_SHELL
TANK_aMMO_SPEEDS["sent_tank_clustershell"]	 = AMMO_VELOCITY_CLUSTER_SHELL
TANK_aMMO_SPEEDS["sent_tank_mgbullet"]			 = AMMO_VELOCITY_CLUSTER_SHELL
TANK_aMMO_SPEEDS["sent_tank_flak"]			 = AMMO_VELOCITY_flAK_SHELL
TANK_aMMO_SPEEDS["sent_artillery_shell"]	 = AMMO_VELOCITY_aRTILLERY_SHELL
TANK_aMMO_SPEEDS["sent_tank_autocannon_shell"]	 = AMMO_VELOCITY_HE_SHELL
TANK_aMMO_SPEEDS["sent_tank_38cm_rocket"]	 = 3050
TANK_aMMO_SPEEDS["sent_tank_300mm_rocket"]	 = 3050
TANK_aMMO_SPEEDS["prop_physics"]	 = 3050
TANK_aMMO_SPEEDS["sent_tank_poison_shell"]	 = 1550
TANK_aMMO_SPEEDS["sent_tank_scud_missile"]	 = 50




print( "[NeuroBase] neureotec_tankloadout.lua loaded!" )