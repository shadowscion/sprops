
--[[
    My attempt at getting around garry's brilliant idea of blocking .txt files from the workshop.

    This loads the spawnlists (in the same layout) from .vmt files instead, and adds them to
    custom, non-ingame editable nodes below the default spawnlist node.

    -- by shadowscion


    Example 1:
        spawnmenu.AddCustomSpawnlistNode( "SProps", "materials/settings/spawnlist/sprops/", "icon16/brick.png" )

    Example 2:
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

]]--


------------------------------------------------------------
-- Reload game menu

concommand.Add( "custom_spawnlist_reloadvgui", function()
    MsgC( Color( 255, 125, 0 ), "Reloaded VGUI\n" )
    hook.Run( "OnGamemodeLoaded" )
end )


------------------------------------------------------------
-- Create custom spawnlists
-- "options" argument is a table of functions to add to each node

local customSpawnlists = {}

function spawnmenu.AddCustomSpawnlistNode( name, folder, icon, options )

    if not string.EndsWith( folder, "/" ) then folder = folder .. "/" end

    local spawnList = {
        name   = name,
        folder = folder,
        icon   = icon or "icon16/heart.png",
        options = options,
    }

    customSpawnlists[name] = spawnList

    return spawnlist

end


------------------------------------------------------------
-- Custom spawnlist header

surface.CreateFont( "CustomSpawnlistHeader",
{
    font      = "Helvetica",
    size      = 40,
    weight    = 1000,
    antialias = true,
} )

local function addCustomHeader( container, object )

    local control = vgui.Create( "ContentHeader", container )

    control:SetText( object.text )
    control:SetFont( "CustomSpawnlistHeader" )

    control.DoRightClick = function() end
    control.OpenMenu = function() end

    container:Add( control )

end


------------------------------------------------------------
-- Custom spawnlist icon

local function addCustomIcon( container, object )

    local control = vgui.Create( "SpawnIcon", container )

    control:InvalidateLayout( true )
    control:SetWide( 64 )
    control:SetTall( 64 )
    control:SetModel( object.model )
    control:SetTooltip( string.Replace( string.GetFileFromFilename( object.model ), ".mdl", "" ) )

    control.DoClick = function( self )
        surface.PlaySound( "ui/buttonclickrelease.wav" )
        RunConsoleCommand( "gm_spawn", self:GetModelName(), self:GetSkinID() or 0, self:GetBodyGroup() or "" )
    end

    control.OpenMenu = function( self )
        local menu = DermaMenu()

        menu:AddOption( "Copy to Clipboard", function()
            SetClipboardText( string.gsub( object.model, "\\", "/" ) )
        end )

        local submenu = menu:AddSubMenu( "Re-Render", function() self:RebuildSpawnIcon() end )
        submenu:AddOption( "This Icon", function() self:RebuildSpawnIcon() end )
        submenu:AddOption( "All Icons", function() container:RebuildAll() end )

        menu:Open()
    end

    control:InvalidateLayout( true )
    container:Add( control )

end


------------------------------------------------------------
-- Custom spawnlist content panel

local function addCustomContent( self, pnlContent, contents )

    if self.ContentsPanel then return end

    self.ContentsPanel = vgui.Create( "CUSTOM_ContentContainer", pnlContent )
    self.ContentsPanel:SetVisible( false )
    self.ContentsPanel.IconList:SetBaseSize( 64 )

    for _, object in SortedPairs( contents ) do
        if type( object.type ) ~= "string" then continue end

        if object.type == "model" then
            addCustomIcon( self.ContentsPanel, object )
            continue
        end

        if object.type == "header" then
            addCustomHeader( self.ContentsPanel, object )
        end
    end

end


------------------------------------------------------------
-- Recursive file folder searching

local function recursiveFileSearch( dir, ext, gfolder, onFind )

    local _, folders = file.Find( dir .. "*", gfolder )
    for _, folder in pairs( folders ) do
        recursiveFileSearch( dir .. folder, ext, gfolder, onFind )
    end

    for _, fileFound in pairs( file.Find( dir .. "*." .. ext, gfolder ) ) do
        if onFind then onFind( dir, fileFound ) end
    end

end


------------------------------------------------------------
-- Check if spawnlist has proper values

local function validSpawnlist( info )
    if not info then return false end
    if not info.name or type( info.name ) ~= "string" then return false end
    if not info.icon or type( info.icon ) ~= "string"  then return false end
    if not info.contents  or type( info.contents ) ~= "table" then return false end

    return true
end


------------------------------------------------------------
-- Populate custom spawnlists

local function populateCustomSpawnlists( pnlContent, tree, node )

    for _, data in pairs( customSpawnlists ) do
        -- get files in folder
        local files = {}
        recursiveFileSearch( data.folder, "vmt", "GAME", function( dir, fileFound )
            files[#files + 1] = fileFound
        end )

        if #files == 0 then continue end

        -- add node
        local custom = tree:AddNode( data.name, data.icon )

        -- add tree
        for _, path in pairs( files ) do
            local info = util.KeyValuesToTable( file.Read( data.folder .. path, "GAME" ) )

            if not validSpawnlist( info ) then
                MsgC( Color( 255, 125, 0 ), "Malformed custom spawnlist <" .. data.folder .. path .. ">" )
                continue
            end

            local newNode = custom:AddNode( info.name, info.icon )

            newNode.DoClick = function( self )
                addCustomContent( self, pnlContent, info.contents )
                pnlContent:SwitchPanel( self.ContentsPanel )
            end

            -- add custom options if they exist
            if not data.options then continue end
            for k, value in pairs( data.options ) do
                newNode[k] = value
            end
        end
    end

end

hook.Add( "PopulateContent", "populate_custom_spawnlists_vmt", populateCustomSpawnlists )
