local PANEL = {}

function PANEL:Init()
	self:SetDrawOnTop(true)
	self.Entity = NULL
	self.paintColor = Color(255,255,255,255)
	self.icon = Material("icons/tanks/noimage.png")
end

function PANEL:SetEntity(ent)
	self.Entity = ent
end

function PANEL:Paint()
	surface.SetMaterial(self.icon)
	surface.SetDrawColor(Color(255,255,255,255))
	surface.DrawTexturedRect(0, 0, self:GetWide(), self:GetTall())
	
	surface.SetDrawColor(self.paintColor)
	surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
	surface.DrawOutlinedRect(1, 1, self:GetWide()+2, self:GetTall()+2)
	surface.DrawOutlinedRect(1, 1, self:GetWide()-2, self:GetTall()-2)
end

function PANEL:Think( )
	
end

function PANEL:Select()
	self:SetColor(Color(255,0,0,255))
end

function PANEL:UnSelect()
	self:SetColor(Color(255,255,255,255))
end

function PANEL:SetMaterial(material)
	self.icon = material
end

function PANEL:SetColor(color)
	self.paintColor = color
end

derma.DefineControl("DNeuroMenuItem","Neuro Menu item is cool",PANEL,"DPanel")

print( "[NeuroTanks] dneuromenuitem.lua loaded!" )