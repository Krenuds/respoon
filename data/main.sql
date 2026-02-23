-- Respoon Database Schema
-- Version: 4.0.0
--
-- Usage:
--   1. Run cleanup section if upgrading from Lua version
--   2. Run main schema to create tables
--   3. Run seed script to populate model catalog

-- =============================================================================
-- NOTE: Manual cleanup (if upgrading from old Lua version)
-- =============================================================================
-- If you need to reset the database, run this SQL manually:
--
--   SET FOREIGN_KEY_CHECKS = 0;
--   DROP TABLE IF EXISTS respoon_entities, respoon_room_members,
--     respoon_room_access, respoon_rooms, respoon_models,
--     respoon_sessions, respoon_objects;
--   SET FOREIGN_KEY_CHECKS = 1;
--
-- DO NOT add DROP TABLE to this file - it will destroy production data
-- if the migration re-runs (e.g., after validator repair).
-- =============================================================================

-- =============================================================================
-- MODEL CATALOG
-- Pre-seeded with all GTA V models (vehicles, peds, objects)
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_models (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100) NOT NULL UNIQUE,
    hash            BIGINT NOT NULL,
    entity_type     ENUM('prop', 'vehicle', 'ped') NOT NULL,
    category        VARCHAR(50),           -- Vehicle: SUPER, SEDAN; Ped: CIVMALE, Animal
    label           VARCHAR(100),          -- English display name
    dlc             VARCHAR(50),           -- DLC pack name (TitleUpdate, mpheist, etc.)

    -- Vehicle-specific fields (NULL for non-vehicles)
    vehicle_type    ENUM('automobile', 'bike', 'boat', 'heli', 'plane', 'submarine', 'trailer', 'train', 'quad', 'blimp') DEFAULT NULL,
    seats           TINYINT UNSIGNED DEFAULT NULL,
    manufacturer    VARCHAR(50) DEFAULT NULL,

    -- Ped-specific fields (NULL for non-peds)
    is_animal       BOOLEAN DEFAULT FALSE,

    tags            JSON,                  -- Flexible metadata for future use
    added_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Indexes for efficient querying
    INDEX idx_type_cat (entity_type, category),
    INDEX idx_hash (hash),
    INDEX idx_vehicle_type (vehicle_type),
    FULLTEXT idx_search (name, label)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- ROOMS (For persistence - stub for Phase 5)
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_rooms (
    uuid            CHAR(36) PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    owner_id        VARCHAR(100) NOT NULL,  -- Player license identifier
    bucket          INT NOT NULL DEFAULT 0, -- Routing bucket
    is_public       BOOLEAN DEFAULT TRUE,
    home_position   JSON DEFAULT NULL,      -- Spawn point: {"x": 0.0, "y": 0.0, "z": 0.0, "heading": 0.0}
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_owner (owner_id),
    INDEX idx_public (is_public),
    UNIQUE KEY unique_bucket (bucket)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MIGRATIONS (Run these on existing databases)
-- =============================================================================

-- Migration: Add home_position column to respoon_rooms (v4.1.0)
-- This is safe to run multiple times - it will fail silently if column exists
-- ALTER TABLE respoon_rooms ADD COLUMN home_position JSON DEFAULT NULL AFTER is_public;

-- =============================================================================
-- ENTITIES (For persistence - stub for Phase 5)
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_entities (
    uuid            CHAR(36) PRIMARY KEY,
    room_uuid       CHAR(36) NOT NULL,
    model_hash      BIGINT NOT NULL,
    model_name      VARCHAR(100) NOT NULL,
    entity_type     ENUM('prop', 'vehicle', 'ped') NOT NULL,

    -- Transform
    pos_x           FLOAT NOT NULL,
    pos_y           FLOAT NOT NULL,
    pos_z           FLOAT NOT NULL,
    rot_x           FLOAT DEFAULT 0,
    rot_y           FLOAT DEFAULT 0,
    rot_z           FLOAT DEFAULT 0,

    -- Common properties
    alpha           TINYINT UNSIGNED DEFAULT 255,
    visible         BOOLEAN DEFAULT TRUE,
    collision       BOOLEAN DEFAULT TRUE,
    frozen          BOOLEAN DEFAULT TRUE,
    invincible      BOOLEAN DEFAULT TRUE,
    lod_distance    INT DEFAULT -1,

    -- Type-specific data (stored as JSON)
    entity_data     JSON,

    -- Metadata
    created_by      VARCHAR(100),          -- Player license identifier
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (room_uuid) REFERENCES respoon_rooms(uuid) ON DELETE CASCADE,
    INDEX idx_room (room_uuid),
    INDEX idx_type (entity_type),
    INDEX idx_model (model_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- ROOM MEMBERS (For persistence - stub for Phase 5)
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_room_members (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    room_uuid       CHAR(36) NOT NULL,
    player_id       VARCHAR(100) NOT NULL,  -- Player license identifier
    role            ENUM('owner', 'editor', 'viewer') DEFAULT 'viewer',
    joined_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (room_uuid) REFERENCES respoon_rooms(uuid) ON DELETE CASCADE,
    UNIQUE KEY unique_room_member (room_uuid, player_id),
    INDEX idx_player (player_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
