-- Respoon Animation Database Schema
-- Version: 1.0.0
-- Purpose: Enable Stage 2 animation/clipset selection for peds
--
-- Usage:
--   1. Run this script to create animation tables
--   2. Run seed_animations.sql to populate data
--
-- Note: Current animation/clipset CANNOT be extracted from FiveM - natives don't exist
--       This database enables SETTING animations, not viewing current state

-- =============================================================================
-- ANIMATION DICTIONARIES
-- Parsed from animDictsCompact.json (~1000+ dictionaries)
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_animation_dicts (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    dict_name       VARCHAR(200) NOT NULL UNIQUE,
    clip_count      INT NOT NULL DEFAULT 0,
    category        VARCHAR(50),  -- e.g., "world_human", "amb@", "move_", "anim@"

    INDEX idx_category (category),
    FULLTEXT idx_dict_search (dict_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- ANIMATION CLIPS
-- Individual animations within each dictionary
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_animation_clips (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    dict_id         INT NOT NULL,
    clip_name       VARCHAR(100) NOT NULL,
    search_text     VARCHAR(300) DEFAULT NULL,

    FOREIGN KEY (dict_id) REFERENCES respoon_animation_dicts(id) ON DELETE CASCADE,
    UNIQUE KEY unique_clip (dict_id, clip_name),
    INDEX idx_dict (dict_id),
    FULLTEXT idx_clip_search (clip_name),
    FULLTEXT idx_search_text (search_text)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- MOVEMENT CLIPSETS
-- Parsed from movementClipsetsCompact.json and movementClipsetsWalkingCompact.json
-- Used for SetPedMovementClipset() in Stage 2
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_movement_clipsets (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    clipset_name    VARCHAR(200) NOT NULL UNIQUE,
    category        VARCHAR(50),  -- Derived from name pattern: "drunk", "injured", "stealth", etc.
    is_walking      BOOLEAN DEFAULT FALSE,  -- TRUE if from movementClipsetsWalkingCompact.json

    INDEX idx_category (category),
    INDEX idx_walking (is_walking),
    FULLTEXT idx_clipset_search (clipset_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================================================
-- RELATIONSHIP GROUPS (Bonus)
-- Common relationship group hashes for ped lookups
-- =============================================================================

CREATE TABLE IF NOT EXISTS respoon_relationship_groups (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    hash            BIGINT NOT NULL UNIQUE,
    name            VARCHAR(100) NOT NULL,

    INDEX idx_hash (hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Relationship groups will be seeded by seed_animations.sql with pre-computed hashes
