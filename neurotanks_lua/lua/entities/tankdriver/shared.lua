AddCSLuaFile()


ENT.Base 			= "base_nextbot"
ENT.PrintName	= "Tank Driver"
ENT.Spawnable		= false


function ENT:Initialize()


	self:SetModel( "models/Kleiner.mdl" );
	self:SetHealth(500)
	
	self.loco:SetDeathDropHeight(500)	//default 200
	self.loco:SetAcceleration(900)		//default 400
	self.loco:SetDeceleration(900)		//default 400
	self.loco:SetStepHeight(18)			//default 18
	self.loco:SetJumpHeight(58)		//default 58
	
	self.Isjumping = false
	
end



--
-- Name: NEXTBOT:BehaveUpdate
-- Desc: Called to update the bot's behaviour
-- Arg1: number|interval|How long since the last update
-- Ret1:
--
function ENT:BehaveUpdate( fInterval )


	if ( !self.BehaveThread ) then return end
	
	-- for _,j in pairs( ents.FindInSphere( self:GetPos(), 8000 ) ) do
		
		-- if( IsValid( j ) && j.VehicleType && j.VehicleType == VEHICLE_TANK && !IsValid( j.Pilot ) && j.LastAmmoSwap ) then

			-- self.Target = j
			
		-- end
		
	-- end
	
	-- If you are not jumping yet and a player is close jump at them
	-- if (!self.Isjumping && IsValid( self.Target ) ) then


			-- self.loco:FaceTowards( self.Target:GetPos() )
			-- self.loco:Jump( )
			-- self.Isjumping = true

	-- else	-- If you are in the air and a player is really close explode
		
		
	
	-- end
		
	local ok, message = coroutine.resume( self.BehaveThread )
	if ( ok == false ) then


		self.BehaveThread = nil
		Msg( self, "error: ", message, "\n" );


	end


end


function ENT:RunBehaviour()


	while ( true ) do


		-- Find the player
		local pos
		
		for _,j in pairs( ents.FindInSphere( self:GetPos(), 8000 ) ) do
			
			if( IsValid( j ) && j.VehicleType && j.VehicleType == VEHICLE_TANK && !IsValid( j.Pilot ) && j.LastAmmoSwap ) then
				
				pos = j:GetPos()
				local mp = self:GetPos()
				self.Target = j
				
				if( mp:Distance( pos ) < 200 ) then
					
					j:Use( self, self, 1, 1 )
					
					return
					
				end
			
			end
		
		end
				
		if ( pos ) then
			self:StartActivity( ACT_RUN )				-- run anim
			self.loco:SetDesiredSpeed( 360 )			-- run speed	
			local opts = {	lookahead = 300,
							tolerance = 20,
							draw = true,
							maxage = 1,
							repath = 0.1	}
			
			self:MoveToPos( pos, opts )													-- move to position (yielding)
			self.loco:FaceTowards( pos )

		else


			-- some activity to signify that we didn't find shit
			self:StartActivity( ACT_RUN )							-- walk anims
			self.loco:SetDesiredSpeed( 360 )						-- walk speeds
			self:MoveToPos( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 200 ) -- walk to a random place within about 200 units (yielding)
		end


		coroutine.yield()


	end


end


function ENT:OnLandOnGround()


	self.Isjumping = false
	self:StartActivity( ACT_RUN )
	
end


function ENT:OnKilled( damageinfo )
	
	-- If its killed by something other then it exploding then explode
	if ( damageinfo:GetAttacker() != self ) then
		
		
		
	end
	self:BecomeRagdoll( damageinfo )


end


--
-- List the NPC as spawnable
--
list.Set( "NPC", "UT2K4_SpiderMine", 	{	Name = "UT2K4 Spider Mine", 
										Class = "UT2K4_SpiderMine",
										Category = "UT2K4"	
									})