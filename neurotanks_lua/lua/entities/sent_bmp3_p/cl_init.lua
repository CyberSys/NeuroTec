include('shared.lua')

function ENT:Initialize()
	
	self:NeuroCarsDefaultInit()

	self.Barrel = self:GetNetworkedEntity( "Barrel",NULL )
	self.Tower = self:GetNetworkedEntity( "Tower", NULL )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	
end

function ENT:Think()
	
	self:DefaultNeuroCarThink()
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	return TankDefaultCalcView( ply, Origin, Angles, Fov, self.Entity )
	
end
local vec = Vector()
local ang = Angle( 90, 0, 0 )
local rsize = 512
local size = 32
local camdat = { fov = 70 }
local noisemat = Material( "effects/tvscreen_noise003a" )
local bsod = Material( "vgui/bsod.png" )
local welc = Material( "vgui/welcome.png" )

local rendertarget = GetRenderTarget( "tankrtcam", 512, 512, false )	
-- print( rendertarget:GetName() )
local w, h = ScrW(), ScrH() 
local cammaterial = CreateMaterial("NeuroTec_TankDisplay", "UnlitGeneric", {
	["$ignorez"] = 1,
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
	["$nolod"] = 1,
	["$basetexture"] = rendertarget:GetName()
})

function ENT:Draw()
	
	
	local pilot = self:GetNetworkedEntity("Pilot",NULL)
	local hp =  self:GetNetworkedInt("health",0 )
	-- print( IsValid( pilot ) )
	
	-- self:DrawModel()
	self:NeuroCarsDefaultDraw()
	-- local old_rendertarget = render.GetRenderTarget()
	
	
	if( IsValid( pilot ) && pilot == LocalPlayer() ) then
		-- self:SetColor( Color( 0,0,0,0 ) )
	
		
		vec = self:LocalToWorld( self.CockpitMonitorPos )
		ang = self:GetAngles()

		ang:RotateAroundAxis( self:GetRight(), 180 ) 
		ang:RotateAroundAxis( self:GetForward(), 90 ) 
		ang:RotateAroundAxis( self:GetUp(), 90 ) 

		camdat.origin = self:LocalToWorld( self.ExternalCameraPosition ) 
		camdat.angles = self:GetAngles()+Angle(5,0,0)
		
		camdat.w = w
		camdat.h = h
		camdat.x = 0
		camdat.y = 0
		camdat.drawviewmodel = false
		camdat.drawhud = false
		camdat.drawmonitors = false
		camdat.dopostprocess = false
		camdat.orth = false
		if( self.Pilot:KeyDown( IN_WALK ) ) then
			
			camdat.fov = Lerp(0.25, camdat.fov, 30 )
		
		else
			
			camdat.fov = Lerp(0.25, camdat.fov, 70 )
		
		end
		
		render.SetRenderTarget( rendertarget ) --// Change the RenderTarget, so all drawing will be redirected to our new RT
		
		render.SetViewPort( 0, 0, rsize, rsize )	
		render.Clear(0,0,0,255,true,true)
		render.ClearDepth()
		render.RenderView(camdat) 
		
		render.SetViewPort( 0, 0, w, h )
		render.SetRenderTarget( old_rendertarget ) --// Resets the RenderTarget to our screen
		cammaterial:SetTexture("$basetexture", rendertarget)

		self:DrawModel()
		
		cam.Start3D2D(vec, ang, 0.25)
			surface.SetDrawColor( 255, 255, 255, 255 )
			if( self:GetNetworkedBool("IsStarted",false) && hp > 200 ) then
				if( hp < self.InitialHealth/2 ) then
					surface.SetMaterial( noisemat )
					surface.DrawTexturedRect( -size, -size/2, size*2, size ) 
				end
				surface.SetMaterial( cammaterial )
				surface.DrawTexturedRect( -size, -size/2, size*2, size ) 
			else
				
				surface.SetDrawColor( 1, 1, 1, 1 )
				surface.SetMaterial( noisemat )
				surface.DrawTexturedRect( -size, -size/2, size*2, size ) 
			
			
			end

			surface.SetDrawColor( 255, 0, 0, 85 )
			surface.DrawLine( -size/2, -5, size/2, -5 )
			surface.DrawLine( 0, -size/4-5, 0, size/4-5 )

		cam.End3D2D()
		
	end
	
	-- self:SetColor( Color( 255,255,255,255 ) )

	
end
