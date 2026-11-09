<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mohit's Math Game - Math Whiz</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header">
                <h1 class="title">Mohit's Math Game</h1>
                <p class="subtitle">Live Lab Test #2 &bull; Java Servlet &amp; JDBC Web Application</p>
                <span class="badge badge-normal">Difficulty: NORMAL</span>
            </div>

            <form action="game" method="post">
                <input type="hidden" name="action" value="start">
                
                <div class="form-group">
                    <label for="playerName">Enter Your Name:</label>
                    <input type="text" id="playerName" name="playerName" class="form-control" 
                           placeholder="e.g. Mohit" required autofocus>
                </div>

                <button type="submit" class="btn btn-primary">Start Game 🚀</button>
            </form>

            <div class="btn-group">
                <a href="game?action=leaderboard" class="btn btn-secondary" style="width: 100%;">
                    🏆 View Top 10 Leaderboard
                </a>
            </div>
        </div>
    </div>
</body>
</html>
