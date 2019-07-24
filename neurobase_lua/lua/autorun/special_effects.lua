-- This is where we register custom particle effect systems.
game.AddParticles("particles/vman_explosion.pcf") 		-- dusty_rockets
game.AddParticles("particles/neuro_tank_arty.pcf") 		-- rt_impact / rt_impact_tank
game.AddParticles("particles/neuro_gore.pcf") 			-- tank_gore
game.AddParticles("particles/neuro_tank_he.pcf") 		-- tank_impact_dirt / tank_impact_wall
game.AddParticles("particles/neuro_tank_ap.pcf") 		-- 30cal_impact
game.AddParticles("particles/neuro_ricochet.pcf") 		-- tank_ric
game.AddParticles("particles/neuro_tankfire.pcf") 		-- tank_Fire fire_smoke_b_mini  fire_b_mini
game.AddParticles("particles/neuro_tank_flash.pcf") 	-- tank_muzzleflash / AA_muzzleflash / mg_muzzleflash
game.AddParticles("particles/neuro_cookoff.pcf") 		-- tank_cookoff 
game.AddParticles("particles/neuro_trails.pcf") 		-- rockettrail, scud_trail scud_launch
game.AddParticles("particles/neuro_v1.pcf") 			-- v1_impact
game.AddParticles("particles/neuro_ied.pcf") 			-- VBIED_explosion
game.AddParticles("particles/neuro_rocket.pcf") 		-- rocket_impact_dirt / rocket_impact_wall
game.AddParticles("particles/neuro_water_impact.pcf") 	-- water_impact_big   
game.AddParticles("particles/neuro_nuke.pcf") 			-- nuke  
game.AddParticles("particles/neuro_vehic_explosions.pcf")-- Jet_EX_smoke 
game.AddParticles("particles/neuro_bombs.pcf") 			-- FAB_Explosion FAB_groundwave carpet_explosion
game.AddParticles("particles/neuro_flamethrower.pcf") 	-- flamethrower_initial
game.AddParticles("particles/neuro_gascan.pcf") 		-- neuro_gascan_explo - neuro_gascan_explo_air - air
game.AddParticles("particles/neuro_nuke_lowyield.pcf") 	--  lowyield_nuke_air_main lowyield_nuke_ground_main 
game.AddParticles("particles/fuel_air_bomb.pcf") 		-- neuro_Fab_main_ground neuro_Fab_main_air 
game.AddParticles("particles/propellant_large_hoffa.pcf")-- propellant_large_main -- Main exhaust, propellant_smoke_blast -- collision smoke
game.AddParticles("particles/aang_poison_gas.pcf") 		-- poison_gas_main -- Ground explosionm poison_air_main -- You know what it means..
game.AddParticles("particles/poison_gas_main.pcf") 		-- poison_gas_large_ground poison_gas_large_air
game.AddParticles("particles/neuro_Fireball.pcf") 		-- fireball_explosion
game.AddParticles("particles/neuro_Fireboom.pcf") 		-- fireboom_explosion - fireboom_explosion_midair 
game.AddParticles("particles/neuro_inferno.pcf") 		-- fireplume -  fireplume_small 
game.AddParticles("particles/gbe_trinity_explo.pcf") --trinity_main and trinity_air
game.AddParticles("particles/gb5_napalm.pcf") --napalm_explosion and napalm_air
game.AddParticles("particles/neuro_scud.pcf") --scud_explosion 
game.AddParticles("particles/neuro_naval.pcf") --  navalgun_muzzleflash
game.AddParticles("particles/neuro_naval3.pcf") --  navalgun_muzzleflash_3
game.AddParticles("particles/neuro_tank_arty_mini.pcf") --  navalgun_muzzleflash_3
game.AddParticles("particles/neuro_water_impact_mini.pcf") --  water_impact_big_mini
game.AddParticles("particles/neuro_tank_arty_bkp.pcf") --  water_impact_big_mini
game.AddParticles("particles/neuro_tankfire_bkp.pcf") --  water_impact_big_mini
game.AddParticles("particles/neuro_tank_flash_bkp.pcf") --  water_impact_big_mini
game.AddParticles("particles/neuro_nuke_lowyield_bkp.pcf") --  water_impact_big_mini
 

game.AddParticles("particles/neuro_micro.pcf") 
--[[lowyield_nuke_air_main lowyield_nuke_ground_main lowyield_nuke_air_main lowyield_nuke_ground_main_mini 
Microplane muzzleflash: "microplane_mG_muzzleflash"
Microplane crash explosion: "microplane_explosion"
Microbomber crash explosion: "microplane_bomber_explosion"
Mid-air explosion: "microplane_midair_explosion"
Microplane structual dismemberment: "microplane_damage"
Microplane fuel leak: "microplane_Fuel_leak"
Microplane fuel leak fire: "microplane_Fuel_leak_Fire"
Microplane engine fire: "microplane_jet_flame"
17:01 - Rogue Cheney: neuro_tank_arty_mini
17:02 - Rogue Cheney: RT_impact_mini = ground
17:02 - Rogue Cheney: RT_impact_tank_mini = air

 ]]--
 
-- rocketrail/s
print( "[NeuroBase] special_effects.lua loaded!" )