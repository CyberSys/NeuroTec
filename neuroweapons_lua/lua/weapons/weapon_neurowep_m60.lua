AddCSLuaFile()

SWEP.HoldType = "shotgun"
SWEP.IronSightHoldType = "smg"

if CLIENT then
   SWEP.PrintName = "M-60"
   SWEP.Slot = 2
   SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - MGs"

SWEP.Spawnable = true
SWEP.Tracer = "AR2Tracer"
SWEP.Primary.Damage = 25
SWEP.Primary.Delay = 0.0923076923
SWEP.Primary.Cone = 0.01

SWEP.Primary.ClipSize = 250
SWEP.Primary.ClipMax = 250
SWEP.Primary.DefaultClip = 250

SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AirboatGun"
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Sound = Sound("M60.Single")
SWEP.CSMuzzleFlashes = true 
SWEP.CSMuzzleX = true 
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/v_mach_m60.mdl"
SWEP.WorldModel =  "models/weapons/w_mach_m60.mdl"

SWEP.HeadshotMultiplier = 2

SWEP.IronSightsPos = Vector(-5.45, -2.116,  3.5 )
SWEP.IronSightsAng = Vector( 1, 0, 0)

SWEP.Pos = Vector(0, 6, 2)
SWEP.Ang = Angle(0, -180, 0)

function SWEP:CreateWorldModel()
   if not self.WModel then
      self.WModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
      self.WModel:SetNoDraw(true)
      self.WModel:SetBodygroup(1, 1)
   end
  
   return self.WModel
end

function SWEP:DrawWorldModel()
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