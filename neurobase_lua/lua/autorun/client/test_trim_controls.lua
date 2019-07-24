
hook.Add("ContextMenuOpen", "NeuroTecSurfaceTrimMenu", function()
	
	local ply = LocalPlayer()
	local v = ply:GetScriptedVehicle()
	if( IsValid( v ) && ( v.ControlSurfaces || v.IsHelicopter ) && ply.PlanePanel == nil ) then 
		
		
		RunConsoleCommand("neurotec_trimcontrols")
		
		return false 
	
	end 


end )

concommand.Add("neurotec_trimcontrols", function( ply, cmd, args ) 
	local ply = LocalPlayer()
	local Settings = ply.TrimSettings or Vector()
	if( ply.PlanePanel ) then 
		ply.PlanePanel:Remove()
	end 
	
	ply.PlanePanel = vgui.Create( "DFrame" )
	local PlanePanel = ply.PlanePanel
	PlanePanel:SetPos( 5,5  )
	PlanePanel:SetSize( 300, 250 )
	PlanePanel:SetTitle( "Adjust Control Surface Trim" )
	PlanePanel:SetVisible( true )
	PlanePanel:SetDraggable( true )
	PlanePanel:ShowCloseButton( true )
	PlanePanel:MakePopup()

	local aileron = vgui.Create("DNumSlider", PlanePanel )
	aileron:SetPos( 0,60 )
	aileron:SetWide( 200 )
	aileron:SetMin( -1 )
	aileron:SetMax( 1 )
	aileron:SetValue( Settings.x )

	local dlabel = vgui.Create("DLabel", PlanePanel )
	dlabel:SetText("Aileron Trim")
	dlabel:SetPos( 100, 50 )
	dlabel:SetWide( 200 )
	
	local elevator = vgui.Create("DNumSlider", PlanePanel )
	elevator:SetPos( 0,100 )
	elevator:SetWide( 200 )
	elevator:SetMin( -1 )
	elevator:SetMax( 1 )
	elevator:SetValue( Settings.y )


	local dlabel = vgui.Create("DLabel", PlanePanel )
	dlabel:SetText("Elevator Trim")
	dlabel:SetPos( 100, 90 )
	dlabel:SetWide( 200 )
		
	local rudder = vgui.Create("DNumSlider", PlanePanel )
	rudder:SetPos( 0,150 )
	rudder:SetWide( 200 )
	rudder:SetMin( -1 )
	rudder:SetMax( 1 )
	rudder:SetValue( Settings.z )

	local dlabel = vgui.Create("DLabel", PlanePanel )
	dlabel:SetText("Rudder Trim")
	dlabel:SetPos( 100, 140 )
	dlabel:SetWide( 200 )
	
	local MenuButton = vgui.Create("DButton",PlanePanel)
	MenuButton:SetText( "Clear Trim! " )
	MenuButton:SetPos( 125, 190)
	MenuButton:SetSize( 75, 25 )
	MenuButton.DoClick = function ( btn )
		ply.TrimSettings = Vector( )
		RunConsoleCommand( "neurotec_trim", 0, 0, 0 )
		aileron:SetValue( 0 )
		rudder:SetValue( 0 )
		elevator:SetValue( 0 )
		PlanePanel:Remove()
		
	end 

	local MenuButton2 = vgui.Create("DButton",PlanePanel)
	MenuButton2:SetText( "Apply Trim! " )
	MenuButton2:SetPos( 50, 190)
	MenuButton2:SetSize( 75, 25 )
	MenuButton2.DoClick = function ( btn )
		
		SetTrimValues( aileron, elevator, rudder ) 
		PlanePanel:Remove()
		
	end 

	-- local MenuButton = vgui.Create("DButton",PlanePanel)
	-- MenuButton:SetText( "Set Trim " )
	-- MenuButton:SetPos( 100, 215)
	-- MenuButton:SetSize( 75, 25 )
	-- MenuButton.DoClick = function ( btn )
		-- SetTrimValues( aileron, elevator, rudder )
	-- end 

	rudder.OnValueChanged = function( val ) SetTrimValues( aileron, elevator, rudder ) end 
	elevator.OnValueChanged = function( val ) SetTrimValues( aileron, elevator, rudder ) end 
	aileron.OnValueChanged = function( val ) SetTrimValues( aileron, elevator, rudder ) end 
	

end )

function SetTrimValues( aileron, elevator, rudder )
	local ply = LocalPlayer()
	ply.TrimSettings = Vector( aileron:GetValue(), elevator:GetValue(), rudder:GetValue() )
	RunConsoleCommand( "neurotec_trim", aileron:GetValue(), elevator:GetValue(), rudder:GetValue() )

end 

print("Loaded NeuroMicro Control Surface Trim Panel");
