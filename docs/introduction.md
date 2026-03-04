# Introduction

Respoon is a real-time development toolkit for FiveM. It lets you inspect, edit, and script game entities — vehicles, peds, props, and particle effects — without restarting your server. Every change is server-authoritative, networked across all connected clients, and automatically persisted to a database. Think of it as a Swiss Army knife for FiveM development: entity inspector, AI scripting tool, environment controller, and collaborative workspace rolled into one resource.

## Who It's For

- **Server developers** building and iterating on FiveM servers who need fast feedback loops without constant restarts.
- **Content creators** designing scenes, cinematics, and environments using GTA V's entity system.
- **QA testers** inspecting live entity state, verifying property configurations, and reproducing issues in isolated rooms.
- **Machinima creators** choreographing ped AI sequences, camera setups, and environmental conditions for video production.

## What You Can Do

- **Real-time entity property editing** -- modify 27+ vehicle properties (colors, liveries, mods, neon, doors, extras), 16+ ped properties (weapons, animations, factions, behavior, appearance), and common flags (alpha, collision, frozen, invincible) with immediate visual feedback. No server restarts required.
- **Isolated rooms for parallel development** -- up to 62 concurrent rooms, each mapped to a FiveM routing bucket. Entities and players in different rooms are completely invisible to each other. Work on multiple scenes simultaneously without interference.
- **Entity inspector with live property editing** -- select any entity in the world, view its full state in the Inspector panel, and modify properties through sliders, toggles, color pickers, and dropdowns. Changes apply instantly and auto-save.
- **Freecam and transform gizmo system** -- navigate freely with a detached camera. Position and rotate entities precisely with move (W) and rotate (E) gizmos. Snap to ground, toggle between local and world coordinate space.
- **Task sequence builder for ped AI scripting** -- build multi-step behavior sequences from 21 step types across 3 sequence modes (once, loop, ping-pong). Movement, combat, animations, scenarios, property changes, and timing gates. Server-authoritative execution with client-side playback.
- **Environment controls** -- adjust time of day, weather, atmosphere, lighting, gravity, traffic density, and more. 20 properties across 8 categories (time, weather, atmosphere, sky, lighting, effects, water, traffic), all room-scoped and persistent.
- **Particle effects browser** -- browse and spawn from 2,907 effects across 364 dictionaries. Position and preview particles in real-time. Server stores metadata; each client renders its own copy for reliable playback.
- **Collaborative editing with room roles and permissions** -- invite other players to your room with 17 granular permissions covering entity creation, deletion, property editing, environment changes, and administrative actions. Role-based access control for organized teamwork.
- **Entity library for saving and reusing configurations** -- save any configured entity (with all properties, appearance, and attachments) as a reusable preset. Spawn library entries into any room to recreate exact configurations instantly. Supports composite entries with parent and attached children.
- **Full-text searchable model catalog** -- search across 23,000+ models (props, vehicles, peds) by name. Preview models before spawning. Translucent preview placement with gizmo positioning before confirmation.
- **Searchable animation catalog** -- browse 269,000+ animation clips organized by dictionary. Preview animations on peds, filter by category. Assign animations as task steps or standalone playback.
- **Cross-resource API with 8 server exports** -- integrate Respoon into your resource ecosystem. Query active rooms, player sessions, entity state, and scene status from any other resource via `exports.respoon`.
- **15 weather presets and 190+ curated ambient scenarios** -- set weather conditions from built-in presets (clear, rain, snow, fog, and more). Assign peds to 190+ curated ambient scenarios (smoking, sweeping, exercising) with engine-managed props and transitions.

## Next Steps

- [Getting Started](getting-started.md) -- Your first session with Respoon.
- [Features Overview](features.md) -- Deep dive into each feature.
- [Installation](installation.md) -- Server requirements and setup instructions.
