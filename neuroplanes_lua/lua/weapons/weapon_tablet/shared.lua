SWEP.PrintName 		= "Satellite Tablet"
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
-- SWEP.ViewModel = "models/weapons/v_c4.mdl"
-- SWEP.WorldModel = "models/weapons/w_c4.mdl"
SWEP.ViewModel = "models/weapons/v_binoculars.mdl"
SWEP.WorldModel = "models/weapons/w_binoculars.mdl"
SWEP.Spawnable                = false
SWEP.AdminSpawnable            = false
SWEP.Category                 = "Military Accessories"--"Military Accessories"
SWEP.Instructions	      = "Locate everything!"
SWEP.Purpose =	"Spy, seek and lock"
SWEP.Author		      = "StarChick"
SWEP.Slot =	5
SWEP.SlotPos =	4
SWEP.Drawammo =	false
SWEP.Drawcrosshair =	true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["v_weapon.c4"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["v_weapon.Left_arm"] = { scale = Vector(1, 1, 1), pos = Vector(-4.263, 2.562, -3.401), angle = Angle(0, 0, 0) }
}
SWEP.IronSightsPos = Vector(3.5, 0, 4.5)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.VElements = {
	["tablet"] = { type = "Model", model = "models/nirrti/tablet/tablet.mdl", bone = "v_weapon.Right_Hand", rel = "", pos = Vector(2.144, 0.481, -6.994), angle = Angle(7.157, -114.932, 77.718), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 8, bodygroup = {} }
}
SWEP.WElements = {
	["tablet"] = { type = "Model", model = "models/nirrti/tablet/tablet.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.031, 7.362, 0.381), angle = Angle(90, 0, 15.218), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 8, bodygroup = {} }
}

SWEP.Primary.Clipsize =	-1
SWEP.Primary.DefaultClip =	-1
SWEP.Primary.Automatic =	false
SWEP.Primary.Ammo =	"none"

SWEP.Secondary.Clipsize =	-1
SWEP.Secondary.DefaultClip =	-1
SWEP.Secondary.Automatic =	false
SWEP.Secondary.Ammo =	"none"

local ShootSound =	"bf2/tanks/vehicle_weapon_trigger_click.wav"
local debug = false
local Frozen = false
local LastSatelliteClick = CurTime()
local order = Vector(0,0,0)
local orderR = Vector(0,0,0)
-- other initialize code goes here
if SERVER then
util.AddNetworkString( "SendTargetStream")
util.AddNetworkString( "SendDroneStream")
end

function SWEP:Initialize()

if CLIENT then

	-- self:CreateModels(self.VElements) -- create viewmodels
	-- self:CreateModels(self.WElements) -- create worldmodels

	-- init view model bone build function
	self.BuildViewModelBones = function( s )
		if LocalPlayer():GetActiveWeapon() == self and self.ViewModelBoneMods then
			for k, v in pairs( self.ViewModelBoneMods ) do
			local bone = s:LookupBone(k)
				if (!bone) then continue end
				local m = s:GetBoneMatrix(bone)
				if (!m) then continue end
				m:Scale(v.scale)
				m:Rotate(v.angle)
				m:Translate(v.pos)
				s:SetBoneMatrix(bone, m)
				end
			end
	end

end
end

function SWEP:Deploy()
--	self.VElements["tablet"].skin = 0
--	self.Weapon:Fire("skin",0) 
	self:SendWeaponAnim(ACT_VM_DRAW)
--	self.Owner:Freeze(false)

	local pos =	self.Owner:GetPos()
	
	local SpawnPos = pos + self.Owner:GetForward() * 150 + self.Owner:GetUp() * 20
	local vec = self.Owner:GetAimVector():Angle()
	local newAng = Angle(0,vec.y,0)
	for k,v in pairs(ents.FindByClass("sent_helidrone")) do
		if IsValid(v) and (v:GetOwner() == self.Owner) then
		v:Remove()
		end	
	end
	self.Drone = ents.Create( "sent_helidrone" )
	self.Drone:SetPos( SpawnPos )
	self.Drone:SetAngles( newAng )
	self.Drone:Spawn()
	self.Drone:Activate()
	self.Drone:SetOwner(self.Owner)
	undo.Create("self.Drone")
		undo.AddEntity(self.Drone)
		undo.SetPlayer(self.Owner)
		undo.SetCustomUndoText("Drone destroyed")
	undo.Finish()
	self.Weapon:EmitSound("hk/reboot.wav")
	self.Owner:SetNetworkedVector( "PositionOrder", Vector(0,0,0) )	
	self.Owner:SetNetworkedEntity( "Drone", self.Drone )
	timer.Simple( 1, function() self.Weapon:Fire( "skin",8) end )
	SetGlobalEntity("WeaponScreen_RT", self.Weapon)
-- datastream.StreamToServer( "SendTargetStream", { self.Drone:GetPos() } )
net.Start( "SendTargetStream" )
net.WriteVector( self.Drone:GetPos() )
-- net.SendToServer()
net.Send()
		-- self.Owner:SendLua("RunConsoleCommand( \"target_X\","..self.Drone:GetPos().x..")")
	-- self.Owner:SendLua("RunConsoleCommand( \"target_Y\","..self.Drone:GetPos().y..")")
	-- self.Owner:SendLua("RunConsoleCommand( \"target_Z\","..self.Drone:GetPos().z..")")
	-- self.Owner:SendLua("RunConsoleCommand( \"target_Set\",0")
	-- RunConsoleCommand( "target_X", self.Drone:GetPos().x )
	-- RunConsoleCommand( "target_Y", self.Drone:GetPos().y )
	-- RunConsoleCommand( "target_Z", self.Drone:GetPos().z )
	-- RunConsoleCommand( "target_Set", 0 )
   return true
end
function SWEP:Holster( wep )
	self.Owner:Freeze(false)
--	if IsValid(self.Drone) then
--	self.Drone:Remove()
--	end
	self.Owner:GetViewModel():SetColor( Color( 255,255,255,255 ) )
	return true
end

function SWEP:PrimaryAttack()
	
	if CLIENT then
	
	if debug == true then
		Msg("[PTG]Primary Attack \n")
	end
			local Drone = self.Owner:GetNetworkedEntity( "Drone", self.Owner)
			local pos = Drone:GetPos()
			--local ang2 = self.Owner:GetAimVector()
			local tracedata = {}
			tracedata.start = pos
			tracedata.endpos = pos+Drone:GetUp()*-100000
			tracedata.filter = {self.Owner,Drone,Drone.DroneCam}
			local trace = util.TraceLine(tracedata)
			if trace.HitNonWorld then
				target = trace.Entity
-- datastream.StreamToServer( "SendTargetStream", { target:GetPos() } )

net.Start( "SendTargetStream" )
net.WriteVector( target:GetPos() )
-- net.WriteEntity( target )
-- net.SendToServer()
net.Send()
				-- self.Owner:SendLua("RunConsoleCommand( \"target_X\","..target:GetPos().x..")")
				-- self.Owner:SendLua("RunConsoleCommand( \"target_Y\","..target:GetPos().y..")")
				-- self.Owner:SendLua("RunConsoleCommand( \"target_Z\","..target:GetPos().z..")")
				-- self.Owner:SendLua("RunConsoleCommand( \"target_Set\",1")
				-- RunConsoleCommand( "target_X", target:GetPos().x )
				-- RunConsoleCommand( "target_Y", target:GetPos().y )
				-- RunConsoleCommand( "target_Z", target:GetPos().z )
				-- RunConsoleCommand( "target_Set", 1 )
				self.Owner:SetNetworkedString( "TargetAcquired", "Acquired" )
--				self.Owner:SetNetworkedEntity( "GPSTarget", target )
			else
				target = trace.HitPos
-- datastream.StreamToServer( "SendTargetStream", { target } )
net.Start( "SendTargetStream" )
net.WriteVector( target )
net.SendToServer()
-- net.Send()
				-- self.Owner:SendLua("RunConsoleCommand( \"target_X\","..target.x..")")
				-- self.Owner:SendLua("RunConsoleCommand( \"target_Y\","..target.y..")")
				-- self.Owner:SendLua("RunConsoleCommand( \"target_Z\","..target.z..")")
				-- self.Owner:SendLua("RunConsoleCommand( \"target_Set\",1")
				-- RunConsoleCommand( "target_X", target.x )
				-- RunConsoleCommand( "target_Y", target.y )
				-- RunConsoleCommand( "target_Z", target.z )
				-- RunConsoleCommand( "target_Set", 1 )
				self.Owner:SetNetworkedString( "TargetAcquired", "Nothing" )
--				self.Owner:SetNetworkedVector( "GPSTargetPos", target )			
			end
			self.Weapon:EmitSound("lockon/searchwarning.mp3")
	/* --Teleport
	local trace =	self.Owner:GetEyeTrace()
	trace.HitPos.z = trace.HitPos.z+10
	self.Owner:SetPos(trace.HitPos)
	
	self.Weapon:EmitSound(ShootSound)
	*/
	
	end
	
end
function SWEP:SecondaryAttack()
	if debug == true then
		Msg("[PTG]Secondary Attack \n")
	end
	if (LastSatelliteClick + 0.1 < CurTime() ) then 
		if !Frozen then
			self.Owner:Freeze(true)
			Frozen = true
		self.Weapon:EmitSound("lockon/masterWarning.mp3")
		end
		if Frozen then
			self.Owner:Freeze(false)
			Frozen = false
		end	
	LastSatelliteClick = CurTime()
	end
end

function SWEP:Reload()
	if debug == true then
		Msg("[PTG]Reload \n")
	end
	if (LastSatelliteClick + 0.5 < CurTime() ) then 
	LastSatelliteClick = CurTime()
	--self.Drone.Target = self.Owner
	if (GetConVarNumber("drone_auto", 0 )==0 ) then
		RunConsoleCommand( "drone_auto", 1 )
	elseif (GetConVarNumber("drone_auto", 0 )== 1) then
		RunConsoleCommand( "drone_auto", 2 )
	elseif (GetConVarNumber("drone_auto", 0 )== 2) then
		RunConsoleCommand( "drone_auto", 0 )		
	end
	self.Weapon:EmitSound("lockon/searchwarning.mp3")
	-- RunConsoleCommand( "target_Set", 0 )
	RunConsoleCommand( "target_Set", 1 )
	end
end
function SWEP:FreezeMovement() 
	if Frozen then
		return true
	end 
	return false
end
function SWEP:ContextScreenClick( aimvec, mousecode, pressed, ply )
	local aim = ply:GetAimVector():Angle()
	local ang = ply:GetEyeTrace().Normal:Angle()
--	ply:SetEyeAngles( Angle(0,aim.y,aim.z))
--	local aimvec= Vector(0,0,0)
	if pressed then
		if mousecode == 107 then -- Left click
		aimvec.x =math.Clamp( math.AngleDifference(aim.p, ang.p)/30,-1,1)
		aimvec.y =math.Clamp( math.AngleDifference(aim.y, ang.y)/60,-1,1)
		aimvec.z = 0
--		RunConsoleCommand( "drone_X", aimvec.x )
--		RunConsoleCommand( "drone_Y", aimvec.y )

-- datastream.StreamToServer( "SendDroneStream", { aimvec } )
net.Start( "SendDroneStream" )
net.WriteVector( aimvec )
-- net.SendToServer()
net.Send()
		-- self.Owner:SendLua("RunConsoleCommand( \"drone_orders\","..aimvec.x..","..aimvec.y..",0,0 )")
--		RunConsoleCommand( "drone_orders",aimvec.x,aimvec.y,0,0 )

		order.x,order.y,order.z = aimvec.x,aimvec.y,0
--		self.Owner:SetNetworkedVector( "PositionOrder", aimvec )
		self.Weapon:EmitSound("lockon/lock.mp3")
		elseif mousecode == 108 then -- Right click
		aimvec.x = 0
		aimvec.y = 0
		aimvec.z = math.Clamp( math.AngleDifference(aim.p, ang.p)/30,-1,1)
-- datastream.StreamToServer( "SendDroneStream", { aimvec } )
net.Start( "SendDroneStream" )
net.WriteVector( aimvec )
-- net.SendToServer()
net.Send()
		-- self.Owner:SendLua("RunConsoleCommand( \"drone_orders\",0,0,"..aimvec.z..",0 )")
--		RunConsoleCommand( "drone_orders",0,0,aimvec.z,0 )
		order.x,order.y,order.z = 0,0,aimvec.z
--		RunConsoleCommand( "drone_Z", aimvec.z )
				
		self.Owner:SetNetworkedVector( "PositionOrder", aimvec )
		self.Weapon:EmitSound("lockon/lock.mp3")
		
		elseif mousecode == 109 then -- Middle click
		aimvec.x = 0
		aimvec.y = 0
		aimvec.z =math.Clamp( math.AngleDifference(ang.y, aim.y), -40,40 )		
		orderR.x,orderR.y,orderR.z = 0,0,aimvec.z
-- datastream.StreamToServer( "SendDroneStream", { Vector(0,0,0), aimvec } )
net.Start( "SendDroneStream" )
net.WriteVector( aimvec )
-- net.SendToServer()
net.Send()
		-- self.Owner:SendLua("RunConsoleCommand( \"drone_orders\",0,0,0,"..-aimvec.z.." )")
--		RunConsoleCommand( "drone_orders",0,0,0,aimvec.z )
--		RunConsoleCommand( "drone_Yaw", aimvec.z )
		self.Owner:SetNetworkedVector( "TurnOrder", aimvec )	
		self.Weapon:EmitSound("lockon/masterWarning.mp3")
	end
	
	else
		order.x,order.y,order.z = 0,0,0
		orderR.x,orderR.y,orderR.z = 0,0,0
-- datastream.StreamToServer( "SendDroneStream", { Vector(0,0,0) } )
net.Start( "SendDroneStream" )
net.WriteVector( Vector(0,0,0) )
-- net.SendToServer()
net.Send()
		-- self.Owner:SendLua("RunConsoleCommand( \"drone_orders\",0,0,0,0 )")
--		RunConsoleCommand( "drone_orders",0,0,0,0 )
/*		RunConsoleCommand( "drone_X", 0 )
		RunConsoleCommand( "drone_Y", 0 )
		RunConsoleCommand( "drone_Z", 0 )
		RunConsoleCommand( "drone_Yaw", 0 )
*/
--	self.Owner:SetNetworkedVector( "PositionOrder", Vector(0,0,0) )	
--	self.Owner:SetNetworkedVector( "TurnOrder", Vector(0,0,0) )	
	end
	
end
function SWEP:Think()
	
	if self.Owner:KeyDown( IN_MOVELEFT ) then
	self.Owner:SetNetworkedVector( "TurnOrder", Vector(0,1,0) )	

	elseif self.Owner:KeyDown( IN_MOVERIGHT ) then
	self.Owner:SetNetworkedVector( "TurnOrder", Vector(0,-1,0) )	
	else
	self.Owner:SetNetworkedVector( "TurnOrder", Vector(0,0,0) )	
	end
	
end

/*
local function SetupPlayerVisibility( pl )     
    for i, entity in pairs( ents.GetAll( ) ) do        
        AddOriginToPVS( entity:GetPos( ) );        
    end    
end
hook.Add( "SetupPlayerVisibility", "AddEntsToPVS", SetupPlayerVisibility );
*/
function SWEP:DrawHUD()
	--Hud informations	
	local x=order.x
	local y=order.y
	local z=order.z
	local pitch=orderR.x
	local yaw=orderR.z
	local roll=orderR.y
	if (GetConVarNumber("drone_auto", 0 )==1 ) then
	draw.SimpleText("Auto-pilot activated","TargetID",10, 10,Color(255,0,0,255))
	elseif (GetConVarNumber("drone_auto", 0 )==2 ) then
	draw.SimpleText("Searching..","TargetID",10, 10,Color(255,255,0,255))	
	else
	draw.SimpleText("Remote control Mode","TargetID",10, 10,Color(255,255,255,255))	
	end
	-- draw.SimpleText("GPS: x="..math.floor(100*x).." y="..math.floor(100*y).." z="..math.floor(100*z),"ChatFront",10, 25,Color(255,255,255,255))		
	-- draw.SimpleText("Angle: x="..math.floor(pitch).." y="..math.floor(yaw).." z="..math.floor(roll),"ChatFront",10, 40,Color(255,255,255,255))		
	draw.SimpleText("GPS: x="..math.floor(100*x).." y="..math.floor(100*y).." z="..math.floor(100*z),"TargetID",10, 25,Color(255,255,255,255))		
	draw.SimpleText("Angle: x="..math.floor(pitch).." y="..math.floor(yaw).." z="..math.floor(roll),"TargetID",10, 40,Color(255,255,255,255))		
	local t=self.Owner:GetNetworkedString( "TargetAcquired", "Nothing" )
	draw.SimpleText("Target: "..t,"ScoreboardText",10, 60,Color(255,150,0,255))		

	local v=self.Owner:GetNetworkedVector( "PositionOrder", Vector(0,0,0) )
	local s=self.Owner:GetNetworkedVector( "TurnOrder", Vector(0,0,0) )
	/*
	if (v) then
	draw.SimpleText("GPS: x="..(v.x).." y="..(v.y).." z="..(v.z),"ScoreboardText",10, 25,Color(255,255,255,255))		
	end
	if (s) then
	draw.SimpleText("Strafe: x="..(s.x).." y="..(s.y).." z="..(s.z),"ScoreboardText",10, 40,Color(255,255,255,255))		
	end
	*/
	local tg = self.Owner:GetNetworkedEntity( "Target", NULL )
		if IsValid(tg) then
		local t = tg:GetPos()
		-- local tx = GetConVarNumber("target_X", self.Owner:GetPos().x )
		-- local ty = GetConVarNumber("target_Y", self.Owner:GetPos().y )
		-- local tz = GetConVarNumber("target_Z", self.Owner:GetPos().z )
		
		local tpos = Vector(t.x, t.y, t.z):ToScreen()
		surface.SetDrawColor( 255,0,0,255 )
		surface.DrawOutlinedRect( tpos.x - 4, tpos.y - 4, 8, 8 )
		surface.DrawCircle( tpos.x, tpos.y, 8, Color(255,0,0,255) )
		end
end

function SWEP:OnRemove()

-- other onremove code goes here

if CLIENT then
self:RemoveModels()
end

end

SWEP.vRenderOrder = nil
function SWEP:ViewModelDrawn()

	local old
 	local pos = self.Weapon:GetPos()
	local ang = self.Weapon:GetAngles()

    old = render.GetRenderTarget( )    
    render.SetRenderTarget( self.RenderTarget )  
    cam.Start2D( )
    cam.End2D( )     
    render.SetViewPort( 0, 0, ScrW( ), ScrH( ) )
    render.SetRenderTarget( old )
	
	
--Tablet's Code	
local vm = self.Owner:GetViewModel()
vm:SetPos(self.IronSightsPos )
if !IsValid(vm) then return end

if (!self.VElements) then return end

if vm.BuildBonePositions ~= self.BuildViewModelBones then
vm.BuildBonePositions = self.BuildViewModelBones
end

if (self.ShowViewModel == nil or self.ShowViewModel) then
vm:SetColor( Color ( 255,255,255,255) )
else
-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
vm:SetColor( Color ( 255,255,255,1) )
vm:SetRenderMode( RENDERMODE_TRANSALPHA )
end

if (!self.vRenderOrder) then

-- we build a render order because sprites need to be drawn after models
self.vRenderOrder = {}

for k, v in pairs( self.VElements ) do
if (v.type == "Model") then
table.insert(self.vRenderOrder, 1, k)
elseif (v.type == "Sprite" or v.type == "Quad") then
table.insert(self.vRenderOrder, k)
end
end

end

for k, name in ipairs( self.vRenderOrder ) do

local v = self.VElements[name]
if (!v) then self.vRenderOrder = nil break end

local model = v.modelEnt
local sprite = v.spriteMaterial

if (!v.bone) then continue end

local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )

if (!pos) then continue end

if (v.type == "Model" and IsValid(model)) then

model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
ang:RotateAroundAxis(ang:Up(), v.angle.y)
ang:RotateAroundAxis(ang:Right(), v.angle.p)
ang:RotateAroundAxis(ang:Forward(), v.angle.r)

model:SetAngles(ang)
model:SetModelScale(v.size)

if (v.material == "") then
model:SetMaterial("")
elseif (model:GetMaterial() != v.material) then
model:SetMaterial( v.material )
end

if (v.skin and v.skin != model:GetSkin()) then
model:SetSkin(v.skin)
end

if (v.bodygroup) then
for k, v in pairs( v.bodygroup ) do
if (model:GetBodygroup(k) != v) then
model:SetBodygroup(k, v)
end
end
end

if (v.surpresslightning) then
render.SuppressEngineLighting(true)
end

render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
render.SetBlend(v.color.a/255)
model:DrawModel()
render.SetBlend(1)
render.SetColorModulation(1, 1, 1)

if (v.surpresslightning) then
render.SuppressEngineLighting(false)
end

elseif (v.type == "Sprite" and sprite) then

local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
render.SetMaterial(sprite)
render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)

elseif (v.type == "Quad" and v.draw_Func) then

local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
ang:RotateAroundAxis(ang:Up(), v.angle.y)
ang:RotateAroundAxis(ang:Right(), v.angle.p)
ang:RotateAroundAxis(ang:Forward(), v.angle.r)

cam.Start3D2D(drawpos, ang, v.size)
v.draw_Func( self )
cam.End3D2D()

end

end

end

SWEP.wRenderOrder = nil
function SWEP:DrawWorldModel()

if (self.ShowWorldModel == nil or self.ShowWorldModel) then
self:DrawModel()
end

if (!self.WElements) then return end

if (!self.wRenderOrder) then

self.wRenderOrder = {}

for k, v in pairs( self.WElements ) do
if (v.type == "Model") then
table.insert(self.wRenderOrder, 1, k)
elseif (v.type == "Sprite" or v.type == "Quad") then
table.insert(self.wRenderOrder, k)
end
end

end

if (IsValid(self.Owner)) then
bone_ent = self.Owner
else
-- when the weapon is dropped
bone_ent = self
end

for k, name in pairs( self.wRenderOrder ) do

local v = self.WElements[name]
if (!v) then self.wRenderOrder = nil break end

local pos, ang

if (v.bone) then
pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
else
pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
end

if (!pos) then continue end

local model = v.modelEnt
local sprite = v.spriteMaterial

if (v.type == "Model" and IsValid(model)) then

model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
ang:RotateAroundAxis(ang:Up(), v.angle.y)
ang:RotateAroundAxis(ang:Right(), v.angle.p)
ang:RotateAroundAxis(ang:Forward(), v.angle.r)

model:SetAngles(ang)
model:SetModelScale(v.size)

if (v.material == "") then
model:SetMaterial("")
elseif (model:GetMaterial() != v.material) then
model:SetMaterial( v.material )
end

if (v.skin and v.skin != model:GetSkin()) then
model:SetSkin(v.skin)
end

if (v.bodygroup) then
for k, v in pairs( v.bodygroup ) do
if (model:GetBodygroup(k) != v) then
model:SetBodygroup(k, v)
end
end
end

if (v.surpresslightning) then
render.SuppressEngineLighting(true)
end

render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
render.SetBlend(v.color.a/255)
model:DrawModel()
render.SetBlend(1)
render.SetColorModulation(1, 1, 1)

if (v.surpresslightning) then
render.SuppressEngineLighting(false)
end

elseif (v.type == "Sprite" and sprite) then

local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
render.SetMaterial(sprite)
render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)

elseif (v.type == "Quad" and v.draw_Func) then

local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
ang:RotateAroundAxis(ang:Up(), v.angle.y)
ang:RotateAroundAxis(ang:Right(), v.angle.p)
ang:RotateAroundAxis(ang:Forward(), v.angle.r)

cam.Start3D2D(drawpos, ang, v.size)
v.draw_Func( self )
cam.End3D2D()

end

end

end

function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )

local bone, pos, ang
if (tab.rel and tab.rel != "") then

local v = basetab[tab.rel]

if (!v) then return end

-- Technically, if there exists an element with the same name as a bone
-- you can get in an infinite loop. Let's just hope nobody's that stupid.
pos, ang = self:GetBoneOrientation( basetab, v, ent )

if (!pos) then return end

pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
ang:RotateAroundAxis(ang:Up(), v.angle.y)
ang:RotateAroundAxis(ang:Right(), v.angle.p)
ang:RotateAroundAxis(ang:Forward(), v.angle.r)

else

bone = ent:LookupBone(bone_override or tab.bone)

if (!bone) then return end

pos, ang = Vector(0,0,0), Angle(0,0,0)
local m = ent:GetBoneMatrix(bone)
if (m) then
pos, ang = m:GetTranslation(), m:GetAngles()
end

if (IsValid(self.Owner) and self.Owner:IsPlayer() and
ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
ang.r = -ang.r -- Fixes mirrored models
end

end

return pos, ang
end

function SWEP:CreateModels( tab )

if (!tab) then return end

-- Create the clientside models here because Garry says we can't do it in the render hook
for k, v in pairs( tab ) do
if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and
string.find(v.model, ".mdl") and file.Exists ("../"..v.model) ) then

v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
if (IsValid(v.modelEnt)) then
v.modelEnt:SetPos(self:GetPos())
v.modelEnt:SetAngles(self:GetAngles())
v.modelEnt:SetParent(self)
v.modelEnt:SetNoDraw(true)
v.createdModel = v.model
else
v.modelEnt = nil
end

elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
and file.Exists ("../materials/"..v.sprite..".vmt")) then

local name = v.sprite.."-"
local params = { ["$basetexture"] = v.sprite }
-- make sure we create a unique name based on the selected options
local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
for i, j in pairs( tocheck ) do
if (v[j]) then
params["$"..j] = 1
name = name.."1"
else
name = name.."0"
end
end

v.createdSprite = v.sprite
v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)

end
end

end

function SWEP:OnRemove()
self:RemoveModels()
end

function SWEP:RemoveModels()
if (self.VElements) then
for k, v in pairs( self.VElements ) do
if (IsValid( v.modelEnt )) then v.modelEnt:Remove() end
end
end
if (self.WElements) then
for k, v in pairs( self.WElements ) do
if (IsValid( v.modelEnt )) then v.modelEnt:Remove() end
end
end
self.VElements = nil
self.WElements = nil
end


/**************************************************
SWEP Construction Kit base code
Created by Clavus
Available for public use, thread at:
facepunch.com/threads/1032378
**************************************************/