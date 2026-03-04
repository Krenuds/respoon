# Getting Started

This guide walks you through your first session with Respoon. By the end, you will have created a room, spawned an entity, edited its properties, and adjusted the environment.

## Opening the Editor

Type `/rs` in the FiveM chat to open the Respoon editor. The interface has three main areas:

- **Left panel** -- Scene management, entity hierarchy, and model browser tabs.
- **Right panel** -- Inspector for the selected entity's properties.
- **3D viewport** -- The game world with freecam navigation and transform gizmos.

The editor activates freecam mode, giving you full camera control to navigate the scene independently of your player character.

## Creating a Room

Rooms are isolated workspaces. Each room maps to a FiveM routing bucket, so entities and players in different rooms cannot see each other.

1. Open the **Scene** tab in the left panel.
2. Enter a **name** for your room.
3. Optionally add a **description** and toggle **Public** to let other players find and join it.
4. Click **Create**.

You are now in your own room. Any entities you spawn here are isolated from the rest of the server.

## Spawning Your First Entity

1. Open the **Browser** tab in the left panel.
2. Select a sub-tab: **Props**, **Vehicles**, or **Peds**.
3. Search by name in the search bar (e.g., "adder" for a vehicle, "cop" for a ped, "bench" for a prop).
4. Click a result to enter placement mode. A translucent preview of the entity appears at your cursor.
5. Use the gizmos to position it:
   - **W** -- Move gizmo (drag along axes to reposition).
   - **E** -- Rotate gizmo (drag to change orientation).
6. Press **Enter** to confirm placement. The entity is spawned, synced to the server, and saved to the database.

## Editing Properties

1. Click an entity in the viewport or select it from the hierarchy panel to select it.
2. The **Inspector** panel on the right displays all editable properties for that entity type.
3. Modify values using sliders, toggles, color pickers, and dropdowns:
   - **Vehicles** -- primary/secondary color, livery, modifications, doors, windows, extras, neon lights.
   - **Peds** -- weapon, animation, faction, behavior preset (passive, defensive, aggressive), appearance.
   - **All entities** -- alpha (transparency), visibility, collision, frozen state, invincibility, LOD distance.
4. Changes apply immediately in the game world. All modifications are automatically saved to the database.

## Environment Controls

Environment settings affect the entire room -- every player in the room sees the same time, weather, and atmosphere.

1. Click the **Scene Settings** button (sunset icon) in the toolbar.
2. Adjust settings across categories:
   - **Time** -- Set hour and minute. Toggle time lock to freeze the clock.
   - **Weather** -- Select from 15 presets (clear, clouds, rain, thunder, snow, fog, and more).
   - **Atmosphere** -- Wind speed, wind direction, rain level, snow level.
   - **Lighting** -- Blackout mode to disable artificial lights.
   - **Effects** -- Gravity, snow ground textures, ped footprint tracks, vehicle tire trails.
   - **Traffic** -- Enable or disable ambient vehicle traffic and pedestrian population.
3. All environment changes are room-scoped and persist across sessions.

## Saving Your Work

Entities are automatically saved to the database as you create and modify them. No manual save is needed for basic work.

To save an entity configuration for reuse across rooms:

1. Select the entity you want to save.
2. Click the **Save to Library** button (floppy disk icon) in the Inspector panel.
3. Enter a **name** and an optional **description**.
4. The entity is saved to your library with all its current properties, appearance, and attachments.

You can spawn library entries into any room from the Library tab in the Browser panel.

## Keyboard Shortcuts

| Key | Action |
| --- | --- |
| W | Move gizmo |
| E | Rotate gizmo |
| Q | Toggle coordinate space (local / world) |
| Space | Snap entity to ground |
| Ctrl+D | Clone selected entity |
| Delete | Delete selected entity |
| Enter | Confirm placement |
| Escape | Cancel placement / close panels |

For the full list, see the [Keyboard Shortcuts](shortcuts.md) reference.

## Next Steps

- [Features Overview](features.md) -- Detailed coverage of every feature.
- [Permissions](permissions.md) -- Room roles and granular access control.
- [Exports API](exports.md) -- Integrate Respoon into your own resources.
