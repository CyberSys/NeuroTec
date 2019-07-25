local PANEL = {}

function PANEL:Init()
	self:SetDrawOnTop(true)
	self.maxItems = 7
	self.menuItems = {}
	self.selection = NULL
end

function PANEL:Paint()
	surface.SetDrawColor(Color(40,40,40,190))
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
end

function PANEL:Think( )
	
end

function PANEL:AddItem(sentName)
	if(#self.menuItems < self.maxItems) then
		if(TankDB.IsInDB(sentName)) then
			local icon = TankDB.GetVar(sentName, "icon") --Icon should be added on the gm
			if(!icon) then
			 icon = "icons/tanks/noimage.png"
			end
			-- local icon = Material("materials/tankicons/t71.png")
			local item = vgui.Create("DNeuroMenuItem", self)
			item:SetMaterial(Material(icon))
			item:SetEntity(sentName)
			local w, h = self:GetSize()
			local gSize = 1.5
			local iconH = (h)/gSize
			local iconW = (w/5)/gSize
			local sepW = (w/self.maxItems) - iconW
			if(#self.menuItems > 0) then
				local itemW, itemH = self.menuItems[#self.menuItems]:GetPos() + self.menuItems[#self.menuItems]:GetSize()
				item:SetPos(itemW+sepW,(h-iconH)/2)
			else
				item:Select()
				item:SetPos(sepW,(h-iconH)/2)
			end
			item:SetSize(iconW,iconH)
			item.OnMousePressed = function(panel, mc)
				for _,v in pairs(self.menuItems) do
					v:UnSelect()
				end
				panel:Select()
				self:ChangeTank(item.Entity)
			end
			table.insert(self.menuItems, item)
		end
	else
		print("Ignored tank "..sentName..": Maximum tank amount reached")
	end
end

function PANEL:GetSelection()
	return self.selection
end

function PANEL:ChangeTank() //To be overwritten at parent
end

function PANEL:OnRemove()
	for _,v in pairs(self.menuItems) do
		v:Remove()
	end
	self.menuItems = nil
	self:Remove()
end

derma.DefineControl("DNeuroTankBar","Neuro Tank bar is cool",PANEL,"DPanel")

print( "[NeuroTanks] dneurotankbar.lua loaded!" )