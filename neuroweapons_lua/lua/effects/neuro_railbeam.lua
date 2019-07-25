-- Credit to Garry for original Egon Beam effect from the old GMDM Gamemode. 
-- Modernized and adapted for NeuroWeapons by Hoffa1337
if SERVER then 
	AddCSLuaFile()
end 

EFFECT.Mat 		= Material(  "sprites/tp_beam001" )--"effects/strider_tracer" ) -- "sprites/flamelet5" )--"sprites/yellowflare" ) --
EFFECT.HelixMat = Material(  "sprites/tp_beam001" ) -- "sprites/flamelet5" )--"" ) --
EFFECT.Refract 	= Material("effects/fas_glow_debris");
EFFECT.MaxLife 	= .75

function EFFECT:Init( data )
	
	self.Owner		 = data:GetEntity()
	self.StartPos 	 = data:GetStart()
	self.EndPos 	 = data:GetOrigin()
	self.Angles		 = data:GetAngles()
	self.LifeTime = CurTime() + self.MaxLife
	
end

function EFFECT:Think( )

	if CurTime() > self.LifeTime then return false end

	return true
	
end

function EFFECT:Render( )

	local StartPos = self.StartPos;
	local EndPos = self.EndPos;
	local Ang = (EndPos-StartPos):GetNormal():Angle()
	local Forward	= Ang:Forward();
	local Right 	= Ang:Right();
	local Up 		= Ang:Up();
	local Distance 	= StartPos:Distance(EndPos);
	local StepSize  = 20
	local LastPos;
	local fadeOut =  ( self.LifeTime  - CurTime() ) / self.MaxLife 
	local RingTightness = 2
	local RingRadius = 4
	
	render.SetMaterial(self.Refract);
	render.DrawSprite(
		EndPos + (EndPos-StartPos):GetNormal()* -16,
		256*fadeOut,256*fadeOut,
		Color(255,255,255,math.Clamp( 255*fadeOut, 0, 255 ))
	);
	render.DrawSprite(
		StartPos,
		128*fadeOut,128*fadeOut,
		Color(255,255,255,math.Clamp( 255*fadeOut, 0, 255 ))
	);

	for i=1, Distance, StepSize do
		
		local sin = math.sin( math.rad( i * RingTightness ) ) ;
		local cos = math.cos( math.rad( i * RingTightness ) );
		local Pos = StartPos+(Forward*i)+(Up*sin*RingRadius)+(Right*cos*RingRadius);
		
		if LastPos then
		
			render.SetMaterial( self.HelixMat )
			render.DrawBeam(LastPos,Pos,14*fadeOut,0,math.sin(CurTime())*100,Color(255,55,55,math.Clamp( 255*fadeOut, 0, 255 ) ) )
			
		end
		
		LastPos = Pos
		
		if ( i >= Distance - StepSize ) then			
		
			local adjustPos = Pos - (Up*sin*RingRadius)-(Right*cos*RingRadius);
			
			render.SetMaterial( self.Mat )
			render.DrawBeam(StartPos, adjustPos, 18*fadeOut, -math.sin(CurTime())*11,math.sin(CurTime())*11, Color(255,55,55, math.Clamp( 255*fadeOut, 0, 255  ) ) );
			
		end
		
	end
	
end
