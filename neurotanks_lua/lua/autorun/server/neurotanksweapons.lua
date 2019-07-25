local Meta = FindMetaTable("Entity")

function Meta:TankAmmo_GetDamage( Type )
	
	if( !Type ) then Type = 2 end
	
	local DT = NeuroTanksDamageTables[self.TankType]
	if( Type == "sent_tank_apshell" || Type == "sent_tank_armorpiercing" || Type == "sent_tank_kinetic_shell" ) then
		
		return DT[3], DT[4], DT[5]
		
	else
	
		return DT[1], DT[2], DT[6]
		
	end

end

function Meta:TankAmmo_addAmmo( Type, Name, Min, Max )


end


function Meta:TankAmmo_ShouldDeflect( data, physobj )
	 
	if( TWO_TEAM_GAMEMODE ) then
		
		local own = self.Owner
		if( IsValid( own ) ) then
			
			local tank = data.HitEntity
			local driver = tank.Owner
			if( IsValid( driver ) && own:Team() == driver:Team() ) then
			
			
				return true
			
			end
			
		end
		
	end
				
	
			
		
	local dh = data.HitNormal:Angle()
	local da = self:GetAngles()
	local de = data.HitEntity
	
	-- print( de.TankType, self.TankType, self.TankType - de.TankType )
	if( self.TankType && de.TankType && de.TankType+1 <= self.TankType ) then
		
		-- print( "Size Matters" )
		if( math.random(1,10) == 7 ) then return true end
		
		return false
	
	end
	
	if( de && de:IsPlayer()  ) then
		
		util.BlastDamage( self, self.Owner, de:GetPos(), 32, de:Health() )
		ParticleEffect("tank_gore", de:GetPos(), Angle(0,0,0), nil )
		
		self:SetPos( self:GetPos() + self:GetForward() * 32 )

		return false 
	
	end
	
	local a,b,c = self:VecAngD( dh.p, da.p ),self:VecAngD( dh.y, da.y ),self:VecAngD( dh.r, da.r )
	local factor = 45 
	-- print( a,b,c )
	if( ( a > factor || a < -factor || b > factor || b < -factor /* || c > factor || c < -factor */ ) && IsValid( data.HitEntity ) and data.HitEntity.VehicleType and data.HitEntity.VehicleType == VEHICLE_TANK ) then	
		
        local rand = math.random( 1, 15 )
       
		if rand >= 10 then
		
            self.Owner:EmitSound("wot/radio/armor_ricochet_by_player_".. rand ..".wav",511,100)
			
        else
		
            self.Owner:EmitSound("wot/radio/armor_ricochet_by_player_0".. rand ..".wav",511,100)
			
        end
		
		-- print( "bounced" )
		self:EmitSound( "wot/global/ricochet".. math.random( 1, 7 ) ..".wav", 511, 100 )
		
		if( IsValid( data.HitEntity ) && data.HitEntity.HealtVal != nil ) then
			
			if( data.HitEntity.HealthVal > 250 ) then
			
				util.BlastDamage( self, self, self:GetPos(), 128, math.random(150,250) )
				
			end
		
		end
		
		ParticleEffect( "shell_ric", self:GetPos(), Angle(0,0,0), nil )

		-- local fx = EffectData()
		-- fx:SetStart( data.HitPos )
		-- fx:SetOrigin( data.HitPos )
		-- fx:SetNormal( data.HitNormal )
		-- fx:SetScale( 10.5 )
		-- util.Effect("ManhackSparks", fx )
		self:Remove()
		
		return true
	
	end
	
    -- if( IsValid( data.HitEntity ) && data.HitEntity.VehicleType && data.HitEntity.VehicleType == VEHICLE_TANK ) then	

        -- self.Owner:EmitSound("wot/global/armor_pierced_by_player_0".. math.random( 1, 9 ) ..".wav",511,100)

    -- end
	
	return false 
	
end

function Meta:TankGetLaunchVelocity( AmmoType )
//How to get launch speed:
// self:TankGetLaunchVelocity( self.AmmoTypes[ self.AmmoIndex ].Type )	
		
	local LaunchVelocity = AMMO_VELOCITY_HE_SHELL
	   
	if( table.HasValue( TANK_aMMO_SPEEDS, AmmoType ) ) then					   
		launchVelocity = TANK_aMMO_SPEEDS[ AmmoType ]
	else
		print("Ammo didnt exist in our Ammo table!!!!")
	end
	   
	return LaunchVelocity

end

print( "[NeuroTanks] neurotanksweapons.lua loaded!" )