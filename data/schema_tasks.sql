-- =============================================================================
-- TASK SEQUENCES (Phase T5 - Task Persistence)
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_task_sequences (
    uuid            CHAR(36) PRIMARY KEY,
    room_uuid       CHAR(36) NOT NULL,
    name            VARCHAR(100) NOT NULL,
    mode            ENUM('once', 'loop', 'pingpong') NOT NULL DEFAULT 'once',
    steps           JSON NOT NULL,              -- Array of TaskStep objects
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (room_uuid) REFERENCES respoon_rooms(uuid) ON DELETE CASCADE,
    INDEX idx_room (room_uuid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- ENTITY TASK ASSIGNMENTS (Phase T5 - Task Persistence)
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_entity_tasks (
    entity_uuid     CHAR(36) PRIMARY KEY,
    sequence_uuid   CHAR(36) DEFAULT NULL,      -- Reference to template (nullable)
    inline_steps    JSON DEFAULT NULL,          -- One-off sequence (nullable)
    assigned_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (entity_uuid) REFERENCES respoon_entities(uuid) ON DELETE CASCADE,
    FOREIGN KEY (sequence_uuid) REFERENCES respoon_task_sequences(uuid) ON DELETE SET NULL,
    INDEX idx_sequence (sequence_uuid)
    -- Note: XOR constraint (sequence_uuid OR inline_steps, not both) enforced at application layer
    -- MariaDB/MySQL CHECK constraints don't work well with nullable columns in this pattern
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
