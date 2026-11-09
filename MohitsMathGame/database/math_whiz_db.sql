-- ========================================================
-- Database Schema for Mohit's Math Game (Live Lab Test #2)
-- Database Name: math_whiz_db
-- Table Name: game_scores
-- ========================================================

CREATE DATABASE IF NOT EXISTS math_whiz_db;
USE math_whiz_db;

-- Drop table if exists to ensure clean setup
DROP TABLE IF EXISTS game_scores;

-- Create game_scores table
CREATE TABLE game_scores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    score INT NOT NULL,
    difficulty VARCHAR(20) DEFAULT 'NORMAL',
    played_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample records for initial testing & leaderboard preview
INSERT INTO game_scores (player_name, score, difficulty, played_at) VALUES 
('Mohit', 10, 'NORMAL', NOW() - INTERVAL 10 MINUTE),
('Rahim', 8, 'NORMAL', NOW() - INTERVAL 25 MINUTE),
('Karim', 7, 'NORMAL', NOW() - INTERVAL 40 MINUTE),
('Sadia', 5, 'NORMAL', NOW() - INTERVAL 50 MINUTE);

-- Query to verify top 10 leaderboard
SELECT * FROM game_scores ORDER BY score DESC, played_at ASC LIMIT 10;
