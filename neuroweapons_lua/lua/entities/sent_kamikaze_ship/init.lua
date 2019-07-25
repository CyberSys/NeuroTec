AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
ENT.Sauce = 5000

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 180,0)
	local ent = ents.Create( "sent_kamikaze_ship" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( ply:GetAngles() )
	ent:Spawn()
	ent:Activate()
	ent:SetSkin( math.random(1,4 ) )
	
--	construct.SetPhysProp( ply, ent, 0, nil,  { GravityToggle = true, Material = "rubber" } )  //useless because static
	
	return ent
	
end

function ENT:Initialize()

	self:SetModel( "models/sillirion/kamikazeboat.mdl" )	
	
	self.seed = math.random( 0, 1000 )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.Owner = self:GetOwner() or self

	self.PhysObj = self:GetPhysicsObject()
	
	if (self.PhysObj:IsValid()) then

		self.PhysObj:EnableGravity( true )
		--self.PhysObj:SetMass( 2000 )
		self.PhysObj:SetBuoyancyRatio( 0.3 ) --Don't mess with this value or I will find you and stab you with a spork.
		self.PhysObj:EnableDrag( true )
		self.PhysObj:Wake()
			
    self.KeepUp = ents.Create("prop_physics")
    self.KeepUp:SetModel("models/props_borealis/bluebarrel001.mdl")
    self.KeepUp:SetPos( self:GetPos() + Vector( 0, 0, 30 ) )
    self.KeepUp:SetAngles(self:GetAngles())
    self.KeepUp:Spawn()
	self.KeepUp:SetSolid( SOLID_NONE )
	self.KeepUp:SetRenderMode( RENDERMODE_TRANSALPHA )
    self.KeepUp:SetColor(0, 0, 0)
    self.KeepUp:Activate()
		
	self.PhysObjB = self.KeepUp:GetPhysicsObject()
	
	if ( self.PhysObjB:IsValid() ) then
		
		self.PhysObjB:SetMass( 300 )
		
	end
		
local weld = constraint.Weld( self.KeepUp, self, 0, 0, 0, true )
local keepup = constraint.Keepupright( self.KeepUp, Angle( 0,0,0 ), 0, 99999999999999999 )

	end

end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > 50 && data.DeltaTime > 0.2 ) then 
	

		self:Remove()
	
	end
	
end

local function apr(a,b,c)

	local z = math.AngleDifference( b, a )
	
	return math.Approach( a, a + z, c )
	
end

function ENT:PhysicsUpdate()

	
	if ( IsValid( self.Target ) ) then 
				
		local dir = ( self.Target:GetPos() - self:GetPos() ):Angle()
		local d = self:GetPos():Distance( self.Target:GetPos() )
		local a = self:GetAngles()
		a.p, a.r, a.y = apr( a.p, 0, 2.4 ),apr( a.r, dir.r, 4 ),apr( a.y, dir.y, 4.0 )

		if( self:WaterLevel() > 0	) then
			self:SetAngles( a )
		end
	
	else

			for k,v in pairs( ents.FindInSphere(self:GetPos(), 15000 ) ) do 

				if( v.IsMicroCruiser && !v.IsMicroSubmarine ) then
				
				if( v != self.Owner ) then
				
					self.Target = v
				
				end
				
				return
				
			end
			
		
		end
		
		
	end
	
	if( self:WaterLevel() > 0	) then

		if( self.Sauce > 0 ) then
			
			self.PhysObj:SetVelocity( self:GetForward() * 150 )
			self.Sauce = self.Sauce - 1
	
		end
			
	end
end

function ENT:Think()
	
	if ( IsValid( self.Target ) ) then 
	
		local a = self:GetPos()
		local ta = ( self.Target:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		local offs = self:VecAngD( ma.y, ta.y )	
		
		if ( offs > -85 && offs < 85 ) then
			
			// Nothing, we can still hit.
			
		else
			
			// Can't locate enemy so we clear the target and the rocket sails away.
			self.Target = nil
		
		end
	
	end
	
	//self:EmitSound("Missile.Accelerate")
	
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 300 ) ) do
	
		if ( v && IsValid( v ) && v == self.Target && v:GetClass() != self:GetClass() ) then
			

			self:Remove()
			
			return
			
		end
		
	end 
	
end 

function ENT:OnRemove()
	 self.KeepUp:Remove()
	if( self:WaterLevel() > 0 ) then
			
		ParticleEffect( "water_impact_big", self:GetPos(),self:GetAngles(), nil )

	end
	
	local e = EffectData()
	e:SetOrigin( self:GetPos() )
	util.Effect( "Explosion", e )
	
	util.BlastDamage( self, self, self:GetPos(), 750, math.random(750,2500) )
	
	self:EmitSound("lockon/ExplodeWater.mp3",300,100)
	
end
