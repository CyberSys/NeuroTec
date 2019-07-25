include("shared.lua")

if SERVER then
    SWEP.RenderTarget = GetRenderTarget( "materials/models/lt_c/tablet/screen9.vmt", 64, 64, true )
    SWEP.Font = surface.CreateFont( "7 SEGMENTAL DIGITAL DISPLAY", 50, 400, true, false, "7segment", false, false )
     
    local mat
     
    mat = Material("models/lt_c/tablet/screen9.vmt" )
    mat:SetMaterialTexture( "$basetexture", SWEP.RenderTarget )
          
    mat = Material( "models/lt_c/tablet/screen9.vmt" )
    mat:SetMaterialVector( "$tint", Vector( 1.2, 0, 0 ) )

end


 
 