-- Respoon - Particle System Schema
-- Version: 4.3.0
--
-- Creates particle tables for the particle system feature.

-- Particles placed in rooms
CREATE TABLE IF NOT EXISTS respoon_particles (
    uuid            CHAR(36) PRIMARY KEY,
    room_uuid       CHAR(36) NOT NULL,
    dictionary      VARCHAR(100) NOT NULL,
    effect          VARCHAR(100) NOT NULL,
    pos_x           FLOAT NOT NULL,
    pos_y           FLOAT NOT NULL,
    pos_z           FLOAT NOT NULL,
    rot_x           FLOAT DEFAULT 0,
    rot_y           FLOAT DEFAULT 0,
    rot_z           FLOAT DEFAULT 0,
    alpha           TINYINT UNSIGNED DEFAULT 255,
    created_by      VARCHAR(100) DEFAULT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (room_uuid) REFERENCES respoon_rooms(uuid) ON DELETE CASCADE,
    INDEX idx_room (room_uuid),
    INDEX idx_dict_effect (dictionary, effect)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Particle effect metadata table (seeded from YPT extraction)
CREATE TABLE IF NOT EXISTS respoon_particle_effects (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    dictionary      VARCHAR(100) NOT NULL,
    effect          VARCHAR(100) NOT NULL,
    is_looped       BOOLEAN DEFAULT FALSE,
    duration_min    FLOAT DEFAULT NULL,
    duration_max    FLOAT DEFAULT NULL,
    responds_to     JSON DEFAULT NULL,

    UNIQUE KEY unique_dict_effect (dictionary, effect),
    INDEX idx_dictionary (dictionary),
    FULLTEXT idx_search (dictionary, effect)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
