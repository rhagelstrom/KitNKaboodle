--
-- Please see the license.txt file included with this distribution for
-- attribution and copyright information.
--

local onDragStartOriginal;

function onInit()
	if super and super.onInit then
		super.onInit();
	end

	onDragStartOriginal = detail.onDragStart;
	detail.onDragStart = onDetailsDragStart;
end

function onDetailsDragStart(_, _, _, draginfo)
	draginfo.setType("poweraction");
	draginfo.setIcon("action_roll");
	draginfo.setDatabaseNode(getDatabaseNode());
	return true;
end

function update(bReadOnly, bHideCast)
	if bReadOnly then
		resetMenuItems();
		detail.onDragStart = onDragStartOriginal;
	else
		registerMenuItem(Interface.getString("power_menu_actiondelete"), "radial_delete_action", 4);
		registerMenuItem(Interface.getString("list_menu_deleteconfirm"), "radial_delete_action_confirm", 4, 3);
		detail.onDragStart = onDetailsDragStart;
	end

	detail.setVisible(not bReadOnly);

	if contents and contents.subwindow and contents.subwindow.update then
		contents.subwindow.update(bReadOnly, bHideCast);
	end
end