-- Respoon: Purge all tables
-- Run manually via phpMyAdmin, HeidiSQL, or CLI to reset the database.
-- This drops ALL respoon data including seed catalogs.
-- After running, restart the resource to re-run migrations.

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS respoon_scene_state;
DROP TABLE IF EXISTS respoon_frame_entities;
DROP TABLE IF EXISTS respoon_frames;
DROP TABLE IF EXISTS respoon_entity_tasks;
DROP TABLE IF EXISTS respoon_task_sequences;
DROP TABLE IF EXISTS respoon_particles;
DROP TABLE IF EXISTS respoon_entities;
DROP TABLE IF EXISTS respoon_room_members;
DROP TABLE IF EXISTS respoon_rooms;
DROP TABLE IF EXISTS respoon_entity_library;
DROP TABLE IF EXISTS respoon_animation_clips;
DROP TABLE IF EXISTS respoon_animation_dicts;
DROP TABLE IF EXISTS respoon_movement_clipsets;
DROP TABLE IF EXISTS respoon_relationship_groups;
DROP TABLE IF EXISTS respoon_particle_effects;
DROP TABLE IF EXISTS respoon_models;
DROP TABLE IF EXISTS respoon_migrations;

SET FOREIGN_KEY_CHECKS = 1;
