AddCSLuaFile()

SWEP.HoldType = "grenade"

if CLIENT then
   SWEP.PrintName = "Molotov Cocktail"
   SWEP.Slot = 3
   -- SWEP.ViewModelFlip = true
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Equipment"
SWEP.PrimaryAnim = ACT_VM_THROW

SWEP.Spawnable = false
SWEP.Thrown = true 
SWEP.ThrownObject = "sent_neuro_molotov"
SWEP.ThrowForce = 3000

SWEP.Primary.Damage = 150
SWEP.Primary.Delay = 10
SWEP.Primary.Cone = 0.0

SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 999
SWEP.Primary.DefaultClip = 1

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "grenade"
SWEP.Primary.Recoil = 0
SWEP.Primary.Sound = Sound( "Grenade.Throw" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 50
SWEP.ViewModel = "models/weapons/v_molotov.mdl"
SWEP.WorldModel	= "models/weapons/w_molotov.mdl"

SWEP.HeadshotMultiplier = 3.5


SWEP.Pos = Vector(-2,4, 3)
SWEP.Ang = Angle(0, -180, 0)

function SWEP:CreateWorldModel()
   if not self.WModel then
      self.WModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
      self.WModel:SetNoDraw(true)
      self.WModel:SetBodygroup(1, 1)
   end
   -- print("whot")
   return self.WModel
end

function SWEP:DrawWorldModel()
	if( !IsValid( self.Owner ) ) then return end 
   local wm = self:CreateWorldModel()
   
   local bone = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
   local pos, ang = self.Owner:GetBonePosition(bone)
		
   if bone then
      ang:RotateAroundAxis(ang:Right(), self.Ang.p)
      ang:RotateAroundAxis(ang:Forward(), self.Ang.y)
      ang:RotateAroundAxis(ang:Up(), self.Ang.r)
      wm:SetRenderOrigin(pos + ang:Right() * self.Pos.x + ang:Forward() * self.Pos.y + ang:Up() * self.Pos.z)
      wm:SetRenderAngles(ang)
      wm:DrawModel()
   end
end
