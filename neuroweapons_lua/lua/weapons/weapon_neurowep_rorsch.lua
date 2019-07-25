AddCSLuaFile()

SWEP.HoldType = "ar2"

if CLIENT then
   SWEP.PrintName = "Rorsch Mk-1"
   SWEP.Slot = 3
   SWEP.ViewModelFlip = false

   SWEP.WepSelectIcon	= surface.GetTextureID("vgui/entities/preview_rorsch")

  	surface.CreateFont( "neuro_rorsch", {
		font = "Arial",
		size = 25,
		weight = 500,
	} )
end

SWEP.Author = "Smithy285, Hoffa & Killstr3aKs"
SWEP.Base	= "weapon_neurowep_base"
SWEP.Category = "NeuroTec Weapons - Snipers"

SWEP.Spawnable = true
SWEP.Scoped = true
SWEP.Secondary.ScopeZoom = 10
SWEP.ScopeTexture = Material( "scope/x1_crosshair_outline.png" )
SWEP.ScopeTexture2 = Material( "scope/overlay_outer.png" )
SWEP.ScopeTextureScale = 0.25
SWEP.ScopeUseTextureSize = true 
SWEP.ImpactForce = 50000

SWEP.HullSize = 6 -- used by FireBullets traceline
SWEP.Primary.Damage = 800
SWEP.Primary.Delay = 1.5
SWEP.Primary.Cone = 0.0

SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 30
SWEP.Primary.DefaultClip = 1

SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "xbowbolt"
SWEP.Primary.Recoil = 5
SWEP.Primary.Sound = Sound( "RORSCH.Single" )

SWEP.UseHands	= true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV	= 50
SWEP.ViewModel = "models/killstr3aks/c_rorsch.mdl"
SWEP.WorldModel	= "models/killstr3aks/w_rorsch.mdl"
-- EFfect Overrides
SWEP.Tracer = "neuro_railbeam"
SWEP.TracerCount = 1 
SWEP.ForcePenetration = true 
SWEP.ImpactScale = 1.45
SWEP.NoLines = true 
SWEP.PenetrationSound = { Sound( "wt/sounds/tank_hit_small2_01.wav" ),Sound( "wt/sounds/tank_hit_small2_02.wav" ),Sound( "wt/sounds/tank_hit_small2_03.wav" ),Sound( "wt/sounds/tank_hit_small2_04.wav" ),Sound( "wt/sounds/tank_hit_small2_05.wav" ) }
SWEP.HeadshotMultiplier = 5.65

SWEP.IronSightsPos = Vector(-3.483, -11.5, 2.439)
SWEP.IronSightsAng = Vector(0, 0, 0)

local oldAmmo = 0
local reddot = Material( "sprites/glow04_noz" )
local beep = Sound( "weapons/rorsch/beep.mp3" )

function SWEP:PreDraw()
	if ( self.Scoped ) and self:GetIronsights() then
		local radius = 30 
		local thickness = 1
		local roughness = 1
		local color = Color( 13, 173, 192 )
		local clockwise = false

	    local ammo = Lerp( 0.1, oldAmmo, self:Clip1() )
		local maxAmmo = self.Primary.ClipSize or 32
		local clamped = math.min( ammo, maxAmmo )

		local startang = 0
		local endang = ( clamped / maxAmmo ) * 361

		local x = ScrW() / 2
		local y = ScrH() / 2
		
		draw.Arc( x, y, radius, thickness, startang, endang, roughness, color, clockwise )

		oldAmmo = clamped

		local trac = {}
		trac.start = self.Owner:GetShootPos( )
		trac.endpos = trac.start + ( self.Owner:GetAimVector( ) * 99999 )
		trac.filter = { self.Owner }
		local tra = util.TraceLine( trac )

		if tra.Entity:IsPlayer() or tra.Entity:IsNPC() then
			surface.PlaySound( beep )
			surface.SetDrawColor( 255, 0, 0, 255 )
		else
			surface.SetDrawColor( 0, 255, 0, 255 )
		end

		surface.SetMaterial( reddot	)
		surface.DrawTexturedRect( x - 32 / 2, y - 32 / 2, 32, 32 )

		local trdistanceraw = tostring( self.Owner:GetPos( ):Distance( tra.HitPos ) /39 )
		local trdistance =  math.Clamp( math.Round( trdistanceraw ), 0, 10000 )

		draw.SimpleText( ">", "neuro_rorsch", ScrW() * 0.40, y * self.ScopeTextureScale + 100, Color( 13, 173, 192 ), 1, 1 )
		draw.SimpleText( "Distance: " .. trdistance .. " m", "neuro_rorsch", x, y * self.ScopeTextureScale + 100, Color( 13, 173, 192 ), 1, 1 )
		draw.SimpleText( "<", "neuro_rorsch", ScrW() * 0.60, y * self.ScopeTextureScale + 100, Color( 13, 173, 192 ), 1, 1 )
	else
		oldAmmo = 0
	end
end 

function SWEP:PostDraw()

end 