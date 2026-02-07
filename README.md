# Respoon v0.05

A networked scene editor for FiveM. Spawn props, peds, and vehicles — collaborate in real-time.

**[Join the Discord](https://discord.gg/F2s8hREkbY)** for help, updates, and to share what you build.

---

## Quick Start

1. Download the latest release from the [Releases](https://github.com/Krenuds/respoon/releases) page
2. Extract `respoon` into your server's `resources/` folder
3. Add this to your `server.cfg`:

```cfg
ensure respoon

add_ace builtin.everyone respoon.use allow
add_ace group.admin respoon.admin allow
```

Start the server. First boot takes ~30 seconds while catalogs are seeded — subsequent starts are instant.

## Database

Respoon needs MySQL/MariaDB. If you already have **oxmysql**, you're set — Respoon detects it automatically.

If not, add a connection string to your `server.cfg`:

```cfg
set mysql_connection_string "mysql://user:password@localhost:3306/database"
```

## Getting Started

Press **F7** or type `/rs` to open the editor.

- **Rooms** — Create or join private workspaces to collaborate with others
- **Entity Spawning** — Place props, peds (with animations), and vehicles
- **Property Inspector** — Edit every property in real-time: colors, mods, appearance, AI, flags
- **Attachment System** — Attach entities to parent bones with offset/rotation control
- **Particle Effects** — 33,000+ searchable particle effects
- **Animation System** — 15,000+ animations with favorites and preview
- **Faction Manager** — 10x10 relationship matrix for ped AI interactions
- **Task Builder** — Chain movements, animations, and actions into AI sequences
- **Scene Director** — Save named frames and choreograph multi-ped scenes
- **User Library** — Save configured entities for reuse across scenes

## Features

### Entity Types
- **Props** — 21,000+ models with texture variations
- **Vehicles** — Full customization: colors, mods, extras, liveries, doors, windows, performance, 153 config flags
- **Peds** — Appearance (drawables, props, head blend, face features, overlays), behavior presets, weapons, factions, 71 config flags

### Collaboration
- Real-time multi-user editing
- Room-based isolation via routing buckets
- Entity locking prevents edit conflicts
- Full persistence — everything saves to database and restores on restart

## Need Help?

**[Discord](https://discord.gg/F2s8hREkbY)** — bug reports, feature requests, questions, anything.
