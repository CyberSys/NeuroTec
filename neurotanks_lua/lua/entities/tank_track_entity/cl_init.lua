include('shared.lua')

function ENT:Initialize()

	
	if( self:GetBoneCount() > 1 ) then 
	
		self.BonePositions = {}
		
		for i=0,self:GetBoneCount() do 
			
			local bp,ba = self:GetBonePosition( i )
			
			if( bp && string.find( string.lower(self:GetBoneName(i)), "tread" ) != nil ) then 
			
				table.insert( self.BonePositions, { Pos = self:WorldToLocal( bp ), Idx = i } )
		
			end 
		
		end 
		
	
	end 
	
end


function ENT:Draw()
	if( self:GetBoneCount() > 1  ) then 
		-- for i=1,track:GetBoneCount() do
		for i=1,#self.BonePositions   do 
		

			--local bp,ba = self:GetBonePosition( i )
			local bp =self.BonePositions[i].Pos 
			if( bp ) then 
			-- print( bp, ba )
				-- print( self:GetModel() )
				local lpos = self:LocalToWorld( bp ) 
				local tr,trace={},{}
				if( lpos.y >= 0 ) then 
					lpos.y = lpos.y + 20 
				else
					lpos.y = lpos.y - 20 
				end 
				
				tr.start = lpos + self:GetUp()*-1
				tr.endpos =  lpos + self:GetUp() * -100
				tr.filter = { self } 
				tr.mask = MASK_SOLID
				trace = util.TraceLine( tr )
				local c = Color( 255, 0,0, 255 )
				if( trace.Hit ) then 
					 c = Color( 0, 255,0, 255 )
				end 
				
				local dist = math.Clamp( self:WorldToLocal( trace.HitPos ).z - self.BonePositions[i].Pos.z +16, -100, 1 )*1.5
				-- print( dist )
				-- print( math.Clamp( dist, -100, 16  ) )
				self:ManipulateBonePosition( i, Vector(0,dist,0 ) )
				debugoverlay.Line( tr.start, trace.HitPos, 1.1, c, true )
				-- self:DrawLaserTracer( bp,tr.endpos	)
				
			end 
		
		
		end 
		
	end 
	
		
	self:DrawModel()
	
end

function ENT:OnRemove()

end
