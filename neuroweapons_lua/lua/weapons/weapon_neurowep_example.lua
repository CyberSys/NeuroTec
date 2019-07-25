AddCSLuaFile()

SWEP.PrintName				= "Pipe Bar"
SWEP.Author					= "sillirion"
SWEP.Purpose				= "kill."

SWEP.Slot					= 1
SWEP.SlotPos				= 2

SWEP.Spawnable				= true

SWEP.ViewModel              = "models/weapons/c_melee_crowbar.mdl"
SWEP.WorldModel				=  "models/props_canal/mattpipe.mdl" 
SWEP.ViewModelFOV			= 54
SWEP.UseHands				= true

SWEP.DrawAmmo				= false
SWEP.AdminOnly				= true

SWEP.ViewModelFlip = false	--the default viewmodel won't be flipped

SWEP.Pos = Vector(0,0, -5)
SWEP.Ang = Angle(0, 0, 0)

SWEP.Primary.Delay = 0.5
SWEP.Primary.ClipSize = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Damage = 15
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "batman"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1

local HitSound = Sound( "Flesh.ImpactHard" )
SWEP.Primary.Sound = Sound( "weapons/knife/knife_slash1.wav" )


function SWEP:PrimaryAttack()

	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Owner:EmitSound( "WeaponFrag.Throw" )
	
		local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:GetClass() == "prop_ragdoll" ) ) then 
			
				local dmg = DamageInfo()
				dmg:SetAttacker( self.Owner )
				dmg:SetInflictor( self )
				if( primary == false ) then 
					dmg:SetDamage( 25 )
				else 
					dmg:SetDamage( self.Primary.Damage )
				end 
				dmg:SetDamageType( DMG_SLASH )
				dmg:SetDamagePosition( tr.HitPos )
				dmg:SetDamageForce( self.Owner:GetAimVector() * 50 )
				tr.Entity:TakeDamageInfo( dmg )
			self:EmitSound( HitSound )
end	
		
			   if tr.HitWorld then
			   
self:EmitSound("physics/metal/metal_solid_impact_hard"..math.random(4,5)..".wav", 511, 100 )
util.Decal( "ManhackCut",tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )	
			end 
			

				local mat = tr.MatType
				if( mat == MAT_FlESH || mat == MAT_ALIENFLESH || mat == MAT_BLOODYFLESH ) then 
						local dir = VectorRand()*128
						util.Decal( "Blood",tr.HitPos + dir, tr.HitPos - dir )
						
					end 
			
		end 
		
function SWEP:SecondaryAttack()
end

function SWEP:Initialize( )
    self:SetWeaponHoldType( "melee" )
    
    if CLIENT then
        wm = ClientsideModel(self.WorldModel)
       wm:AddEffects( bit.bor( EF_NODRAW, EF_NOSHADOW ) )
    end
end

function SWEP:ViewModelDrawn( vm )

 local bone = vm:LookupBone("ValveBiped.Bip01_R_Hand")
   local pos, ang = vm:GetBonePosition(bone)
		
   if bone then
      ang:RotateAroundAxis(ang:Right(), self.Ang.p)
      ang:RotateAroundAxis(ang:Forward(), self.Ang.y)
      ang:RotateAroundAxis(ang:Up(), self.Ang.r)
      wm:SetRenderOrigin(pos + ang:Right() * self.Pos.x + ang:Forward() * self.Pos.y + ang:Up() * self.Pos.z)
      wm:SetRenderAngles(ang)
      wm:DrawModel()
   end
end

SWEP.Pos2 = Vector(2, 3, -7.792)
SWEP.Ang2 = Angle(0, 0, 0)

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
      ang:RotateAroundAxis(ang:Right(), self.Ang2.p)
      ang:RotateAroundAxis(ang:Forward(), self.Ang2.y)
      ang:RotateAroundAxis(ang:Up(), self.Ang2.r)
      wm:SetRenderOrigin(pos + ang:Right() * self.Pos2.x + ang:Forward() * self.Pos2.y + ang:Up() * self.Pos2.z)
      wm:SetRenderAngles(ang)
      wm:DrawModel()
   end
end
