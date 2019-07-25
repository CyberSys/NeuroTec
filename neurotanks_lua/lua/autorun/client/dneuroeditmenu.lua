local PANEL = {}

function PANEL:Init()
	self:SetDrawOnTop(true)
	
	self.selected = NULL
	self.selectedTank = NULL
	
	self.nameLabel = vgui.Create("DLabel", self)
	self.nameLabel:SetDrawOnTop(true)
	self.nameLabel:SetPos(self:GetWide()/2,self:GetTall())
	self.nameLabel:SetText("PART NAME")
	self.nameLabel:SizeToContents()
end

function PANEL:SetSelected(ent)
	self.selected = ent
end

function PANEL:SetSelectedTank(ent)
	self.selectedTank = ent
end

function PANEL:Paint()
	-- surface.SetDrawColor(Color(40,40,40,220))
	surface.SetDrawColor(Color(90,90,90,255))
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
end

function PANEL:LookupModel(ent, model)

	local body = string.lower(TankDB.GetVar(ent,"Model"))
	local tower = string.lower(TankDB.GetVar(ent,"TowerModel"))
	local barrel = string.lower(TankDB.GetVar(ent,"BarrelModel"))
	local tracks = TankDB.GetVar(ent,"TrackModels")
	trackL = string.lower(tracks[1])
	trackR = string.lower(tracks[2])
	
	if(model == body) then
		return "BODY"
	elseif(model == tower) then
		return "TOWER"
	elseif(model == barrel) then
		return "BARREL"
	elseif(model == trackL || model == trackR ) then
		return "TRACK"
	else
		return "?????"
	end
end

function PANEL:Think( )
	if(self.selected != NULL) then
		self.nameLabel:SetText(self:LookupModel(self.selectedTank, self.selected:GetModel()))
		self.nameLabel:SizeToContents()
	else
		self.nameLabel:SetText("PART NAME")
		self.nameLabel:SizeToContents()
	end
end

function PANEL:SetActivated(enabled)
	if(enabled) then
		self:Show()
		for _,v in pairs(self:GetChildren()) do
			v:Show()
		end
	else
		self:Hide()
		for _,v in pairs(self:GetChildren()) do
			v:Hide()
		end
	end
end

function PANEL:OnRemove()
	self:Remove()
end

derma.DefineControl("DNeuroEditMenu","Neuro Tank edit menu is cool",PANEL,"DPanel")

print( "[NeuroTanks] dneuroeditmenu.lua loaded!" )