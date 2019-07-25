if SERVER then
	util.AddNetworkString( "NeuroTec_MissileBase_Text" )

elseif CLIENT then
	local message_codes = {
		[1] = "This is an admin only weapon!",
		[2] = " Armed!",
		[3] = " stepped on his own landmine!",
		[4] = " stepped on ",
		[5] = " stepped on your bouncing betty!",
		[6] = "You stepped on your own bouncing betty!",
		[7] = " stepped on your claymore!",
	}

	local neurotec_tag_colour = Color( 52, 152, 219 )
	local message_text_colour = Color( 255, 255, 255 )

	net.Receive( "NeuroTec_MissileBase_Text", function( length )
		local message_code = net.ReadInt( 32 )
		local message_code_string = net.ReadString()
		local message_code_string_2 = net.ReadString()

		local message_code_locate = message_codes[message_code]

		if message_code == 2 then
			chat.AddText( neurotec_tag_colour, "[NeuroTec] ", message_text_colour, message_code_string .. message_code_locate )
			return
		elseif message_code == 3 then
			chat.AddText( neurotec_tag_colour, "[NeuroTec] ", message_text_colour, message_code_string .. message_code_locate )
			return
		elseif message_code == 4 then
			chat.AddText( neurotec_tag_colour, "[NeuroTec] ", message_text_colour, message_code_string .. message_code_locate .. message_code_string_2 .. "'s landmine!" )
			return
		elseif message_code == 5 then
			chat.AddText( neurotec_tag_colour, "[NeuroTec] ", message_text_colour, message_code_string .. message_code_locate )
			return
		elseif message_code == 7 then
			chat.AddText( neurotec_tag_colour, "[NeuroTec] ", message_text_colour, message_code_string .. message_code_locate )
			return
		end
		chat.AddText( neurotec_tag_colour, "[NeuroTec] ", message_text_colour, message_code_locate )
	end)
end

print( "[NeuroWeapons] neuroweapons_messages.lua loaded!" )