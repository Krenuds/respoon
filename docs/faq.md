# Frequently Asked Questions

## General

**What is Respoon?**

Respoon is a real-time development toolkit for FiveM. It provides entity inspection, property editing, ped AI scripting, environment controls, particle effects, and collaborative room-based editing -- all without server restarts. See the [Introduction](introduction.md) for a full overview.

**What are the requirements?**

- FiveM server (artifact build 5181 or later)
- MySQL 5.7+ or MariaDB 10.2+
- oxmysql (recommended database driver)
- ox_lib
- ox_core

See [Installation](installation.md) for full setup instructions.

**Does Respoon work with ESX, QBCore, or standalone?**

Respoon requires ox_core as its player and character framework. It does not currently support ESX, QBCore, or standalone server configurations.

**How many rooms can run simultaneously?**

Up to 62 concurrent rooms. This limit comes from FiveM routing buckets, which Respoon uses for room isolation (bucket 0 is reserved for the default world, buckets 1-62 are available for rooms).

**How many entities can a room hold?**

The soft limit is 500 entities per room for optimal performance, with a hard limit around 1,000. Props have lower sync overhead and can go higher -- up to approximately 5,000 in prop-only scenes.

---

## Installation and Setup

**First boot takes a long time. Is that normal?**

Yes. On first start, Respoon seeds the model catalog (approximately 23,000 models) and animation catalog (approximately 269,000 clips). This process takes roughly 30 seconds. Do not restart the server during seeding. All subsequent starts are instant.

**I get "Failed to verify protected resource." What do I do?**

The hidden `.fxap` file was not copied during extraction. Re-extract the resource ZIP and make sure your archive tool preserves hidden files. On Windows, 7-Zip and WinRAR handle this correctly. The built-in Windows extractor may skip hidden files.

**The editor does not open when I type /rs.**

Check the following:

1. The player must have the `respoon.use` ACE permission. Add this to your `server.cfg` or `permissions.cfg`:
   ```
   add_ace builtin.everyone respoon.use allow
   ```
2. Verify Respoon is running: type `ensure respoon` in the server console.
3. Check the server console for startup errors.

See [Permissions](permissions.md) for a full breakdown of ACE permissions.

**I see database errors on startup.**

Ensure your MySQL or MariaDB server is running and the connection string in `server.cfg` is correct. Respoon requires MySQL 5.7+ or MariaDB 10.2+. If you are using oxmysql (recommended), no additional database configuration is needed beyond the standard connection string. Respoon creates its own tables automatically on first boot.

**What is the correct resource load order?**

Respoon must load after ox_core and ox_lib. The recommended order in `server.cfg` is:

```
ensure chat
ensure oxmysql
ensure ox_lib
ensure ox_core
# ... other ox extensions (ox_inventory, ox_target, etc.)
ensure respoon
```

Loading Respoon before its dependencies will cause startup failures.

---

## Usage

**How do I give someone admin access?**

Add the `respoon.admin` ACE permission to their identifier or group. Admins bypass all internal permission checks within the editor. Example:

```
add_ace identifier.license:abc123 respoon.admin allow
```

See [Permissions](permissions.md) for details on the full permission system including custom roles.

**Can I use Respoon for machinima or video production?**

Yes. Use the task builder to choreograph ped sequences, environment controls to set time and weather, and the built-in recording feature to capture footage. Press PageUp to start recording and Insert to stop. Open Rockstar Editor from the toolbar to edit your captured clips.

**How do I save my work?**

All entity changes auto-save to the database as you make them. There is no manual save step for entity placement, properties, or transforms.

For reusable presets, use the Save to Library feature (floppy disk icon in the toolbar, or right-click an entity and select Save to Library). Library entries store the full entity configuration including appearance, properties, tasks, and attachments.

**Can multiple people edit the same room?**

Yes. Respoon supports real-time collaborative editing. Multiple editors see each other's changes instantly. Selection locking prevents two editors from modifying the same entity at the same time.

**How do I control NPC traffic and pedestrians?**

Use the vehicle traffic and ped population toggle buttons in the toolbar, or open Scene Settings to toggle them. When disabled, existing ambient NPCs are cleared and new ones stop spawning within that room. These settings are room-scoped and do not affect other rooms or the default world.

**Can other resources interact with Respoon?**

Yes. Respoon exposes 8 server-side exports for querying rooms, entities, players, and scene state. See the [Exports API](exports.md) for full documentation and code examples.

---

## Troubleshooting

**Entities are invisible after a server restart.**

Entities respawn when a player joins their room. Open the editor, join the room, and entities will begin spawning in distance-sorted batches. This is expected behavior -- entities are not kept alive when no players are present.

**My changes are not saving.**

All changes auto-persist to the database. If changes appear lost after a restart, check the server console for database connectivity errors. Common causes include MySQL/MariaDB being unreachable, connection timeouts, or disk space issues on the database server.

**Keyboard shortcuts are not working.**

Make sure the editor UI is focused by clicking inside it. Some shortcuts are mode-specific. For example, the Delete key for resetting entity positions only works in HUD mode, and transform shortcuts require an entity to be selected. See [Keyboard Shortcuts](shortcuts.md) for the full list.

**Entities spawn at the wrong position or fall through the ground.**

This usually indicates the entity was placed before the world finished loading at that location. Teleport to the area and let the map stream in fully, then reposition the entity. For interior locations, make sure the relevant IPL is loaded.

**The model or animation browser is empty.**

The catalogs are seeded on first boot. If the server was interrupted during seeding, the catalogs may be incomplete. Check the server console for seeding-related errors. Restarting the resource (`ensure respoon`) will retry the seeding process.

---

## Support

For additional help, join the Discord support server. The invite link is available on the Tebex product page.
