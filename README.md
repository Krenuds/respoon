# Respoon

<p align="center">
  <img src="screenshots/banner.png" alt="Respoon — Networked Scene Editor for FiveM" width="100%">
</p>

<p align="center">
  <a href="https://github.com/Krenuds/respoon/releases/latest"><img src="https://img.shields.io/github/v/release/Krenuds/respoon?style=flat-square" alt="Release"></a>
  <a href="https://github.com/Krenuds/respoon/stargazers"><img src="https://img.shields.io/github/stars/Krenuds/respoon?style=flat-square" alt="Stars"></a>
  <a href="https://discord.gg/mgumPaknVK"><img src="https://img.shields.io/discord/1464650557980541182?style=flat-square&label=Discord" alt="Discord"></a>
  <a href="https://github.com/Krenuds/respoon/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-custom-blue?style=flat-square" alt="License"></a>
</p>

<p align="center">
  A networked scene editor for FiveM. Spawn props, peds, and vehicles — collaborate in real-time.<br>
  <strong><a href="https://discord.gg/mgumPaknVK">Join the Discord</a></strong> for help, updates, and to share what you build.
</p>

---

## Features

- **Real-Time Collaboration** — Create or join rooms and build scenes together with other players, live
- **Prop Spawner** — Browse and place 21,000+ props with gizmo controls, snapping, and rotation
- **Ped & Vehicle Spawner** — Spawn from 1,100+ peds and 900+ vehicles with full customization
- **Task Builder** — Chain ped movements, animations, and actions into AI sequences
- **Scene Director** — Save named frames and switch between scene configurations
- **Ped Animations** — Search and preview 269,000+ animation clips
- **Particle Effects** — Browse and attach 2,800+ particle effects
- **Debug Menu** — Inspect and manipulate the game world in real time
- **Environment Controls** — Per-room time, weather, traffic, and population settings

**Works with QBCore, ESX, QBox, or standalone** — no framework dependency.

---

<p align="center">
  <a href="https://www.youtube.com/watch?v=24AHaWQnQYM">
    <img src="https://img.youtube.com/vi/24AHaWQnQYM/maxresdefault.jpg" alt="Respoon Demo" width="80%">
  </a>
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

Type `/rs` in chat to open the editor. You can also bind a key in FiveM's keybind settings.

- **Rooms** — Create or join private workspaces to collaborate with others
- **Entity Spawning** — Place props, peds (with animations), and vehicles
- **Scene Director** — Save named frames and switch between scene configurations
- **Task Builder** — Chain ped movements, animations, and actions into sequences
- **Environment** — Control time, weather, traffic, and pedestrian population per-room

## Need Help?

**[Discord](https://discord.gg/mgumPaknVK)** — bug reports, feature requests, questions, anything.
