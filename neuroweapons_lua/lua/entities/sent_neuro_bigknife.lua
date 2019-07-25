AddCSLuaFile()

ENT.PrintName = "Big Knife"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Gear"
ENT.Base = "sent_neuro_gear_base"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.InitialHealth = 75
ENT.Model = "models/wic/ground/t-80u/t-80u_knife.mdl" 
-- ENT.Model = 
ENT.ModelScale = 1.0
-- ENT.UsingBones = true 
ENT.AttachmentBone = "forward"
ENT.HitgroupProtected = HITGROUP_CHEST
ENT.DamageScaling = 0.0 -- 0 = no damage taken, 1.0 = full damage, 2.0 = double damage. 
ENT.AttachmentAngle = Angle( 0, -25,0 )
ENT.AttachmentPos = Vector( -4,0,-7  ) 
hook.Add("GravGunOnPickedUp", "NeuroWeapons_FixImpaleAngles", function( ply, ent )
	 
	if( ent.CorrectAnglesOnPickup ) then 
		
		-- ent:SetAngles( ply:EyeAngles() )
		-- ent:GetPhysicsObject():SetAngles( ply:EyeAngles() )
		-- print("walla")
	end 

end ) 

function ENT:Initialize()

	self.HealthVal = self.InitialHealth 
	self:SetNWInt("HealthVal", math.floor( self.HealthVal ) )
	
	if SERVER then
	
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		
		
		self.Knife = ents.Create("prop_physics_override")
		self.Knife:SetPos( self:LocalToWorld( Vector( -5,0,-7) ) )
		self.Knife:SetAngles( self:GetAngles() )
		self.Knife:SetModel( "models/props_junk/harpoon002a.mdl" )
		self.Knife:Spawn()
		self.Knife.CorrectAnglesOnPickup = true 
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_NONE )
		self:SetParent( self.Knife )
		self:DeleteOnRemove( self.Knife )
		self.Knife:SetNoDraw( true )
		-- self.Knife:GetPhysicsObject():Destroy()
		
		-- self.PhysObj = self:GetPhysicsObject()
		
		-- if ( self.PhysObj:IsValid() ) then
		
			-- self.PhysObj:Wake()
			-- self.PhysObj:SetMass( 5 )
			-- self.PhysObj:EnableDrag( true )
			-- self.PhysObj:EnableGravity( true )
			
		-- end
		
	end 
	
end 
function ENT:Think()
	if( SERVER ) then 
		
		
		
	end 

end 
function ENT:Use( ply, act, a, b )
	
	

end 


-- custom hooks
function ENT:OnEquipItem( ply ) 
	

end 

function ENT:OnDestroyed( dmginfo )


end 
