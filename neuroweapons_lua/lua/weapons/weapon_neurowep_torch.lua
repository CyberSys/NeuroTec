SWEP.HoldType = "melee"
SWEP.IronSightHoldType = "revolver"
if CLIENT then
   SWEP.PrintName = "The Flaming Bitchslap"
   SWEP.Slot = 1
   SWEP.ViewModelFlip = false
   SWEP.HoldType      = "melee"
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Melee"

SWEP.Spawnable = true

SWEP.Primary.Damage = 5
SWEP.Primary.Delay = 0.5
SWEP.Primary.Cone = 0.010

SWEP.Primary.ClipSize = 0
SWEP.Primary.ClipMax = 0
SWEP.Primary.DefaultClip = 0

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "batman"
SWEP.Primary.Recoil = 0
SWEP.Primary.Sound = Sound( "weapons/knife/knife_slash1.wav" )
SWEP.Secondary.Automatic = false 

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 60
SWEP.ViewModel = "models/weapons/c_melee_crowbar.mdl"
SWEP.WorldModel	= "models/torch.mdl"	-- Weapon world model

SWEP.HeadshotMultiplier = 2.2
SWEP.IsMeleeWeapon = true 

SWEP.Pos = Vector(0,-4,0)
SWEP.Ang = Angle( 190, -15, 25 )
SWEP.WorldModelScale = Vector( 1,1,1 )
	function SWEP:DrawWorldModel()
		if( !self.Pos || !self.Ang || !IsValid( self.Owner ) ) then return end 
		local wm = self:CreateWorldModel()
		local bone = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
		if( !bone ) then return end 
		local pos, ang = self.Owner:GetBonePosition(bone)
		local subMat = self:GetNWString("SubMaterial")
		if( subMat ) then 

			wm:SetSubMaterial( self.SkinSubMaterialIndex, self.HasSetSubmaterial )

		end 

	   if bone then
			ang:RotateAroundAxis(ang:Right(), self.Ang.p)
			ang:RotateAroundAxis(ang:Forward(), self.Ang.y)
			ang:RotateAroundAxis(ang:Up(), self.Ang.r)

			wm:SetRenderOrigin(pos + ang:Right() * self.Pos.x + ang:Forward() * self.Pos.y + ang:Up() * self.Pos.z)
			wm:SetRenderAngles(ang)
			wm:DrawModel()
	   end
		if( self.DrawWorldModelCallback ) then 
			self:DrawWorldModelCallback()
		end 
	end
function SWEP:MeleeHitCallback( trace )
	
	if( SERVER and  IsValid( trace.Entity ) ) then 
		trace.Entity:Ignite( 1,1 )

	end 
	local edata = EffectData()
	edata:SetOrigin(trace.HitPos )
	edata:SetMagnitude(10)
	edata:SetScale(10)
	util.Effect("neuro_flamey_slappy_Fire", edata)
end 

function SWEP:DrawWorldModelCallback()
	-- print("u wot")
	if( IsValid( self.WModel ) ) then 
		-- print("WOLOLO", self.Owner )
		local w = self.Owner:GetActiveWeapon().WModel
		local edata = EffectData()
		-- edata:SetEntity(self.WModel)
		edata:SetOrigin( w:GetPos() + self:GetUp() * 15 + self:GetRight() * -15 )
		-- print( w:GetUp()  )
		-- edata:SetStart( self.WModel:GetPos() )
		-- edata:SetMagnitude(2)
		edata:SetScale(2)
		util.Effect("neuro_flamey_slappy_Fire", edata)
				
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then

			local c = Color( 191+math.random(-5,5), 64+math.random(-5,5), 0, 100 )

			dlight.Pos = w:GetPos() + Vector(0,0,20)
			dlight.r = c.r
			dlight.g = c.g
			dlight.b = c.b
			dlight.Brightness = .5
			dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
			dlight.Size = math.random(406,512)
			dlight.DieTime = CurTime() + 0.025

		end
		
	end 
	if( IsValid( self.VisualViewModel ) ) then 
		self.VisualViewModel:SetNoDraw( true )
	end 

end 

function SWEP:CreateVisualViewModel( vm, bone  )
	if( !self.VisualViewModel ) then 
		
		self.VisualViewModel = ClientsideModel( "models/torch.mdl", RENDER_GROUP_VIEW_MODEL_OPAQUE)
		self.VisualViewModel:SetParent( vm )
		-- self.VisualViewModel:Fire("SetParentAttachmentMaintainOffset", bone )
	end 
	
	return self.VisualViewModel 
end 
function SWEP:Holster()
	if( IsValid( self.VisualViewModel ) ) then 
		self.VisualViewModel:Remove()
		self.VisualViewModel = nil 
	end 
	return true 
end
 
function SWEP:PostDrawViewModel( vm, ply, weapon )
	local bone = vm:LookupBone( "ValveBiped.Bip01_R_Hand" )
	local ar = self:CreateVisualViewModel( vm, bone )
	if( !IsValid( ar ) ) then return end 
	if( IsValid( self.VisualViewModel ) ) then 
		self.VisualViewModel:SetNoDraw( false )
	end 
	local mat = vm:GetBoneMatrix( bone )
	local ang = Angle(0,0,0)
	local pos = Vector(0,0,0)
	if mat then
		pos = mat:GetTranslation()
		ang = mat:GetAngles()
	end
	self:ResetBonePositions( vm )
	ang:RotateAroundAxis( self:GetRight(), 180 )
	ar:SetAngles( ang )
	ar:SetPos( pos + ang:Forward() * 1 )
	local edata = EffectData()
	edata:SetEntity(self)
	edata:SetOrigin( ar:LocalToWorld(Vector(0,0,16) ) )
	edata:SetStart( self:GetPos() )
	edata:SetMagnitude(1)
	edata:SetScale(1)
	util.Effect("neuro_flamey_slappy_Fire", edata)
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 191+math.random(-5,5), 64+math.random(-5,5), 0, 100 )

		dlight.Pos = ar:GetPos() + Vector(0,0,25)
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = .5
		dlight.Decay = 0.1 + math.Rand( 0.01, 0.1 )
		dlight.Size = math.random(256,512)
		dlight.DieTime = CurTime() + 0.025

	end
end 