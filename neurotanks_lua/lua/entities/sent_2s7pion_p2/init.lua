AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
ENT.BulletDelay = CurTime()

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	local ent = ents.Create( self.FolderName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
	if( self.SkinCount && self.SkinCount > 1 ) then
	
		ent:SetSkin( math.random(1, self.SkinCount ) )
	
	end
	
	return ent
	
end


function ENT:Initialize()
	
	self:TanksDefaultInit()

	self.ArtilleryToggle = true
	self.LandMines = {}
	
	self.LastLandMine = CurTime()
	self.LastSeatChange = CurTime()
	self.LastSmokeTick = CurTime()
	self.LastArtilleryMode = CurTime()
	self.LastLaunch = CurTime() + 1.0
	
	self.ForceVariable = 0
	self.Yaw = 0

	self.Stopper = ents.Create("prop_physics_override")
	self.Stopper:SetModel("models/wic/ground/2s7 pion/2s7 pion_stopper.mdl")
	self.Stopper:SetPos( self:GetPos() + self:GetForward() * -177 + self:GetUp() * 23 )
	self.Stopper:SetParent( self )
	self.Stopper:SetSkin( self:GetSkin() )
	self.Stopper:SetAngles( self:GetAngles() )
	self.Stopper:Spawn()
	self.StopperPhys = self.Stopper:GetPhysicsObject()	
	if ( self.StopperPhys:IsValid() ) then
	
		self.StopperPhys:Wake()
		self.StopperPhys:EnableGravity( true )
		//self.BarrelPhys:EnableDrag( true )
		
	end	
	
	self.SeatPos = { Vector( 129, -24, 57 ), Vector( 129, 24, 57 ) }
	self.Seats = {}
	self.MountedGuns = {}
	
	for i=1,#self.SeatPos do
		
		self.Seats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
		self.Seats[i]:SetPos( self:LocalToWorld( self.SeatPos[i] ) )
		self.Seats[i]:SetModel( "models/nova/jeep_seat.mdl" )
		self.Seats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.Seats[i]:SetKeyValue( "limitview", "60" )
		self.Seats[i].HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
		self.Seats[i]:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
		self.Seats[i]:SetParent( self )
		self.Seats[i]:SetColor(0,0,0,0)
		self.Seats[i]:Spawn()
		self.Seats[i].isChopperGunnerSeat = true
		
		self.MountedGuns[i] = ents.Create( "prop_physics_override" )
		self.MountedGuns[i]:SetPos( self.Seats[i]:LocalToWorld(  Vector( 0, 19, 27 ) ) )
		self.MountedGuns[i]:SetAngles( self:GetAngles() )
		self.MountedGuns[i]:SetModel( "models/weapons/hueym60/m60.mdl"  )
		self.MountedGuns[i]:SetParent( self )
		self.MountedGuns[i]:SetSolid( SOLID_NONE )
		self.MountedGuns[i].LastAttack = CurTime()
		self.MountedGuns[i]:Spawn()
		
		self.Seats[i].MountedWeapon = self.MountedGuns[i]
		
	end

	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 5000000 )
	
	self:StartMotionController()
		
	self.AmmoIndex = 1
	self.AmmoTypes = { 
						
						{
							PrintName = "203MM 2A44 Shell",
							Type = self.PrimaryAmmo,
							MinDmg = self.MinDamage,
							MaxDmg = self.MaxDamage,
							Radius = self.BlastRadius,
							Delay = self.PrimaryDelay,
							Sound = self.ShootSound,
						};
}
end

function ENT:OnTakeDamage(dmginfo)
	
	self:TankDefaultTakeDamage( dmginfo )
	
end

function ENT:OnRemove()
	
	self:TankDefaultRemove()
	
end

function ENT:Use(ply,caller)

	self:TankDefaultUse( ply, caller )
	
end

function ENT:Think()

	self:TankDefaultThink()
	self:NextThink( CurTime() )

	/*
	if NeuroKeys:KeyDown(self.Pilot, 16) then
	print("It works!!!")
	NeuroKeys:KillKey(self.Pilot, 16)
	end
*/
if IsValid(self.Pilot) then	
		if ( self.Pilot:KeyDown( IN_RELOAD ) && self.LastLandMine + 1.5 <= CurTime() ) then			

			
			--//self:ArtilleryStrike()
			self.LastLandMine = CurTime()
			
			local nm = #self.LandMines+1
			
			if( nm < 20 ) then
				
				self.LandMines[nm] = ents.Create("sent_bouncingbetty")
				self.LandMines[nm]:SetPos( self:LocalToWorld( Vector( -48, 0, -5 ) ) )
				self.LandMines[nm]:SetAngles( self:GetAngles() )
				self.LandMines[nm]:SetOwner( self )
				self.LandMines[nm].Owner = self.Pilot
				self.LandMines[nm].Spawner = self.Pilot
				self.LandMines[nm]:SetPhysicsAttacker( self.Pilot )
				self.LandMines[nm]:Spawn()
				
				self:EmitSound( "ambient/machines/catapult_throw.wav", 511, 100 )
				
				local fx = EffectData()
				fx:SetOrigin( self.LandMines[nm]:GetPos() )
				fx:SetStart( self.LandMines[nm]:GetPos() )
				fx:SetNormal( self.LandMines[nm]:GetUp() )
				fx:SetScale( 0.17 )
				util.Effect( "ManhackSparks", fx )
			
			
			end
				

		end

		if ( self.Pilot:KeyDown( IN_JUMP ) ) then
			self:ArtilleryStrike()		
		end
		if ( self.Pilot:KeyDown( IN_ATTACK ) ) then					
			self:PrimaryAttack()
		end

		if ( self.Pilot:KeyDown( IN_ATTACK2 ) && self.LastLaunch <= CurTime() ) then
			
			self.ForceVariable = math.Approach( self.ForceVariable, 100, 1 )
			self.Pilot:PrintMessage( HUD_PRINTCENTER, "Charge: "..self.ForceVariable.."%" )
	
		end

		if(  self.Pilot:KeyReleased( IN_ATTACK2 ) || ( self.ForceVariable > 0 && !self.Pilot:KeyDown( IN_ATTACK2 ) ) || ( self.ForceVariable == 100 ) ) then
			
		
			if( self.ForceVariable > 0 && self.BulletDelay > CurTime() ) then
				
				self.Pilot:PrintMessage( HUD_PRINTCENTER, "Reloading" )
				
				return
				
			end
			
			self.ForceVariable = 0
			self.LastLaunch = CurTime() + 1.0
			//self:SecondaryAttack()		//Not set.
			
			return
			
		end

end
		-- Passenger Seat Swap
		for i=1,#self.Seats do
			
			local dr = self.Seats[i]:GetDriver()
			if( IsValid( dr ) ) then
				
				if( dr:KeyDown( IN_SPEED ) && self.LastSeatChange + 0.5 <= CurTime() ) then
					 
					self.LastSeatChange = CurTime()
				
					for j=1,#self.Seats do 
						
						local dr2 = self.Seats[j]:GetDriver()
						
						if( !IsValid( dr2 ) && self.Seats[i] != self.Seats[j] ) then
							
							dr:ExitVehicle()
							dr:EnterVehicle( self.Seats[j] )
							
							break
							
						end
								
					end
				
					
				end
			
			end
			
		end
			
	-- Passenger Seat Gun controls
	local seat
	local gunner
	local wep
	
	// Gunners
	for i=1,#self.Seats do
	
		seat = self.Seats[i]
		gunner = seat:GetDriver()
		wep = self.MountedGuns[i]
		
		if( IsValid( seat ) && IsValid( gunner ) && IsValid( wep ) ) then
		
			local ang = gunner:EyeAngles()
			
			if ( gunner:KeyDown( IN_ATTACK ) && wep.LastAttack + .0755 <= CurTime() ) then
				
				ang = ang + Angle( math.Rand(-.8,.8), math.Rand(-.8,.8), 0 )
				
				local bullet = {} 
				bullet.Num 		= 1
				bullet.Src 		= wep:GetPos() + wep:GetForward() * 55
				bullet.Dir 		= wep:GetAngles():Forward()					// Dir of bullet 
				bullet.Spread 	= Vector( .03, .03, .03 )				// Aim Cone 
				bullet.Tracer	= 1											// Show a tracer on every x bullets  
				bullet.Force	= 0						 				// Amount of force to give to phys objects 
				bullet.Damage	= math.random( 14, 38 )
				bullet.AmmoType = "Ar2" 
				bullet.TracerName = "Tracer" 
				bullet.Callback = function ( a, b, c )
				
										local effectdata = EffectData()
											effectdata:SetOrigin( b.HitPos )
											effectdata:SetStart( b.HitNormal )
											effectdata:SetNormal( b.HitNormal )
											effectdata:SetMagnitude( 100 )
											effectdata:SetScale( 25 )
											effectdata:SetRadius( 30 )
										util.Effect( "ImpactGunship", effectdata )
										
										util.BlastDamage( gunner, gunner, b.HitPos, 256, 18 )
										
										return { damage = true, effects = DoDefaultEffect } 
										
									end 
									
				wep:FireBullets( bullet )
		        wep:EmitSound( "npc/turret_floor/shoot"..math.random(2,3)..".wav", 511, math.random(40,50) )

				local effectdata = EffectData()
					effectdata:SetStart( wep:GetPos() )
					effectdata:SetOrigin( wep:GetPos() )
				util.Effect( "RifleShellEject", effectdata )  

				local e = EffectData()
					e:SetStart( wep:GetPos()+wep:GetForward() * 62 )
					e:SetOrigin( wep:GetPos()+wep:GetForward() * 62 )
					e:SetEntity( wep )
					e:SetAttachment(1)
				util.Effect( "ChopperMuzzleFlash", e )

				wep.LastAttack = CurTime()
	
			end

			
			wep:SetAngles( ang )
		end
		
	end


	return true
	
end
function ENT:PrimaryAttack()

	if ( !self ) then // silly timer errors.
		
		return
		
	end

		-- local Power
		-- if !self.ArtilleryToggle then
		-- Power = 50000
		-- else Power = 9999999
		-- end
		
		if  ( self.BulletDelay < CurTime() ) then	
	
		self.BulletDelay = CurTime() + 3 //math.random(3,6)

		self:EmitSound( "bf2/tanks/d30_artillery_fire.mp3", 511, math.random( 70, 100 ) )
		self:EmitSound( "bf2/tanks/t-90_reload.wav", 511, math.random( 70, 100 ) )
		self:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * -10000 )
		
		local e1 = EffectData()
		e1:SetStart( self.Barrel:GetPos() + self.Barrel:GetForward() * 410	+ self.Barrel:GetRight() * 5  )
		e1:SetNormal( self.Barrel:GetForward() )
		e1:SetEntity( self.Barrel )
		e1:SetScale( 1.5 )
		util.Effect( "tank_muzzle", e1 )

		-- local Shell = ents.Create( "sent_artillery_shell" )
		local Shell = ents.Create( "sent_gravity_shell" )
		-- Shell.TargetPos = self.Pilot:GetNetworkedVector( "TargetPos", self:GetPos() + self:GetForward()*self.MaxRange )
		Shell.TargetPos = self.Pilot:GetShootPos()
		Shell.MaxRange = self.MaxRange
		Shell:SetModel( "models/weapons/w_missile_launch.mdl" )
		Shell:SetPos( self.Barrel:GetPos() + self.Barrel:GetForward()*self.BarrelLength) 				
		Shell:SetAngles( self.Barrel:GetAngles() )
		Shell:Spawn()
		Shell:Activate() 
		Shell:GetPhysicsObject():Wake()
		Shell:GetPhysicsObject():SetMass( 10 )
		Shell:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * 17000 )
		constraint.NoCollide( Shell, self, 0, 0)	
		constraint.NoCollide( Shell, self.Barrel, 0, 0)	
		
	end


	self:StopSound( "bf2/tanks/d30_artillery_fire.mp3" )
	self:StopSound( "bf2/tanks/t-90_reload.wav" )

end

function ENT:PhysicsUpdate()
	
	if  (GetConVarNumber("tank_artilleryview") != 1 ) then
		if( self.HasTower ) then
		
			self:TankTowerRotation()
		
		else
			
			self:TankNoTowerRotation()
		
		end
	end
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	self:TankHeavyPhysics( phys, deltatime )
	
end

