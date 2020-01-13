
local PANEL = {}

DEFINE_BASECLASS( "DScrollPanel" );

AccessorFunc( PANEL, "m_pControllerPanel",              "ControllerPanel" )
AccessorFunc( PANEL, "m_strCategoryName",               "CategoryName" )
AccessorFunc( PANEL, "m_bTriggerSpawnlistChange",       "TriggerSpawnlistChange" )


function PANEL:Init()

    self:SetPaintBackground( false )

    self.IconList = vgui.Create( "CUSTOM_TileLayout", self:GetCanvas() )
    self.IconList:SetBaseSize( 64 )
    self.IconList:SetSelectionCanvas( true )

    self.IconList:Dock( TOP )
    self.IconList.OnModified = function() self:OnModified() end

end

function PANEL:Add( pnl )

    self.IconList:Add( pnl )

    if pnl.InstallMenu then
        pnl:InstallMenu( self )
    end

    self:Layout()

end

function PANEL:Layout()

    self.IconList:Layout()
    self:InvalidateLayout()

end

function PANEL:PerformLayout()

    BaseClass.PerformLayout( self )
    self.IconList:SetMinHeight( self:GetTall() - 16 )

end


function PANEL:RebuildAll( proppanel )

    local items = self.IconList:GetChildren()

    for k, v in pairs( items ) do

        v:RebuildSpawnIcon()

    end

end


function PANEL:GetCount()

    local items = self.IconList:GetChildren()
    return #items

end


function PANEL:Clear()

    self.IconList:Clear( true )

end

function PANEL:OnModified()


end


function PANEL:ContentsToTable( contentpanel )

    local tab = {}

    local items = self.IconList:GetChildren()

    for k, v in pairs( items ) do

        v:ToTable( tab )

    end

    return tab

end

vgui.Register( "CUSTOM_ContentContainer", PANEL, "DScrollPanel" )
