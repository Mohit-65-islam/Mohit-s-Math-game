package dao;

import model.GameScore;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ScoreDAO {

    // Database configuration constants for XAMPP MySQL
    private static final String DB_URL = "jdbc:mysql://localhost:3306/math_whiz_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = ""; // XAMPP default MySQL password is blank

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found: " + e.getMessage());
        }
    }

    /**
     * Establishes a connection to the database.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    /**
     * Saves a player's score to the game_scores table using PreparedStatement.
     */
    public static boolean saveScore(GameScore gameScore) {
        String sql = "INSERT INTO game_scores (player_name, score, difficulty, played_at) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, gameScore.getPlayerName());
            stmt.setInt(2, gameScore.getScore());
            stmt.setString(3, gameScore.getDifficulty() != null ? gameScore.getDifficulty() : "NORMAL");
            stmt.setTimestamp(4, gameScore.getPlayedAt() != null ? gameScore.getPlayedAt() : new Timestamp(System.currentTimeMillis()));

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("Error saving game score: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves the top 10 scores sorted by score DESC, then played_at ASC.
     */
    public static List<GameScore> getTopScores() {
        List<GameScore> list = new ArrayList<>();
        String sql = "SELECT * FROM game_scores ORDER BY score DESC, played_at ASC LIMIT 10";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                GameScore score = new GameScore(
                        rs.getInt("id"),
                        rs.getString("player_name"),
                        rs.getInt("score"),
                        rs.getString("difficulty"),
                        rs.getTimestamp("played_at")
                );
                list.add(score);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving top scores: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
}
