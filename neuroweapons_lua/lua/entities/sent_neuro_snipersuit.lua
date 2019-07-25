AddCSLuaFile()

ENT.PrintName = "Ghillie Shroud"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Gear"
ENT.Base = "sent_neuro_gear_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.ModelScale = .7

ENT.InitialHealth = 55
ENT.Model ="models/props_Foliage/grasses/shrub_m_bg.mdl"
-- ENT.Model =  -- 3d model
ENT.AttachmentBone = "chest"
ENT.HitgroupProtected = bit.band( HITGROUP_CHEST, HITGROUP_STOMACH )
ENT.DamageScaling = 0.0 -- 0 = no damage taken, 1.0 = full damage, 2.0 = double damage. 
ENT.AttachmentAngle = Angle( 25, 180, 0 )
ENT.AttachmentPos = Vector( 2.5, -0, -35 ) 
function ENT:Draw()
	
	self:SetModel("models/props_Foliage/r_shrub2.mdl")
	if( activator != LocalPlayer() || GetConVarNumber("Developer")>0 ) then
		self:DrawModel()
	end
end 
-- custom hooks
function ENT:OnEquipItem( ply ) 
	

end 

function ENT:OnDestroyed( dmginfo )
	
	-- self:SetModel()

end 

