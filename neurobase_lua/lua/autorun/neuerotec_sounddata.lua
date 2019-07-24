local Meta = FindMetaTable("Entity")
local LONGDISTANCE_SOUNDS = {}
				-- Emitted Sound                  		-- Sound to replace with
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_01.wav"] = "wt/sounds/tank_explosion_Far_1.wav";
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_02.wav"] = "wt/sounds/tank_explosion_Far_2.wav";
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_03.wav"] = "wt/sounds/tank_explosion_Far_3.wav";
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_04.wav"] = "wt/sounds/tank_explosion_Far_4.wav";
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_05.wav"] = "wt/sounds/tank_explosion_Far_5.wav";
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_06.wav"] = "wt/sounds/tank_explosion_Far_6.wav";
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_07.wav"] = "wt/sounds/tank_explosion_Far_7.wav";
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_08.wav"] = "wt/sounds/tank_explosion_Far_8.wav";
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_09.wav"] = "wt/sounds/tank_explosion_Far_9.wav";
LONGDISTANCE_SOUNDS["wt/sounds/tanks_explosion_10.wav"] = "wt/sounds/tank_explosion_Far_10.wav";


local function FindAndMarkNearByPlayers( pos, snd  )
	
	-- local plys = {} 
	
	for k,v in pairs( ents.FindInSphere( pos, 1500 ) ) do 
		
		if( v:IsPlayer() ) then 
			
			v._NeuroTecSoundData = { Sound = snd, LastHeard = CurTime(), Pos = v:GetPos() }
			-- table.insert( plys, v )
		
		end 
	
	end 
	
	-- return plys 
	
end 

function Meta:PlayWorldSound(snd)

	for k, v in pairs( player.GetAll() ) do
		
		if( v._NeuroTecSoundData && v._NeuroTecSoundData.Sound == snd && v._NeuroTecSoundData.LastHeard + 1 >= CurTime() && v:GetPos():Distance( v._NeuroTecSoundData.Pos ) < 1500 ) then
		
			-- next -- we're close enough to hear the previous players worldsound emit so we dont need to create another one 
		else
		
	
		-- local tr,trace = {}, {}
		-- tr.start = self:GetPos()
		-- tr.endpos = v:GetPos()
		-- tr.mask = MASK_SOLID
		-- tr.filter = self
		-- trace = util.TraceLine( tr )
		-- self:DrawLaserTracer( tr.start, trace.HitPos  )
		-- if ( !trace.HitWorld ) then
		
			local norm = ( self:GetPos() - v:GetPos() ):GetNormalized()
			local d = self:GetPos():Distance( v:GetPos() )
			local sonic =  13044 -- 1.8 * 1224 -- sound of speed according to micro 13044 acc. to valve 
			local timeDelay = d / sonic 
	
			-- print( d )
		if( d > 3500 ) then
			local ent = v 
			local spos = self:GetPos()
			local pos = v:GetPos()
			local mvel = self:GetVelocity()
			local tvel = v:GetVelocity()
			
--Gmod12		-- WorldSound( snd, v:GetPos() + norm * ( d / 10 ), 211, 100   )
	
			timer.Simple( timeDelay, 
			function()
					if( IsValid( ent ) ) then 
						-- local worldSound = sound.PlayFile( snd, "3d", 
						
						-- function( hookerBalls )
						
						-- if( IsValid( hookerBalls ) ) then 
							
							-- local mvel = self:GetVelocity():Length()
							-- local tvel = ent:GetVelocity():Length()
							
							-- local relativeVelocityR = ( mvel + ( mvel / tvel  ) / mvel + ( tvel / mvel ) )
							-- print("dopppler", relativeVelocityR )
						
							-- worldSound:SetPlaybackRate( 1.0 - ( d / 44000 ) ) -- doppler effect 
							-- worldSound:SetPos( ent:GetPos() + norm * ( d / 20 ) )
							-- worldSound:SetVolume( 1.0 - ( d / 36000 ) ) -- scale the volume based on distance from entity emitting the sound. f*** you valve 	
							local soundpos =  ent:GetPos() + norm * ( d / 30 )
							-- if ( true ) then
							
								-- debugoverlay.Cross( soundpos, 32, 10.1, Color( 255,255,255,255 ), false )
							
							-- end
							local doppler = math.Clamp( (pos:Distance(spos+tvel)-pos:Distance(spos+mvel))/200, -55, 55 )
							-- print( doppler )
							local properties = sound.GetProperties(  snd )
							FindAndMarkNearByPlayers( pos, snd )
							if( LONGDISTANCE_SOUNDS[snd] ) then 
								
								snd = LONGDISTANCE_SOUNDS[snd]
							
							end 
							local vol = 500 
							
							-- local tr1,trace1 ={},{}
							-- tr1.start = ent:GetPos()
							-- tr1.endpos = spos
							-- tr1.mask = MASK_SOLID_BRUSHONLY  + MASK_WATER
							-- trace1 = util.TraceLine( tr ) 
							
							
							sound.Play( snd, soundpos, 500, 100+doppler  ) -- Crappy Sauce Engine can't handle a couple of hundred meters of sound. Hackfix for doppler effect.
				
						-- end 
						 
					-- end )
					
					-- sound.Play( snd, ent:GetPos() + norm * ( d / 20 ), 511, 100  ) -- Crappy Sauce Engine can't handle a couple of hundred meters of sound. Hackfix for doppler effect.
				
				end
			
			end )
			
		else
		
			self:EmitSound( snd, 211, 100 )
		
		end
		
		end 
		
	end

end

print( "[NeuroBase] neuerotec_sounddata.lua loaded!" )