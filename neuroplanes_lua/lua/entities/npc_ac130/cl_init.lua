include( 'shared.lua' )
language.Add ("npc_ac130", "AC-130H Spectre")
local material = Material( "sprites/gmdm_pickups/light" )

function ENT:Initialize()

	local pilots = {
					{"models/player/t_phoenix.mdl"};
					{"models/player/ct_sas.mdl"};
					{"models/player/ct_urban.mdl"};
					{"models/humans/charple02.mdl"};
					{"models/humans/charple04.mdl"};
				}
	local CrashDebris = {
						{"models/military2/air/air_130_r.mdl"};
						{"models/military2/air/air_130_r.mdl"};
						{"models/military2/air/air_130_r.mdl"};
						{"models/military2/air/air_130_r.mdl"};
						{"models/props_wasteland/laundry_washer003.mdl"};
						{"models/props_pipes/concrete_pipe001d.mdl"};
						{"models/props_pipes/concrete_pipe001c.mdl"};
						{"models/props_citizen_tech/steamengine001a.mdl"};
						}
				
	for k,v in pairs(CrashDebris) do
	
		util.PrecacheModel(tostring(v))
	
	end

	for k,v in pairs(pilots) do
	
		util.PrecacheModel(tostring(v))
	
	end
	
end

function ENT:Draw()
	
	self:DrawModel()
	
end

function ENT:OnRemove()

end

