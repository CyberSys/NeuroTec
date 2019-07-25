AddCSLuaFile()

SWEP.HoldType = "pistol"

if CLIENT then
   SWEP.PrintName = "Winchester 1887"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = true
end

SWEP.Base = "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Shotguns"

SWEP.Spawnable = true
SWEP.Primary.Sound			= Sound( "Weapon_M3.Single" )
SWEP.Primary.Recoil			= 2.5
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 15
SWEP.Primary.Cone			= 0.025
SWEP.Primary.ClipSize		= 5
SWEP.Primary.Delay			= 0.9
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"

SWEP.UseHands = false
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 50

SWEP.ViewModel			= "models/weapons/v_hex1_wincheste.mdl"
SWEP.WorldModel			= "models/weapons/w_hex1_winchester.mdl"

SWEP.HeadshotMultiplier = 2.2

SWEP.IronSightsPos = Vector (4.827, -1.0853, 3.14656)
SWEP.IronSightsAng = Vector (-0.1361, -0.2285, 2.4948)


local function Sparklies(attacker, b, dmginfo)
	local effectdata = EffectData()
	effectdata:SetOrigin( b.HitPos )
	effectdata:SetStart( b.HitNormal )
	effectdata:SetNormal( b.HitNormal )
	effectdata:SetMagnitude( 1 )
	effectdata:SetScale( 0.5 )
	effectdata:SetRadius( 1 )
   if b.HitWorld and b.MatType == MAT_METAL then
	util.Effect( "micro_he_impact_plane", effectdata )
	elseif( b.Entity && b.Entity:IsPlayer() ) then 
		effectdata:SetScale( 0.8 )
	util.Effect( "micro_he_blood", effectdata )
	end
end

function SWEP:PrimaryAttack()
	
	if( !self.LastAttack ) then 
		self.LastAttack = CurTime() - 2
	end 
	if( self.Weapon:GetNetworkedBool( "reloading", false ) ) then return end 
	
	if( self.Owner:WaterLevel() > 0 ) then 
		return
	end

	if( self.LastAttack + self.Primary.Delay <= CurTime() ) then
	
		self.LastAttack = CurTime()
		
		if( self:Clip1() <= 0 ) then 
			self:Reload() 
			return false 
		end
		local owner = self.Owner
	   if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end
		self.LastAttack = CurTime() 
		
	   owner:ViewPunch( Angle( math.Rand(-5.2,-4.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
	   local bullet = {}
	   bullet.Num    = 8
	   bullet.Src    = self.Owner:GetShootPos()
	   bullet.Dir    = self.Owner:GetAimVector()
	   bullet.Spread =   math.Rand(-2,2) * Vector( 0.2,0.2,0.0 )--Vector( math.random(-cone,cone),math.random(-cone, cone), 0 ) 
	   bullet.Tracer = 1
	   bullet.TracerName = self.Tracer or "Tracer"
	   bullet.Force  = 10
	   bullet.Damage = self.Primary.Damage
	   bullet.Callback = Sparklies

	   self.Owner:FireBullets( bullet )
		self.Owner:EmitSound(  "weapons/m3/m3-1.wav", 511, 100)
					
		self.Weapon:TakePrimaryAmmo( 1 )
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		
	end

end
	
function SWEP:Reload()
		
	self:SetIronsights( false )
	

	if ( self.Weapon:GetNetworkedBool( "reloading", false ) ) then return end
	
	if ( self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		
		self.Weapon:SetNetworkedBool( "reloading", true )
		self.Weapon:SetVar( "reloadtimer", CurTime() + 0.65 )
		self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
		
	end

end


function SWEP:Think()


	if ( self.Weapon:GetNetworkedBool( "reloading", false ) ) then
	
		if ( self.Weapon:GetVar( "reloadtimer", 0 ) < CurTime() ) then
			
			if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
				self.Weapon:SetNetworkedBool( "reloading", false )
				return
			end
			
			self.Weapon:SetVar( "reloadtimer", CurTime() + 0.65 )
			self.Owner:EmitSound( "weapons/m3/m3_insertshell.wav" )
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			self.Weapon:SetClip1(  self.Weapon:Clip1() + 1 )
			
			if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
			    self.Owner:EmitSound( "weapons/m3_pump.wav" )
				self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			else
			
			end
			
		end
	
	end

end