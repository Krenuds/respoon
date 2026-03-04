# Installation

Step-by-step guide to installing Respoon on your FiveM server.

## Prerequisites

Before installing Respoon, make sure you have the following:

- **FiveM server** running artifact build **5181 or newer**
- **MySQL 5.7+** or **MariaDB 10.2+** database
- **oxmysql** — recommended but optional (Respoon includes a bundled mysql2 fallback for servers that do not run oxmysql)

## Step-by-Step Installation

### 1. Extract the Resource

Copy the `respoon` folder into your server's `resources/` directory.

Add `ensure respoon` to your `server.cfg`. If you use oxmysql, Respoon should load after it:

```cfg
ensure chat
ensure oxmysql
# ... your other resources
ensure respoon
```

Respoon has no framework dependencies — it works with any server setup (ESX, QBCore, ox_core, standalone, etc.).
### 3. Database Configuration

**If you run oxmysql:** No extra configuration is needed. Respoon detects oxmysql automatically and uses its connection pool.

**Without oxmysql:** Add a MySQL connection string to your `server.cfg`:

### 4. Permissions

Add ACE permissions to your `server.cfg` or `permissions.cfg`:

```cfg
# Allow all players to open the Respoon editor
add_ace builtin.everyone respoon.use allow

# Give admins full access (bypasses all internal permission checks)
add_ace group.admin respoon.admin allow
```

For a full breakdown of the permission system, see [Permissions](permissions.md).

### 5. First Boot

Start your server. On first boot, Respoon will automatically:

1. Run database migrations to create all required tables
2. Seed the model catalog (approximately 23,000 props, vehicles, and peds)
3. Seed the animation catalog (approximately 269,000 clips)

This initial seeding takes roughly **30 seconds**. Do not restart the server or the resource during seeding — interrupting the process may leave the database in an incomplete state. You can monitor progress in the server console.

Subsequent starts skip seeding entirely and are instant.

### 6. Open the Editor

Once the server is running and seeding is complete:

- Type `/rs` in the FiveM chat, or
- Bind a key in **FiveM Settings > Key Bindings > Respoon**

The editor toggle key is unbound by default. You can assign it in FiveM key binding settings or continue using the `/rs` chat command.

## Optional Configuration

### Log Level

Control log verbosity by adding this convar to your `server.cfg`:

```cfg
setr respoon_log_level "info"
```

Valid values:

| Level   | Description                                   |
| ------- | --------------------------------------------- |
| `debug` | Verbose output, useful for development        |
| `info`  | General operational messages                   |
| `warn`  | Warnings that may indicate issues              |
| `error` | Errors only (default)                          |

The default level is `error`. Set to `debug` or `info` when troubleshooting, then revert to `error` for production to reduce log noise.

## Troubleshooting

### "Failed to verify protected resource"

The hidden `.fxap` file was not copied during extraction. Re-extract the resource and ensure your extraction tool includes hidden files. On Windows, check "Show hidden items" in File Explorer before copying. On Linux, verify the file exists with `ls -a resources/respoon/`.

### Seeding takes longer than expected

This is normal on first boot, especially on slower hardware or remote database connections. Watch the server console for seeding progress messages. Do not restart during this process.

### Editor does not open

- Verify the player has the `respoon.use` ACE permission
- Check the server console for error messages
- Confirm Respoon started successfully (look for initialization messages in the console)
- Make sure you are typing `/rs` in the FiveM chat, not the server console

### Database errors on startup

- Confirm your MySQL or MariaDB server is running
- Verify the connection string is correct and the database exists
- Ensure the database user has CREATE TABLE, INSERT, SELECT, UPDATE, and DELETE permissions
- Check that you are running MySQL 5.7+ or MariaDB 10.2+

### Resource not found

- Confirm the `respoon` folder is directly inside your `resources/` directory (not nested in a subfolder)
- Confirm `ensure respoon` is present in your `server.cfg`
- Run `refresh` in the server console, then `ensure respoon`
