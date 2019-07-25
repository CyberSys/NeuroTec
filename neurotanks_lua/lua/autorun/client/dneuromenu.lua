local PANEL = {}

function PANEL:Init()
	
	local w = ScrW()
	local h = ScrH()
	
	self:SetSize(w, h)
	self:SetPos(0,0)
	
	self.selected = NULL
	self.curTank = NULL
	
	self.threeD = vgui.Create("D3DViewer", self)
	self.threeD:SetPos( 0, 0 )
	self.threeD:SetSize( w, h )
	self.threeD:SetUp()
	self.threeD.OnModelSelection = function(panel, ent)
		self.selected = ent
		self.editMenu:SetSelected(ent)
	end

	self:SpawnHangar()
	
	self.modelLabel = vgui.Create("DLabel", self)
	self.modelLabel:SetPos(20,20)
	self.modelLabel:SetSize(300,100)
	
	self.topBar = vgui.Create("DNeuroTopBar", self.threeD)
	self.topBar:SetPos(0,0)
	self.topBar:SetSize(w, h/20)
	self.topBar:SetUp(self)
	
	self.editMenu = vgui.Create("DNeuroEditMenu",self.threeD)
	self.editMenu:SetSize(w/10,h-(h/4))
	self.editMenu:SetPos(0,h/20)
	self.editMenu:SetVisible(false)
	
	self.tankMenu = vgui.Create("DNeuroTankBar", self.threeD)
	self.tankMenu:SetPos(w/22,h-(h/5))
	self.tankMenu:SetSize(w/1.10,h/5)	
	
	self.tankMenu.ChangeTank = function(panel, tank)
		self:ChangeTank(tank)
	end
	
	self.tankMenu:AddItem("sent_f180batchatillon_p")
	self.tankMenu:AddItem("sent_t71_p")
	self.tankMenu:AddItem("sent_tiger_p")
	self.tankMenu:AddItem("sent_hetzer_p")
	
	self.tankMenu:AddItem("sent_m47patton_p")
	self.tankMenu:AddItem("sent_m47patton_p")
	self.tankMenu:AddItem("sent_m47patton_p")
	
	self:ChangeTank("sent_f180batchatillon_p")
	
end

function PANEL:SpawnHangar()
	local offset = self.threeD:AddModel("models/error.mdl", Vector(0,0,0), false)
	if(offset) then
		offset:SetMaterial("models/effects/vol_light001")
		offset:SetAngles(Angle(0,0,180))
	end
	local hangar1 = self.threeD:AddModel("models/aftokinito/wot/misc/hangar_prem1.mdl", Vector(-400,0,0), false)
	local hangar2 = self.threeD:AddModel("models/aftokinito/wot/misc/hangar_prem2.mdl", Vector(-400,0,-7), false)
	local hangar3 = self.threeD:AddModel("models/aftokinito/wot/misc/hangar_prem3.mdl", Vector(-400,0,0), false)
	-- if hangar then
		-- hangar:SetAngles(Angle(0,270,0))
	-- end
end

function PANEL:ChangeTank(sentName)
	self.curTank = sentName
	if(TankDB.IsInDB(sentName)) then
		self.threeD:ClearModels()
		self.selected = NULL

		self:SpawnHangar()
		
		local bodyModel = TankDB.GetVar(sentName, "Model")
		local bodyPos = Vector(0,0,5)
		local tank = self.threeD:AddModel(bodyModel, bodyPos, true)
		
		local towerModel = TankDB.GetVar(sentName, "TowerModel")
		local towerPos = TankDB.GetVar(sentName, "TowerPos")
		local tower = self.threeD:AddModel(towerModel, towerPos, true)
		
		local barrelModel = TankDB.GetVar(sentName, "BarrelModel")
		local barrelPos = TankDB.GetVar(sentName, "BarrelPos")
		local barrel = self.threeD:AddModel(barrelModel, barrelPos, true)
		
		local trackModels = TankDB.GetVar(sentName, "TrackModels")
		local trackModelLeft = trackModels[1]
		local trackModelRight = trackModels[2]
		local trackPos = TankDB.GetVar(sentName, "TrackPositions") or {Vector(0,0,0), Vector(0,0,0)}
		local trackPosLeft = trackPos[1]
		local trackPosRight = trackPos[2]
		local trackLeft = self.threeD:AddModel(trackModelLeft, trackPosLeft, true)
		local trackRight = self.threeD:AddModel(trackModelRight, trackPosRight, true)
		self:SetUpTracks(trackLeft, "left")
		self:SetUpTracks(trackRight, "right")
		
		local wheelModels = TankDB.GetVar(sentName, "TrackWheels")
		if(wheelModels) then
			local wheelModelLeft = wheelModels[1]
			local wheelModelRight = wheelModels[2]
			self.threeD:AddModel(wheelModelLeft, trackPosLeft, false)
			self.threeD:AddModel(wheelModelRight, trackPosLeft, false)
		end
				
		
	end
end

function PANEL:SetUpTracks(ent, side)
	if ent then
		if(side == "left") then
			local bMin, bMax = ent:GetRenderBounds()
			bMin = bMin + (-ent:GetAngles():Right() * 30) + (-ent:GetAngles():Forward() * 10)
			bMax = bMax + (-ent:GetAngles():Right() * 10) + (ent:GetAngles():Up() * 10) + (ent:GetAngles():Forward() * 10)
			ent:SetRenderBounds(bMin, bMax)
		elseif(side == "right") then
			local bMin, bMax = ent:GetRenderBounds()
			bMin = bMin + (ent:GetAngles():Right() * 10) + (-ent:GetAngles():Forward() * 10)
			bMax = bMax + (ent:GetAngles():Right() * 30) + (ent:GetAngles():Up() * 10) + (ent:GetAngles():Forward() * 10)
			ent:SetRenderBounds(bMin, bMax)			
		end
	end
end

function PANEL:OnRemove()
	self.modelLabel:Remove()
	self.tankMenu:Remove()
	self.threeD:Remove()
	self:Remove()
end

function PANEL:CreateTestModels(body)
	local tank = body:AddModel( "models/aftokinito/wot/american/t71_body.mdl", Vector(0,0,5), true)
	local tower = body:AddModel( "models/aftokinito/wot/american/t71_turret.mdl", Vector(-7,0,55), true)
	local gun = body:AddModel( "models/aftokinito/wot/american/t71_gun.mdl", Vector(-7,0,70), true)
	local lTrack = body:AddModel( "models/aftokinito/wot/american/t71_tracks_l.mdl", Vector(0,0,5), true)
	if lTrack then
		local bMin, bMax = lTrack:GetRenderBounds()
		bMin = bMin + (-lTrack:GetAngles():Right() * 30) + (-lTrack:GetAngles():Forward() * 10)
		bMax = bMax + (-lTrack:GetAngles():Right() * 10) + (lTrack:GetAngles():Up() * 10) + (lTrack:GetAngles():Forward() * 10)
		lTrack:SetRenderBounds(bMin, bMax)
	end	
	local rTrack = body:AddModel( "models/aftokinito/wot/american/t71_tracks_r.mdl", Vector(0,0,5), true)
	if rTrack then
		local bMin, bMax = rTrack:GetRenderBounds()
		bMin = bMin + (rTrack:GetAngles():Right() * 10) + (-rTrack:GetAngles():Forward() * 10)
		bMax = bMax + (rTrack:GetAngles():Right() * 30) + (rTrack:GetAngles():Up() * 10) + (rTrack:GetAngles():Forward() * 10)
		rTrack:SetRenderBounds(bMin, bMax)
	end		
	local lWheel = body:AddModel( "models/aftokinito/wot/american/t71_wheels_r.mdl", Vector(0,0,5), false)
	local rWheel = body:AddModel( "models/aftokinito/wot/american/t71_wheels_l.mdl", Vector(0,0,5), false)
end

function PANEL:Think( )
	if ( input.IsKeyDown( KEY_TAB ) ) then
		self.modelLabel:Remove()
		self.tankMenu:Remove()
		self.threeD:Remove()
		self:Remove()
	end
	
	self.editMenu:SetSelectedTank(self.curTank)
	
	local selected = self.selected
	if (selected != NULL) then
		self.modelLabel:SetText(selected:GetModel())
	else
		self.modelLabel:SetText("No Selection")
	end
	
end

derma.DefineControl("DNeuroMenu","Neuro Menu is cool",PANEL,"DPanel")

print( "[NeuroTanks] dneuromenu.lua loaded!" )