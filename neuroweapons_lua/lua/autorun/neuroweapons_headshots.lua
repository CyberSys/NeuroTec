-- Headshot Sound Effect module for NeuroWeapons.
-- I might have gone a little over board for "CS:GO Headshot Sound"
game.AddDecal("NeuroBrain", "brain.vtf" )

local hitgroupBones = {} // Thanks Valve
hitgroupBones[HITGROUP_LEFTARM] = { "ValveBiped.Bip01_L_Finger", "ValveBiped.Bip01_L_Hand", "ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_UpperArm","ValveBiped.Bip01_L_Ulna","ValveBiped.Bip01_L_Bicep",  "ValveBiped.Bip01_L_Shoulder", "ValveBiped.Bip01_L_Elbow" }
hitgroupBones[HITGROUP_RIGHTARM] = { "ValveBiped.Bip01_R_Finger", "ValveBiped.Bip01_R_Hand", "ValveBiped.Bip01_R_Forearm","ValveBiped.Bip01_R_UpperArm","ValveBiped.Bip01_R_Ulna",  "ValveBiped.Bip01_R_Bicep","ValveBiped.Bip01_R_Shoulder", "ValveBiped.Bip01_R_Elbow" }
hitgroupBones[HITGROUP_LEFTLEG] = { "ValveBiped.Bip01_L_Foot", "ValveBiped.Bip01_L_Thigh", "ValveBiped.Bip01_L_Calf", "ValveBiped.Bip01_L_Toe0" }
hitgroupBones[HITGROUP_RIGHTLEG] = { "ValveBiped.Bip01_R_Foot", "ValveBiped.Bip01_R_Thigh", "ValveBiped.Bip01_R_Calf", "ValveBiped.Bip01_R_Toe0" }

local BloodBones = {}
BloodBones[HITGROUP_LEFTARM] = "ValveBiped.Bip01_L_Shoulder"
BloodBones[HITGROUP_RIGHTARM] = "ValveBiped.Bip01_R_Shoulder"
BloodBones[HITGROUP_LEFTLEG] = "ValveBiped.Bip01_L_Thigh"
BloodBones[HITGROUP_RIGHTLEG] = "ValveBiped.Bip01_R_Thigh"

local Chunks = {
	"models/themask/boney/boney_brain_sg.mdl",
	"models/gibs/humans/eye_gib.mdl",
	"models/gibs/humans/eye_gib.mdl",
	"models/gibs/hgibs_scapula.mdl",
	"models/gibs/hgibs_scapula.mdl"
	-- "models/props_junk/watermelon01_chunk02a.mdl",
	-- "models/props_junk/watermelon01_chunk01b.mdl",
	-- "models/props_junk/watermelon01_chunk02a.mdl"
}

if( CLIENT ) then 
	/*
	killicon.Add( "NeuroHeadshots", "NeuroHeadshotIcon", Color( 255,255,255,255 ) )
	
	local Color_Icon = Color( 255, 80, 0, 255 )
	local NPC_Color = Color( 250, 50, 50, 255 )
	local Deaths = {}
	local hud_deathnotice_time = CreateConVar( "hud_deathnotice_time", "6", FCVAR_REPLICATED, "Amount of time to show death notice" )
	
	-- hook.Add("InitPostEntity", "NeuroWeapons_OverrideDrawDeathNotice", function() 

	-- local gmeta = GM 
	-- if( !gmeta ) then 
		-- gmeta = GAMEMODE 
	-- end 
		
	-- hook.Add("PlayerInitialSpawn", "NeuroWeapons_PLeaseKILLME", function( ply )

	local function DrawDeath( x, y, death, hud_deathnotice_time )

		local w, h = killicon.GetSize( death.icon )
		if ( !w || !h ) then return end
		
		local fadeout = ( death.time + hud_deathnotice_time ) - CurTime()
		
		local alpha = math.Clamp( fadeout * 255, 0, 255 )
		death.color1.a = alpha
		death.color2.a = alpha
		
		-- Draw Icon
		killicon.Draw( x, y, death.icon, alpha )
		
		-- Draw KILLER
		if ( death.left ) then
			draw.SimpleText( death.left,	"ChatFont", x - ( w / 2 ) - 16, y, death.color1, TEXT_ALIGN_RIGHT )
		end
		
		-- Draw VICTIM
		draw.SimpleText( death.right,		"ChatFont", x + ( w / 2 ) + 16, y, death.color2, TEXT_ALIGN_LEFT )
		
		return ( y + h * 0.70 )

	end

	function GAMEMODE:AddDeathNotice( Victim, team1, Inflictor, Attacker, team2 )
		
		-- print("what") 
		local Death = {}
		Death.victim	= Victim
		Death.attacker	= Attacker
		Death.time		= CurTime()

		Death.left		= Victim
		Death.right		= Attacker
		Death.icon		= Inflictor
		local vic = NULL
		for k,v in pairs( player.GetAll() ) do 
			
			if( v:Name() == Attacker ) then 
			
				vic = v 
				
				break 
				
			end 
			
		end 
	
		if( vic && vic.HeadshotIcon ) then 
			vic.HeadshotIcon = false 
			Death.icon = "NeuroHeadshots"
		
		end 
		
		if ( team1 == -1 ) then Death.color1 = table.Copy( NPC_Color )
		else Death.color1 = table.Copy( team.GetColor( team1 ) ) end
		
		if ( team2 == -1 ) then Death.color2 = table.Copy( NPC_Color )
		else Death.color2 = table.Copy( team.GetColor( team2 ) ) end
		
		if (Death.left == Death.right) then
			Death.left = nil
			Death.icon = "suicide"
		end
		
		table.insert( Deaths, Death )
	
		-- return Deaths
		
	end 

	hook.Add("DrawDeathNotice", "NeuroWeapons_OverrideNotice", function( x, y )
		-- print("whut")
		if ( GetConVarNumber( "cl_drawhud" ) == 0 ) then return end

		local hud_deathnotice_time = hud_deathnotice_time:GetFloat()

		x = x * ScrW()
		y = y * ScrH()
		
		-- Draw
		for k, Death in pairs( Deaths ) do

			if ( Death.time + hud_deathnotice_time > CurTime() ) then
		
				if ( Death.lerp ) then
					x = x * 0.3 + Death.lerp.x * 0.7
					y = y * 0.3 + Death.lerp.y * 0.7
				end
				
				Death.lerp = Death.lerp or {}
				Death.lerp.x = x
				Death.lerp.y = y
			
				y = DrawDeath( x, y, Death, hud_deathnotice_time )
			
			end
			
		end
		
		-- We want to maintain the order of the table so instead of removing
		-- expired entries one by one we will just clear the entire table
		-- once everything is expired.
		for k, Death in pairs( Deaths ) do
			if ( Death.time + hud_deathnotice_time > CurTime() ) then
				return
			end
		end
		
		Deaths = {}
		
		-- return true 
					
	end )

	-- end ) 
	*/
	
end 

if SERVER then 
	AddCSLuaFile() 
	util.AddNetworkString( "NeuroWeapons_TransmitBoneUpdate" )
	util.AddNetworkString( "NeuroWeapons_ScreenBloodEffect" )
	
-- if( SERVER ) then 
	-- Check if we have Exhos lovely hitmarkers installed :D
	hook.Add("InitPostEntity", "NeuroWeapons_HijackExhosHitmarkers", function()
		if( util.NetworkStringToID("DrawHitMarker") != 0 ) then 
				hook.Add("EntityTakeDamage","HitmarkerDetector_NeuroWeaponsHijack",function( ply, dmginfo )
				local att = dmginfo:GetAttacker()
				local dmg = dmginfo:GetDamage()
				if (IsValid(att) and att:IsPlayer() and att ~= ply) then
					-- print( ply.Pilot == att )
					if ( ply.HealthVal ~= nil && ply.Owner != att  && IsValid( ply.Pilot ) && ply.Pilot != att ) then -- Only players and NPCs show hitmarkers
						net.Start("DrawHitMarker")
						net.Send(att) -- Send the message to the attacker
					end
				end
			end)	
		end 
	end )
	
-- end 
	
	local mEntity = FindMetaTable( "Player" )
	function mEntity:NeuroWeapons_SendBloodyScreen()
		
		net.Start("NeuroWeapons_ScreenBloodEffect")
			net.WriteBool( true )
		net.Send( self )
		
	end 
	
	-- hook.Add("OnDamagedByExplosion", "NeuroWeapons_ExplosionGore", function( ply, dmginfo )
		
		-- if( GetConVarNumber("neuroweapons_headshotsound") == 0 ) then return end 

		-- if( ply:Health() + ply:Armor() <= 0 ) then
			
			-- ply:Neurotec_ExplosionGore()
			-- local rag = ply:GetRagdollEntity()
			-- if( IsValid( rag ) ) then 
				-- rag:Remove()
			-- end 
			
		-- end 
		
	-- end )
	
	local bodyparts = {
	-- "models/gibs/humans/eye_gib.mdl",
	-- "models/gibs/humans/eye_gib.mdl",
	"models/themask/boney/boney_brain_sg.mdl",
	"models/themask/boney/boney_heart_sg.mdl",
	"models/themask/boney/boney_liver_sg.mdl",
	"models/gibs/hgibs_scapula.mdl",
	"models/gibs/hgibs_rib.mdl",
	"models/gibs/hgibs_spine.mdl",
	}
	local bodyparts_ragdoll = {
	"models/themask/boney/boney_lungh_sg.mdl",
	"models/themask/boney/boney_skull_bg_sg.mdl",
	"models/gibs/fast_zombie_legs.mdl"
	}
	function mEntity:Neurotec_ExplosionGore()
		
		for k,v in pairs( bodyparts ) do 
			local gib = ents.Create("prop_physics")
			gib:SetPos( self:GetPos() )
			gib:SetAngles( self:GetAngles() )
			gib:SetModel( v )
			gib:Spawn()
			gib:Fire("kill","",math.random(3,7))
			if( k <= #bodyparts_ragdoll ) then 
				local rgib = ents.Create("prop_ragdoll")
				rgib:SetPos( self:GetPos() + Vector(0,0,16) )
				rgib:SetAngles( self:GetAngles() )
				rgib:SetModel( bodyparts_ragdoll[k] )
				rgib:Spawn()
				rgib:Fire("kill","",math.random(3,7) )
				rgib:GetPhysicsObject():SetVelocity( VectorRand() * 512 ) 
				rgib:GetPhysicsObject():AddAngleVelocity( VectorRand() * 100 )
			end
			
			local fx = EffectData()
			fx:SetStart( gib:GetPos() + VectorRand() * 4 )
			fx:SetOrigin( gib:GetPos() + VectorRand() * 4 )
			fx:SetScale( math.Rand( .5, 1.45 ) )
			fx:SetNormal( VectorRand() )
			util.Effect( "micro_he_blood", fx )
			
			local tr,trace={},{}
			tr.start = gib:GetPos() 
			tr.endpos = tr.start + VectorRand() * 128
			tr.mask = MASK_SOLID
			tr.filter = { self, gib }
			trace = util.TraceLine( tr )
			util.Decal( "blood", trace.HitPos + trace.HitNormal , trace.HitPos - trace.HitNormal  )
			
		end 
		
		ParticleEffect("tank_gore", self:GetPos(), self:GetAngles(), nil )
		
	end 
	
	function mEntity:CopyAllBoneAngles( target )
		
		local num = target:GetPhysicsObjectCount()-1
		for i=0, num do
			
			local bone = target:GetPhysicsObjectNum(i)
				if IsValid(bone) then

				local bp, ba = self:GetBonePosition( target:TranslatePhysBoneToBone(i))
				 if bp and ba then
					
					bone:SetPos(bp)
					bone:SetAngles(ba)
					
				 end
				
			end 
			
		end 
			
		net.Start( "NeuroWeapons_TransmitBoneUpdate" )
			net.WriteEntity( target )
			net.WriteEntity( self )
		net.Broadcast()
	end 

	function mEntity:CreateRagdollFromHitgroup(  )
		
		Hitgroup = self:LastHitGroup() 
		
		-- print( self:LastHitGroup(), Hitgroup, hitgroupBones[Hitgroup], self )
		if( self.LastChainsawed && self.LastChainsawed + 1 >= CurTime() ) then 
			
			Hitgroup = math.random( HITGROUP_HEAD+1, HITGROUP_RIGHTLEG )
			-- print("New Hitgroup:", Hitgroup )
			
		end 
		
		local parts = hitgroupBones[Hitgroup]
		if( parts ) then 
			
			local rag = self:GetRagdollEntity()
			if( !IsValid( rag ) ) then return end 
			
			local newRag = ents.Create("prop_ragdoll")
			newRag:SetPos( rag:GetPos() )
			newRag:SetAngles( self:GetAngles() )
			newRag:SetModel( self:GetModel() )
			newRag:Spawn()
			newRag:Activate()
			newRag:Fire("kill","",15)
			newRag:SetSkin( rag:GetSkin() )
			newRag:SetRenderMode( RENDERMODE_TRANSALPHA )
			newRag.GetPlayerColor = function( )
				return IsValid( self ) and self:GetPlayerColor() or Vector(1,1,1)
			end		
		
			local newRag2 = ents.Create("prop_ragdoll")
			newRag2:SetPos( rag:GetPos() )
			newRag2:SetAngles( self:GetAngles() )
			newRag2:SetModel( self:GetModel() )
			newRag2:Spawn()
			newRag2:Activate()
			newRag2:Fire("kill","",15)
			newRag2:SetSkin( rag:GetSkin() )
			newRag2:SetRenderMode( RENDERMODE_TRANSALPHA )
			newRag2.GetPlayerColor = function( )
				return IsValid( self ) and self:GetPlayerColor() or Vector(1,1,1)
			end		
			rag:Remove()
			self:Spectate( OBS_MODE_CHASE )
			self:SpectateEntity( newRag2)
		
			newRag2:EmitSound( "physics/flesh/flesh_bloody_break.wav", 511, math.random(90,105) )
			newRag:EmitSound("npc/barnacle/barnacle_die1.wav",511,math.random(150,180))
			self.NeuroBodyParts = { newRag, newRag2 }
			
			for i=0,newRag:GetBoneCount()-1 do
				
				local boneName = newRag:GetBoneName( i )
				local hasBoneInList = false 
				for j,v in ipairs( parts ) do
									
					if( string.find( boneName, v ) != nil ) then 
						hasBoneInList = true 
						break 
					end 
				
				end 
	
				if( hasBoneInList ) then 
					
					newRag:ManipulateBoneScale( i, Vector( 0,0,0 ) )
					
				else 
							
					newRag2:ManipulateBoneScale( i, Vector( 0,0,0 ) )
					local bone = newRag2:TranslateBoneToPhysBone( i )
					local physbone = newRag2:GetPhysicsObjectNum( bone )
					physbone:ApplyForceCenter( newRag2:GetUp() * 500 )
	
				end 
			
			end 
			
			timer.Simple( 0, function()
				
				if( !IsValid( newRag ) || !IsValid( newRag2 ) || !IsValid( self ) ) then return end 
				self:CopyAllBoneAngles( newRag )
				self:CopyAllBoneAngles( newRag2 )
			
			end ) 
			
		end 

	end 
	
end 
if CLIENT then 
	
	local ScreenImpacts = {}
	local ScreenOverlays = {  
		Material( "neurogore/blood1.png"), 
		Material( "neurogore/blood2.png"), 
		Material( "neurogore/blood3.png"),
		Material( "neurogore/blood4.png")
	}
	
	-- function Add
	net.Receive( "NeuroWeapons_ScreenBloodEffect", function( length, client )
		local nextOverlay
		while( nextOverlay == nil || type( nextOverlay )  == "number" ) do -- the fuck ?????????
			nextOverlay = ScreenOverlays[math.random(1,#ScreenOverlays)]
		end 
		table.insert( ScreenImpacts, { CurTime(),  nextOverlay, math.random(-ScrW(),ScrW()), math.random(-ScrH(),ScrH() ), math.random(0,360) } )
	
	end )
	
	hook.Add( "PostDrawHUD", "NeuroWeapons_BloodyScreenHook", function() 
		-- local renderTasks = ScreenImpacts
		for k,v in pairs( ScreenImpacts ) do 
			-- print( v[2] )
		
			if( v[1] + 3.25 <= CurTime() ) then 
				
				table.RemoveByValue( ScreenImpacts, v )
				-- break 
				
			else 
				
				if( type(v[2]) == "IMaterial" ) then 
					
					surface.SetDrawColor( 255,255,255, math.Clamp( 255 * ( 1.0 - ( ( CurTime() - v[1] ) / 3 ) ), 0, 255 ) )
					surface.SetMaterial( v[2] )
					surface.DrawTexturedRectRotated( v[3], v[4], ScrW(), ScrH(), v[5] )
				
				else 
				
					table.RemoveByValue( ScreenImpacts, v ) 
				
				end 
			
			end 
			
		end 
	
	end ) 
	net.Receive( "NeuroWeapons_TransmitBoneUpdate", function( length, client )
		local target = net.ReadEntity()
		local pplayer = net.ReadEntity()
		if( IsValid( target ) && IsValid( pplayer ) ) then 
			target.GetPlayerColor = function( )
				return IsValid( pplayer ) and pplayer:GetPlayerColor() or Vector( 1,1,1 )
			end
			target:SetModel( pplayer:GetModel() ) -- fix inconsistency with bot player models not applying instantly on spawn.
			local num = pplayer:GetPhysicsObjectCount()-1
			for i=0, num do
				
				local bone = target:GetPhysicsObjectNum(i)
					if IsValid(bone) then

					local bp, ba = pplayer:GetBonePosition( target:TranslatePhysBoneToBone(i))
					 if bp and ba then
						
						bone:SetPos(bp)
						bone:SetAngles(ba)
						
					 end
					
				end 
				
			end 
			
			-- for i=0,pplayer:GetBoneCount() do
				-- local tp,ta = pplayer:GetBonePosition( i ) 
				-- if( tp && ta ) then 
					-- target:SetBonePosition( i, tp, ta ) 
				-- end 
			-- end 
		end 
	end )
	
	hook.Add("Think", "NeuroWeapons_NetFireThink", function() 
		local p = LocalPlayer()
		if( IsValid( p ) && IsValid( p:GetActiveWeapon() ) ) then 
			local w = p:GetActiveWeapon()
			if( !w.RandomSkins ) then 
				p:GetViewModel(0):SetSubMaterial( nil )
			end 
		end 
		
		for k,v in ipairs( ents.GetAll() ) do 
			if( v:GetNWBool("NeuroNetFire") ) then 						
				local dlight = DynamicLight( v:EntIndex() )
				if ( dlight ) then

					local c = Color( 205+math.random(25,50), 93+math.random(-5,5), 0, 100 )
					dlight.Pos = v:GetPos() + Vector(0,0,72 )
					dlight.r = c.r
					dlight.g = c.g
					dlight.b = c.b
					dlight.Brightness = math.Rand( .3, 1.25 )
					dlight.Decay = math.Rand( .001, .15 )
					dlight.Size = 768
					dlight.DieTime = CurTime() + 0.15

				end
				
			end 
			
		end 
		
	end ) 
	
	
end 

   -- local v = ply:GetVelocity()

   -- bullets have a lot of force, which feels better when shooting props,
   -- but makes bodies fly, so dampen that here
   -- if dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsDamageType(DMG_SLASH) then
      -- v = v / 5
   -- end


      -- if IsValid(bone) then
         -- local bp, ba = ply:GetBonePosition(rag:TranslatePhysBoneToBone(i))
         -- if bp and ba then
            -- bone:SetPos(bp)
            -- bone:SetAngles(ba)
         -- end

local botmodels = {}
botmodels["Bot01"] = "models/player/riot.mdl"
botmodels["Bot02"] = "models/player/gasmask.mdl"
botmodels["Bot03"] = "models/player/leet.mdl"
botmodels["Bot04"] = "models/player/swat.mdl"
botmodels["Bot05"] = "models/player/urban.mdl"
botmodels["Bot06"] = "models/player/arctic.mdl"
botmodels["Bot07"] = "models/player/gasmask.mdl"
botmodels["Bot08"] = "models/player/arctic.mdl"
botmodels["Bot09"] = "models/player/leet.mdl"
botmodels["Bot10"] = "models/player/skeleton.mdl"
botmodels["Bot11"] = "models/player/leet.mdl"
botmodels["Bot12"] = "models/player/gasmask.mdl"
botmodels["Bot13"] = "models/player/arctic.mdl"
botmodels["Bot14"] = "models/player/skeleton.mdl"
botmodels["Bot15"] = "models/player/leet.mdl"
botmodels["Bot16"] = "models/player/skeleton.mdl"
botmodels["Bot17"] = "models/player/arctic.mdl"
botmodels["Bot18"] = "models/player/leet.mdl"
botmodels["Bot19"] = "models/player/skeleton.mdl"
botmodels["Bot20"] = "models/player/combine_super_soldier.mdl"
for i=20,128 do
	
	botmodels["Bot"..i] = botmodels[math.random(1,#botmodels)]
	
end
hook.Add("PlayerSpawn",  "BotSetModel", function( ply )
	
	-- if( ply:GetNWBool("HeadshotIcon") ) then 
		ply.HeadshotIcon = false 
		-- ply:SetNWBool("HeadshotIcon", false )

	-- end 
	
	if( botmodels[ply:Nick()] ) then
		
		ply:SetModel( botmodels[ply:Nick()] )
		
	end
	if( ply.NeuroBodyParts ) then  
		for k,v in pairs( ply.NeuroBodyParts ) do 
			if( IsValid( v ) ) then v:Remove() end 
		end 
	end 
end )

resource.AddFile("models/arleitiss/riotshield/")
resource.AddFile("materials/arleitiss/riotshield/")

hook.Add("PlayerSpawn","NeuroWeapons_CleanupRagdolls", function( ply )
	
	if( IsValid( ply.NewRagdoll ) ) then 	
	
		ply.NewRagdoll:Remove()
		
	end 

end ) 

if CLIENT then 
	
	hook.Add("Think","NeuroHeadshotsClientDeathThink", function()
		local ply = LocalPlayer()
		if( !ply:Alive() && ply:GetNWEntity("WasLastDeathFromHS") ) then 
			-- if( IsValid( ply.NewRagdoll ) && ply.LastHeadshot + 4 >= CurTime() ) then 
				ply.NewRagdoll = ply:GetNWEntity("WasLastDeathFromHS")
				if( !IsValid( ply.NewRagdoll ) ) then return end 
				local BoneIndx = ply.NewRagdoll:LookupBone("ValveBiped.Bip01_Head1")
				if( BoneIndx ) then 
				
					local BonePos , BoneAng = ply.NewRagdoll:GetBonePosition( BoneIndx )
					local dir = BoneAng:Up()
					local fx = EffectData()
					fx:SetStart( BonePos + VectorRand() * 4 )
					fx:SetOrigin( BonePos + VectorRand() * 4 )
					fx:SetScale( math.Rand( .1, .45 ) )
					fx:SetNormal( dir )
					util.Effect( "micro_he_blood", fx )
					-- fx:SetScale( math.Rand( .1, .45 ) )
					-- util.Effect( "bloodspray", fx )
					util.Effect( "BloodImpact", fx )
				
					local tr,trace={},{}
					tr.start = BonePos 
					tr.endpos = tr.start + dir * 60 + VectorRand() * 32 
					tr.mask = MASK_SOLID
					tr.filter = { ply, ply.NewRagdoll }
					trace = util.TraceLine( tr )
					util.Decal( "blood", trace.HitPos + trace.HitNormal , trace.HitPos - trace.HitNormal  )

				end
			
			-- end 
		
		end 
		
	end )

end 
hook.Add("PlayerDeathThink", "NeuroWeapons_HeadlessRagdollGore", function( ply ) 
	-- print("yolo")
	if( IsValid( ply.NewRagdoll ) && ply.LastHeadshot + 4 >= CurTime() ) then 
		
		local BoneIndx = ply.NewRagdoll:LookupBone("ValveBiped.Bip01_Head1")
		if( BoneIndx ) then 
		
			local BonePos , BoneAng = ply.NewRagdoll:GetBonePosition( BoneIndx )
			local dir = BoneAng:Up()
			local fx = EffectData()
			fx:SetStart( BonePos + VectorRand() * 4 )
			fx:SetOrigin( BonePos + VectorRand() * 4 )
			fx:SetScale( math.Rand( .1, .45 ) )
			fx:SetNormal( dir )
			util.Effect( "micro_he_blood", fx )
			-- fx:SetScale( math.Rand( .1, .45 ) )
			-- util.Effect( "bloodspray", fx )
			util.Effect( "BloodImpact", fx )
		
			local tr,trace={},{}
			tr.start = BonePos 
			tr.endpos = tr.start + dir * 60 + VectorRand() * 32 
			tr.mask = MASK_SOLID
			tr.filter = { ply, ply.NewRagdoll }
			trace = util.TraceLine( tr )
			util.Decal( "blood", trace.HitPos + trace.HitNormal , trace.HitPos - trace.HitNormal  )

		end
	
	end 
	
	if( ply.NeuroBodyParts && ply.LastHitgroupHit  ) then

		local hitgroupBone = BloodBones[ply.LastHitgroupHit]
		if( hitgroupBone ) then 
			
			for i=1,#ply.NeuroBodyParts do 
				
				local part = ply.NeuroBodyParts[i]
				if( IsValid( part ) ) then 
				
					local bone = part:LookupBone( hitgroupBone )
					if( !bone ) then return end 
					
					local BonePos, BoneAng = part:GetBonePosition( bone )				
					local up = BoneAng:Up()
					local direction = i == 1 and -1 or 1 
					
					local fx = EffectData()
					fx:SetStart( BonePos + VectorRand() * 4 )
					fx:SetOrigin( BonePos + VectorRand() * 4 )
					fx:SetScale( math.Rand( .1, .25 ) )
					fx:SetNormal( up * direction )
					util.Effect( "micro_he_blood", fx )
				
					local tr,trace={},{}
					tr.start = BonePos 
					tr.endpos = tr.start + ( up * direction ) * 60 + VectorRand() * 32 
					tr.mask = MASK_SOLID
					tr.filter = { ply, ply.NewRagdoll }
					trace = util.TraceLine( tr )
					util.Decal( "blood", trace.HitPos + trace.HitNormal , trace.HitPos - trace.HitNormal  )

					
				end 
			
			end 
		
		end 
		
		-- if( ) then 
		
		
		-- BloodBones[HITGROUP_LEFTARM] = "ValveBiped.Bip01_L_Shoulder"
		-- BloodBones[HITGROUP_RIGHTARM] = "ValveBiped.Bip01_R_Shoulder"
		-- BloodBones[HITGROUP_LEFTLEG] = "ValveBiped.Bip01_L_Thigh"
		-- BloodBones[HITGROUP_RIGHTLEG] = "ValveBiped.Bip01_R_Thigh"
		
		
		-- end 
		
	end 
	
end ) 

hook.Add("PlayerDeath", "NeuroWeapons_StoreBonePositions", function( ply ) 
	-- if( !IsValid( self.Owner ) ) then return end 
	if( !IsValid( ply:GetViewModel(0) ) ) then return end 
	ply:GetViewModel(0):SetSubMaterial(0, nil )
	
	if( ply.LastHeadshot && ply.LastHeadshot + 1 > CurTime() ) then 

		
		ply.LastBonePositions = {}
		
		for i=0, ply:GetBoneCount() do
			
			local pp,pa = ply:GetBonePosition( i ) 
			
			table.insert( ply.LastBonePositions, 
				{ 
					Pos = pp, 
					Ang =  pa
					
				} )
		
		end 
	
	end 
	

end ) 
	
hook.Add("PlayerDeath", "NeuroWeapons_RemoveBrokenHead", function( ply, vi, inf) 
	if( SERVER ) then 
		
		local rag = ply:GetRagdollEntity()
		if( ply.LastHeadshot && ply.LastHeadshot + 1 > CurTime() && IsValid( rag ) ) then 
			
			local c = ply:GetPlayerColor()
			local newRag = ents.Create("prop_ragdoll")
			newRag:SetPos( rag:GetPos() )
			newRag:SetAngles( ply:GetAngles() )
			newRag:SetModel( ply:GetModel() )
			newRag:Spawn()
			newRag:Activate()
			newRag:Fire("kill","",15)
			newRag:SetSkin( rag:GetSkin() )
			newRag:SetRenderMode( RENDERMODE_TRANSALPHA )
			newRag:SetNoDraw( true )
			newRag:Fire("StartRagdollBoogie", "2",  2)
			
			newRag:EmitSound("npc/barnacle/barnacle_die1.wav",511,math.random(150,180))
			newRag.GetPlayerColor = function( )
				return IsValid( ply ) and ply:GetPlayerColor() or Vector(1,1,1)
			end
			
			newRag:GetPhysicsObject():SetVelocity( ply:GetVelocity() )
			timer.Simple( 0.0, function()
				
				if( !IsValid( newRag ) || !IsValid( ply ) ) then return end 
				
				ply:CopyAllBoneAngles( newRag ) 
				newRag:SetNoDraw( false )
				
				ply:Spectate( OBS_MODE_CHASE )
				ply:SpectateEntity( newRag )
			
				if( IsValid( rag ) ) then 
				
					rag:Remove()
				
				end 
				
			end ) 
			local BoneIndx = newRag:LookupBone("ValveBiped.Bip01_Head1")
			if( BoneIndx ) then 
			
				local BonePos , BoneAng = newRag:GetBonePosition( BoneIndx )
				local dir = BoneAng:Forward()
				if( IsValid( newRag ) ) then 
					local p = newRag:GetPhysicsObjectNum( BoneIndx ) 
					if( p ) then 
					
						p:ApplyForceCenter( ( BonePos - ply.LastHeadshotPos ):GetNormalized() * 70000 )
					end 
					
				end 
				
			end
			
			ply.NewRagdoll = newRag 
			ply:SetNWEntity("WasLastDeathFromHS", newRag )
			
			local head = newRag:LookupBone( "ValveBiped.Bip01_Head1" )
			if( head ) then 
				
				newRag:ManipulateBoneScale( head, Vector( 0,0,0 ) )
			
			end 
		
		
		end 

		
		if( ply.LastHitgroupHit && ply.LastDamageTaken ) then 
			
			ply:CreateRagdollFromHitgroup(  )
			
		end 
		
	end 

end ) 


-- hook.Add("EntityFireBullets", "NeuroWeapons_Barrelsmoke", function( ent, data ) 
	
	-- if( ent:IsPlayer() && ( data.Src - ent:GetShootPos() ):Length() < 8 ) then 
		
		-- local muzzle = ent:LookupAttachment( "muzzle" )	
		-- local fx = EffectData()
		-- fx:SetOrigin( data.Src )
		-- fx:SetAttachment( muzzle )
		-- fx:SetEntity( ent )
		-- fx:SetStart( data.Src )
		-- fx:SetScale( 0.01 )
		-- fx:SetNormal( Vector(0,0,1 ) )
		-- util.Effect("neurotecHeatwave", fx )
	
	-- end 
 
-- end ) 

hook.Add("DoPlayerDeath","NeuroWeapons_DropShieldHook", function( ply, attacker, dmg )
	local wep = ply.Shield
	if( IsValid( wep ) ) then 
		
		local shield = ents.Create("sent_neuro_riotshield")
		-- shield:SetModel("models/arleitiss/riotshield/shield.mdl")
		shield:SetPos( ply:LocalToWorld( Vector( 14,-6, 10 ) ) ) -- self.Owner:GetPos() + Vector(10,0,15) + (self.Owner:GetForward()*25))
		shield:SetAngles( ply:GetAngles() )
		shield:Spawn()
		shield:SetModel( wep:GetModel() )
		shield:Activate()
		shield:Fire("kill","",60 )
		undo.Create( "sent" )
		 undo.AddEntity( shield )
		 undo.SetPlayer( ply )
		undo.Finish()
	end 

end )

local ArmorPiercing = { "weapon_neurowep_ptrs41","weapon_neurowep_rorsch", "weapon_neurowep_50cal_ap", "weapon_neurowep_ap44" } 
hook.Add("EntityTakeDamage", "NeuroWeapons_ScaleShieldDamage", function( ply, dmginfo ) 
	local atk = dmginfo:GetAttacker()
	-- print( ArmorPiercing[atk:GetActiveWeapon():GetClass()]  )
	if( IsValid( atk ) && atk:IsPlayer() && IsValid( atk:GetActiveWeapon() ) && table.HasValue( ArmorPiercing, atk:GetActiveWeapon():GetClass() )  ) then
		dmginfo:SetDamageType(DMG_CRUSH)
	end 
	if( !ply:IsPlayer() ) then  return end 

	local wep = ply:GetActiveWeapon()
	if( IsValid( wep ) && ( wep:GetClass() == "weapon_neurowep_riotshield" || wep:GetClass() == "weapon_neurowep_blastshield" ) ) then 
		
		local DotProduct = ply:GetAimVector():Dot(  ( dmginfo:GetDamagePosition() - ply:GetPos() ):GetNormalized() )
		
		if( DotProduct > .4 ) then 
			
			dmginfo:ScaleDamage( 0.1 )

		end 

	end 

end ) 

local BodyParts = {
					HITGROUP_GENERIC,
					HITGROUP_HEAD,
					HITGROUP_CHEST,
					HITGROUP_STOMACH,
					HITGROUP_LEFTARM,
					HITGROUP_RIGHTARM,
					HITGROUP_LEFTLEG,
					HITGROUP_RIGHTLEG
					}


hook.Add("PlayerDeath", "NeuroGear_ClearItems", function( ply, inf, att )
	
	if( ply.NeuroArmor ) then 
		
		for k,v in pairs( ply.NeuroArmor ) do 
			if( IsValid( v ) ) then 
			
				v:ForceDeath()

			end 
	
		end 
		
		ply.NeuroArmor = {}
		
	end 
	if( IsValid( ply.Shield ) ) then
		ply.Shield:Remove()
		
	end 

end )


local PlayerMeta = FindMetaTable("Player")

function PlayerMeta:IsHitgroupProtected( hitgroup, dmginfo )
	local PlayerGear = self.NeuroArmor
	local stoptheshow = false 
	local scale = 1 
	local damage = dmginfo:GetDamage()
	if( PlayerGear ) then 
	
		for k,ent in ipairs( PlayerGear ) do 

			if( IsValid( ent ) && ent.HitgroupProtected && bit.band( ent.HitgroupProtected, hitgroup ) == hitgroup ) then 
				
				scale = ent.DamageScaling
					
				ent.HealthVal = ent.HealthVal - damage
				ent:SetNWInt( "HealthVal", math.floor( math.Clamp( ent.HealthVal, 0, 99999999 ) ) )
				
				if( ent.HealthVal <= 0 ) then 
					
					ent:ForceDeath()
					
					stoptheshow = false 
					
					break 
			
				end 
			
				stoptheshow = true 
				
				break 
				
			elseif( !IsValid( ent ) ) then 
				
				table.remove( self.NeuroArmor, k )
				
			end 
		
		end 
	
	end 
	
	return stoptheshow, scale 
	
end 
 
-- Insanely advanced and thorough system. lol
hook.Add("ScalePlayerDamage", "NeuroWeapons_HeadshotKlonk", function( ply, hitgroup, dmginfo )
	
	if( ply:HasGodMode() ) then return end 
	
	if( GetConVarNumber("neuroweapons_headshotsound") == 0 ) then return end 
	local atk = dmginfo:GetAttacker()
	local damage = dmginfo:GetDamage() 
	local PlayerGear = ply.NeuroArmor
	local stoptheshow, damagescale = ply:IsHitgroupProtected( hitgroup, dmginfo ) 
	local dist = ( ply:GetPos() - atk:GetPos() ):Length()
	-- print( dist, damage )
	
	ply.LastHitgroupHit = hitgroup 
	ply.LastDamageTaken = damage 
	if( SERVER ) then 
	
		ply:NeuroWeapons_SendBloodyScreen()
		if( atk:IsPlayer() && ( atk:GetPos() - ply:GetPos() ):Length() < 72 ) then 
			
			atk:NeuroWeapons_SendBloodyScreen()
		end 
		
	end 
	
	if( stoptheshow ) then 
		
		dmginfo:ScaleDamage( damagescale )
		
		return
		
	end 
	if ( hitgroup == HITGROUP_HEAD ) then
		
		-- ply:SetNWBool("HeadshotIcon", true )	
		ply.HeadshotIcon = true 
	
	end 
	
	-- print( "Icon?", ply.HeadshotIcon )
		
	if( SERVER ) then 

		if ( atk:IsPlayer() && damage * 2 > ply:Health() ) then

			// More damage when we're shot in the head
			if ( hitgroup == HITGROUP_HEAD ) then

				local wep = NULL 
				local dmgScale = 2 
			
				if( atk:IsPlayer() ) then 
			
					atk:EmitSound( "crit_hit.wav", 511, 100 )
					ply:EmitSound( "crit_received1.wav", 511, 100 )
					ply.LastHeadshot = CurTime() 
			
					ply.LastHeadshotPos = atk:GetPos() 
					local BoneIndx = ply:LookupBone("ValveBiped.Bip01_Head1")
					if( BoneIndx ) then 
					
						local BonePos , BoneAng = ply:GetBonePosition( BoneIndx )
						local dir = atk:GetAimVector()
				
						local fx = EffectData()
						fx:SetStart( BonePos )
						fx:SetOrigin( BonePos )
						fx:SetScale( 1 )
						fx:SetNormal( dir )
						util.Effect( "micro_he_blood", fx )
						fx:SetScale( .51 )
						fx:SetNormal( dir*-1 )
						util.Effect( "micro_he_blood", fx )
						fx:SetScale( 0.85 )
						fx:SetNormal( ply:GetUp() )
						util.Effect( "micro_he_blood", fx )
				
						for i =1,#Chunks do 
						
							local melon = ents.Create("prop_physics")
							melon:SetPos( BonePos + ( VectorRand() * 2 ) )
							melon:SetAngles( BoneAng )
							melon:SetModel( Chunks[ i ] )
							melon:Spawn()
							melon:SetOwner( ply ) 
							-- melon:SetColor( Color( 65,0,0,255 ) ) 
							-- melon:SetMaterial( "models/zombie_Fast/fast_zombie_sheet" )
							-- melon:SetSubMaterial( "models/zombie_Fast/fast_zombie_sheet", 0 )
							melon:GetPhysicsObject():SetVelocity(  Vector(0,0,25) + ( dmginfo:GetDamagePosition() - atk:GetPos() ):GetNormalized() * 111  )
							melon:Fire( "kill","", math.random(3,5) )
							if( i == #Chunks ) then 
									
								ply.NeuroWeaponHSChunk = melon 
								
							end 
							
						end 
					
			
						
						for i=1,5 do 
						
							local tr,trace={},{}
							tr.start = BonePos 
							tr.endpos = tr.start + ( dir + VectorRand() * .25 ) * 256 
							tr.filter = { atk, ply }
							tr.mask = MASK_SOLID
							trace = util.TraceLine( tr ) 
							
							util.Decal( "Blood", trace.HitPos + trace.HitNormal, trace.HitPos-trace.HitNormal )
						
						end 
						
					end 
					
					local wep = atk:GetActiveWeapon()			
					if( IsValid( wep ) && wep.HeadshotMultiplier ) then 
						
						dmgScale = wep.HeadshotMultiplier 
					
					end 
						
				end 
				
				dmginfo:ScaleDamage( dmgScale )

			end
			
			if ( hitgroup == HITGROUP_LEFTARM or
				hitgroup == HITGROUP_RIGHTARM or
				hitgroup == HITGROUP_LEFTLEG or
				hitgroup == HITGROUP_RIGHTLEG or
				hitgroup == HITGROUP_GEAR ) then
				
				dmginfo:ScaleDamage( 0.75 )
				if( hitgroup == HITGROUP_RIGHTARM || hitgroup == HITGROUP_LEFTARM ) then 
				
					if( IsValid( ply:GetActiveWeapon() ) && damage > 30 && ( damage > 75 || math.random(1,5 ) == 3 ) ) then
						
						ply:DropWeapon( ply:GetActiveWeapon() )
						ply:EmitSound( "player/damage"..math.random(1,3)..".wav", 511, 100 )
						
					end 
				
				end 
				
			end

		end
		
		
	end 
			
end )

print("NeuroWeapons Headshot Effects Loaded! neuroweapons_headshotsound 1 / 0 ")
