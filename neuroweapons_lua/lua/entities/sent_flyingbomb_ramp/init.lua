AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Ammo = "sent_flying_bomb"


function ENT:SpawnFunction( ply, tr)
	if ( !tr.Hit ) then return end
	self.Ply = ply
	local trhp = tr.HitPos + tr.HitNormal * 32
	local ent = ents.Create( "sent_flyingbomb_ramp" )
	ent:SetPos( trhp)
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
self.Entity:SetVar( 'TLaunch', CurTime() )
	self.Entity:SetModel( "models/ukulele/props_v1_flying_bomb/v1_flying_bomb_ramp_destroyed_gib.mdl" )
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )	
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.bomb = ents.Create("prop_physics")
	self.bomb:SetAngles(self.Entity:GetAngles())
	self.bomb:SetPos(self.Entity:GetPos())
	self.bomb:SetParent(self.Entity)
	self.bomb:SetModel("models/ukulele/props_v1_flying_bomb/v1_flying_bomb.mdl")
	self.bomb:Spawn()
	self.PhysObj = self.Entity:GetPhysicsObject()
	if (self.PhysObj:IsValid()) then
		self.PhysObj:Wake()
		self.PhysObj:EnableGravity(false)
	end
end

function ENT:PhysicsUpdate()
return true
end

function ENT:Use( activator, caller )
end

local function apr(a,b,c)
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end

function ENT:LerpAim(Target)

	if ( !IsValid( Target ) ) then

		return

	end

			
	local pos = Target:GetPos()
	local mp = self:GetPos()
	
	local dir = ( pos - mp ):Angle()
	local a = self:GetAngles()
	a.p, a.r, a.y = apr( a.p, dir.p, 4.5 ),apr( a.r, dir.r, 4.5 ),apr( a.y, dir.y, 4.5 )
	
	self:SetAngles( a )
		
end

function ENT:Think()
for k,v in pairs(ents.FindInSphere(self.Entity:GetPos(),8048)) do
if ( v:IsNPC() || v.HealthVal != nil || v:GetNetworkedEntity("Pilot") ) then
if v:OnGround() && (self.Entity:GetPos() - v:GetPos()):Length() > 1048 then
		self.Target = v
		self.Entity:LerpAim(v)
		end
	local tr={}
	tr.start=self.Entity:GetPos()+self.Entity:GetForward()*128
	tr.endpos=self.Entity:GetForward()*600000000
	tr.filter=self.Entity
	local trace=util.TraceLine(tr)
		if (trace.Hit) then
		local entz = {}
			for k,v in pairs(ents.FindInSphere(trace.HitPos,512)) do
				-- table.insert(entz,v)
					-- local tNum = table.Count(entz)
						-- if tNum > 1 then
						

							local TSlaunch = self.Entity:GetVar('TLaunch', 0)
							if (TSlaunch + 10) > CurTime() then return end
							
							self.Entity:SetVar( 'TLaunch', CurTime() )
							self.Projectile = ents.Create(self.Ammo)
							self.Projectile:SetPos(self.Entity:GetPos()+self.Entity:GetForward()*64 +self.Entity:GetUp()*50)
							self.Projectile.Target = trace.Entity
							self.Projectile:SetAngles(self.Entity:GetAngles())
							self.Projectile.Offset = self.Entity:GetPos():Distance(trace.HitPos) / 1.5
							self.Projectile.TargetPos = trace.HitPos
							self.Projectile.LaunchPos = self.Entity:GetPos()
							self.Projectile:SetOwner(self.Entity)
							self.Projectile:SetOwner(self.bomb)
							self.Projectile:Spawn()
							

							
				-- end
				end
			end
		end
	end
end
-- end
function ENT:OnRemove()
end

