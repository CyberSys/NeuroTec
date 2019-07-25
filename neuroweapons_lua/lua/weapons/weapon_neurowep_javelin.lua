AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "FGM-148 Javelin"
    SWEP.Slot = 3
		
	surface.CreateFont( "NeuroTec_Javelin", {
		font = "BOMBARD_",
		size = 45,
		weight = 100,
	} )


end

SWEP.Category = "NeuroTec Weapons - Launchers"
SWEP.Author = "Smithy285, Hoffa & Killstr3aKs"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.Base	= "weapon_neurowep_base_ent"
SWEP.Spawnable = true

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 50

SWEP.ViewModel = "models/killstr3aks/c_javelin.mdl"
SWEP.WorldModel = "models/killstr3aks/w_javelin.mdl"
 SWEP.HoldType = "passive"
 SWEP.IronSightHoldType = "camera"
-- Primary Fire Attributes --
if( game.SinglePlayer() ) then 
SWEP.Primary.Recoil         = 0
else
SWEP.Primary.Recoil         = 4
end 
SWEP.Primary.Damage         = 0
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0
SWEP.Primary.ClipSize       = 1
SWEP.Primary.DefaultClip    = 3
SWEP.Primary.Automatic      = false    
SWEP.Primary.Ammo           = "RPG_Round"
SWEP.Primary.Delay 			= 4
SWEP.Primary.Sound = Sound( "lockon/missilelaunchengine.mp3")

-- Secondary Fire Attributes --
SWEP.Secondary.Recoil        = 0
SWEP.Secondary.Damage        = 0
SWEP.Secondary.NumShots      = 1
SWEP.Secondary.Cone          = 0
SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip   = -1
SWEP.Secondary.Automatic     = false
SWEP.Secondary.Ammo 		 = "none"
SWEP.Secondary.Delay 		= 1

SWEP.PhysBulletEnable = true 
SWEP.Primary.PhysAmmoType = "sent_neuro_javelin"
SWEP.PhysBulletPropType = "sent_neuro_javelin"
SWEP.BulletForce = 100
SWEP.HasLockonSystem = true 

-- EFfect Overrides
SWEP.Tracer = "neuro_railbeam"
SWEP.TracerCount = 1 
SWEP.ForcePenetration = true 
SWEP.ImpactScale = 1.45
SWEP.NoLines = true 

SWEP.Scoped = true
SWEP.Secondary.ScopeZoom = 10
SWEP.ScopeTexture = Material(  "scope/javelinscope.png" )
SWEP.ScopeTexture2 = Material( "scope/javelinscope.png" )
SWEP.ScopeTextureScale = 1.0
SWEP.ScopeUseTextureSize = false 
SWEP.ImpactForce = 50000

SWEP.IronSightsPos = Vector(-5.12, -18.493, 8.239)
SWEP.IronSightsAng = Vector(0, 0, 0)

local oldAmmo = 0
local reddot = Material( "sprites/glow04_noz" )
local beep = Sound( "weapons/javelin/targetting.wav" )
local warning = Sound("weapons/pistol/pistol_empty.wav")
 
function SWEP:CanPrimaryAttack()
   if not IsValid(self.Owner) then return end
   if ( self:GetNetworkedBool( "reloading" ) ) then return false end
	local eyetrace = self.Owner:GetEyeTrace()
   if( !self:GetIronsights()|| eyetrace.HitSky ) then 
				
		self.Owner:EmitSound( beep, 40, 30 )
		self:SetNextPrimaryFire( 0 )
		self:SetNextSecondaryFire( 0 )
		return false 
   end 
   local tr = self.Owner:GetEyeTrace()
   local dist = ( self.Owner:GetShootPos() - tr.HitPos ):Length() 
   if( dist < 1024 ) then 
		
		-- self.Owner:EmitSound( warning, 511, 45 )
		self:SetNextPrimaryFire( 0 )
		self:SetNextSecondaryFire( 0 )
		return false 
   end 

   if self:Clip1() <= 0 then
      self:DryFire(self.SetNextPrimaryFire)
      return false
   end
   return true
end

function SWEP:PostDraw()
	if ( self.Scoped ) and self:GetIronsights() then

		local map = game.GetMap()
		local IsNight = string.find( map, "night" ) != nil 
		
		-- local radius = 30 
		-- local thickness = 1
		-- local roughness = 1
		-- local color = Color( 13, 173, 192 )
		-- local clockwise = false

	    -- local ammo = Lerp( 0.1, oldAmmo, self:Clip1() )
		-- local maxAmmo = self.Primary.ClipSize or 32
		-- local clamped = math.min( ammo, maxAmmo )

		-- local startang = 0
		-- local endang = ( clamped / maxAmmo ) * 361

		local x = ScrW() / 2
		local y = ScrH() / 2
		
	
		oldAmmo = clamped

		local trac = {}
		trac.start = self.Owner:GetShootPos( )
		trac.endpos = trac.start + ( self.Owner:GetAimVector( ) * 99999 )
		trac.filter = { self.Owner }
		local tra = util.TraceLine( trac )

		if tra.Entity:IsPlayer() or tra.Entity:IsNPC() then
			surface.SetDrawColor( 255, 0, 0, 255 )
		else
			surface.SetDrawColor( 0, 255, 0, 255 )
		end

		surface.SetMaterial( reddot	)
		surface.DrawTexturedRect( x - 32 / 2, y - 32 / 2, 32, 32 )

		local trdistanceraw = tostring( self.Owner:GetPos( ):Distance( tra.HitPos ) /39 )
		local trdistance =  math.Clamp( math.Round( trdistanceraw ), 0, 10000 )

		local col =  Color( 13, 173, 13 )
		if( trdistance < 75 ) then 
		
			col = Color( 173, 13, 13 ) //draw.SimpleText( trdistance .. " m", "NeuroTec_Javelin", x, y * self.ScopeTextureScale - 200, , 1, 1 )
		
		end 
		
		draw.SimpleText( ">", "NeuroTec_Javelin", ScrW() * 0.40, y * self.ScopeTextureScale - 200, col, 1, 1 )
		draw.SimpleText( trdistance .. " m", "NeuroTec_Javelin", x, y * self.ScopeTextureScale - 200, col, 1, 1 )
		draw.SimpleText( "<", "NeuroTec_Javelin", ScrW() * 0.60, y * self.ScopeTextureScale - 200, col, 1, 1 )
		if( !IsNight ) then 
		
			draw.SimpleText( "DAY", "NeuroTec_Javelin", ScrW() * 0.3, y * self.ScopeTextureScale - 320, Color( 13, 173, 13 ), 1, 1 )

		else
			
			draw.SimpleText( "DAY", "NeuroTec_Javelin", ScrW() * 0.3, y * self.ScopeTextureScale - 320, Color( 13, 173, 13,15 ), 1, 1 )
			
		end 
		
		draw.SimpleText( "BCU", "NeuroTec_Javelin", ScrW() * 0.3, ScrH() * .85, Color( 13, 173, 13,15  ), 1, 1 )
		if( IsNight ) then 
		
			draw.SimpleText( "NIGHT", "NeuroTec_Javelin", ScrW() * 0.2075, ScrH() * 0.25, Color( 13, 173, 13 ), 1, 1 )
		else
			
			draw.SimpleText( "NIGHT", "NeuroTec_Javelin", ScrW() * 0.2075, ScrH() * 0.25, Color( 13, 173, 13,15 ), 1, 1 )
			
			
		end 
		
		draw.SimpleText( "CLU", "NeuroTec_Javelin", ScrW() * 0.2075, ScrH() * 0.5, Color( 13, 173, 13, 15 ), 1, 1 )
		draw.SimpleText( "DIR", "NeuroTec_Javelin", ScrW() * 0.79, ScrH() * 0.5, Color( 13, 173, 13, 15 ), 1, 1 )
		if( LocalPlayer():FlashlightIsOn() ) then 
		
			draw.SimpleText( "FLIR", "NeuroTec_Javelin", ScrW() * 0.79, ScrH() * 0.75, Color( 13, 173, 13 ), 1, 1 )
			
		else 
		
			draw.SimpleText( "FLIR", "NeuroTec_Javelin", ScrW() * 0.79, ScrH() * 0.75, Color( 13, 173, 13, 15 ), 1, 1 )
			
		end 
		
		draw.SimpleText( "CLU", "NeuroTec_Javelin", ScrW() * 0.2075, ScrH() * 0.75, Color( 13, 173, 13, 15 ), 1, 1 )
		draw.SimpleText( "TOP", "NeuroTec_Javelin", ScrW() * 0.79, ScrH() * 0.25, Color( 13, 173, 13, 15 ), 1, 1 )
		draw.SimpleText( "WFOV", "NeuroTec_Javelin", ScrW() * 0.4, y * self.ScopeTextureScale - 320, Color( 13, 173, 13, 15 ), 1, 1 )
		draw.SimpleText( "HANG FIRE", "NeuroTec_Javelin", ScrW() * 0.43, ScrH() * .85, Color( 13, 173, 13, 15 ), 1, 1 )
		draw.SimpleText( "NFOW", "NeuroTec_Javelin", ScrW() * 0.6, y * self.ScopeTextureScale - 320, Color( 13, 173, 13, 15 ), 1, 1 )
		if( self.HasLockedOnTarget ) then 
			
			draw.SimpleText( "SEEK", "NeuroTec_Javelin", ScrW() * 0.7, y * self.ScopeTextureScale - 320, Color( 13, 173, 13,15 ), 1, 1 )
			
		else 
		
			draw.SimpleText( "SEEK", "NeuroTec_Javelin", ScrW() * 0.7, y * self.ScopeTextureScale - 320, Color( 13, 173, 13 ), 1, 1 )
			
		end 
		
	else
		oldAmmo = 0
	end
end 

function SWEP:PreDraw()
	if ( self.Scoped ) and self:GetIronsights() then
	
		local tr,trace={},{}
		tr.start = self.Owner:GetShootPos()
		tr.endpos = tr.start + self.Owner:GetAimVector() * 36000
		tr.filter = { self, self.Owner }
		tr.mask = MASK_SOLID 
		trace = util.TraceLine( tr ) 
		
		if( trace.Hit ) then
			local Radius = 1000
			local closest = Radius 
			local ent = NULL 
			
			for k,v in ipairs( ents.FindInSphere( trace.HitPos, Radius ) ) do 
				local dist = ( v:GetPos() - trace.HitPos ):Length() 
				if( v != LocalPlayer() && ( v:IsPlayer() || v:IsNPC() || v:GetNWInt("health") ) && dist < closest ) then 
					closest = dist 
					ent = v 
				end 
			end 
			
			if( IsValid( ent ) ) then 
				surface.PlaySound( beep )
				self.HasLockedOnTarget = true 
				
				local pos = ( ent:GetPos() + Vector(0,0,16 ) ):ToScreen()
				surface.SetDrawColor( Color( 0, 255,0, 255 ) )
				surface.DrawLine( 0, pos.y, ScrW(), pos.y ) 
				surface.DrawLine( pos.x, 0, pos.x, ScrH() ) 
				-- surface.DrawLine( number startX, number startY, number endX, number endY )
			else
				
				self.HasLockedOnTarget = false 
			
			end 
			
		end 
		
	end 
	
end 	