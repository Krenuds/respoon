# Permissions

Respoon uses a two-tier permission system: server-level ACE permissions control who can access the editor, and in-editor room roles control what users can do within rooms.

## ACE Permissions

FiveM ACE (Access Control Entry) permissions gate access to Respoon at the server level. There are two permission keys:

| ACE Key          | Purpose                                                              |
| ---------------- | -------------------------------------------------------------------- |
| `respoon.use`    | Required to open the editor. Without this, the `/rs` command and keybind do nothing. |
| `respoon.admin`  | Bypasses all internal permission checks. Grants full access to every room and feature. |

### Configuration

Add ACE permissions to your `server.cfg` or a separate `permissions.cfg` file (exec'd from `server.cfg`):

```cfg
# Allow all connected players to open the editor
add_ace builtin.everyone respoon.use allow

# Give the admin group full access
add_ace group.admin respoon.admin allow
```

### Assigning Players to Groups

`builtin.everyone` applies to all connected players automatically and does not require assignment.

For `group.*` roles, you must explicitly assign players using `add_principal`. FiveM identifies players by their platform identifiers:

```cfg
# Assign a specific player to the admin group by Discord ID
add_principal identifier.discord:123456789012345678 group.admin

# Assign by Steam hex
add_principal identifier.steam:110000abcdef01 group.admin

# Assign by license
add_principal identifier.license:abcdef1234567890abcdef1234567890abcdef12 group.admin
```

**Note:** FiveM does not automatically sync Discord roles to ACE groups. If you need role-based access from Discord, use txAdmin whitelisting or a third-party resource that maps Discord roles to ACE principals.

### Recommended Setup

For most servers:

```cfg
# permissions.cfg

# Everyone can use the editor
add_ace builtin.everyone respoon.use allow

# Admin group gets full editor access
add_ace group.admin respoon.admin allow

# Assign your admins
add_principal identifier.discord:123456789012345678 group.admin
add_principal identifier.discord:987654321098765432 group.admin
```

Then exec it from `server.cfg`:

```cfg
exec permissions.cfg
```

## Room Roles

Inside the editor, each room has its own role-based permission system. Room roles determine what a player can do within that specific room.

### Built-In Roles

Every room starts with three default roles:

| Role       | Description                                                                 |
| ---------- | --------------------------------------------------------------------------- |
| **Owner**  | The player who created the room. Full control over room settings, members, and deletion. Cannot be removed. |
| **Editor** | Can create, edit, and delete entities within the room. Cannot manage room settings or members. |
| **Viewer** | Read-only access. Can observe the room and its entities but cannot modify anything. |

### Assigning Room Roles

Room owners and players with the `admin.manageRoles` permission can assign roles:

1. Open the Permissions panel (shield icon in the editor toolbar)
2. Navigate to the **Players** tab
3. Select a player and choose a role from the dropdown

Players without an assigned role cannot access the room unless they have the `respoon.admin` ACE permission, which bypasses all room-level checks.

### Custom Roles

Admins can create custom roles with any combination of the 17 internal permissions. To create a custom role:

1. Open the Permissions panel
2. Navigate to the **Roles** tab
3. Create a new role with a name and description
4. Toggle the desired permissions
5. Set a priority level (higher priority wins when a player has multiple roles)

## Internal Permission Keys

Respoon defines 17 granular permissions across 10 domains. These are used by both built-in and custom roles.

### Entity

| Permission      | Description                                      |
| --------------- | ------------------------------------------------ |
| `entity.create` | Create and spawn new entities (props, vehicles, peds) |
| `entity.delete` | Remove entities from a room                       |
| `entity.update` | Modify entity transforms and properties           |

### Room

| Permission       | Description                |
| ---------------- | -------------------------- |
| `room.create`    | Create new rooms            |
| `room.delete`    | Delete rooms                |
| `room.reset`     | Reset room state            |
| `room.duplicate` | Duplicate existing rooms    |

### Admin

| Permission          | Description                          |
| ------------------- | ------------------------------------ |
| `admin.manageRoles` | Create, edit, and delete roles       |

### Player

| Permission        | Description                                          |
| ----------------- | ---------------------------------------------------- |
| `player.manage`   | View player info, freeze, make invisible/invincible  |
| `player.kick`     | Remove players from rooms                            |
| `player.teleport` | Move players to coordinates                          |

### Particle

| Permission        | Description                        |
| ----------------- | ---------------------------------- |
| `particle.create` | Create and place particle effects  |
| `particle.delete` | Remove particle effects            |

### Environment

| Permission             | Description                              |
| ---------------------- | ---------------------------------------- |
| `environment.update`   | Modify room environment settings (time, weather) |

### Faction

| Permission       | Description                   |
| ---------------- | ----------------------------- |
| `faction.update` | Edit faction relationships    |

### Task

| Permission    | Description                              |
| ------------- | ---------------------------------------- |
| `task.manage` | Create, edit, and run task sequences     |

### Scene

| Permission      | Description                                    |
| --------------- | ---------------------------------------------- |
| `scene.control` | Control scene playback (play, stop, reset)     |

## Permission Precedence

- **ACE `respoon.admin`** overrides everything. A player with this ACE permission has unrestricted access to all rooms and features regardless of room role assignments.
- **Room Owner** has all permissions within their room by default.
- **Custom roles** are evaluated by priority level. If a player holds multiple roles, the highest-priority role determines their effective permissions.
- **No role** means no access. Players without a room role and without `respoon.admin` cannot interact with that room.
