AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Flak Shotgun"
    SWEP.Slot = 3
		
	surface.CreateFont( "NeuroTec_Javelin", {
		font = "BOMBARD_",
		size = 45,
		weight = 100,
	} )


end

SWEP.Category = "NeuroTec Weapons - Shotguns"
SWEP.Author = "Hoffa"
SWEP.Contact = ""
SWEP.Purpose = "Dispenses Flak"
SWEP.Instructions = "Take out those pesky airplanes!"

SWEP.Base	= "weapon_neurowep_base_ent"
SWEP.Spawnable = true
SWEP.AdminOnly = false 

SWEP.UseHands	= false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 65
SWEP.SequentialReload = true 
SWEP.ViewModel = "models/weapons/v_shot_pm1014.mdl"
SWEP.WorldModel = "models/weapons/w_shot_pm1014.mdl"
 SWEP.HoldType = "shotgun"
 SWEP.IronSightHoldType = "rpg"
-- Primary Fire Attributes --
if( game.SinglePlayer() ) then 
SWEP.Primary.Recoil         = 0
else
SWEP.Primary.Recoil         = 15
end 
SWEP.Primary.Damage         = 0
SWEP.Primary.NumShots       = 6
SWEP.Primary.Cone           = 0
SWEP.Primary.ClipSize       = 6
SWEP.Primary.DefaultClip    = 6
SWEP.Primary.Automatic      = false    
SWEP.Primary.Ammo           = "RPG_Round"
SWEP.Primary.Delay 			= 2.0
SWEP.Primary.Sound = Sound( "50mm_Fire011.wav")

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
SWEP.PhysBulletPropType = "sent_mini_flak"
SWEP.BulletForce = 9001
-- SWEP.HasLockonSystem = true 

-- EFfect Overrides
SWEP.Tracer = "neuro_railbeam"
SWEP.TracerCount = 1 
SWEP.ForcePenetration = true 
SWEP.ImpactScale = 1.45
SWEP.NoLines = true 

SWEP.Scoped = false
SWEP.Secondary.ScopeZoom = 10
SWEP.ScopeTexture = Material(  "scope/javelinscope.png" )
SWEP.ScopeTexture2 = Material( "scope/javelinscope.png" )
SWEP.ScopeTextureScale = 1.0
SWEP.ScopeUseTextureSize = false 
SWEP.ImpactForce = 100000
SWEP.GravityEnabledOnShells = true 

SWEP.IronSightsPos = Vector(-5.12, 0, 3.239)
SWEP.IronSightsAng = Vector(0, 0, 0)

// Call everytime a physical bullet is launched 
function SWEP:SwepPhysbulletCallback( bullet ) 
	
	bullet.MinDamage = 55
	bullet.MaxDamage = 75
	bullet.Radius = 92
	-- bullet.HasShockwave = true 
	
	local Glow = ents.Create("env_sprite")				
	Glow:SetKeyValue("model","sprites/orangeflare1.vmt")
	Glow:SetKeyValue("rendercolor","175 175 255")
	Glow:SetKeyValue("scale",tostring(.125))
	Glow:SetPos(bullet:GetPos())
	Glow:SetParent(bullet)
	Glow:Spawn()
	Glow:Activate()

	local Shine = ents.Create("env_sprite")
	Shine:SetPos(bullet:GetPos())
	Shine:SetKeyValue("renderfx", "0")
	Shine:SetKeyValue("rendermode", "5")
	Shine:SetKeyValue("renderamt", "255")
	Shine:SetKeyValue("rendercolor", "195 195 255")
	Shine:SetKeyValue("framerate12", "20")
	Shine:SetKeyValue("model", "light_glow01.spr")
	Shine:SetKeyValue("scale", tostring( .251 ) )
	Shine:SetKeyValue("GlowProxySize", tostring( .25 ))
	Shine:SetParent(bullet)
	Shine:Spawn()
	Shine:Activate()
	
	-- util.SpriteTrail( bullet, 0, Color( 255,0,0,255), false, 16, 0, 1, .25, "effects/ex_smoketrail" )

end 

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