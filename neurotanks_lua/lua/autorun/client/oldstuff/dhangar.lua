    local PANEL = {}
    function PANEL:PaintModel()
            if(!IsValid(self.Entity)) then return end
            local x, y = self:LocalToScreen(0, 0)
            self:LayoutEntity(self.Entity)
           
            local angCam = Angle(self.camAng.p,self.camAng.y,self.camAng.r)
            local posCam = angCam:Forward() *self.camDistance +self:GetCamPos()
            cam.Start3D(posCam,(self.vLookatPos -posCam):Angle(),self.fFOV,x,y,self:GetSize())
                    render.SuppressEngineLighting(true)
                    render.SetLightingOrigin(self.Entity:GetPos())
                    render.ResetModelLighting(self.colAmbientLight.r /255,self.colAmbientLight.g /255,self.colAmbientLight.b /255)
                    render.SetColorModulation(self.colColor.r /255,self.colColor.g /255,self.colColor.b /255)
                    render.SetBlend(self.colColor.a /255)
                   
                    for i = 0,6 do
                            local col = self.DirectionalLight[i]
                            if(col) then
                                    render.SetModelLighting(i,col.r /255,col.g /255,col.b /255)
                            end
                    end
                    self.Entity:DrawModel()
                    if(self.m_tbSubEnts) then
                            for _, ent in ipairs(self.m_tbSubEnts) do
                                    if(ent:IsValid()) then ent:DrawModel() end
                            end
                    end
                   
                    render.SuppressEngineLighting(false)
            cam.End3D()
            self.LastPaint = RealTime()
    end
     
    function PANEL:SetCamDistance(dist)
            self.pnlModel.camDistance = dist
    end
     
    function PANEL:Init()
            self:SetDrawOnTop(true)
            self:NoClipping(true)
    end
     
    function PANEL:SetUp()
            self.pnlModel = vgui.Create("DModelPanel",self)
            local w,h = self:GetSize()
            self.pnlModel:SetSize(w,h)
            self.pnlModel.m_tbSubEnts = {}
            self.pnlModel:SetPos(0,h *0.06)
            self.pnlModel:SetModel("models/aftokinito/wot/misc/Hangar.mdl")
            self.pnlModel:SetFOV(70)
            self.pnlModel:SetCamPos(Vector(-500,0,300))
            self.pnlModel:SetLookAt(Vector(0,0,100))
            self.pnlModel:SetPaintedManually(true)
            self.pnlModel.camAng = Angle(0,0,0)
            self.pnlModel.Paint = self.PaintModel
            self.pnlModel:SetAmbientLight(Vector( 15, 5, 5 ))
            self:SetCamDistance(0)
            self.pnlModel.LayoutEntity = function(pnl)
                    pnl:RunAnimation()
            end
            -- tank = self:AddModel("models/beat the zombie/wot/german/tiger_i_body.mdl")
            -- tank:SetPos(Vector(0,0,10))
            -- tank:SetAngles(Angle(0,90,0))
    end
     
    function PANEL:AddModel(mdl)
            local ent = ClientsideModel(mdl)
            ent:SetNoDraw(true)
            ent:Spawn()
            ent:Activate()
            table.insert(self.pnlModel.m_tbSubEnts,ent)
            return ent
    end
     
    function PANEL:Think()
    end
     
    function PANEL:OnClose()
            local pnlModel = self.pnlModel
            local touchPnl = self.touchPnl
            self:Remove()
            pnlModel:Remove()
            -- touchPnl:Remove()
    end
     
    function PANEL:Hide()
            self:SetVisible(false)
    end
     
    function PANEL:Paint()
    end
     
    function PANEL:PaintOver()  
            self.pnlModel:Paint()
    end
    
    -- function PANEL:OnCursorMoved(x,y)
        -- local x,y = self:CursorPos()
        -- local pos = Vector(0,0,0) 
        -- pos.x = pos.x + math.sin( x ) * 500
        -- pos.y = pos.y + math.cos( y ) * 500
        -- pos.z = 300
        -- print("X: "..x)
        -- print("Y: "..y)
        -- self.pnlModel:SetCamPos(pos)
    -- end    
    derma.DefineControl("DHangar","A Hangar",PANEL,"DPanel")

print( "[NeuroTanks] DHangar.lua loaded!" )