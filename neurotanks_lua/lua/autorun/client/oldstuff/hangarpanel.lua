include('DHangar.lua')
include('DProgressBar.lua')
include('TankDB.lua')
surface.CreateFont( "MenuLabel", {
 font = "Impact",
 size = 32,
 weight = 5000,
 blursize = 0,
 scanlines = 0,
 antialias = true,
 underline = false,
 italic = false,
 strikeout = false,
 symbol = false,
 rotary = false,
 shadow = false,
 additive = false,
 outline = false
} )
-- Return the percentage of absolute value:
-- e.g.: Perc(ScrW(),75) returns the 75% of screen width
function Perc(absolute, percentage)
	return absolute * percentage/100
end


function DrawHangar()
    local index = 1
    local bgindex1 = 0
    local bgindex2 = 0
    local skin = 0
    local TPExists = false
    local GPExists = false
    local SkinExists = false
    local Click = false
    local campos = Vector(-450,0,200)
    local camrad = 450
    
    
    -- print("Index: "..index)
    
    local MainPanel = vgui.Create( "DFrame" )
    
    local MainW,MainH = Perc(ScrW(),90),Perc(ScrH(),90)
    MainPanel:SetPos(Perc(ScrW(),5),Perc(ScrH(),5))
    
    MainPanel:SetSize(MainW,MainH)
    MainPanel:SetTitle( "Vehicle Selection" )
    MainPanel:SetVisible( true )
    MainPanel:SetDraggable( false )
    MainPanel:ShowCloseButton( true )
    MainPanel:MakePopup()


    local SectionPanel1 = vgui.Create( "DPanel", MainPanel )
    local Sp1W,Sp1H = Perc(MainW,60),Perc(MainH,85)
    
    SectionPanel1:SetSize( Sp1W, Sp1H )
    SectionPanel1:SetPos(Perc(MainW,4), Perc(MainH,10))
    
    SectionPanel1.Paint = function()
        surface.SetDrawColor( 50, 50, 50, 255 ) 
        surface.DrawRect( 0, 0, SectionPanel1:GetWide(), SectionPanel1:GetTall() )
    end    
    
    local SectionPanel2 = vgui.Create( "DPanel", MainPanel )
    local Sp2W,Sp2H = 35,35
    
    SectionPanel2:SetSize( Sp2W,Sp2H )
    SectionPanel2:SetPos( Perc(MainW,100), Perc(MainH,100) )    
    
    SectionPanel2.Paint = function()
        surface.SetDrawColor( 50, 50, 50, 255 ) 
        surface.DrawRect( 0, 0, SectionPanel2:GetWide(), SectionPanel2:GetTall() )
    end 

    local pnl = vgui.Create("DHangar",SectionPanel1)
    pnl:SetSize(Sp1W,Sp1H)
    pnl:SetPos(0,-37)    
    pnl:SetUp()    

    local touchPnl = vgui.Create("DPanel",SectionPanel1)
    touchPnl:SetSize(Sp1W,Sp1H)
    touchPnl:SetPos(0,0)    
    -- touchPnl:SetVisible( true )
    -- touchPnl:SetDraggable( false )
    -- touchPnl:ShowCloseButton( false )
    -- touchPnl:MakePopup()
    
    -- pnl.OnCursorMoved = function(x,y)
        -- local x,y = self:CursorPos()
        -- local pos = Vector(0,0,0) 
        -- pos.x = pos.x + math.sin( x ) * 500
        -- pos.y = pos.y + math.cos( y ) * 500
        -- pos.z = 300
        -- print("X: "..x)
        -- print("Y: "..y)
        -- self.pnlModel:SetCamPos(pos)
    -- end
    touchPnl.OnMousePressed = function(panel, mc)
        if mc == MOUSE_LEFT then
            Click = true
        end
        -- print("OnMousePressed: "..tostring(Click))
    end
    touchPnl.OnMouseReleased = function(panel, mc)
        if mc == MOUSE_LEFT then
            Click = false
        end
        -- print("OnMouseReleased: "..tostring(Click))
    end
    touchPnl.OnCursorMoved = function(panel, x, y)
        -- print("OnCursorMoved: "..tostring(Click))
        if Click then
            -- local x,y = pnl.touchPnl:CursorPos()/2.5
            campos.x = math.sin( x*math.pi/180 ) * camrad
            campos.y = math.cos( x*math.pi/180 ) * camrad
            campos.z = 200
            pnl.pnlModel:SetCamPos(campos)       
            pnl.pnlModel:SetLookAt(tank:GetPos())    
        end
    
    end      
    
    tank = pnl:AddModel(TankDB[index].BodyMdl)
    tank:SetPos(Vector(0,0,10))
    tank:SetAngles(Angle(0,90,0))
    
    turret = pnl:AddModel(TankDB[index].TurretMdl)
    turret:SetPos(tank:LocalToWorld(TankDB[index].TurretPos))
    turret:SetAngles(Angle(0,90,0))
    
    gun = pnl:AddModel(TankDB[index].GunMdl)
    gun:SetPos(tank:LocalToWorld(TankDB[index].GunPos))
    gun:SetAngles(Angle(0,90,0))    
    
	local tracks
	if( TankDB[index].TrackModels != nil ) then
		
		local Tracks = TankDB[index].TrackModels 
		for i=1,#Tracks do
			
			tracks = pnl:AddModel( Tracks[i] )
			tracks:SetPos( Vector(0,0,0) )
			tracks:SetAngles( Angle( 0,90, 0 ) )
		
		end
		
	end
		
		
    pnl.pnlModel:SetCamPos(campos)
    pnl.pnlModel:SetLookAt(tank:GetPos())
    
---------------------Labels and Bars-----------------------           
    
    local NameLabel = vgui.Create("DLabel", SectionPanel2)
    -- NameLabel:SetFont("HUDNumber1")
    NameLabel:SetText( string.upper( TankDB[index].Name ) )
    -- --NameLabel:SizeToContents()
	NameLabel:SetFont("MenuLabel")
    local NlaW,NlaH = NameLabel:GetSize()
	NameLabel:SetPos((Sp2W-NlaW)/2,Perc(Sp2H,2))
    NameLabel:SetColor(Color(255,255,255,255)) 
    NameLabel:SetExpensiveShadow( 3, Color( 0, 0, 0, 255 ) )
    
    local NameLabelAlign = 1
    
---------------Square for buttons and bars----------------
	local SbbX,SbbY = 0,Perc(Sp2H,2)+NlaH
	local SbbW,SbbH = Sp2W,Perc(Sp2H,90)-SbbY
	local BarAndButtonH = Perc(SbbH,24)
      
---------------------Turret-------------------------------    
    
-- if TankDB[index].TurretBgCount > 0 then

local function Bg1Create()

    TurretBar = vgui.Create( "DProgressBar",SectionPanel2)
    TurretBar:SetSize( Perc(SbbW,90), Perc(SbbH,6) )
    TurretBar:SetPos( Perc(SbbW,5)+SbbX, Perc(SbbH,4)+SbbY+BarAndButtonH)
    TurretBar:SetMin( 0 )
    TurretBar:SetMax(TankDB[index].TurretBgCount)   
    TurretBar:SetValue(bgindex1) 

    Bg1Left = vgui.Create( "DButton", SectionPanel2 )
    Bg1Left:SetPos( Perc(SbbW,5)+SbbX,Perc(SbbH,12)+SbbY+BarAndButtonH )
    Bg1Left:SetSize( Perc(SbbH,12),Perc(SbbH,12) )
    Bg1Left:SetText( "<" )    
    Bg1Left.DoClick = function ()
        bgindex1 = bgindex1 - 1
        if bgindex1 < 0 then bgindex1 = 0 end
        -- print("BGIndex: "..bgindex1)
        
        turret:SetBodygroup(0,bgindex1)
        TurretBar:SetValue(bgindex1)
    end
    
    
    Bg1Right = vgui.Create( "DButton", SectionPanel2 )
    Bg1Right:SetSize( Perc(SbbH,12),Perc(SbbH,12) )
    Bg1Right:SetPos( SbbX+SbbW-Perc(SbbW,5)-Perc(SbbH,12),Perc(SbbH,12)+SbbY+BarAndButtonH )
    
    Bg1Right:SetText( ">" )
       
    Bg1Right.DoClick = function ()
        bgindex1 = bgindex1 + 1
        if bgindex1 > TankDB[index].TurretBgCount then bgindex1 = TankDB[index].TurretBgCount end
        -- print("BGIndex: "..bgindex1)
    
        turret:SetBodygroup(0,bgindex1)
        TurretBar:SetValue(bgindex1)
    end
    
    -- TurretBar:SetMax(TankDB[index].TurretBgCount)
    -- TurretBar:SetValue(bgindex1)
    
    TPExists = true

end

local function Bg1Remove()
    Bg1Left:Remove()
    Bg1Right:Remove()
    TurretBar:Remove()
    TPExists = false    
end

Bg1Create()
---------------------GUN-------------------------------
    
-- if TankDB[index].GunBgCount > 0 then    

local function Bg2Create()
    
    GunBar = vgui.Create( "DProgressBar",SectionPanel2)
    GunBar:SetSize( Perc(SbbW,90), Perc(SbbH,6) )
    GunBar:SetPos( Perc(SbbW,5)+SbbX, Perc(SbbH,4)+SbbY+BarAndButtonH*2)
    GunBar:SetMin( 0 )
    GunBar:SetMax(TankDB[index].GunBgCount)   
    GunBar:SetValue(bgindex2)        
    
    Bg2Left = vgui.Create( "DButton",SectionPanel2 )
    Bg2Left:SetText( "<" )
    Bg2Left:SetPos( Perc(SbbW,5)+SbbX,Perc(SbbH,12)+SbbY+BarAndButtonH*2 )
    Bg2Left:SetSize( Perc(SbbH,12),Perc(SbbH,12) )
    Bg2Left.DoClick = function ()
    
        bgindex2 = bgindex2 - 1
        if bgindex2 < 0 then bgindex2 = 0 end
        -- print("BG2Index: "..bgindex2)
        
        gun:SetBodygroup(0,bgindex2)
        GunBar:SetValue(bgindex2) 
    
    
    end
    
    Bg2Right = vgui.Create( "DButton",SectionPanel2 )
    Bg2Right:SetSize( Perc(SbbH,12),Perc(SbbH,12) )
    Bg2Right:SetPos( SbbX+SbbW-Perc(SbbW,5)-Perc(SbbH,12),Perc(SbbH,12)+SbbY+BarAndButtonH*2 )
    Bg2Right:SetText( ">" )
    Bg2Right.DoClick = function ()
    
        bgindex2 = bgindex2 + 1
        if bgindex2 > TankDB[index].GunBgCount then bgindex2 = TankDB[index].GunBgCount end
        -- print("BG2Index: "..bgindex1)
    
        gun:SetBodygroup(0,bgindex2)
        GunBar:SetValue(bgindex2) 
    
    end

    -- GunBar:SetMax(TankDB[index].GunBgCount)
    -- GunBar:SetValue(bgindex2)   
    
    GPExists = true
    
end

local function Bg2Remove()
    Bg2Left:Remove()
    Bg2Right:Remove()
    GunBar:Remove()
    GPExists = false
end

Bg2Create()
        

---------------------------Skin----------------------------- 
        
        
local function SkinCreate()
    
    SkinBar = vgui.Create( "DProgressBar",SectionPanel2)
    SkinBar:SetSize( Perc(SbbW,90), Perc(SbbH,6) )
    SkinBar:SetPos( Perc(SbbW,5)+SbbX, Perc(SbbH,4)+SbbY+BarAndButtonH*3)
    SkinBar:SetMin( 0 )
    SkinBar:SetMax(tank:SkinCount())   
    SkinBar:SetValue(skin)        
    
    SkinLeft = vgui.Create( "DButton",SectionPanel2 )
    SkinLeft:SetText( "<" )
    SkinLeft:SetPos( Perc(SbbW,5)+SbbX,Perc(SbbH,12)+SbbY+BarAndButtonH*3 )
    SkinLeft:SetSize( Perc(SbbH,12),Perc(SbbH,12) )
    SkinLeft.DoClick = function ()
    
        skin = skin - 1
        if skin < 0 then skin = 0 end
        -- print("Skin: "..skin)
        
        tank:SetSkin(skin)
        turret:SetSkin(skin)
        gun:SetSkin(skin)
        SkinBar:SetValue(skin) 
    
    
    end
    
    
    SkinRight = vgui.Create( "DButton",SectionPanel2 )
    SkinRight:SetText( ">" )
    SkinRight:SetSize( Perc(SbbH,12),Perc(SbbH,12) )
    SkinRight:SetPos( SbbX+SbbW-Perc(SbbW,5)-Perc(SbbH,12),Perc(SbbH,12)+SbbY+BarAndButtonH*3 )
    SkinRight.DoClick = function ()
    
        skin = skin + 1
        if skin > tank:SkinCount() then skin = tank:SkinCount() end
        -- print("Skin: "..skin)
    
        tank:SetSkin(skin)
        turret:SetSkin(skin)
        gun:SetSkin(skin)
        SkinBar:SetValue(skin) 
    
    end

    SkinExists = true
    
end

local function SkinRemove()
    SkinLeft:Remove()
    SkinRight:Remove()
    SkinBar:Remove()
    SkinExists = false
end

SkinCreate()        
        
        
---------------------------Body-----------------------------                       
    local Left = vgui.Create( "DButton", SectionPanel2 )
    Left:SetText( "<" )
    Left:SetPos( Perc(SbbW,5)+SbbX,Perc(SbbH,12)+SbbY )
    Left:SetSize( Perc(SbbH,12),Perc(SbbH,12) )
    Left.DoClick = function ()
        index = index - 1
        if index < 1 then index = 1 end
        -- print("Index: "..index)
        
        bgindex1 = TankDB[index].DefaultTurretBg
        bgindex2 = TankDB[index].DefaultGunBg
        -- if TankDB[index].TurretBgCount
        
        if TankDB[index].TurretBgCount > 0 then
            if not TPExists then
                Bg1Create()
            end
            TurretBar:SetMax(TankDB[index].TurretBgCount)
            TurretBar:SetValue(bgindex1)            
        else
            Bg1Remove()
        end
        
        if TankDB[index].GunBgCount > 0 then
            if not GPExists then
                Bg2Create()
            end
            GunBar:SetMax(TankDB[index].GunBgCount)
            GunBar:SetValue(bgindex2)              
        else
            Bg2Remove()
        end    
        
        tank:SetModel(TankDB[index].BodyMdl)
        turret:SetModel(TankDB[index].TurretMdl)
        gun:SetModel(TankDB[index].GunMdl)
        turret:SetPos(tank:LocalToWorld(TankDB[index].TurretPos))
        gun:SetPos(tank:LocalToWorld(TankDB[index].GunPos))
        turret:SetBodygroup(0,TankDB[index].DefaultTurretBg)   
        gun:SetBodygroup(0,TankDB[index].DefaultGunBg)
        -- NameLabel:SetText(TankDB[index].Name)
		NameLabel:SetText( string.upper( TankDB[index].Name ) )
        --NameLabel:SizeToContents()
        
        local w1,h1 = SectionPanel2:GetSize()/2 ---NameLabelAlign
        local w2,h2 = NameLabel:GetSize()
        local w3 = w1+w2
        local w4 = SectionPanel2:GetSize() - w3
        local w5 = (w1+w4)/2
        NameLabel:SetPos(50,30)
        
        -- print(tank:SkinCount())
        
        if tank:SkinCount() > 1 then
            if not SkinExists then
                SkinCreate()
            end
            SkinBar:SetMax(tank:SkinCount())
            SkinBar:SetValue(skin)              
        else
            SkinRemove()
        end              
            
    end
    
    
    local Right = vgui.Create( "DButton",SectionPanel2 )
    Right:SetText( ">" )
    Right:SetSize( Perc(SbbH,12),Perc(SbbH,12) )
    Right:SetPos( SbbX+SbbW-Perc(SbbW,5)-Perc(SbbH,12),Perc(SbbH,12)+SbbY )
    Right.DoClick = function ()
    
        index = index + 1
        if index > #TankDB then index = #TankDB end
        -- print("Index: "..index)
        
        bgindex1 = TankDB[index].DefaultTurretBg
        bgindex2 = TankDB[index].DefaultGunBg

        -- if TankDB[index].TurretBgCount
        
        if TankDB[index].TurretBgCount > 0 then
            if not TPExists then
                Bg1Create()
            end
            TurretBar:SetMax(TankDB[index].TurretBgCount)
            TurretBar:SetValue(bgindex1)            
        else
            Bg1Remove()
        end
        
        if TankDB[index].GunBgCount > 0 then
            if not GPExists then
                Bg2Create()
            end
            GunBar:SetMax(TankDB[index].GunBgCount)
            GunBar:SetValue(bgindex2)              
        else
            Bg2Remove()
        end       
        
        tank:SetModel(TankDB[index].BodyMdl)
        turret:SetModel(TankDB[index].TurretMdl)
        gun:SetModel(TankDB[index].GunMdl)
        turret:SetPos(tank:LocalToWorld(TankDB[index].TurretPos))
        gun:SetPos(tank:LocalToWorld(TankDB[index].GunPos))
        turret:SetBodygroup(0,TankDB[index].DefaultTurretBg)   
        gun:SetBodygroup(0,TankDB[index].DefaultGunBg)
        -- NameLabel:SetText(TankDB[index].Name)
		 NameLabel:SetText( string.upper( TankDB[index].Name ) )
        --NameLabel:SizeToContents()          
        
        local w1,h1 = SectionPanel2:GetSize()/2-NameLabelAlign
        local w2,h2 = NameLabel:GetSize()
        local w3 = w1+w2
        local w4 = SectionPanel2:GetSize() - w3
        local w5 = (w1+w4)/2
        NameLabel:SetPos(w5,30)
        
        -- print(tank:SkinCount())
        
        if tank:SkinCount() > 1 then
            if not SkinExists then
                SkinCreate()
            end
            SkinBar:SetMax(tank:SkinCount())
            SkinBar:SetValue(skin)              
        else
            SkinRemove()
        end           

    end
    
    -- NumSlider = vgui.Create( "DNumSlider", SectionPanel2 )
    -- NumSlider:SetPos( 100,550 )
    -- NumSlider:SetWide( 100 )
    -- NumSlider:SetText( "Rotation" )
    -- NumSlider:SetMin( 0 )
    -- NumSlider:SetMax( 360 )
    -- NumSlider:SetDecimals( 0 )
    -- NumSlider.OnValueChanged = function( panel, value )
        -- local pos = Vector(0,0,200)
        -- pos.x = 0 + math.sin( value*math.pi/180 ) * 450
        -- pos.y = 0 + math.cos( value*math.pi/180 ) * 450
        -- pos.z = 200
        -- pnl.pnlModel:SetCamPos(pos)       
        -- pnl.pnlModel:SetLookAt(tank:GetPos())
    -- end       
    
    Spawnbutton = vgui.Create( "DButton",SectionPanel2 )
    Spawnbutton:SetText( "Apply" )
    Spawnbutton:SetPos( Perc(SbbW,30) , SbbH+SbbY)
    Spawnbutton:SetSize( Perc(SbbW,40), Perc(Sp2H,10))
    Spawnbutton.DoClick = function ()
    
        -- ApplySettings(TankDB[index].Ent,bgindex1,bgindex2)
        RunConsoleCommand("neurotanks_spawnvehicle", TankDB[index].Ent, bgindex1, bgindex2, skin);
        MainPanel:Remove()
    end
end    
--------------------------VGUI END----------------------------------------

-- DrawHangar()
print( "[NeuroTanks] HangarPanel.lua loaded!" )