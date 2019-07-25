AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "RPG-7"
    SWEP.Slot = 3
    SWEP.SlotPos = 3
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true
end

SWEP.Category = "NeuroTec Weapons - Launchers"
SWEP.Author = "Hoffa & Smithy285"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/vrpg7.mdl"
SWEP.WorldModel = "models/weapons/w_rpg7/w_rpg7.mdl"
  
-- Primary Fire Attributes --
SWEP.Primary.Recoil         = 0
SWEP.Primary.Damage         = 0
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0
SWEP.Primary.ClipSize       = 1
SWEP.Primary.DefaultClip    = 3
SWEP.Primary.Automatic      = false    
SWEP.Primary.Ammo           = "RPG_Round"
SWEP.Primary.Delay 			= 4
 
-- Secondary Fire Attributes --
SWEP.Secondary.Recoil        = 0
SWEP.Secondary.Damage        = 0
SWEP.Secondary.NumShots      = 1
SWEP.Secondary.Cone          = 0
SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip   = -1
SWEP.Secondary.Automatic     = false
SWEP.Secondary.Ammo 		 = "none"

SWEP.IronSightsPos = Vector( -3.74, -11, 0.139 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )

function SWEP:Initialize()
    self:SetWeaponHoldType( "rpg" )
	self.LastAttack = ( CurTime() - 5 )
end

function SWEP:Precache()
end

function SWEP:Deploy()
	if not self.Owner.CanReload then
		self.Owner.CanReload = true
	end

    self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self:DefaultReload( ACT_VM_RELOAD ) 
	self.Owner:SetAnimation( PLAYER_RELOAD )
	
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:Reload()
	if SERVER then
		if not self.Owner.CanReload then
			
			return
		end

		if self.Weapon:Clip1() == 0 then
			self.Weapon:DefaultReload(ACT_VM_RELOAD)
		end
	end
	
    return false
end

function SWEP:PrimaryAttack()
	if ( self.LastAttack + self.Primary.Delay <= CurTime() ) then
		self.LastAttack = CurTime()
			
		if ( self:Clip1() <= 0 ) then self:Reload() return false end

		if SERVER then
			local rpg = ents.Create( "sent_rpg7_rocket" )
			
			if ( !self.Weapon:GetNetworkedBool( "Ironsights", false ) ) then
				rpg:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector() * 30 + self.Owner:GetUp() * -2 + self.Owner:GetRight() * 4  )
			else
				rpg:SetPos( self.Owner:GetShootPos() + self.Owner:GetAimVector() * 30 + self.Owner:GetUp() * -1  )
			end
			
			rpg:SetAngles( self.Owner:EyeAngles() )
			rpg.Owner = self.Owner
			rpg:Spawn()
			rpg:SetOwner( self.Owner )
			self.Owner:EmitSound( "weapons/rpg/rocketfire1.wav", 95, 100 )
		end

		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		
		if ( self.Owner:IsPlayer() ) then
			self.Owner:GetViewModel():SetPlaybackRate( 3 )
			self.Owner:ViewPunch( Angle( -5, 0, 0 ) )
		end
		
		self.Weapon:SetClip1( 0 )
		
		timer.Simple( 0.5, function() if ( IsValid( self ) ) then self:Reload() end end )
	end
end

local IRONSIGHT_TIME = 0.25

/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
function SWEP:GetViewModelPosition( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )
	self.DrawCrosshair = !bIron
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end


/*---------------------------------------------------------
	SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights( b )

	self.Weapon:SetNetworkedBool( "Ironsights", b )

end


SWEP.NextSecondaryAttack = 0
/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	
	bIronsights = !self.Weapon:GetNetworkedBool( "Ironsights", false )
	
	if( bIronsights ) then
		
		self.ViewModelFOV    = 80
		self.Owner:SetFOV( 40, 0.3 )
		
	else
		
		self.ViewModelFOV    = 60
		self.Owner:SetFOV( 90, 0.3 )
		-- self.Zoom = 
	end
	
	self:SetIronsights( bIronsights )
	
	self.NextSecondaryAttack = CurTime() + 0.3
	
end

/*---------------------------------------------------------
	DrawHUD
	
	Just a rough mock up showing how to draw your own crosshair.
	
---------------------------------------------------------*/
function SWEP:DrawHUD()

	// No crosshair when ironsights is on
	if ( self.Weapon:GetNetworkedBool( "Ironsights" ) ) then return end

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0
	local scale = 10 * self.Primary.Cone
	
	// Scale the size of the crosshair according to how long ago we fired our weapon
	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	
	surface.SetDrawColor( 0, 255, 0, 255 )
	
	// Draw an awesome crosshair
	local gap = 40 * scale
	local length = gap + 20 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )

end

/*---------------------------------------------------------
	onRestore
	Loaded a saved game (or changelevel)
---------------------------------------------------------*/
function SWEP:OnRestore()

	self.NextSecondaryAttack = 0
	self:SetIronsights( false )
	
end