AddCSLuaFile()

ENT.PrintName = "Boonie"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Gear"
ENT.Base = "sent_neuro_gear_base"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.InitialHealth = 55
ENT.Model = "models/killstr3aks/boonie.mdl"
-- ENT.Model =x
ENT.ModelScale = 1.0
-- ENT.UsingBones = true 
ENT.AttachmentBone = "forward"
ENT.HitgroupProtected = HITGROUP_HEAD
ENT.DamageScaling = 0.0 -- 0 = no damage taken, 1.0 = full damage, 2.0 = double damage. 
ENT.AttachmentAngle = Angle( 0, 0,0 )
ENT.AttachmentPos = Vector( -1.5,0,6 ) 

-- custom hooks
function ENT:OnCreate()
	if( SERVER ) then 
		
		local mi,ma = self:GetModelBounds()
		self:PhysicsInitBox( mi, ma )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:Activate()
	end 

end 

function ENT:OnEquipItem( ply ) 
	

end 

function ENT:OnDestroyed( dmginfo )


end 
