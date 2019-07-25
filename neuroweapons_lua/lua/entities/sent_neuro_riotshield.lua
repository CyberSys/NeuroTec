AddCSLuaFile()

ENT.PrintName = "Riot Shield"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Gear"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.HealthVal = 600 -- missile health
ENT.Model = "models/arleitiss/riotshield/shield.mdl" -- 3d model
ENT.EngineSoundPath = "missile.accelerate" -- Engine sound, precached or string filepath.
ENT.SpawnPos = Vector( 0, 0, 30 )
ENT.SpawnAngle = Angle( -90, 0, 0 )
ENT.Interval = 1
if CLIENT then 

	function ENT:Draw()
		self:DrawModel()
	end 
	
end 

-- local Shields = {  
	 -- == ",
	--  = "
 -- }
-- Shields
-- Shields[
if( SERVER ) then 
	function ENT:Use( ply, caller, blah, bleh ) 
		
		local a = ply:EyeAngles()
		self:SetAngles( ply:GetAngles() )
		ply:SetEyeAngles( Angle( 0, a.y, a.r ) ) 
		local wep = ""
		if( self:GetModel() == "models/arleitiss/riotshield/shield.mdl" ) then 
			wep = "weapon_neurowep_riotshield"
		elseif( self:GetModel() == "models/bf4/bf4_shield.mdl" ) then 
			wep = "weapon_neurowep_blastshield"
		end 
		ply:Give( wep )
		ply:SelectWeapon( wep )
		self:Remove()
		
		return 
		
	end 	
	
	function ENT:OnTakeDamage( dmg )
		
		local atk = dmg:GetAttacker()
		local dmgtype = dmg:GetDamageType()
		local dpos = dmg:GetDamagePosition()
		local dir = ( self:GetPos() - atk:GetPos() ):GetNormalized()
		local dot = self:GetForward():Dot( dir )
		-- print( dot )
		-- print( dot, dmgtype )
		if( bit.band( dmgtype, DMG_BULLET ) == DMG_BULLET ) then 
			
			local tr,trace = {},{}
			tr.start = dpos + dir * 16
			tr.endpos = dpos
			tr.filter = { self.Owner, self:GetOwner() }
			tr.mask = MASK_SOLID
			trace = util.TraceLine( tr )
			
			debugoverlay.Line( tr.start, trace.HitPos, 1, Color(255,5,5,255), true )
			
			util.Decal("Impact.Glass", trace.HitPos+trace.HitNormal, trace.HitPos - trace.HitNormal )
		
		end 
		
		
	end 
	
	-- function ENT:Initialize() 
	
	-- end 
	
	function ENT:Think()
		
		if( IsValid (self.Owner ) && !self.Owner:Alive() ) then 
			
			self:SetParent( nil )
		
		end 
		
		-- self:GetPhysicsObject():Wake()
		
	end 

end 
