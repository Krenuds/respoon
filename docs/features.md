# Features

Respoon is a development toolkit for FiveM -- a swiss army knife for building, testing, and directing scenes in GTA V multiplayer. Rather than organizing around entity types, Respoon is organized around **workflows**: inspect, spawn, direct, collaborate, and control. This page covers every major capability.

---

## Entity Inspector

The core development tool. Select any entity in the world and edit its properties in real-time through the Inspector panel. All changes apply instantly with optimistic updates and auto-persist to the database.

- **Props**: texture variation, alpha, visibility, collision, frozen, invincible, LOD distance
- **Vehicles** (27+ properties): primary/secondary/pearlescent/neon/wheel colors, engine/body/dirt/fuel health, 47 mod slots (performance and visual), lock/engine/roof state, up to 15 toggleable extras, individual door and window control, 193 config flags, plate text and style, window tint, livery
- **Peds** (16+ properties): health and armor, 12 drawable slots and 5 prop slots for clothing, freemode appearance (head blend, 20 face features, hair and eye color, 13 overlays), weapons, behavior configuration (alertness, combat ability/movement/range, seeing and hearing range), 462 config flags
- **Player entities**: root properties are editable (alpha, frozen, visible, collision, invincible) and players can serve as bodyguard targets
- Changes propagate to all connected editors via state bags -- no manual refresh needed

All changes propagate to connected editors via FiveM state bags -- no manual refresh needed.

---

## Spawning and Model Browser

A full-text searchable catalog for finding and placing any entity, effect, or animation in the game.

- **23,000+ models**: props, vehicles, and peds -- searchable by name
- **2,907 particle effects** across 364 dictionaries
- **269,000+ animation clips** with full-text search
- **190+ curated ambient scenarios**
- **Preview system**: click a model to preview it as a translucent ghost, position it with the transform gizmo, and press Enter to confirm placement
- **Favorites**: bookmark models and library entries for quick access
- **Filter modes**: All, Stock Models, Saved Library, Favorites

---

## Rooms and Collaboration

Isolated workspaces powered by FiveM routing buckets. Each room is a self-contained world where teams can build scenes without interfering with each other.

- Up to 62 concurrent rooms (FiveM routing bucket limit)
- Full isolation -- entities and players in different rooms are invisible to each other
- **Room roles**: Owner, Editor, Viewer with different permission levels
- Public and private room visibility
- Real-time collaborative editing -- multiple editors see changes instantly
- **Selection locking** prevents edit conflicts with a visual indicator showing who is editing what
- Auto-teleport option and configurable home position per room

Room owners control access through the [Permissions](permissions.md) system.

---

## Environment Controls

Full world control scoped to each room. 20 properties across 8 categories let you set up the exact conditions your scene requires.

- **Time**: set hour and minute, lock time to freeze the day/night cycle
- **Weather**: 15 presets including Clear, Rain, Snow, Blizzard, Thunder, Foggy, and more
- **Atmosphere**: wind speed and direction, rain level, snow level, ocean wave intensity
- **Sky**: cloud type and cloud opacity
- **Lighting**: blackout mode disables all artificial lights in the world
- **Effects**: gravity level, snow on ground, ped footprint tracks, vehicle tire trails
- **Timecycles**: visual filter system with adjustable strength -- apply cinematic looks without post-processing
- **Traffic**: toggle vehicle traffic and ped population independently, with automatic clearing of existing NPCs

Each room stores its own environment settings in the database. Changes broadcast to all room members in real time.

---

## Task Sequences and Ped AI

A visual task builder for scripting ped behavior without writing a single line of code. Build multi-step sequences, preview them in real time, and direct complex choreography across multiple peds.

- **21 step types** across categories:
  - **Movement**: go to coordinate, wander in area, wait in place, idle
  - **Interactions**: hands up, flee from entity, combat target
  - **Animation**: play animation clip (once, hold, loop, or timed), play ambient scenario
  - **Vehicle**: enter vehicle, leave vehicle, drive to coordinate, cruise/wander
  - **Combat**: protect/bodyguard a target with formation and distance settings
  - **Configuration**: set behavior, set config flags, clear behavior, clear tasks, apply properties
- **3 sequence modes**: Once (play through), Loop (repeat from start), Ping Pong (forward then reverse)
- **Frame property modifiers**: change weapon, faction, behavior, invincibility, and config flags at the start of any step
- **Cross-ped triggers**: fire and wait on named triggers to synchronize multi-ped choreography (e.g., Guard A reaches the door, then Guard B starts moving)
- **Drag-to-reorder** steps in the UI
- Dead peds automatically respawn on task reset

Task sequences persist to the database and survive server restarts.

---

## Factions and AI Relationships

A custom faction system that replaces GTA V's built-in relationship groups with something configurable and visual.

- **5 factions**: Player, Allies, Enemies, Civilians, Police
- **5x5 relationship matrix**: click cells to cycle between Ally, Neutral, and Enemy
- **Behavior presets**: Default, Passive, Defensive, Aggressive, Coward -- each applies a bundle of AI settings in one click
- **Bodyguard system**: assign any ped to follow and protect a target (ped or player) with configurable formation and follow distance
- **Room-scoped**: each room maintains its own faction relationships independently

---

## Particle Effects

Browse, preview, and place particle effects (PTFX) in 3D space. Particles are client-local by default -- the server stores metadata and each client spawns its own copy.

- **2,907 effects** across 364 dictionaries
- Preview effects before committing placement
- Adjustable position, rotation, and alpha
- Clone and duplicate particles with Ctrl+D
- Room-isolated with manual sync on room switch
- Collaborative editing with the same lock system used for entities

---

## Scene Playback

Room-wide playback controls for directing all task sequences at once. Use the toolbar or keyboard shortcuts to run, stop, and reset your scene.

- **Play from Start**: reset all peds to step 0 and run all task sequences
- **Stop**: halt all tasks, preserving current state for debugging
- **Reset Positions**: teleport all entities back to their saved database positions
- **Home teleport**: set a fixed position per room and return to it instantly
- Scene status indicators in the toolbar (idle, playing, stopped, reset)
- **Keyboard shortcuts**: PageDown (play), End (stop), Delete (reset in HUD mode)

---

## Entity Library

Save and reuse fully configured entities as reusable presets. Build once, spawn anywhere.

- Save any configured ped or vehicle as a library entry with full snapshot: properties, appearance, attachments
- **Composite entries**: parent entity plus all attached children saved and restored together
- Browse saved entries in the Library filter, search by name
- Rename, delete, and favorite library entries
- Owner-scoped -- each user manages their own library

---

## Admin Panel

Server-wide player and permission management for server operators.

- **Global player list** showing all connected players across all rooms
- **17 permissions** across 10 domains: entity, room, admin, player, particle, environment, faction, task, scene, and library
- **Role creation**: name, description, permission checkboxes, and priority level
- Assign roles to connected players from the admin panel
- **ACE integration**: `respoon.use` (required to open the editor) and `respoon.admin` (full permission bypass)
- Teleport players between rooms, kick players from rooms

For setup instructions, see the [Permissions](permissions.md) page.

---

## Additional Features

Respoon includes a set of tools and quality-of-life features that support the workflows above.

- **Freecam**: smooth camera controls for navigating the scene without moving your player
- **Transform gizmo**: translate and rotate entities in world or local space
- **Snap to ground**: drop entities to the terrain surface
- **Attachment system**: attach any entity to any other entity's bone with offset and rotation (single-depth)
- **3 UI themes**: Dark, Light, and Cyberpunk
- **HUD mode**: a minimal playback strip when the full editor is closed, toggled with the Home key
- **Recording mode**: capture clips compatible with Rockstar Editor
- **Copy and export**: copy entity JSON to clipboard or download a full snapshot
- **14 keyboard shortcuts** for common actions
- **Cross-resource API**: 8 server exports (`getPlayer`, `getAllPlayers`, `findEntity`, `getRoomEntities`, `getRoomParticles`, `getRoomState`, `getAllRooms`, `getSceneStatus`) for integration with other FiveM resources -- see [Exports API](exports.md)
