<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.GameScore" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top 10 Leaderboard - Mohit's Math Game</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header">
                <h1 class="title">🏆 Top 10 Leaderboard</h1>
                <p class="subtitle">Mohit's Math Game &bull; Hall of Fame</p>
                <span class="badge badge-normal">Difficulty: NORMAL</span>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Player Name</th>
                            <th>Score</th>
                            <th>Difficulty</th>
                            <th>Date / Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<GameScore> topScores = (List<GameScore>) request.getAttribute("topScores");
                            if (topScores != null && !topScores.isEmpty()) {
                                int rank = 1;
                                for (GameScore score : topScores) {
                                    String rankClass = "";
                                    String medal = "";
                                    if (rank == 1) { rankClass = "rank-1"; medal = "🥇 "; }
                                    else if (rank == 2) { rankClass = "rank-2"; medal = "🥈 "; }
                                    else if (rank == 3) { rankClass = "rank-3"; medal = "🥉 "; }
                        %>
                            <tr>
                                <td class="<%= rankClass %>"><%= medal %><%= rank++ %></td>
                                <td><strong><%= score.getPlayerName() %></strong></td>
                                <td><strong style="color: #38bdf8;"><%= score.getScore() %> / 10</strong></td>
                                <td><span class="badge badge-normal"><%= score.getDifficulty() %></span></td>
                                <td style="color: #94a3b8; font-size: 0.85rem;"><%= score.getPlayedAt() %></td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="5" style="text-align: center; color: #94a3b8; padding: 24px;">
                                    No game records found in database yet. Be the first to play! 🚀
                                </td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="btn-group">
                <a href="index.jsp" class="btn btn-primary" style="flex: 1;">🎮 Play New Game</a>
            </div>
        </div>
    </div>
</body>
</html>
