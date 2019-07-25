AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sound = "ah64fire.wav"
ENT.Model = "models/ac-130/gatling.mdl"
ENT.MaxDamage = 100
ENT.MinDamage = 30
ENT.BlastRadius = 1524
 
function ENT:Initialize()

	self.Entity:SetModel( self.Model )
	self.Entity:SetVar('DoAttack',CurTime())
	self.Entity:PhysicsInit( SOLID_NONE )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )	
	self.Entity:SetSolid( SOLID_NONE )
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.Damage = self.Damage or 55
	
	local seed = math.random( 0, 1000 )
	self.guid = tostring( CurTime() - seed )..self:EntIndex( )
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		
	end
	
	if self.Entity:GetOwner() == nil then
		
		return

	end
	
	self.Owner = self.Entity:GetOwner()
	
	self.Entity:SetPhysicsAttacker(self.Owner)

end

function ENT:LerpAim(Target, i)

	if ( Target == nil ) then

		return

	end
	
	if (!Target:IsValid()) then
			
		return
		
	end
	
	local a = self:GetPos() 
	local b = Target:GetPos() 
	local c = Vector( a.x - b.x, a.y - b.y, a.z - b.z )
	local e = math.sqrt( ( c.x ^ 2 ) + ( c.y ^ 2 ) + (c.z ^ 2 ) ) 
	local target = Vector( -( c.x / e ), -( c.y / e ), -( c.z / e ) )
	
	if( i == 0 ) then
		
		self:SetAngles( target:Angle() )
		
	else
	
		self:SetAngles( LerpAngle( 0.001, target:Angle(), self:GetAngles() ) )
	
	end
	
end

function ENT:FireTurret( i )

	if ( !self ) then // silly timer errors.
		
		return
		
	end
	
	
	local sm = EffectData()
	sm:SetStart( self:GetPos() )
	sm:SetOrigin( self:GetPos() )
	sm:SetScale( 10.5 )
	util.Effect( "a10_muzzlesmoke", sm )
	ParticleEffect( "AA_muzzleflash", self:GetPos() + self:GetForward() * 90,  self:GetAngles(), self )
	
 	local bullet = {} 
 	bullet.Num 		= math.random(2,5)
 	bullet.Src 		= self:GetPos() + self:GetForward() * 90
 	bullet.Dir 		= self:GetAngles():Forward()			// Dir of bullet 
 	bullet.Spread 	= Vector( 0, 0, 0 )						// Aim Cone 
 	bullet.Tracer	= math.random( 1, 2 )					// Show a tracer on every x bullets  
 	bullet.Force	= 5					 					// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 20, 35 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer" 
 	bullet.Callback    = function ( a, b, c ) self:HackWall( a, b, c ) end 
 	
	self:FireBullets( bullet ) 
	
	self:GetOwner():PlayWorldSound( self.Sound )
	
	self:EmitSound( self.Sound, 511, math.random( 65, 71 ) )
	
	local sm = EffectData()
	sm:SetStart( self:GetPos() + self:GetForward() * 90 )
	sm:SetScale(0.8)
	util.Effect( "Launch2", sm )

	if ( i >= self.BurstSize ) then
		
		if ( DEBUG ) then
			print("Attack Sequence Completed")
		end
		
		self.ShouldAttack = false
	
	end
	
end

function ENT:HackWall(a,b,c)

	local ang = ( self:GetPos() - b.HitPos ):GetNormalized()
 	local bullet = {} 
 	bullet.Num 		= math.random(2,5)
 	bullet.Src 		= b.HitPos + ang * -64
 	bullet.Dir 		= self:GetAngles():Forward()			// Dir of bullet 
 	bullet.Spread 	= Vector( .5, .5, .5 )			// Aim Cone 
 	bullet.Tracer	= math.random( 1, 2 )					// Show a tracer on every x bullets  
 	bullet.Force	= 5					 					// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 20, 35 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer" 
 	bullet.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 
 	self:FireBullets( bullet ) 

	return { damage = true, effects = DoDefaultEffect } 
	
end

function ENT:ExplosiveShellCallback(a,b,c)

	local info = DamageInfo( )  
		info:SetDamageType( DMG_NEVERGIB )  
		info:SetDamagePosition( b.HitPos )  
		info:SetMaxDamage( self.MaxDamage )  
		info:SetDamage( self.MinDamage )  
		info:SetAttacker( self:GetOwner( ) )  
		info:SetInflictor( self:GetOwner( ) )  

		
	ParticleEffect( "30cal_impact", b.HitPos, ( b.HitPos - b.HitNormal ):Angle(), nil )
	
	util.BlastDamage( self:GetOwner(), self:GetOwner(), b.HitPos, 500, 8 )  
	

	return { damage = true, effects = DoDefaultEffect } 
	

end

function ENT:ProtectPlane() // Shoot at incoming missiles :D	
	
	for k, v in pairs( ents.GetAll() ) do
		
		local logic = ( string.find( v:GetClass(), "missile" ) != nil || 
						string.find( v:GetClass(), "rocket" ) != nil ||
						string.find( v:GetClass(), "rpg" ) != nil ||
						string.find( v:GetClass(), "homing" ) != nil )
		local filter = { "weapon_rpg" }
		
		local filterlogic = !table.HasValue( filter, v:GetClass() )
		
		if ( v:GetPos():Distance( self:GetPos() ) < 5000 && logic && filterlogic ) then
			
			local ta = ( self:GetOwner():GetPos() - v:GetPos() ):Angle()
			local ma = self:GetOwner():GetAngles()
			local offs = self:VecAngD( ma.y, ta.y )
			
			if ( offs >= 40 && offs <= 100 ) then
				
				self:LerpAim( v, 1337 )
				
				if( math.random( 1, 3 ) == 3 ) then
				
					self:FireTurret( 1 )
					
				end
				
			end
			
		end
	
	end
	
end

function ENT:Think()
	
	//self:ProtectPlane()
	
	local selfpos = self.Entity:GetPos()
	local forward = self.Entity:GetForward()
	local entities = ents.FindInSphere(selfpos,2400)
	self.BurstSize = math.random(10,20)
	if( self.ShouldAttack && self.Target ) then
		// Aimbot!!
		self.Entity:LerpAim( self.Target, 0 )

		for i = 1, self.BurstSize do
		
			local x=i/10
			
			if( self ) then
			
				self.Damage = math.random( 35, 65 )
				timer.Create( tostring(self.guid)..i, x, 1, function() if( IsValid( self ) ) then self:FireTurret( i ) end end )
				
			end
			
		end
		
	end

	
end

function ENT:OnRemove()
	
	for i=1, self.BurstSize do
		
		timer.Destroy( tostring(self.guid)..i )
		
	end
	
end

