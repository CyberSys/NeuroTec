/*********************************************************************/
/* 																	 */
/*  					NEUROTANK MENU								 */
/* 																	 */
/*********************************************************************/

//Some variables we need

local Tank = {}
Tank.Background = surface.GetTextureID( "console/background01" )
Tank.button = surface.GetTextureID( "tankhud/tank_button.vtf" )
Tank.ButtonColor = Color( 255, 205, 0, 255)
Tank.PrimaryWeaponIcon = surface.GetTextureID( "vgui/shells/high_explosive.vtf" )
Tank.SecondaryWeaponIcon = surface.GetTextureID( "effects/neuro_shell.vtf" )
Tank.CounterMeasureIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" ) //
Tank.OpticIcon = surface.GetTextureID( "vgui/entities/binoculars.vtf" )
Tank.UpgradeIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" ) //
Tank.SkinIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" ) //
Tank.GunnerOpticIcon = surface.GetTextureID( "vgui/entities/util_binoculars.vtf" )
Tank.GunnerUpgradeIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" ) //

function Tank.Menu(ply,tr)

	local TankFrame = vgui.Create( "DFrame" )
	TankFrame:SetPos( 0,0 )
	TankFrame:SetSize( ScrW(), ScrH() )
	TankFrame:SetTitle( "Select Tank" )
	TankFrame:SetVisible( true )
	-- TankFrame:SetAlpha( 10 )
	TankFrame:SetDraggable( false )
	TankFrame:ShowCloseButton( true )
	TankFrame:MakePopup()
	-- TankFrame:ParentToHUD()
	
 	local x,y=ScrW()*0.05, ScrH()*0.1
	local w,h=200,ScrH()*0.045
	local view_H=ScrH()*0.6
	local view_W=view_H*16/9

	local TankPanel = vgui.Create( "DPanel", TankFrame )
	TankPanel:SetPos( 0, 23 )
	TankPanel:SetSize( TankFrame:GetWide(), TankFrame:GetTall()-23 )
	TankPanel.Paint = function()
		//Drawing the background
		-- surface.SetDrawColor( 200, 200, 200, 100 ) 
		-- surface.DrawRect( 0, 0, TankPanel:GetWide(), TankPanel:GetTall() )
		surface.SetDrawColor( 150, 150, 150, 255 )
		surface.SetTexture( Tank.Background )
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH()-23 )
		
		surface.SetTexture( Tank.button );
		surface.DrawTexturedRect( ScrW()*0.5+view_W/2, ScrH()*0.5-view_H/2, view_W/3 , view_H )
		draw.SimpleText("Some description.", "TargetID", ScrW()*0.9, ScrH()*0.5-view_H/4, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		//Drawing separating lines with button texture below
		for i =2,5 do
		surface.SetDrawColor( 255, 255, 255, 255 ) 
		surface.DrawOutlinedRect( x, y*i, w, h )
		surface.DrawOutlinedRect( x, y*(i+0.5), w, h )
		surface.SetDrawColor( 0, 0, 0, 255 ) 
		surface.DrawLine( x, y*i+h/2, x+w-h, y*i+h/2 )
		surface.DrawLine( x, y*(i+0.5)+h/2, x+w-h, y*(i+0.5)+h/2 )
		surface.DrawLine( x+w-h, y*i, x+w-h, y*i+h )
		surface.DrawLine( x+w-h, y*(i+0.5), x+w-h, y*(i+0.5)+h )
		surface.SetDrawColor( Tank.ButtonColor ) 
		surface.DrawRect( x, i*y+h/2, w-h, h/2 )
		surface.DrawRect( x, (i+0.5)*y+h/2, w-h, h/2 )
		surface.SetTexture( Tank.button );
		surface.SetDrawColor( 255, 255, 255, 255 ) 
		surface.DrawTexturedRect( x, i*y+h/2, w-h , h/2 )
		surface.DrawTexturedRect( x, (i+0.5)*y+h/2, w-h , h/2 )
		end
		//Writing titles		
		surface.SetDrawColor( 200, 200, 200, 100 ) 
		draw.SimpleText("Primary Weapon", "TargetID", ScrW()*0.05, ScrH()*0.2, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText("Secondary Weapon", "TargetID", ScrW()*0.05, ScrH()*0.25, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText("Countermeasure", "TargetID", ScrW()*0.05, ScrH()*0.3, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText("Optics", "TargetID", ScrW()*0.05, ScrH()*0.35, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText("Upgrade", "TargetID", ScrW()*0.05, ScrH()*0.4, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText("Skin", "TargetID", ScrW()*0.05, ScrH()*0.45, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText("Gunner Optic", "TargetID", ScrW()*0.05, ScrH()*0.5, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		draw.SimpleText("Gunner Upgrade", "TargetID", ScrW()*0.05, ScrH()*0.55, Color( 255, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )

		draw.SimpleText("Close", "TargetID", ScrW()*0.5, ScrH()*0.9, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText("Spawn", "TargetID", ScrW()*0.75, ScrH()*0.9, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		draw.SimpleText("Save", "TargetID", ScrW()*0.05, ScrH()*0.9, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText("Load", "TargetID", ScrW()*0.15, ScrH()*0.9, Color( 255, 255, 255, 200 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		//Icons
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetTexture( Tank.PrimaryWeaponIcon )
		surface.DrawTexturedRect( x+w-h, y*2, h , h )
		surface.SetTexture( Tank.SecondaryWeaponIcon )
		surface.DrawTexturedRect( x+w-h, y*2.5, h , h )
		surface.SetTexture( Tank.CounterMeasureIcon )
		surface.DrawTexturedRect( x+w-h, y*3, h , h )
		surface.SetTexture( Tank.OpticIcon )
		surface.DrawTexturedRect( x+w-h, y*3.5, h , h )
		surface.SetTexture( Tank.UpgradeIcon )
		surface.DrawTexturedRect( x+w-h, y*4, h , h )
		surface.SetTexture( Tank.SkinIcon )
		surface.DrawTexturedRect( x+w-h, y*4.5, h , h )
		surface.SetTexture( Tank.GunnerOpticIcon )
		surface.DrawTexturedRect( x+w-h, y*5, h , h )
		surface.SetTexture( Tank.GunnerUpgradeIcon )
		surface.DrawTexturedRect( x+w-h, y*5.5, h , h )
	end

	-- local TankBackground = vgui.Create( "DFrame", TankFrame )
	-- TankBackground:SetParent(TankPanel)
	-- TankBackground:SetPos( ScrW()*0.2,23 )
	-- TankBackground:SetSize( ScrW()*0.4, 503 )
	-- TankBackground:SetTitle( "Tank View" )
	-- TankBackground:SetVisible( true )
	-- TankBackground:SetDraggable( false )
	-- TankBackground:ShowCloseButton( false )
	-- TankBackground:MakePopup()

//Interface
	local TankMenuDComboBox = {}
	local click_color = 1
	for i=2,5.5,0.5 do
		TankMenuDComboBox[i] = vgui.Create( "DComboBox" )
		TankMenuDComboBox[i]:SetParent(TankPanel)
		-- TankMenuDComboBox[i]:SetPos( x+w/2, i*y +h/2 )
		TankMenuDComboBox[i]:SetPos( x+h, i*y +h/2 )
		TankMenuDComboBox[i]:SetSize( w-2*h, h/2 )
		TankMenuDComboBox[i]:SetDrawBackground( false )	
		TankMenuDComboBox[i].Paint = function()	
			//We don't want the basic "Box" button
		end

	end
	
	//Primary Ammo
	TankMenuDComboBox[2]:SetValue( "HE Shell" )	
	TankMenuDComboBox[2]:AddChoice( "HE Shell" )
	TankMenuDComboBox[2]:AddChoice( "HE Powerfull Shell" )
	TankMenuDComboBox[2]:AddChoice( "120mm AP Shell" )
	TankMenuDComboBox[2]:AddChoice( "AP/cR Shell" )
	TankMenuDComboBox[2]:AddChoice( "AP/HE Shell" )
	TankMenuDComboBox[2]:AddChoice( "Hollow Shell" )
	TankMenuDComboBox[2]:AddChoice( "Flak Shell" )
	TankMenuDComboBox[2].OnSelect = function( panel, index, value, data )	
		if index == 1 then		Tank.PrimaryWeaponIcon = surface.GetTextureID( "vgui/shells/high_explosive.vtf" )
		elseif index == 2 then	Tank.PrimaryWeaponIcon = surface.GetTextureID( "vgui/shells/high_explosive_premium.vtf" )
		elseif index == 3 then	Tank.PrimaryWeaponIcon = surface.GetTextureID( "vgui/shells/armor_piercing.vtf" )
		elseif index == 4 then	Tank.PrimaryWeaponIcon = surface.GetTextureID( "vgui/shells/armor_piercing_cr.vtf" )
		elseif index == 5 then	Tank.PrimaryWeaponIcon = surface.GetTextureID( "vgui/shells/armor_piercing_he.vtf" )
		elseif index == 6 then	Tank.PrimaryWeaponIcon = surface.GetTextureID( "vgui/shells/hollow_charge.vtf" )	
		elseif index == 7 then	Tank.PrimaryWeaponIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" )	
		else
		Tank.PrimaryWeaponIcon = surface.GetTextureID( "vgui/shells/high_explosive.vtf" )
		click_color = 0
		timer.Simple( 1, function() Tank.ButtonColor = Color(255,0,0,255) end)
		end
		-- Msg( TankMenuDComboBox[2] :GetValue().." selected. \n" )
		-- ply:SetNWString( "TankPayload"..i..", ""..TankMenuDComboBox[i] :GetValue().."")
	end
	//Secondary Ammo
	TankMenuDComboBox[2.5]:SetValue( "SMG" )	
	TankMenuDComboBox[2.5]:AddChoice( "SMG" )
	TankMenuDComboBox[2.5]:AddChoice( "Shotgun" )
	TankMenuDComboBox[2.5]:AddChoice( "Minigun" )
	TankMenuDComboBox[2.5]:AddChoice( "TOW Missile" )	
	TankMenuDComboBox[2.5]:AddChoice( "Guided Missile" )	
	TankMenuDComboBox[2.5].OnSelect = function( panel, index, value, data )	
		if index == 1 then		Tank.SecondaryWeaponIcon = surface.GetTextureID( "effects/neuro_shell.vtf" )
		else
		Tank.SecondaryWeaponIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" )
		end
	end
	//counterMeasure
	TankMenuDComboBox[3]:SetValue( "IR Smoke" )
	TankMenuDComboBox[3]:AddChoice( "IR Smoke" )
	TankMenuDComboBox[3]:AddChoice( "CME" )
	TankMenuDComboBox[3]:AddChoice( "Defences" )
	TankMenuDComboBox[3].OnSelect = function( panel, index, value, data )	
		if index == 1 then		Tank.CounterMeasureIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" )
		else
		Tank.CounterMeasureIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" )
		end
	end
	//Optics
	TankMenuDComboBox[3.5]:SetValue( "Zoom Optics" )
	TankMenuDComboBox[3.5]:AddChoice( "Zoom Optics" )
	TankMenuDComboBox[3.5]:AddChoice( "IR Optics" )
	TankMenuDComboBox[3.5].OnSelect = function( panel, index, value, data )	
		if index == 1 then		Tank.OpticIcon = surface.GetTextureID( "vgui/entities/binoculars.vtf" )
		else
		Tank.OpticIcon = surface.GetTextureID( "vgui/entities/binoculars.vtf" )
		end
	end
	//Upgrades
	TankMenuDComboBox[4]:SetValue( "Maintenance" )
	TankMenuDComboBox[4]:AddChoice( "Maintenance" )
	TankMenuDComboBox[4]:AddChoice( "Quick Reload" )
	TankMenuDComboBox[4].OnSelect = function( panel, index, value, data )	
		if index == 1 then		Tank.UpgradeIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" )
		else
		Tank.UpgradeIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" )
		end
	end
	//Skin
	TankMenuDComboBox[4.5]:SetValue( "Default" )
	TankMenuDComboBox[4.5]:AddChoice( "Default" )
	TankMenuDComboBox[4.5]:AddChoice( "Custom" )
	TankMenuDComboBox[4.5]:AddChoice( "Urban" )
	TankMenuDComboBox[4.5]:AddChoice( "Desert" )
	TankMenuDComboBox[4.5]:AddChoice( "Forest" )
	TankMenuDComboBox[4.5]:AddChoice( "Op" )
	TankMenuDComboBox[4.5].OnSelect = function( panel, index, value, data )	
		//->Update the model with the selected skin
	end
	//Gunner Optics
	TankMenuDComboBox[5]:SetValue( "Zoom Optics" )
	TankMenuDComboBox[5]:AddChoice( "Zoom Optics" )
	TankMenuDComboBox[5]:AddChoice( "Thermal Optics" )
	TankMenuDComboBox[5]:AddChoice( "Target Designator" )
	TankMenuDComboBox[5].OnSelect = function( panel, index, value, data )	
		if index == 1 then		Tank.GunnerOpticIcon = surface.GetTextureID( "vgui/entities/util_binoculars.vtf" )
		else
		Tank.GunnerOpticIcon = surface.GetTextureID( "vgui/entities/util_binoculars.vtf" )
		end
	end
	//Gunner Upgrade
	TankMenuDComboBox[5.5]:SetValue( "Proximity Scanner" )
	TankMenuDComboBox[5.5]:AddChoice( "Proximity Scanner" )
	TankMenuDComboBox[5.5]:AddChoice( "Extinguisher" )
	TankMenuDComboBox[5.5]:AddChoice( "Mines" )
	TankMenuDComboBox[5.5].OnSelect = function( panel, index, value, data )	
		if index == 1 then		Tank.GunnerUpgradeIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" )
		else
		Tank.GunnerUpgradeIcon = surface.GetTextureID( "tankhud/dash_powertrain.vtf" )
		end
	end
	
	//Some Buttons
	local TankButton = {}
	local ofw,ofh = w/4,h/2
	for i=1,4 do
		TankButton[i] = vgui.Create( "DImageButton", TankPanel ) 
		TankButton[i]:SetParent(TankPanel)
		TankButton[i]:SetSize( w/2, h )
		TankButton[i]:SetImage( "tankhud/tank_button.vtf" )
	end
	
	TankButton[1]:SetPos( ScrW()*0.5-ofw, ScrH()*0.9-ofh ) 	//close
	TankButton[1].DoClick = function()
		Msg("Tank menu closed. \n")
		TankFrame:Close()
	end
	TankButton[2]:SetPos( ScrW()*0.75-ofw, ScrH()*0.9-ofh ) //Spawn
	TankButton[2].DoClick = function()
		Msg("Tank spawned. \n")
		TankButton[2]:SetColor( Color( 0, 255, 150, 255) )
	end
	TankButton[3]:SetPos( ScrW()*0.05-ofw, ScrH()*0.9-ofh )	//Save
	TankButton[3].DoClick = function()
		Msg("Your settings have been saved... \n")
	end
	TankButton[4]:SetPos( ScrW()*0.15-ofw, ScrH()*0.9-ofh )	//Load
	TankButton[4].DoClick = function()
		Msg("Settings loaded... \n")
	end

		

//Displaying the model
	local model = "models/humvee/humvee.mdl"
	-- local BoundingRadius = model:BoundingRadius()
	-- print(BoundingRadius)
	local TankModelPanel = vgui.Create( "DAdjustableModelPanel", TankPanel )
		TankModelPanel:SetParent(TankPanel)
		TankModelPanel:SetPos( ScrW()*0.5-view_W/2, ScrH()*0.5-view_H/2 )
		TankModelPanel:SetSize( view_W,view_H )
		TankModelPanel:SetCamPos( Vector( -75,150,75 ) )
		TankModelPanel:SetLookAt( Vector( 0,0,50 ) )
		TankModelPanel:SetFOV( 90 )
		TankModelPanel:SetModel( model )
	function TankModelPanel:LayoutEntity( )	self:RunAnimation()	end
		-- function TankModelPanel:LayoutEntity( Entity ) return end 
		local ent = TankModelPanel:GetEntity()
		print(ent:BoundingRadius() )
		-- function TankModelPanel:SetCamPos( Vector( ent:BoundingRadius()*100,ent:BoundingRadius(),ent:BoundingRadius()) ) return end 


end
concommand.Add("NeuroTank_menu", Tank.Menu)

print( "[NeuroTanks] TankMenu.lua loaded!" )