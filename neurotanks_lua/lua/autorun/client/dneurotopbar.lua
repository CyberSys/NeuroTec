local PANEL = {}

function PANEL:Init()
	self:SetDrawOnTop(true)
	self.IsEditEnabled = false
	
	self.closeBtn = vgui.Create("DButton",self)
	self.closeBtn:SetDrawOnTop(true)
	self.closeBtn:SetSize(self:GetWide(),self:GetTall()*1.9)
	self.closeBtn:SetPos(self:GetWide()*24,0)
	self.closeBtn:SetText("X")
	self.closeBtn:SetDrawBorder(true)
	self.closeBtn:SetTextColor(Color(255, 255, 255, 255))
	self.closeBtn.Paint = function()
		surface.SetDrawColor( 70, 70, 70, 100 )
		surface.DrawRect( 0, 0, self.closeBtn:GetWide(), self.closeBtn:GetTall() )
	end
	
	self.editBtn = vgui.Create("DButton",self)
	self.editBtn:SetDrawOnTop(true)
	self.editBtn:SetSize(self:GetWide(),self:GetTall()*1.9)
	self.editBtn:SetPos(0,0)
	self.editBtn:SetText("EDIT")
	self.editBtn:SetDrawBorder(true)
	self.editBtn:SetTextColor(Color(255, 255, 255, 255))
	self.editBtn.Paint = function()
		if(self.IsEditEnabled) then
			self.editBtn:SetTextColor(Color(0, 0, 0, 255))
			surface.SetDrawColor( 100, 100, 100, 130 )
		else
			self.editBtn:SetTextColor(Color(255, 255, 255, 255))
			surface.SetDrawColor( 70, 70, 70, 100 )
		end
		surface.DrawRect( 0, 0, self.editBtn:GetWide(), self.editBtn:GetTall() )
	end
	
end

function PANEL:SetUp(parent)
	self.editBtn.DoClick = function(button)
		self.IsEditEnabled = !self.IsEditEnabled
		parent.threeD:AllowSelection(self.IsEditEnabled)
		parent.editMenu:SetActivated(self.IsEditEnabled)
	end
	self.closeBtn.DoClick = function(button)
		parent:Remove()
	end	
end

function PANEL:Paint()
	surface.SetDrawColor(Color(40,40,40,200))
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
end

function PANEL:Think( )
	
end

function PANEL:OnRemove()
	self:Remove()
end

derma.DefineControl("DNeuroTopBar","Neuro Tank top bar is cool",PANEL,"DPanel")

print( "[NeuroTanks] dneurotopbar.lua loaded!" )