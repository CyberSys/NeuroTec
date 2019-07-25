AddCSLuaFile()

SWEP.HoldType = "slam"

if CLIENT then
   SWEP.PrintName = "Shuriken"
   SWEP.Slot = 3
   -- SWEP.ViewModelFlip = true
end

SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Equipment"
SWEP.PrimaryAnim = ACT_VM_THROW

SWEP.Spawnable = true

SWEP.Primary.Damage = 150
SWEP.Primary.Delay = 1
SWEP.Primary.Cone = 0.0

SWEP.Primary.ClipSize = 15
SWEP.Primary.ClipMax = 999
SWEP.Primary.DefaultClip = 10

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "grenade"
SWEP.Primary.Recoil = 0
SWEP.Primary.Sound = Sound( "Grenade.Throw" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 54
SWEP.ViewModel = "models/weapons/ghor/c_shuriken.mdl"
SWEP.WorldModel	= "models/scav/shuriken.mdl"

SWEP.PhysBulletEnable = true 
-- SWEP.Primary.PhysAmmoType = "sent_neuro_bigknife"
SWEP.PhysBulletPropType = "sent_neuro_shuriken"
SWEP.BulletForce = 3000
-- SWEP.HasLockonSystem = true 

-- EFfect Overrides
SWEP.Tracer = ""
SWEP.TracerCount = 1 
SWEP.ForcePenetration = true 
SWEP.ImpactScale = 1
SWEP.NoLines = true


SWEP.ImpactForce = 10
SWEP.HeadshotMultiplier = 3.5

SWEP.beginidle = 0
SWEP.begindeploy = 0

SWEP.Pos = Vector(0,0, 0)
SWEP.Ang = Angle(0, 0, 0)

local function safeanim(pl,anim)
    if IsValid(pl) then
        pl:SetAnimation(anim)
    end
end

function SWEP:Initialize()
    self:SetHoldType("slam")
end

function SWEP:Equip(owner)
    self:SetAnimation(ACT_IDLE)
end

function SWEP:SetVMAnimation(anim)
    self:SendWeaponAnim(anim)
    local vm = self.Owner:GetViewModel()
    if !IsValid(vm) then
        self.beginidle = 0
        self.begindeploy = 0
        return
    end
    local ctime = CurTime()
    if (anim == ACT_VM_PRIMARYATTACK) || (anim == ACT_VM_SECONDARYATTACK) then
        
		local sub = 0.3

        if anim == ACT_VM_PRIMARYATTACK then
            self.begindeploy = ctime+vm:SequenceDuration()-1.3-sub
            self:SetHoldType("grenade")
        else
            self.begindeploy = ctime+vm:SequenceDuration()-0.4-sub
            self:SetHoldType("knife")
        end
        self:SetNextPrimaryFire(self.begindeploy+0.1)
        self:SetNextSecondaryFire(self.begindeploy+0.1)
        self.beginidle = 0
        
    elseif (anim == ACT_VM_DEPLOY) then
        local divisor = 1
		
        local sequenceend = ctime+vm:SequenceDuration()/divisor
        self:SetNextPrimaryFire(sequenceend)
        self:SetNextSecondaryFire(sequenceend)
        self.beginidle = ctime+vm:SequenceDuration()/divisor
        self.begindeploy = 0
        self:SetHoldType("slam")
    else
        self.beginidle = ctime+vm:SequenceDuration()
    end
end

function SWEP:Think()
    local ctime = CurTime()
	
    if (self.beginidle != 0) && (self.beginidle < ctime) then
        self:SetVMAnimation(ACT_VM_IDLE)
    end
    if (self.begindeploy != 0) && (self.begindeploy < ctime) then
        self:SetVMAnimation(ACT_VM_DEPLOY)
    end
  
end

function SWEP:Deploy()
    self:SetVMAnimation(ACT_VM_DEPLOY)
end

function SWEP:PrimaryAttack()

self:SetVMAnimation(ACT_VM_PRIMARYATTACK)

	--self:TakePrimaryAmmo( 1 )
		 self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not self:CanPrimaryAttack() then return end

	if( self.Owner:WaterLevel() > 0 ) then 
return
end

	  if ( self.LastAttack or 0 + self.Primary.Delay <= CurTime() ) then

      self.LastAttack = CurTime()
         
		if( self:Clip1() <= 0 ) then 
		self:Reload() 
		return false 
		end
		

if SERVER then
    timer.Simple( 0.5, function()
  
    local ang2 = self.Owner:EyeAngles()
    local right = ang2:Right()
    local up = ang2:Up()
   
local proj = ents.Create(self.PhysBulletPropType)
    proj:SetOwner(self.Owner)
	 proj:SetPos(self.Owner:GetShootPos()+right*2+up*1)
    proj:SetAngles(self.Owner:EyeAngles() + Angle(0, 0, 90))
    proj:Spawn()
	proj:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector()*self.BulletForce+self.Owner:GetVelocity())
    self:EmitSound("npc/zombie/claw_miss1.wav")
	end )
        timer.Simple(0.5,safeanim,self.Owner,PLAYER_ATTACK1)
    
end		
end
self.Weapon:TakePrimaryAmmo( 1 )
end

function SWEP:SecondaryAttack()

 self:SetVMAnimation(ACT_VM_SECONDARYATTACK)
	--self:TakePrimaryAmmo( 1 )

		 self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not self:CanPrimaryAttack() then return end

	if( self.Owner:WaterLevel() > 0 ) then 
return
end

	  if ( self.LastAttack or 0 + self.Primary.Delay <= CurTime() ) then

      self.LastAttack = CurTime()
         
		if( self:Clip1() <= 0 ) then 
		self:Reload() 
		return false 
		end
		

if SERVER then
    timer.Simple( 0.4, function() 
	local ang2 = self.Owner:EyeAngles()
    local right = ang2:Right()
    local up = ang2:Up()
local proj = ents.Create(self.PhysBulletPropType)
    proj:SetOwner(self.Owner)
    proj:SetPos(self.Owner:GetShootPos()-right*3-up*3)
    proj:SetAngles(self.Owner:EyeAngles())
    proj:Spawn()
	proj:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector()*self.BulletForce+self.Owner:GetVelocity())
    self:EmitSound("npc/zombie/claw_miss1.wav")
	end )
        timer.Simple(0.2,safeanim,self.Owner,PLAYER_ATTACK1)
    
end		
end
self.Weapon:TakePrimaryAmmo( 1 )
end

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
if !self.dt.wmhide then

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
end
