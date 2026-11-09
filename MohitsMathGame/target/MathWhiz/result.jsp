<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Game Results - Mohit's Math Game</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header">
                <h1 class="title">Mohit's Math Game</h1>
                <p class="subtitle">Game Performance Summary</p>
                <span class="badge badge-normal">Difficulty: NORMAL</span>
            </div>

            <%
                int score = (Integer) session.getAttribute("totalScore");
                String playerName = (String) session.getAttribute("playerName");
                List<Map<String, Object>> history = (List<Map<String, Object>>) session.getAttribute("history");
            %>

            <div class="score-banner">
                <p style="color: #94a3b8; font-size: 1rem; margin-bottom: 4px;">Player: <strong><%= playerName %></strong></p>
                <div class="score-number"><%= score %> <span style="font-size: 1.5rem; color: #94a3b8;">/ 10</span></div>
                <p style="margin-top: 6px; font-weight: 600;">
                    <% 
                        if (score == 10) {
                            out.print("🌟 Outstanding! Perfect 10 / 10 Score!");
                        } else if (score >= 6) {
                            out.print("👏 Well Done! Great Math Skills!");
                        } else {
                            out.print("💪 Good effort! Keep practicing!");
                        }
                    %>
                </p>
                <p style="font-size: 0.85rem; color: #10b981; margin-top: 4px;">
                    ✅ Your score has been securely saved to the database via JDBC!
                </p>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Challenge</th>
                            <th>Problem</th>
                            <th>Your Answer</th>
                            <th>Expected</th>
                            <th>Status</th>
                            <th>Marks</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (history != null) {
                                for (Map<String, Object> item : history) {
                                    boolean isCorrect = (Boolean) item.get("isCorrect");
                        %>
                            <tr>
                                <td><strong><%= item.get("title") %></strong></td>
                                <td><%= item.get("problem") %></td>
                                <td><%= item.get("userAns") %></td>
                                <td><%= item.get("correctAns") %></td>
                                <td>
                                    <% if (isCorrect) { %>
                                        <span class="badge badge-success">Correct</span>
                                    <% } else { %>
                                        <span class="badge badge-danger">Wrong</span>
                                    <% } %>
                                </td>
                                <td><strong><%= item.get("marks") %> / <%= item.get("maxMarks") %></strong></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="btn-group">
                <a href="index.jsp" class="btn btn-primary" style="flex: 1;">🔄 Play Again</a>
                <a href="game?action=leaderboard" class="btn btn-secondary" style="flex: 1;">🏆 Top 10 Leaderboard</a>
            </div>
        </div>
    </div>
</body>
</html>
