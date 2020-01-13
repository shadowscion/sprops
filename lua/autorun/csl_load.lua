
if SERVER then
	--
    AddCSLuaFile()

    AddCSLuaFile( "csl/custom_spawnlist.lua" )
    AddCSLuaFile( "csl/vgui/custom_tilelayout.lua" )
    AddCSLuaFile( "csl/vgui/custom_contentcontainer.lua" )

    -- custom PA offsets
    list.Set( "PA_mirror_exceptions", "models/sprops/trans/wheel_d", Angle( 180, 180, 0 ) )
    list.Set( "PA_mirror_exceptions", "models/sprops/trans/wheel_b", Angle( 180, 180, 0 ) )
    list.Set( "PA_mirror_exceptions", "models/sprops/trans/miscwheels", Angle( 180, 180, 0 ) )
    list.Set( "PA_mirror_exceptions", "models/sprops/trans/train", Angle( 180, 180, 0 ) )
    list.Set( "PA_mirror_exceptions", "models/sprops/trans/lights", Angle( 0, 180, 180 ) )

    list.Set( "PA_mirror_exceptions_specific", "models/sprops/trans/misc/gauge_1.mdl", Angle( 0, 180, 180 ) )
    list.Set( "PA_mirror_exceptions_specific", "models/sprops/trans/misc/gauge_2.mdl", Angle( 0, 180, 180 ) )
    list.Set( "PA_mirror_exceptions_specific", "models/sprops/trans/misc/gauge_3.mdl", Angle( 0, 180, 180 ) )
    list.Set( "PA_mirror_exceptions_specific", "models/sprops/trans/train/track_t90_01.mdl", Angle( 180, 90, 0 ) )
    list.Set( "PA_mirror_exceptions_specific", "models/sprops/trans/train/track_t90_02.mdl", Angle( 180, 90, 0 ) )

end

if CLIENT then

	-- 
	include( "csl/vgui/custom_tilelayout.lua" )
	include( "csl/vgui/custom_contentcontainer.lua" )

	include( "csl/custom_spawnlist.lua" )

	-- custom sprops spawnlists
	spawnmenu.AddCustomSpawnlistNode( "SProps", "materials/settings/spawnlist/sprops/", "icon16/brick.png", {
	    OnNodeSelected = function( self )
	        local parent = self:GetParentNode()

	        if parent.LastActiveNode then
	            parent.LastActiveNode:SetIcon( "icon16/plugin_disabled.png" )
	        end

	        self:SetIcon( "icon16/plugin.png" )
	        parent.LastActiveNode = self
	    end
	} )

end

-- materials list
list.Add( "OverrideMaterials", "sprops/sprops_grid_12x12" )
list.Add( "OverrideMaterials", "sprops/sprops_grid_orange_12x12" )
list.Add( "OverrideMaterials", "sprops/sprops_plastic" )
list.Add( "OverrideMaterials", "sprops/trans/lights/light_plastic" )
list.Add( "OverrideMaterials", "sprops/trans/wheels/wheel_d_rim1" )
list.Add( "OverrideMaterials", "sprops/trans/wheels/wheel_d_rim2" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_chrome" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_chrome2" )
list.Add( "OverrideMaterials", "sprops/textures/gear_metal" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_metal1" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_metal2" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_metal3" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_metal4" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_metal5" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_metal6" )
list.Add( "OverrideMaterials", "sprops/trans/misc/ls_m1" )
list.Add( "OverrideMaterials", "sprops/trans/misc/ls_m2" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_wood1" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_wood2" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_wood3" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_wood4" )
list.Add( "OverrideMaterials", "sprops/trans/misc/tracks_wood" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_cfiber1" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_cfiber2" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_rubber" )
list.Add( "OverrideMaterials", "sprops/textures/sprops_rubber2" )
list.Add( "OverrideMaterials", "sprops/trans/misc/beam_side" )
