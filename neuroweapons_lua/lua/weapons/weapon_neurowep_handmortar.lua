AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Mortar"
    SWEP.Slot = 3

end

SWEP.Category = "NeuroTec Weapons - Launchers"
SWEP.Author = "Hoffa"
SWEP.Contact = ""
SWEP.Purpose = "Dispenses Mortar Rounds"
SWEP.Instructions = "Take out those pesky.. everything!"

SWEP.Base	= "weapon_neurowep_base_ent"
SWEP.Spawnable = true
SWEP.AdminOnly = false 

SWEP.UseHands	= false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 65
SWEP.SequentialReload = true 
SWEP.ViewModel = "models/weapons/v_shot_pm1014.mdl"
SWEP.WorldModel = "models/surgeon/mortar34.mdl"
 SWEP.HoldType = "shotgun"
 SWEP.IronSightHoldType = "shotgun"
-- Primary Fire Attributes --
if( game.SinglePlayer() ) then 
SWEP.Primary.Recoil         = 0
else
SWEP.Primary.Recoil         = 25
end 
SWEP.Primary.Damage         = 0
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0
SWEP.Primary.ClipSize       = 1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.Automatic      = false    
SWEP.Primary.Ammo           = "RPG_Round"
SWEP.Primary.Delay 			= 4.0
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
SWEP.PhysBulletPropType = "sent_tank_shell"
SWEP.BulletForce = 2000
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

-- SWEP.IronSightsPos = Vector(-5.12, 0, 3.239)
-- SWEP.IronSightsAng = Vector(0, 0, 0)

// Call everytime a physical bullet is launched 
function SWEP:SwepPhysbulletCallback( bullet ) 
	
	bullet.MinDamage = 550
	bullet.MaxDamage = 750
	bullet.Radius = 128
	bullet:SetAngles( bullet:GetAngles() + AngleRand() * .005 )
	ParticleEffect(  "tank_muzzleflash", self.Owner:GetShootPos(), bullet:GetAngles(), self.Owner )
	
	local prop = ents.Create("prop_physics")
	prop:SetPos( self.Owner:GetShootPos() + self.Owner:GetRight() * 25 )
	prop:SetAngles( self.Owner:EyeAngles() + Angle(70,0,0) )
	prop:SetModel( "models/surgeon/mortar34.mdl" )
	prop:Spawn()
	prop:Fire("kill","",5)
	
	self.Owner:StripWeapon( self:GetClass() )
	
	
end 

function SWEP:ClientAttackCallback()
	
	ParticleEffect(  "tank_muzzleflash", self.Owner:GetShootPos(), self.Owner:EyeAngles(), self.Owner )
	
end 

SWEP.Pos = Vector(0, 6, 2)
SWEP.Ang = Angle(80, -180, 0)
function SWEP:PreDrawViewModel( vm, ply, weapon )
	
	if( !self.TargetPos ) then 
			self.TargetPos = self.Owner:GetShootPos() + self.Owner:GetRight() * 10 + self.Owner:GetUp() * -19 + self.Owner:GetForward() * -5 
		end 
		
	if ( self:GetNetworkedBool( "reloading" ) ) then 
		self.TargetPos = LerpVector( 0.051, self.TargetPos, self.Owner:LocalToWorld( Vector(0,15,-15) ) )
	else 
		self.TargetPos = LerpVector( 0.991, self.TargetPos, self.Owner:GetShootPos() + self.Owner:GetRight() * 10 + self.Owner:GetUp() * -19 + self.Owner:GetForward() * -5  )
	end

	vm:SetAngles( self.Owner:EyeAngles() + Angle(70,0,0) )
	vm:SetPos( self.TargetPos )
	vm:SetModel( self.WorldModel )
	
end 

function SWEP:CreateWorldModel()
   if not self.WModel then
      self.WModel = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
      self.WModel:SetNoDraw(true)
      self.WModel:SetBodygroup(1, 1)
   end
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