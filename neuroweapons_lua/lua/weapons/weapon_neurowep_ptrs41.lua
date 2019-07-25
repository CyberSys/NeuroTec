AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false
end
SWEP.PrintName = "PTRS-41"
   
SWEP.Author = "Hoffa & Model: Nikolai MacPootislavski"
SWEP.Contact = ""
SWEP.Purpose = "14.5x114mm Anti-Tank"
SWEP.Instructions = "Destroy Armored Vehicles like it's 1942"

SWEP.Category = "NeuroTec Weapons - Snipers"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.NoLines = false 
SWEP.Scoped = false
SWEP.Secondary.ScopeZoom = 10
SWEP.ScopeTexture = Material( "scope/screenoverlay.png" )
SWEP.ScopeTexture2 = Material( "scope/sniper.png" )
SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models/weapons/v_snip_ptrhack.mdl"
SWEP.WorldModel = "models/weapons/w_snip_ptrhack.mdl"
SWEP.ViewModelFlip = true
SWEP.ImpactScale = 1.45
SWEP.Tracer = "ar2tracer"
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.HeadshotMultiplier = 4

SWEP.IronSightsPos = Vector(3.6, -4, 4.2 )
SWEP.IronSightsAng = Vector( 0, 0, 0)
SWEP.CSMuzzleFlashes = true 
SWEP.CSMuzzleX = true 
SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.UseHands = true
SWEP.HoldType = "Ar2" 
SWEP.FiresUnderwater = false
SWEP.DrawAmmo = true
SWEP.ReloadSound = ""
SWEP.Base = "weapon_neurowep_base"
SWEP.Primary.Sound = Sound("l_Fire4.wav") 
SWEP.Primary.Damage = 200
SWEP.Primary.Cone = 0.0
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 5 
SWEP.Primary.Ammo = "357"
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Spread = 0.2
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = false	
SWEP.Primary.Recoil = 5
SWEP.Primary.Delay = 60/70
SWEP.Primary.Force = 100

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.CSMuzzleFlashes = true
SWEP.IronSightZoom = true
SWEP.Secondary.ScopeZoom = 1.45
SWEP.Pos = Vector(0, 6, 2)
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
   local wm = self:CreateWorldModel()
   if( !IsValid( self.Owner ) ) then return end 
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
