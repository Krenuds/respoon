# Exports API

Respoon exposes 8 server-side exports for querying editor state, player sessions, rooms, and entities from other FiveM resources. All exports are read-only and do not modify any state.

## Usage

From Lua:

```lua
local result = exports.respoon:functionName(args)
```

From TypeScript:

```typescript
const result = exports.respoon.functionName(args);
```

---

## Player Exports

### getPlayer

Get the Respoon session for a connected player.

| Parameter | Type     | Description              |
| --------- | -------- | ------------------------ |
| `source`  | `number` | FiveM player source ID   |

**Returns:** `PlayerSession | null` -- The player's editor session, or `null` if the player does not have an active Respoon session.

**PlayerSession fields:**

| Field              | Type             | Description                                 |
| ------------------ | ---------------- | ------------------------------------------- |
| `playerId`         | `number`         | FiveM player source ID                      |
| `identifier`       | `string`         | FiveM license identifier                    |
| `playerName`       | `string`         | Display name                                |
| `currentRoomId`    | `string \| null` | UUID of the room the player is in, or null  |
| `playerEntityUuid` | `string \| null` | Ephemeral entity UUID for this player       |
| `editorOpen`       | `boolean`        | Whether the editor UI is currently open     |
| `lastActivity`     | `number`         | Unix timestamp of last activity             |
| `roleId`           | `number \| null` | Assigned role ID (null = default role)       |
| `permissions`      | `string[]`       | Resolved permission keys from assigned role |

```lua
local session = exports.respoon:getPlayer(source)
if session then
    print("Player is in room: " .. tostring(session.currentRoomId))
    print("Editor open: " .. tostring(session.editorOpen))
end
```

### getAllPlayers

Get all active Respoon sessions.

**Returns:** `PlayerSession[]` -- Array of all active editor sessions. Returns an empty array if no players have active sessions.

```lua
local players = exports.respoon:getAllPlayers()
print("Active editors: " .. #players)

for _, session in ipairs(players) do
    print(session.playerName .. " - Room: " .. tostring(session.currentRoomId))
end
```

---

## Entity Exports

### findEntity

Look up any entity by its UUID.

| Parameter | Type     | Description |
| --------- | -------- | ----------- |
| `uuid`    | `string` | Entity UUID |

**Returns:** `SerializedEntity | null` -- Full serialized entity data, or `null` if no entity with that UUID exists in any room.

The returned object contains the entity's model, position, rotation, type-specific data, and all root-level properties (alpha, visible, collision, frozen, invincible, lodDistance).

```lua
local entity = exports.respoon:findEntity("some-uuid-here")
if entity then
    print("Entity model: " .. entity.model)
    print("Entity type: " .. entity.type)
end
```

### getRoomEntities

Get all entities in a specific room.

| Parameter | Type     | Description |
| --------- | -------- | ----------- |
| `roomId`  | `string` | Room UUID   |

**Returns:** `SerializedEntity[] | null` -- Array of all serialized entities in the room, or `null` if the room does not exist.

```lua
local entities = exports.respoon:getRoomEntities(roomId)
if entities then
    print("Room has " .. #entities .. " entities")
    for _, entity in ipairs(entities) do
        print("  " .. entity.type .. ": " .. entity.model)
    end
end
```

---

## Room Exports

### getAllRooms

Get a summary of all active rooms.

**Returns:** Array of room summary objects. Returns an empty array if no rooms are active.

Each object contains:

| Field            | Type      | Description                    |
| ---------------- | --------- | ------------------------------ |
| `uuid`           | `string`  | Room UUID                      |
| `name`           | `string`  | Room display name              |
| `ownerId`        | `number`  | FiveM source ID of room owner  |
| `ownerName`      | `string`  | Display name of room owner     |
| `isPublic`       | `boolean` | Whether the room is public     |
| `entityCount`    | `number`  | Number of entities in the room |
| `particleCount`  | `number`  | Number of particles in the room|
| `memberCount`    | `number`  | Number of players in the room  |

```lua
local rooms = exports.respoon:getAllRooms()
for _, room in ipairs(rooms) do
    print(room.name .. " (" .. room.memberCount .. " members, " .. room.entityCount .. " entities)")
end
```

### getRoomState

Get the full state summary of a room.

| Parameter | Type     | Description |
| --------- | -------- | ----------- |
| `roomId`  | `string` | Room UUID   |

**Returns:** Full room state object, or `null` if the room does not exist.

| Field            | Type            | Description                              |
| ---------------- | --------------- | ---------------------------------------- |
| `uuid`           | `string`        | Room UUID                                |
| `name`           | `string`        | Room display name                        |
| `description`    | `string`        | Room description                         |
| `ownerId`        | `number`        | FiveM source ID of room owner            |
| `ownerName`      | `string`        | Display name of room owner               |
| `isPublic`       | `boolean`       | Whether the room is public               |
| `routingBucket`  | `number`        | FiveM routing bucket assigned to the room|
| `entityCount`    | `number`        | Number of entities in the room           |
| `particleCount`  | `number`        | Number of particles in the room          |
| `members`        | `array`         | Array of player members in the room      |
| `homePosition`   | `object \| null`| Room home position (coordinates)         |
| `environment`    | `object \| null`| Room environment settings (time, weather)|
| `sceneStatus`    | `string`        | Scene playback status (see getSceneStatus)|

```lua
local state = exports.respoon:getRoomState(roomId)
if state then
    print(state.name .. ": " .. state.entityCount .. " entities")
    print("Scene status: " .. state.sceneStatus)
    print("Members: " .. #state.members)
end
```

---

## Particle Exports

### getRoomParticles

Get all particle effects in a specific room.

| Parameter | Type     | Description |
| --------- | -------- | ----------- |
| `roomId`  | `string` | Room UUID   |

**Returns:** `SerializedParticle[] | null` -- Array of all serialized particle effects in the room, or `null` if the room does not exist.

```lua
local particles = exports.respoon:getRoomParticles(roomId)
if particles then
    print("Room has " .. #particles .. " particles")
end
```

---

## Scene Exports

### getSceneStatus

Get the playback status of a room's scene.

| Parameter | Type     | Description |
| --------- | -------- | ----------- |
| `roomId`  | `string` | Room UUID   |

**Returns:** `string` -- One of the following status values:

| Status      | Meaning                                      |
| ----------- | -------------------------------------------- |
| `"idle"`    | No scene activity (default state)            |
| `"playing"` | Scene is currently playing                   |
| `"stopped"` | Scene was stopped mid-playback               |
| `"reset"`   | Scene was reset to starting positions         |

If the room does not exist or has no scene director, returns `"idle"`.

```lua
local status = exports.respoon:getSceneStatus(roomId)
if status == "playing" then
    print("Scene is currently playing")
elseif status == "idle" then
    print("No scene activity")
end
```

---

## Notes

- All exports are **server-side only**. They cannot be called from client scripts.
- Exports return `nil` (Lua) or `null` (TypeScript) when the resource is not started or the query target does not exist.
- All data returned is **read-only**. Exports do not modify any server state, room state, or entity state.
- Respoon must be running (`ensure respoon` in server.cfg) for exports to be available.
- If your resource starts before Respoon, wrap export calls in a check: verify `GetResourceState('respoon') == 'started'` before calling.
