AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Rambo's Hunting Bow"
    SWEP.Slot = 2
end

SWEP.Category = "NeuroTec Weapons - Equipment"
SWEP.Author = "Lua: Hoffa \nModel: Mighty Lolrus"
SWEP.Contact = ""
SWEP.Purpose = "Dispenses pointy things"
SWEP.Instructions = "Take out those pesky hunters..i mean deers!"

SWEP.Base	= "weapon_neurowep_base_ent"
SWEP.Spawnable = true
SWEP.AdminOnly = false 
SWEP.AutoSwitchFrom = false 
SWEP.UseHands	= false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 75
SWEP.SequentialReload = false 
SWEP.ViewModel = "models/weapons/v_snip_scoub.mdl"
SWEP.WorldModel = "models/weapons/w_snip_scoub.mdl"
 SWEP.HoldType = "rpg"
 SWEP.IronSightHoldType = "rpg"
-- Primary Fire Attributes --
if( game.SinglePlayer() ) then 
SWEP.Primary.Recoil         = 0
else
SWEP.Primary.Recoil         = 0
end 
SWEP.Primary.Damage         = 0
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0
SWEP.Primary.ClipSize       = 254
SWEP.Primary.DefaultClip    = 254
SWEP.Primary.Automatic      = false    
SWEP.Primary.Ammo           = "AirboatGun"
SWEP.Primary.Delay 			= 1.55
SWEP.Primary.Sound = Sound( "weapons/firearms/bow_deerhunter/bow_Fire_01.wav")
SWEP.Primary.AutoReload = false 
-- Secondary Fire Attributes --
SWEP.Secondary.Recoil        = 0
SWEP.Secondary.Damage        = 0
SWEP.Secondary.NumShots      = 0
SWEP.Secondary.Cone          = 0
SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip   = -1
SWEP.Secondary.Automatic     = false
SWEP.Secondary.Ammo 		 = "none"
SWEP.Secondary.Delay 		= 1

SWEP.PhysBulletEnable = true 
-- SWEP.Primary.PhysAmmoType = "sent_neuro_bigknife"
SWEP.PhysBulletPropType = "sent_neuro_arrow"
SWEP.BulletForce = 3000
-- SWEP.HasLockonSystem = true 

-- EFfect Overrides
SWEP.Tracer = "neuro_railbeam"
SWEP.TracerCount = 1 
SWEP.ForcePenetration = true 
SWEP.ImpactScale = 1.45
SWEP.NoLines = true 

SWEP.ImpactForce = 11000
SWEP.GravityEnabledOnShells = true 
SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.IronSightZoom = true
SWEP.Secondary.ScopeZoom = 1.45

SWEP.IronSightsPos = Vector(-12, -25, 21)
SWEP.IronSightsAng = Vector(0, 0, -55)

SWEP.FireModes = {
{ "sent_neuro_arrow", "High-Explosive Remote Triggered Arrow", "models/weapons/w_eq_fraggrenade_thrown.mdl" },
--{ "sent_neuro_arrow_molo", "Molotov's Arrow", "models/props/cs_militia/bottle01.mdl" },
{ "sent_neuro_arrow_electric", "Electric Arrow", "models/props_lab/tpplug.mdl" },
{ "sent_neuro_arrow_ap", "Armor Piercing High Explosive Arrow", "models/surgeon/mortarshell.mdl" },
{ "sent_neuro_arrow_shotgun", "Shotgun Arrow", "models/weapons/w_shotgun.mdl" },
{ "sent_neuro_arrow_grapple", "Flashbang Arrow", "models/weapons/w_eq_flashbang_thrown.mdl" },
--{ "sent_neuro_arrow_poison", "Poison Arrow", "models/weapons/w_eq_fraggrenade_thrown.mdl" },
{ "sent_neuro_arrow_rad", "Radioactive Arrow", "models/weapons/w_eq_smokegrenade_thrown.mdl" },
{ "sent_neuro_arrow_dark", "Dissolving Arrow", "models/weapons/w_medkit.mdl" },
{ "sent_neuro_arrow_love", "Love Arrow", "models/weapons/w_medkit.mdl" },
}

SWEP.SkinSubMaterialIndex = 0 
SWEP.RandomSkins = {
					"models/weapons/v_models/requests studio/sf2/skin_1",
					"models/weapons/v_models/requests studio/sf2/skin_2",
					"models/weapons/v_models/requests studio/sf2/skin_3",
					"models/weapons/v_models/requests studio/sf2/skin_4",
					"models/weapons/v_models/requests studio/sf2/skin_5",
					"models/weapons/v_models/requests studio/sf2/skin_6",
					"models/weapons/v_models/requests studio/sf2/skin_7",
					"models/weapons/v_models/requests studio/sf2/skin_8",
					"models/weapons/v_models/requests studio/sf2/skin_9",
					"models/weapons/v_models/requests studio/sf2/skin_10",
					"models/weapons/v_models/requests studio/sf2/skin_11",
					"models/weapons/v_models/requests studio/sf2/skin_12",
					"models/weapons/v_models/requests studio/sf2/skin_13",
					"models/weapons/v_models/requests studio/sf2/skin_14",
					"models/weapons/v_models/requests studio/sf2/skin_15",
					"models/weapons/v_models/requests studio/sf2/skin_16",
					"models/weapons/v_models/requests studio/sf2/skin_17",
					"models/weapons/v_models/requests studio/sf2/skin_18",
					"models/weapons/v_models/requests studio/sf2/skin_19",
					"models/weapons/v_models/requests studio/sf2/skin_20"
					
					}



function SWEP:Think()
	if( !self.Owner.LastFireModeChange ) then 
		self.Owner.LastFireModeChange = 0
		self.Owner.FireMode = 1
	end
	
	if( IsValid( self.Owner ) && ( self.Owner:KeyDown( IN_USE ) || self.Owner:IsBot() ) && self.Owner.LastFireModeChange + 0.5 <= CurTime() ) then 
		-- if( !self.FireMode ) then self.FireMode = 0 end 
		self.Owner.FireMode = self.Owner.FireMode + 1 
		if( self.Owner.FireMode > #self.FireModes ) then 
			self.Owner.FireMode = 1 
		end 
		
		self.Owner:SetNWInt("CurrentFireMode", self.Owner.FireMode )
		
		self.Owner.LastFireModeChange = CurTime()
		self:SendWeaponAnim( ACT_VM_RELOAD )

		self.Owner:PrintMessage( HUD_PRINTCENTER, self.FireModes[self.Owner.FireMode][2] )
	
		
	end 
		
	self.PhysBulletPropType = self.FireModes[self.Owner.FireMode][1]
	
end 
// called on the client when weapon is used
function SWEP:ClientAttackCallback()
	
end 

// Called everytime a physical bullet is launched 
function SWEP:SwepPhysbulletCallback( bullet ) 
	
end 

SWEP.Pos = Vector(-3.5, -10, -2)
SWEP.Ang = Angle(-15, 180, -10)
SWEP.WorldModelScale = Vector( 1.35, 1.35, 2.35 )

/*
function SWEP:CreateArrowModel( vm, bone  )
	if( !self.ArrowModel ) then 
		
		self.ArrowModel = ClientsideModel( "models/props_junk/popcan01a.mdl", RENDERGROUP_OPAQUE)
		self.ArrowModel:SetParent( vm )
		-- self.ArrowModel:Fire("SetParentAttachmentMaintainOffset", bone )
	end 
	
	return self.ArrowModel 
end 

function SWEP:PostDrawViewModel( vm, ply, weapon )
	
	local bone = vm:LookupBone( "weapon_arrow" )
	local ar = self:CreateArrowModel( vm, bone )
	-- local bone = vm:LookupBone( "ValveBiped.Bip01_R_Hand" )
	local mat = vm:GetBoneMatrix( bone )
	
	local idx = self.Owner:GetNWInt("CurrentFireMode", 1)
	local mdl = self.FireModes[idx][3]
	ar:SetModel( mdl )
	-- mat:Scale(Vector(5,5,5))
	
	-- vm:SetBoneMatrix( bone, mat )
	
	local ang = Angle(0,0,0)
	local pos = Vector(0,0,0)
	
	if mat then
	
		pos = mat:GetTranslation()
		ang = mat:GetAngles()
		
		
	end
	
	ar:SetAngles( ang )
	ar:SetPos( pos + ang:Forward() * 80 )

end 
*/
function SWEP:PreDraw()
	local idx = self.Owner:GetNWInt("CurrentFireMode", 1 )
	if( idx != nil ) then 
		-- print( idx )
		surface.SetFont( "Trebuchet24" )
		surface.SetTextColor( 255, 255, 255, 255 )
		surface.SetTextPos( 15, 15 )
		surface.DrawText( self.FireModes[idx][2] )
		
	end 
	
end 

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
		if( !self.IronSightsAngle ) then self.IronSightsAngle = 0 end 
		
		ang:RotateAroundAxis(ang:Right(), self.Ang.p)
		if( self:GetIronsights() ) then 
			self.IronSightsAngle = Lerp( 0.1, self.IronSightsAngle, 0 )
		else
			self.IronSightsAngle = Lerp( 0.1, self.IronSightsAngle, 45 )
		end 
		ang:RotateAroundAxis(ang:Forward(), self.Ang.y+self.IronSightsAngle)
		ang:RotateAroundAxis(ang:Up(), self.Ang.r)

		wm:SetRenderOrigin(pos + ang:Right() * self.Pos.x + ang:Forward() * self.Pos.y + ang:Up() * self.Pos.z)
		wm:SetRenderAngles(ang)
		wm:DrawModel()
   end
end