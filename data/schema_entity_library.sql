-- =============================================================================
-- ENTITY LIBRARY (Phase C2 - Custom Entities System)
-- =============================================================================
--
-- Stores user-saved entity configurations (peds, vehicles) for reuse.
-- Each entry captures the entity's model and full configuration snapshot.
--
-- The unique constraint on (owner_id, name, entity_type) allows the same name
-- to be used for a ped and a vehicle by the same owner, but not two peds or
-- two vehicles with the same name.

CREATE TABLE IF NOT EXISTS respoon_entity_library (
    uuid            CHAR(36) PRIMARY KEY,
    owner_id        VARCHAR(100) NOT NULL,
    name            VARCHAR(100) NOT NULL,
    model_name      VARCHAR(100) NOT NULL,
    model_hash      BIGINT NOT NULL,
    entity_type     ENUM('vehicle', 'ped') NOT NULL,
    entity_data     JSON NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_owner (owner_id),
    INDEX idx_type (entity_type),
    UNIQUE KEY unique_owner_name_type (owner_id, name, entity_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
