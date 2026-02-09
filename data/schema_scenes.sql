-- Respoon - Scene Director Schema
-- Version: 4.5.0
--
-- Creates tables for scene director feature:
--   - respoon_frames: Named snapshots of entity configurations
--   - respoon_frame_entities: Per-entity overrides within frames
--   - respoon_scene_state: Room's current scene playback state

-- Frames table - named snapshots that can be switched between
CREATE TABLE IF NOT EXISTS respoon_frames (
    uuid            CHAR(36) PRIMARY KEY,
    room_uuid       CHAR(36) NOT NULL,
    name            VARCHAR(64) NOT NULL,
    description     TEXT DEFAULT NULL,
    is_default      BOOLEAN DEFAULT FALSE,
    created_by      VARCHAR(64) DEFAULT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (room_uuid) REFERENCES respoon_rooms(uuid) ON DELETE CASCADE,
    INDEX idx_room (room_uuid),
    INDEX idx_default (room_uuid, is_default)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Frame entity overrides - per-entity state within a frame
CREATE TABLE IF NOT EXISTS respoon_frame_entities (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    frame_uuid      CHAR(36) NOT NULL,
    entity_uuid     CHAR(36) NOT NULL,

    -- Scenario/Animation
    scenario        VARCHAR(128) DEFAULT NULL,
    animation_dict  VARCHAR(64) DEFAULT NULL,
    animation_name  VARCHAR(64) DEFAULT NULL,
    animation_flags INT DEFAULT 0,

    -- Ped behavior
    block_events    BOOLEAN DEFAULT TRUE,
    combat_movement TINYINT DEFAULT 0,
    combat_range    TINYINT DEFAULT 1,
    combat_ability  TINYINT DEFAULT 1,
    alertness       TINYINT DEFAULT 0,
    accuracy        TINYINT DEFAULT 50,
    relationship_group      INT DEFAULT 0,
    relationship_to_player  TINYINT DEFAULT 3,

    -- Config flags (JSON)
    config_flags    JSON DEFAULT NULL,

    UNIQUE KEY unique_frame_entity (frame_uuid, entity_uuid),
    FOREIGN KEY (frame_uuid) REFERENCES respoon_frames(uuid) ON DELETE CASCADE,
    FOREIGN KEY (entity_uuid) REFERENCES respoon_entities(uuid) ON DELETE CASCADE,
    INDEX idx_frame (frame_uuid),
    INDEX idx_entity (entity_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Scene state - tracks which frame is active per room
CREATE TABLE IF NOT EXISTS respoon_scene_state (
    room_uuid           CHAR(36) PRIMARY KEY,
    scene_state         ENUM('editing', 'starting', 'active', 'paused') DEFAULT 'editing',
    active_frame_uuid   CHAR(36) DEFAULT NULL,

    FOREIGN KEY (room_uuid) REFERENCES respoon_rooms(uuid) ON DELETE CASCADE,
    FOREIGN KEY (active_frame_uuid) REFERENCES respoon_frames(uuid) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
