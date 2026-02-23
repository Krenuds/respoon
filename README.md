<p align="center">
  <img src="screenshots/banner.png" alt="Respoon" width="100%">
</p>

<p align="center">
  A networked scene editor for FiveM. Spawn props, peds, and vehicles — collaborate in real-time.<br>
  <strong><a href="https://discord.gg/mgumPaknVK">Join the Discord</a></strong> for help, updates, and to share what you build.
</p>

---

<p align="center">
  <img src="screenshots/hero.png" alt="Respoon Editor Overview" width="100%">
</p>

<p align="center">
  <img src="screenshots/hierarchy.png" alt="Hierarchy Panel" width="260">
  <img src="screenshots/inspector.png" alt="Entity Inspector" width="260">
  <img src="screenshots/browser.png" alt="Entity Browser" width="260">
</p>
<p align="center"><em>Hierarchy — Inspector — Browser</em></p>

<p align="center">
  <img src="screenshots/task-builder.png" alt="Task Builder" width="420">
  <img src="screenshots/scene-panel.png" alt="Scene Panel" width="260">
</p>
<p align="center"><em>Task Builder for ped AI sequences — Scene Panel for room management</em></p>

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
- **Environment** — Control time, weather, traffic, and pedestrian population per-room

## Need Help?

**[Discord](https://discord.gg/mgumPaknVK)** — bug reports, feature requests, questions, anything.
