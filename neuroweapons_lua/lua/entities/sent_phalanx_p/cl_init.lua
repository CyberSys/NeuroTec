include('shared.lua')
local Laser = Material( "cable/redlaser" )
function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )

	self.CamDist = 300
	self.CamUp = 250

	
	self.MinZoom = 10
	self.MaxZoom = 95
	self.ZoomLevel = self.MaxZoom
	self.ZoomVar = self.ZoomLevel
	self.LastZoom = 0
	
end


function ENT:CalcView( ply, Origin, Angles, Fov )

	local weap = ply:GetNetworkedEntity("Weapon", NULL )
	local cannon = ply:GetNetworkedEntity("Cannon",NULL)

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( IsValid( weap ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local fov = GetConVarNumber("fov_desired")
		local ang,pAng,bAng = ply:GetAimVector():Angle(), weap:GetAngles(), cannon:GetAngles()
		
		local pos = cannon:LocalToWorld( Vector( -25, 36, 55 ) ) --Vector( -25, 28, 38 ) )
		ang = bAng
		
		if( ply:KeyDown( IN_ATTACK2 ) && self.LastZoom + 0.5 <= CurTime() ) then
			
			self.LastZoom = CurTime()
			
			if( self.ZoomLevel == self.MinZoom ) then
			
				self.ZoomLevel = self.MaxZoom

			elseif( self.ZoomLevel == self.MaxZoom ) then
			
				self.ZoomLevel = self.MinZoom
		
			end
			
		end
		
		self.ZoomVar = math.Approach( self.ZoomVar, self.ZoomLevel, 10 )
	
		local tAng = weap:GetAngles()
		
		
		view = {
			origin = pos,
			angles = Angle( ang.p, ang.y, ang.r / 1.5 ),
			fov = self.ZoomVar
			}

	end

	return view

end

function ENT:Draw()
	
	self:DefaultDrawInfo()

	
end
