AddCSLuaFile()

ENT.PrintName = "C4"
ENT.Author = "Hoffa & Smithy285"
ENT.Category = "NeuroTec Weapons - Missiles"
ENT.Base = "sent_neuro_missile_base"

ENT.Spawnable = false
ENT.AdminSpawnable = true

ENT.WeaponType = WEAPON_BOMB
ENT.ExplosionSound = "wt/misc/bomb_explosion_1.wav"
ENT.HealthVal = 15 -- missile health
ENT.Damage = 12500 -- missile damage
ENT.Radius = 750 -- missile blast radius
ENT.NozzlePos = Vector( ) -- smoke effect local position
ENT.EngineSoundPath = Sound("bf4/rockets/pods_rocket_engine_wave 2 0 0_2ch.wav") -- Engine sound, precached or string filepath.
ENT.Model = "models/weapons/w_c4_planted.mdl" -- 3d model
ENT.VEffect = "VBIED_explosion" -- The effect we call with ParticleEffect()
ENT.DrawBigSmoke = true

ENT.SpawnPos = Vector( 0, 0, 30 )
ENT.SpawnAngle = Angle( -90, 0, 0 )
ENT.Interval = 1
ENT.MaxLife = 45 

if CLIENT then 
	surface.CreateFont( "NeuroC4Font", {
			font = "Trebuchet22",
			size = 200,
			weight = 700,
			blursize = 0,
			scanlines = 0,
			antialias = true,
			underline = false,
			italic = false,
			strikeout = false,
			symbol = false,
			rotary = false,
			shadow = false,
			additive = false,
			outline = false,
		} )
	function ENT:DrawCamStuff( pos, ang ) 
		
		local timeLeft = self:GetNWInt("NeuroC4TimeLeft", 30 )
	
		local timeString = "00:"..timeLeft
		if( timeLeft < 10 ) then 
			timeString = "00:0"..timeLeft 
		end 
		
		if( timeLeft == 0 ) then 
			timeString = "BYE"
		end 
			
		cam.Start3D2D( pos, ang , .017)
			draw.DrawText(timeString, "NeuroC4Font", 0, 0, Color(255,5,5,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end 

	function ENT:Draw()
		self:DrawModel()
		local pos = self:LocalToWorld( Vector( 4.20,-2.,8.8 ) )
		local ang = self:GetAngles() --+ Angle(90, 90, 90)
		ang:RotateAroundAxis( self:GetRight(), -180 ) 
		
		ang:RotateAroundAxis( self:GetUp(), -90) 
		ang:RotateAroundAxis( self:GetForward(), 180 ) 
		self:DrawCamStuff( pos, ang )
	end 
end 

if( SERVER ) then 
	function ENT:Use( ply, caller, blah, bleh ) 
		if( self.Used ) then return end 
		self.Used = true 
		
		ply:PrintMessage( HUD_PRINTCENTER, "WRONG CODE LOL" )
		self:EmitSound("buttons/button24.wav",100, 100 )
		timer.Simple( math.random(1,5), function() 
		
			if (IsValid( self ) ) then 
				
				-- self:NeuroWepsDetonatePhysics()
				self:MissileDoExplosion()
			
			end 
			
		end ) 
		
		-- return 
		
	end 	

	-- function ENT:Initialize() 
	
	-- end 
	
	function ENT:Think()
			 
		if( !self.IsPlanted ) then return end 
		if( !self.Spawned ) then self.Spawned = CurTime() end 
		if( !self.LastBeep ) then self.LastBeep = 0 end 
		local lifeTime = CurTime() - self.Spawned 
		local life = self.MaxLife 
		
		if( lifeTime < life/3 ) then 
			self.Interval = 1 
		elseif( lifeTime < life/2.5 ) then 
			self.Interval = 0.5 
		elseif( lifeTime < life/10 ) then 
			self.Interval = 0.25
		else
			self.Interval = 0.1
		end 

		
		self:SetNWInt("NeuroC4TimeLeft", math.floor( life - lifeTime ) )
			
		if( self.LastBeep + self.Interval <= CurTime() ) then 
			self.LastBeep = CurTime()			
		
			self:EmitSound("weapons/c4/c4_beep1.wav", 511, 100 )
		
		end 
		if( lifeTime > life ) then 
					
		
			-- self:NeuroWepsDetonatePhysics()
			self:MissileDoExplosion()
			
		end 
		
	end 

end 


