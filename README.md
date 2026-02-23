# Respoon v0.06

A networked scene editor for FiveM. Spawn props, peds, and vehicles — collaborate in real-time.

**[Join the Discord](https://discord.gg/mgumPaknVK)** for help, updates, and to share what you build.

---

## Quick Start

Extract `respoon` into your server's `resources/` folder, then add this to your `server.cfg`:

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
- **Scene Director** — Save named frames and switch between scene configurations
- **Task Builder** — Chain ped movements, animations, and actions into sequences

## Need Help?

**[Discord](https://discord.gg/mgumPaknVK)** — bug reports, feature requests, questions, anything.
