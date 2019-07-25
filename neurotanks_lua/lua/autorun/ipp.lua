//Thanks to Kogitsune for the Impact Point Prediction code. :D
local sv_gravity = GetConVar( "sv_gravity" )
local Meta = FindMetaTable("Entity")

Meta.BoxColor = Color( 000, 000, 000, 180 )
Meta.TextColor = Color( 255, 128, 000, 255 )

Meta.Numbers = { }

Meta.TargetPos = nil
Meta.BigPitch = nil
Meta.LowPitch = nil

Meta.State = "ASST OFF"

function Meta:GetGravAccel( )
    --I was going to do the fancy form of getting the real gravitational acceleration here
    --But it made my head hurt and I had to guess at variables
    --So here's the ultimate guess!
    
    return ( sv_gravity:GetInt( ) / 600 ) * ( 600 / -16 )
end

function Meta:CalculateTrajectory( )
    local theta, g, d, v, tr, a, b, x, y, k, v, v2, v4, x2, p, q, n
    
    tr = util.TraceLine{start = self.Pilot:EyePos( ),
						-- endpos = self.Pilot:EyePos( ) + self.Pilot:GetAimVector( ) * 8192,
						endpos = self.Pilot:GetShootPos(),
						filter = self.Pilot,self,self.Barrel,
						mask = MASK_SHOT }
    
    a = tr.HitPos
    b = self.Barrel:GetPos()
    
    a = a - b
    
    y = math.abs( a.z )
    
    a.z = 0
    
    d = a:Length( )
    
    g = self:GetGravAccel( )
    
    v = 500  --velocity of entity
    
    v2 = v * v
    v4 = v2 * v2
    x = d
    x2 = x * x
    
    k = math.atan( ( ( v2 + ( v4 - g * ( g * x2 + 2 * y * v2 ) ) ^ .5 ) / ( g * x ) ) )
    v = math.atan( ( ( v2 - ( v4 - g * ( g * x2 + 2 * y * v2 ) ) ^ .5 ) / ( g * x ) ) )
    
    if math.min( k, v ) == math.huge then
        --It isn't possible to hit it from here, according to this math
        self.State = "ASST ERR"
        self.TargetPos = nil
--		self:EmitSound( self.Sounds.Error, 30 )
        return
    end
    
    k = 90 + math.deg( k )
    v = 90 + math.deg( v )
    
--	p = tr.HitPos:ToScreen( )
    q = self.Pilot:EyeAngles( )
    
    n = q.p
    
    q.p = n - math.min( k, v )
    self.LowPitch = q:Forward( ) * v * .5
    
    q.p = n - math.max( k, v )
    theta = q.p
    
    self.BigPitch = q:Forward( ) * v * .5
    
    self.TargetPos = tr.HitPos
    
--	self.YCoord = ( self.Pilot:GetShootPos( ) + q:Forward( ) * 6 ):ToScreen( ).y
--	self.State = "ASST ON"
    
--	self:EmitSound( self.Sounds.LockedOn, 30 )
	-- return self.YCoord
	print(theta)
	return theta
end

function Meta:DrawTrajectoryHUD( )
    self:PilotChanged( )
	self:CalculateTrajectory()
	local x, y, w, h, r, n, i, s, a, b, p, q, z, pos
    
    surface.SetFont( "Grenade_Computer_Screen" )
    
    r, n = surface.GetTextSize( " " )
        
    w = ( 4 + 8 + 2 ) * r
    h = n * 6
    
    x = surface.ScreenWidth( ) - ( w + r )
    y = surface.ScreenHeight( ) * .5 - ( h + n * 2 ) * .5
    
    draw.RoundedBox( 1, x, y, w + r, h + n, self.BoxColor )
    
    y = y
    x = x
    
    self.LastUpdate = self.LastUpdate or CurTime( )
    self.LastPos = self.LastPos or LocalPlayer( ):GetPos( )
    
    pos = LocalPlayer( ):GetPos( )
    
    if pos:Distance( self.LastPos ) > 2 and self.TargetPos then
        --We've moved, probably not accurate anymore
        self.State = "ASST ERR"
        self.TargetPos = nil
--		self:EmitSound( self.Sounds.Error, 30 )
    end
    
    if self.Locked or self.Reloading and self.TargetPos then
        self.TargetPos = nil
        self.State = "LOCKED"
    end
    
    self.LastPos = pos
    
    for i = 1, 6 do
        s = "&x%02x %04x %04x"
        
        a = math.random( 65535 )
        b = math.random( 65535 )
        
        a = tostring( a ):sub( 1, 4 )
        b = tostring( b ):sub( 1, 4 )
        
        if i > self.Grenades then
            a = 65535
            b = 65535
        end
        
        if not self.Numbers[ i ] then
            self.Numbers[ i ] = { a, b }
        end
        
        if CurTime( ) > self.LastUpdate + .15 then
            self.Numbers[ i ][ 1 ] = a
            self.Numbers[ i ][ 2 ] = b
        end
        
        s = s:format( i, self.Numbers[ i ][ 1 ], self.Numbers[ i ][ 2 ] ):upper( )
        
        draw.DrawText( s, "Grenade_Computer_Screen", x, y, self.TextColor, TEXT_ALIGN_LEFT )
        
        y = y + n
    end
    
    draw.DrawText( "&X07 " .. self.State, "Grenade_Computer_Screen", x, y, self.TextColor, TEXT_ALIGN_LEFT )
    
    if CurTime( ) > self.LastUpdate + .15 then
        self.LastUpdate = CurTime( )
    end
    
    surface.SetDrawColor( 189, 000, 189, 120 )
    
    if self.TargetPos then
        p = self.TargetPos:ToScreen( )
        q = self.Pilot:EyePos( )
        
        z = ( q + self.LowPitch ):ToScreen( )
        
        surface.DrawRect( p.x - ScrW( ) * .0125, z.y - ScrH( ) * .0125, ScrW( ) * .025, ScrH( ) * .025 )
        
        z = ( q + self.BigPitch ):ToScreen( )
        
        surface.SetDrawColor( 000, 189, 189, 120 )
        
        surface.DrawRect( p.x - ScrW( ) * .0125, z.y - ScrH( ) * .0125, ScrW( ) * .025, ScrH( ) * .025 )
    end
    
    surface.SetDrawColor( 255, 000, 000, 150 )
    
    x = ScrW( ) * .5 - 1
    y = ScrH( ) * .5 - 1
    w = ScrW( ) * .0125 * .5
    h = ScrH( ) * .0125 * .5
    
    surface.DrawRect( x - w * .5, y - h * .5, w, h )
end

print( "[NeuroTanks] IPP.lua loaded!" )