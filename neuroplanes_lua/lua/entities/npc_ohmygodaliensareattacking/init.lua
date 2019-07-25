AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.HealthVal = 8000
ENT.Target = nil
ENT.MaxGDistance = 0
ENT.DeathTimer = 0
ENT.Destroyed = false
ENT.Burning = false

ENT.LagCompensate = 450
ENT.Velocity = 700
ENT.VelocityMod = 100
ENT.VelocityMult = 300
ENT.MinVelocity = 800
ENT.MaxVelocity = 2000

ENT.Mod = 1

ENT.Aliens = {}

local CrashDebris = {
					{"models/apgb/helicopter_brokenpiece_01.mdl"};
					{"models/apgb/helicopter_brokenpiece_02.mdl"};
					{"models/apgb/helicopter_brokenpiece_03.mdl"};
					{"models/apgb/helicopter_brokenpiece_04_cockpit.mdl"};
					{"models/apgb/helicopter_brokenpiece_05_tailfan.mdl"};
					{"models/apgb/helicopter_brokenpiece_06_body.mdl"};
					}



function ENT:Precache()

	for k,v in pairs(CrashDebris) do

		util.PrecacheModel(tostring(v))
		
	end

end

function ENT:IsOverWater()

	local trace,tr = {},{}
	trace.start = self:GetPos()
	trace.endpos = trace.start + self:GetUp() * -10000
	trace.mask = MASK_SOLID
	trace.filter = { self, self.wep  }
	tr = util.TraceEntity( trace, self )
	
	if ( tr.Hit && tr.MatType == 78 ) then // Hit water
	
		return true
		
	end
	
	return false
	
end

function ENT:Initialize()
	
    self:SetModel( "models/ufo/ufo.mdl" )		
    self.Entity:PhysicsInit( SOLID_VPHYSICS )  	
    self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
    self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetHullType( HULL_LARGE )	
    self:SetHealth(self.HealthVal)	
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.HealthVal)
	
	self.LastSweep = CurTime()
	self.LastAlienAttack = CurTime()
	
	self.MaxGDistance = math.random(700,1300)

	self.LolBall = ents.Create("prop_physics_override")
	self.LolBall:SetModel("models/combine_helicopter/helicopter_bomb01.mdl")
	self.LolBall:SetMaterial("debug/env_cubemap_model")
	self.LolBall:SetPos( self:GetPos() + self:GetUp() * 200 )
	self.LolBall:SetOwner( self )
	self.LolBall:SetParent( self )
	self.LolBall:SetSolid( SOLID_NONE )
	self.LolBall:Spawn()
	
	self.Seed = math.random( 0, 1000 )
	
	self.LaserSound = CreateSound( self, Sound("ambient/energy/force_Field_loop1.wav") )
	self.LoopSound = CreateSound( self, Sound("npc/combine_gunship/gunship_engine_loop3.wav") )
	self.LoopSound:PlayEx(511,70)
	self.LoopSound:SetSoundLevel(511)
	
	self.CycleTarget = ents.Create("sent_neurotarget")
	self.CycleTarget.Owner = self
	self.CycleTarget:SetPos(self:GetPos()+Vector(1024,1024,1024))
	self.CycleTarget:Activate()
	self.CycleTarget:Spawn()
	
	self.Ai_sound = ents.Create("ai_sound")
	self.Ai_sound:SetPos( self:GetPos() )
	self.Ai_sound:SetParent( self )
	self.Ai_sound:SetKeyValue("soundtype","8")
	self.Ai_sound:SetKeyValue("volume","700")
	self.Ai_sound:SetKeyValue("duration","1")
	self.Ai_sound:Spawn()
	
	
	self.PhysObj = self:GetPhysicsObject()  	
	
	if ( self.PhysObj:IsValid() ) then 		
	
		self.PhysObj:Wake()  
		self.PhysObj:EnableGravity( false )
		self.PhysObj:EnableDrag( true )
		
	end 
	
end

local function death(ent)

	if (ent == nil) then
		
		return

	end
	
	local explo = EffectData()
	explo:SetOrigin(ent:GetPos())
	util.Effect("Explosion", explo)
	
end

function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed == true ) then
			
		return
	
	end
	
	local fx = EffectData()
	fx:SetEntity( self )
	util.Effect("propspawn", fx )
	
	self:TakePhysicsDamage(dmginfo)
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	
	if ( self.HealthVal < 200 && self.Burning == false ) then
		
		self.Burning = true
		self:EmitSound("npc/combine_gunship/gunship_crashing1.wav",511,80)
	end
	
	if ( self.HealthVal < 5 ) then
	
		self.Destroyed = true
		self.PhysObj:SetMass( 2000 )
		self:Ignite( 60, 100 )
	
		for i = 1, 10 do
		
			local vx = i / 2
			timer.Simple( vx, function() death( self ) end )
			
		end
		
		self.LoopSound:Stop()
		
	end
	
	if ( self.Target == self.CycleTarget ) then
	
		self.Target = dmginfo:GetInflictor()
		
	end
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if ( self.Destroyed ) then
		
		self:DeathFXSpecial()
	
	end
	
	if ( data.HitEntity:GetClass() == "prop_combine_ball" ) then
	
		local fx =EffectData()
		fx:SetOrigin( data.HitPos )
		fx:SetEntity( data.HitEntity )
		fx:SetStart( data.HitPos )
		fx:SetScale( 4 )
		util.Effect( "CballExplode", fx )
		data.HitEntity:Remove()
	
	end
	
end

function ENT:PhysicsSimulate( pobj, delta )

	pobj:Wake()
	local CSC = {}
	CSC.secondstoarrive	= 0.1
	CSC.pos					= self.PhysObj:GetPos()+self:GetForward()*self.LagCompensate+100
	CSC.angle				= (self.PhysObj:GetPos() - self.Target:GetPos()):Angle()
	CSC.maxangular			= 50000
	CSC.maxangulardamp		= 9000
	CSC.maxspeed			= 1000000
	CSC.maxspeeddamp		= 1000
	CSC.dampfactor			= 0.5
	CSC.teleportdistance	= 6000
	CSC.deltatime			= delta
	pobj:ComputeShadowControl(pr)
	
end

function ENT:IncreaseVelocity()

	if(self.Velocity > self.MaxVelocity) then
	
		self.Velocity = self.MaxVelocity
	
	end
	
	self.Velocity = self.Velocity + self.VelocityMod
	self:GetPhysicsObject():ApplyForceCenter( self.gNormal * (self.Velocity * self.VelocityMult) * self.Mod)
	
end

function ENT:DecreaseVelocity()
	
	if(self.Velocity < self.MinVelocity) then
	
		self.Velocity = self.MinVelocity
		
	end
	
	self.Velocity = self.Velocity - self.VelocityMod
	self:GetPhysicsObject():ApplyForceCenter(self.gNormal * (self.Velocity * self.VelocityMult) * self.Mod)
	
end

function ENT:ScanForEnemiesSpecial()
	
	local Ai_ignoreplayers = GetConVarNumber("ai_ignoreplayers") > 0 // hurr durr testers wanted this.
	local dist = dist or 105000
	local tempd = tempd or 0
	local t = t or self.CycleTarget
	local plrLogic
	
	for k,v in pairs( ents.GetAll() ) do
	
		if ( Ai_ignoreplayers ) then
		
			plrLogic = !v:IsPlayer()
		
		else
		
			plrLogic = v:IsPlayer()
		
		end
		
		if ( v != self && v:GetClass() != self:GetClass() && v:GetClass() != "npc_missile_homer" && v:GetClass() != "npc_vortigaunt" && self:Visible( v ) ) then
		
			if ( v:IsNPC() || plrLogic || ( v:IsVehicle() && v:GetVelocity():Length() > 10 ) || string.find( v:GetClass(), "npc_" ) != nil )  then
			
				if( v.Destroyed ) then 
				
					return 
				
				end
				
				tempd = self:GetPos():Distance( v:GetPos() )
				if ( tempd < dist && v.Coldblooded != true ) then
					
					dist = tempd
					t = v
					
				end
				
				self.Target = t
				
			end
			
		end
		
		if ( !IsValid( self.Target ) ) then //better safe than sorry
		
			self.Target = self.CycleTarget
			
		end
		
	end
	
end

function ENT:SweepGround()
	
	local doBeam = false
	local count = 0
	//local enemies = {}
	local trace,tr = {}, {}
	tr.start = self:GetPos()
	tr.endpos = tr.start + self:GetUp() * -8096
	tr.filter = self 
	tr.mask = MASK_SOLID
	trace = util.TraceLine( tr )
	
	if ( trace.Hit ) then
		
		for k,v in pairs( ents.GetAll() ) do
			
			if ( v:IsPlayer() || v:IsNPC() && v:GetClass() != self:GetClass() ) then
				
				if ( v:GetPos():Distance( trace.HitPos ) < 512 && v:OnGround() && v:GetClass() != "npc_vortigaunt" ) then
					
					count = count + 1
					//enemies[count] = v
					/*local fx = EffectData()
					fx:SetOrigin( v:GetPos() )
					util.Effect("ohmygodaliens",fx )*/
				
				end
			
			end
			
		end
	
	end
	//print(count)
	if ( count > 0 ) then
	
		self.DoLaser = true
		self.Ai_sound:SetPos( trace.HitPos + Vector(0,0,72) )
		self.Ai_sound:Fire("EmitAISound","",0)
		
	else
	
		self.DoLaser = false
	
	end
	
	self.LastSweep = CurTime()
	
end

function ENT:MissileDefense()
	
	for k,v in pairs( ents.GetAll() ) do
	
		if ( v:GetPos():Distance( self:GetPos() ) < 3500 && v:GetOwner() != self && v:GetClass() != self:GetClass() && v:GetClass() != "weapon_rpg" ) then
			
			if( string.find( v:GetClass(), "missile") 		 != nil || 
				string.find( v:GetClass(), "rocket" ) 		 != nil || 
				string.find( v:GetClass(), "homing" )		 != nil || 
				string.find( v:GetClass(), "heatseaking" )	 != nil || 
				string.find( v:GetClass(), "stinger" ) 		 != nil || 
				string.find( v:GetClass(), "rpg" ) 			 != nil ) then
					
					
				for i=1,8 do
					local fx = EffectData()
					fx:SetOrigin( v:GetPos() + v:GetRight() * math.sin(CurTime() + (i * 10))*64 + v:GetUp() * math.cos(CurTime()+ (i * 10))*64 )
					fx:SetStart( self.LolBall:GetPos() )
					util.Effect("TraceBeam", fx )
				end
				
				local fx2 = EffectData()
				fx2:SetOrigin( self.LolBall:GetPos() )
				fx2:SetStart( self.LolBall:GetPos() )
				fx2:SetEntity( self.LolBall )
				
				util.BlastDamage( self, self, v:GetPos(), 128, 100 )
				
				if ( math.random( 1, 10 ) > 9 ) then
				
					self.LolBall:EmitSound("ambient/machines/thumper_startup1.wav",511,100)
					v:EmitSound("ambient/energy/whiteflash.wav",511,math.random(95,105))
					v:ExplosionImproved()
					v:Remove()
					
				end
				
			end
			
		elseif( v != self && v:GetClass() == self:GetClass() && v:GetPos():Distance( self:GetPos() ) < 2500 ) then
		
			self:GetPhysicsObject():ApplyForceCenter( ( self:GetPos() - v:GetPos() ):Normalize() * 15000 ) // Scatter If we're too close to a friend
			
		end
		
	end

end

function ENT:PhysicsUpdate()
	

end

function ENT:DealBeamDamage( damage, pos )
	
	local info = DamageInfo( )  
	info:SetDamageType( DMG_DISSOLVE )  
	info:SetDamagePosition( pos )  
	info:SetMaxDamage( damage )  
	info:SetDamage( damage )  
	info:SetAttacker( self )  
	info:SetInflictor( self )  

	for k, v in ipairs( ents.GetAll( ) ) do  
		
		if ( IsValid( v ) && v:Health( ) > 0 && v:GetClass() != self:GetClass() && v:GetClass() != "npc_vortigaunt" ) then  
			
			local p = v:GetPos( )  
			
			if ( p:Distance( pos) <= 128 ) then  
			
				if ( v:VisibleVec( pos ) ) then
				
					info:SetDamage( damage * ( 1 - p:Distance( pos ) / 128 ) )  
					info:SetDamageForce( ( p - pos ):GetNormalized( ) * 10 )  
					v:TakeDamageInfo( info )  
					
				end
				
			end 
			
		end  

	end  
end

function ENT:SpawnInvaders()

		for i=1,math.random(3,5) do
			
			local trace,tr = {},{}
			tr.start = self:GetPos()
			tr.endpos = tr.start + self:GetUp() * -8000 +  Vector(math.random(-300,300),math.random(-300,300),0)
			tr.filter = { self, self.LolBall }
			tr.mask = MASK_SOLID
			trace = util.TraceLine( tr )
			
			if ( trace.Hit ) then
				
				for i=1, 5 do
				
					local fx = EffectData()
					fx:SetOrigin( trace.HitPos + Vector(math.random(-128,128),math.random(-128,128),0) )
					fx:SetStart( trace.HitPos + Vector(math.random(-128,128),math.random(-128,128),0) )
					fx:SetNormal( trace.HitNormal )
					fx:SetScale( 3.0 )
					util.Effect( "VortDispel", fx )
					
				end
				
				//self:EmitSound("npc/vort/attack_shoot.wav",511,math.random(90,100))
				
				//print("hitworld "..i)
				self.Aliens[i] = ents.Create("npc_vortigaunt")
				self.Aliens[i]:SetPos( trace.HitPos + Vector(math.random(-256,256),math.random(-128,128), 72 ) )
				self.Aliens[i]:SetAngles( Angle( 0, 180 / i, 0 ) )
				self.Aliens[i]:SetHealth(1200)
				self.Aliens[i]:Spawn()
				self.Aliens[i]:Activate()
				self.Aliens[i]:Fire("SetRelationship","player D_HT 9999",0) // Don't hate the player, hate the game D:
				self.Aliens[i]:Fire("SetRelationship",tostring(self.Target:GetClass()).." D_HT 9999",0)
				self.Aliens[i]:Fire("ChargeTarget",tostring(self.Target:GetClass()),0)
				self.Aliens[i]:Fire("kill","",30)
				
				local afx = EffectData()
				afx:SetEntity( self.Aliens[i] )
				util.Effect( "propspawn", afx )
				
				self.Aliens[i]:EmitSound("npc/vort/attack_shoot.wav",511,math.random(90,100))
				
		
		end
		
	end

end


function ENT:Think()

	if ( self.Destroyed == true ) then 
	
		local effectdata = EffectData()
		effectdata:SetOrigin( self.PhysObj:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		
		self.DeathTimer = self.DeathTimer + 1
		if( !self.YawSpeed ) then self.YawSpeed = 0 end
		
		local prevel = self.PhysObj:GetVelocity()
		self.mAng2 = Angle( 0, self:GetPhysicsObject():GetAngles().y+3.6, 0 )
		self.PhysObj:SetAngles(self.mAng2+Angle(math.sin(CurTime())*7,self.YawSpeed,0)) 
		self.PhysObj:SetVelocity(prevel)
		self.PhysObj:ApplyForceCenter(self:GetUp()*58000)
		self.PhysObj:ApplyForceCenter(self:GetRight()*40000)
		self.PhysObj:ApplyForceCenter(self:GetForward()*-15000)
		
		if ( self.DeathTimer > 105 ) then
			
			self:DeathFXSpecial()
			
		end
		
		return 
		
	end
	
	local tr,trace = {},{}
	tr.start = self:GetPos()
	tr.endpos = tr.start + Vector(0,0,1) * -8096
	tr.filter = { self, self.LolBall }
	tr.mask = MASK_WORLD
	trace = util.TraceLine( tr )
	
	if ( self.DoLaser && trace.Hit ) then
	
		local fx2 = EffectData()
		fx2:SetOrigin( trace.HitPos )
		fx2:SetScale( 0.5 )
		util.Effect( "AlienBeamSparks", fx2 )
		
		self:SetNetworkedBool("DrawLaserBeams", true )
		
		timer.Simple( 20, function() 
			
			if( IsValid( self ) ) then
				
				self:SetNetworkedBool("DrawLaserBeams", false )
				
			end
			
		end )
		
		self.LaserSound:PlayEx( 1.0, 100 )
		
		local pos = {}
		local pos2 = {}
		
		for i = 1, 36 do
			
			pos[i] = self:GetPos() + self:GetUp() * 32
			pos[i].x = pos[i].x + math.sin( CurTime() - ( i * 10 ) ) * 25
			pos[i].y = pos[i].y + math.cos( CurTime() - ( i * 10 ) ) * 25
			
			pos2[i] = trace.HitPos + Vector( 0,0,0 -400 )
			pos2[i].x = pos2[i].x + math.sin( CurTime() - ( i * 10 ) ) * 256
			pos2[i].y = pos2[i].y + math.cos( CurTime() - ( i * 10 ) ) * 256
			
			local tr,trace = {},{}
			tr.start = pos[i]
			tr.endpos = pos2[i]
			tr.filter = { self, self.LolBall }
			tr.mask = MASK_WORLD
			trace = util.TraceLine( tr )
			
			local fx = EffectData()
			fx:SetStart(  pos[i] )
			fx:SetOrigin( trace.HitPos )
			util.Effect( "TraceBeam", fx )
			
		end
		
		if ( self.LastAlienAttack + 30 < CurTime() ) then
		
			self.LastAlienAttack = CurTime()
			self:SpawnInvaders()
	
		end
		
	else
	
		
		self.LaserSound:Stop()
	
	end


	self:ScanForEnemiesSpecial()

	self:MissileDefense()
	self:NextThink( CurTime() + 0.005 )
	
	self.LoopSound:ChangePitch( 90 + math.sin(CurTime()-1000 ) * 20, 0.001 )
	self.LagCompensate = math.floor( self:GetPhysicsObject():GetVelocity():Length() / 2 + 100 )
	
	self.gVec = ( self.Target:GetPos() - self.PhysObj:GetPos() + Vector( 0, 0, 256 ) )
	self.gNormal = self.gVec:Normalize()
	self.tarDist = self:GetPos():Distance( self.Target:GetPos() )
	
	local a = self:GetAngles()
	self.mVel = self.PhysObj:GetVelocity()
	self.PhysObj:SetAngles( Angle( 0, a.y + 3.6, 0 ) )
	self.PhysObj:SetVelocity( self.mVel )
	
	if( self.LastSweep + 5 <= CurTime() ) then
		
		self:SweepGround()
		
	end
	/*
	for i = 1, 5 do
	
		local pos = self:GetPos()
		pos.x = pos.x + math.sin(CurTime() - self.Seed + i * 10 ) * 230
		pos.y = pos.y + math.cos(CurTime() - self.Seed + i * 10 ) * 230
		pos.z = pos.z + 48
		local fx = EffectData()
		fx:SetOrigin( pos )
		fx:SetEntity( self )
		util.Effect("ohmygodaliens", fx )
	
	end
	*/
	
	if( self.gNormal ) then
	
		if self.tarDist > 2500 then
		
			self:IncreaseVelocity()
			
		elseif ( self.tarDist < 2500 && self.tarDist > 300 ) then
			
			self:DecreaseVelocity()
			
		end
	
	end
	
	local p = self:GetPos()
	local f = self:GetForward()
	local u = self:GetUp()
	local r = self:GetRight()
	
	local tpos = {
				 { start = p, endpos = p + u * -self.MaxGDistance };
				 { start = p, endpos = p + f * ( 500 + ( self:GetVelocity():Length() * 2 ) ) };
				 { start = p, endpos = p + f * -600 };
				 { start = p, endpos = p + r * -600 };
				 { start = p, endpos = p + r * 600 };
				 }
	
	local tr = {}
	local _Filter = { self, self.LolBall }
	local i = 0
	
	for k,v in pairs( tpos ) do
	
		i = i + 1
		v.filter = _Filter
		v.mask = {MASK_SOLID , MASK_WATER }
		tr[i] = util.TraceEntity( v, self )
		
	end
	
	// Cheap Collision Detection & Hackfix to avoid crashing into stuff.
	if ( tr[1].Hit ) then
	
		if ( self:GetPos():Distance(tr[1].HitPos) < self.MaxGDistance * 0.8 && self:GetPhysicsObject():GetVelocity():Length() > 60 ) then
		
			self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() / 1.21 )
			
			self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * 10000 )
	
		end
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * ( 45000 - ( tr[1].Fraction * 45000 + ( self:GetVelocity():Length() * 4 ) ) ) )
		
	end
	
	if ( tr[2].Hit ) then //tr2
		
		self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() / 1.25 )
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * 18000 )
		
	end
	
	if ( tr[3].Hit && !tr[2].Hit ) then
	
		self:IncreaseVelocity()
		
	end
	
	if ( tr[4].Hit && !tr[5].Hit ) then
	
		if ( self:GetVelocity():Length() > 85 ) then
		
			self:SetVelocity( self:GetVelocity() / 1.08 )
			
		end
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetRight() * 9000 )
	
	elseif ( tr[5].Hit && !tr[4].Hit ) then
	
		if ( self:GetVelocity():Length() > 85 ) then
		
			self:SetVelocity( self:GetVelocity() / 1.1 )
			
		end	
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetRight() * -9000 )
	
	elseif ( tr[4].Hit && tr[5].Hit ) then
	
		self:SetVelocity( self:GetVelocity() / 1.1 )
	
	end
	
end

function ENT:DeathFXSpecial()

	local explo = EffectData()
	explo:SetOrigin(self.PhysObj:GetPos())
	util.Effect("Explosion", explo)
	
	local f1 = EffectData()
	f1:SetOrigin(self:GetPos())
	util.Effect("immolate",f1)
	
	for i=0,3 do
	
		local explo1 = EffectData()
		explo1:SetOrigin(self.PhysObj:GetPos()+i*self:GetForward()*64)
		explo1:SetScale(7.25)
		util.Effect("HelicopterMegaBomb", explo1)
		
	end

	for k,v in pairs(CrashDebris) do
		
		local cdeb = ents.Create("prop_physics")
		cdeb:SetModel(tostring(v[1]))
		cdeb:SetPos(self.PhysObj:GetPos()+Vector(math.random(-64,64),math.random(-64,64),math.random(128,256)))
		cdeb:SetSolid(6)
		cdeb:Spawn()
		cdeb:Fire("ignite","",0)
		cdeb:Fire("kill","",15)
		
	end
	
	for i=1,2 do
	
		local pilot = ents.Create("prop_ragdoll")
		
		if(i==1) then
		
			pilot:SetModel("models/humans/charple02.mdl")
			
		else
		
			pilot:SetModel("models/humans/charple01.mdl")
			
		end
		
		pilot:SetPos(self:GetPos()+self:GetRight()*math.random(-48,48))
		pilot:Fire("kill","",15)
		pilot:Spawn()
		
	end
	
	implode( self:GetPos(), 128, 512, -600000000 ) // blow away all debris
	
	for i=1,10 do
	
		local fx=EffectData()
		fx:SetOrigin(self.PhysObj:GetPos()+Vector(math.random(-256,256),math.random(-256,256),math.random(-256,256)))
		fx:SetScale(20*i)
		util.Effect("Firecloud",fx)
	
	end
	
	self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav",200,100)
	util.BlastDamage( self, self,self.PhysObj:GetPos(), 1628, 100 )
	
	self:Remove()

end

function ENT:OnRemove()
	
	self.LolBall:ExplosionImproved()
	self.LolBall:Remove()
	self:StopSound("npc/combine_gunship/gunship_engine_loop3.wav")
	self.LoopSound:Stop()
	
end

