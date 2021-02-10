---------------------------------------------------------------
-- OVERRIDE MATERIALS LIST
list.Add("OverrideMaterials", "sprops/sprops_grid_12x12")
list.Add("OverrideMaterials", "sprops/sprops_grid_orange_12x12")
list.Add("OverrideMaterials", "sprops/sprops_plastic")
list.Add("OverrideMaterials", "sprops/trans/lights/light_plastic")
list.Add("OverrideMaterials", "sprops/trans/wheels/wheel_d_rim1")
list.Add("OverrideMaterials", "sprops/trans/wheels/wheel_d_rim2")
list.Add("OverrideMaterials", "sprops/textures/sprops_chrome")
list.Add("OverrideMaterials", "sprops/textures/sprops_chrome2")
list.Add("OverrideMaterials", "sprops/textures/gear_metal")
list.Add("OverrideMaterials", "sprops/textures/sprops_metal1")
list.Add("OverrideMaterials", "sprops/textures/sprops_metal2")
list.Add("OverrideMaterials", "sprops/textures/sprops_metal3")
list.Add("OverrideMaterials", "sprops/textures/sprops_metal4")
list.Add("OverrideMaterials", "sprops/textures/sprops_metal5")
list.Add("OverrideMaterials", "sprops/textures/sprops_metal6")
list.Add("OverrideMaterials", "sprops/textures/hex_dark_bump")
list.Add("OverrideMaterials", "sprops/textures/hex_dark_refl")
list.Add("OverrideMaterials", "sprops/textures/hex_light_bump")
list.Add("OverrideMaterials", "sprops/textures/hex_light_refl")
list.Add("OverrideMaterials", "sprops/trans/misc/ls_m1")
list.Add("OverrideMaterials", "sprops/trans/misc/ls_m2")
list.Add("OverrideMaterials", "sprops/textures/sprops_wood1")
list.Add("OverrideMaterials", "sprops/textures/sprops_wood2")
list.Add("OverrideMaterials", "sprops/textures/sprops_wood3")
list.Add("OverrideMaterials", "sprops/textures/sprops_wood4")
list.Add("OverrideMaterials", "sprops/trans/misc/tracks_wood")
list.Add("OverrideMaterials", "sprops/textures/sprops_cfiber1")
list.Add("OverrideMaterials", "sprops/textures/sprops_cfiber2")
list.Add("OverrideMaterials", "sprops/textures/sprops_rubber")
list.Add("OverrideMaterials", "sprops/textures/sprops_rubber2")
list.Add("OverrideMaterials", "sprops/trans/misc/beam_side")


if SERVER then
	---------------------------------------------------------------
    -- CUSTOM PA OFFSETS
    list.Set("PA_mirror_exceptions", "models/sprops/trans/wheel_d", Angle(180, 180, 0))
    list.Set("PA_mirror_exceptions", "models/sprops/trans/wheel_b", Angle(180, 180, 0))
    list.Set("PA_mirror_exceptions", "models/sprops/trans/miscwheels", Angle(180, 180, 0))
    list.Set("PA_mirror_exceptions", "models/sprops/trans/train", Angle(180, 180, 0))
    list.Set("PA_mirror_exceptions", "models/sprops/trans/lights", Angle(0, 180, 180))

    list.Set("PA_mirror_exceptions_specific", "models/sprops/trans/misc/gauge_1.mdl", Angle(0, 180, 180))
    list.Set("PA_mirror_exceptions_specific", "models/sprops/trans/misc/gauge_2.mdl", Angle(0, 180, 180))
    list.Set("PA_mirror_exceptions_specific", "models/sprops/trans/misc/gauge_3.mdl", Angle(0, 180, 180))
    list.Set("PA_mirror_exceptions_specific", "models/sprops/trans/train/track_t90_01.mdl", Angle(180, 90, 0))
    list.Set("PA_mirror_exceptions_specific", "models/sprops/trans/train/track_t90_02.mdl", Angle(180, 90, 0))

	return
end


---------------------------------------------------------------
-- SPROPS SPAWNLIST ORDER AND FILE LIST
local FILES = {
	{ name = "Blocks",                file = "materials/sprops/spawnlists/blocks.vmt" },
	{ name = "Plates - Normal",       file = "materials/sprops/spawnlists/plates_normal.vmt" },
	{ name = "Plates - Thin",         file = "materials/sprops/spawnlists/plates_thin.vmt" },
	{ name = "Plates - Superthin",    file = "materials/sprops/spawnlists/plates_superthin.vmt" },
	{ name = "Triangles - Normal",    file = "materials/sprops/spawnlists/triangles_normal.vmt" },
	{ name = "Triangles - Thin",      file = "materials/sprops/spawnlists/triangles_thin.vmt" },
	{ name = "Triangles - Superthin", file = "materials/sprops/spawnlists/triangles_superthin.vmt" },
	{ name = "Tubes - Normal",        file = "materials/sprops/spawnlists/tubes_normal.vmt" },
	{ name = "Tubes - Thin",          file = "materials/sprops/spawnlists/tubes_thin.vmt" },
	{ name = "Tubes - Superthin",     file = "materials/sprops/spawnlists/tubes_superthin.vmt" },
	{ name = "Cylinders",             file = "materials/sprops/spawnlists/cylinders.vmt" },
	{ name = "Geometry",              file = "materials/sprops/spawnlists/geometry.vmt" },
	{ name = "Geometry - Superthin",  file = "materials/sprops/spawnlists/geometry_superthin.vmt" },
	{ name = "Transportation",        file = "materials/sprops/spawnlists/transportation.vmt" },
	{ name = "Mechanics",             file = "materials/sprops/spawnlists/mechanics.vmt" },
	{ name = "Miscellaneous",         file = "materials/sprops/spawnlists/miscellaneous.vmt" },
}


---------------------------------------------------------------
-- SPROPS SPAWNLIST ICONS
local ICONS = {
	tree = "icon16/brick.png",
	on   = "icon16/plugin.png",
	off  = "icon16/plugin_disabled.png",
}


---------------------------------------------------------------
-- COPY CREATE CUSTOM NODE
local SPROPS_AddCustomizableNode = nil

local function SPROPS_SetupCustomNode(node, pnlContent)
	node.CustomSpawnlist = not node.AddonSpawnlist

	node.SetupCopy = function(self, copy)
		SPROPS_SetupCustomNode(copy, pnlContent)

		self:DoPopulate()

		copy.PropPanel = self.PropPanel:Copy()
		copy.PropPanel:SetVisible(false)
		copy.PropPanel:SetTriggerSpawnlistChange(true)
		copy.DoPopulate = function() end
	end

	node.DoPopulate = function(self)
		if IsValid(self.PropPanel) then return end

		self.PropPanel = vgui.Create("ContentContainer", pnlContent)
		self.PropPanel:SetVisible(false)
		self.PropPanel:SetTriggerSpawnlistChange(true)
	end

	node.DoClick = function(self)
		self:DoPopulate()
		pnlContent:SwitchPanel(self.PropPanel)
	end
end

SPROPS_AddCustomizableNode = function(pnlContent, name, icon, parent)
	local node = parent:AddNode(name, icon)
	node.AddonSpawnlist = parent.AddonSpawnlist

	SPROPS_SetupCustomNode(node, pnlContent)

	return node
end


---------------------------------------------------------------
-- POPULATE SPAWNLIST
hook.Add("PopulateContent", "sprops_spawnlists", function(pnlContent, tree, browse)
	-- disable browse node to prevent crashes
	timer.Simple(1, function()
		for _, bNode in ipairs(browse:GetChildNodes()) do
			if bNode:GetText() == "Addons" then
				for _, aNode in ipairs(bNode:GetChildNodes()) do
					if string.find(aNode:GetText(), "SProps Workshop Edition") then
						aNode.Label:SetEnabled(false)
						aNode.Label:SetTextColor(Color(75, 55, 55, 55))
						aNode.Label.DoClick = function() end
						aNode.Label.DoDoubleClick = function() end
						aNode.Label.DoRightClick = function() end
						break
					end
				end
				break
			end
		end
	end)

	-- create custom tree
	local node = SPROPS_AddCustomizableNode(pnlContent, "SProps", ICONS.tree, tree)

	node:SetExpanded(true)
	node.DoRightClick = function() end
	node.OnModified = function() end

	local last
	node.OnNodeSelected = function(self, node)
		if last and last ~= self then
			last:SetIcon(ICONS.off)
			last = nil
		end
		if node and node ~= self then
			last = node
			last:SetIcon(ICONS.on)
		end
	end

	node.AddonSpawnlist = true
	node.CustomSpawnlist = nil

	for k, v in ipairs(FILES) do
		local pnlnode = SPROPS_AddCustomizableNode(pnlContent, v.name, ICONS.off, node, nil)

		if not v.contents then
			local data = file.Read(v.file, "GAME")
			if data then
				v.contents = util.JSONToTable(data)
			end
		end

		pnlnode:SetExpanded(true)

		pnlnode.OnRemove = function(self)
			if IsValid(self.PropPanel) then
				self.PropPanel:Remove()
			end
		end

		pnlnode.DoPopulate = function(self)
			if IsValid(self.PropPanel) then
				return
			end

			self.PropPanel = vgui.Create("ContentContainer", pnlContent)
			self.PropPanel:SetVisible(false)
			self.PropPanel:SetTriggerSpawnlistChange(true)
			if node.AddonSpawnlist then
				self.PropPanel.IconList:SetReadOnly(true)
			end

			if v.contents then
				for _, object in ipairs(v.contents) do
					local cp = spawnmenu.GetContentType(object.type)
					if cp then
						cp(self.PropPanel, object)
					end
				end
			end
		end
	end
end)

---------------------------------------------------------------
-- COMMAND FOR RELOADING VGUI
concommand.Add("sprops_reload_spawnlists", function()
	for k, v in ipairs(FILES) do
		v.contents = nil
	end
	hook.Run("OnGamemodeLoaded")
end)

--[[
local files, folders = file.Find("materials/settings/spawnlist/sprops/*.vmt", "GAME")

for k, v in ipairs(files) do

	local name = string.StripExtension(v)

	name = string.Right(name, #name - 4)
	name = string.Replace(name, "-", "_")

	local info = util.KeyValuesToTable(file.Read("materials/settings/spawnlist/sprops/" .. v, "GAME"))

	local data = {}

	for i, j in ipairs(info.contents) do
		if j.type == "header" then
			table.insert(data, { type = "header", text = j.text })
		end
		if j.type == "model" then
			table.insert(data, { type = "model", model = j.model })
		end
	end

	file.Write("materials/sprops/spawnlists/" .. name .. ".vmt", util.TableToJSON(data, false))
end
]]
