<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Input Challenge Seeds - Mohit's Math Game</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header">
                <h1 class="title">Mohit's Math Game</h1>
                <p class="subtitle">Welcome, <strong><%= session.getAttribute("playerName") %></strong>! Set up your math challenges.</p>
                <div style="margin-top: 10px; font-size: 0.85rem; color: #a5b4fc; background: rgba(99, 102, 241, 0.15); padding: 8px 14px; border-radius: 8px;">
                    🎲 <em>The system will add or subtract a random number (1 to 10) to each value you provide to create the final quiz questions!</em>
                </div>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="game" method="post">
                <input type="hidden" name="action" value="generate">

                <!-- Q1 Prime Seed -->
                <div class="question-box">
                    <div class="question-header">
                        <span class="q-title">Challenge 1: Prime Number Setup</span>
                        <span class="q-marks">2 Marks</span>
                    </div>
                    <div class="form-group">
                        <label for="primeSeed">Give me a number for prime check:</label>
                        <div class="hint">System will alter this by &plusmn; (1..10) and ask if the result is prime.</div>
                        <input type="number" id="primeSeed" name="primeSeed" class="form-control" placeholder="e.g. 17" required>
                    </div>
                </div>

                <!-- Q2 Modulus Seed -->
                <div class="question-box">
                    <div class="question-header">
                        <span class="q-title">Challenge 2: Modulus Operation Setup</span>
                        <span class="q-marks">2 Marks</span>
                    </div>
                    <div class="grid-2">
                        <div class="form-group">
                            <label for="modSeedA">Dividend (Number A):</label>
                            <input type="number" id="modSeedA" name="modSeedA" class="form-control" placeholder="e.g. 25" required>
                        </div>
                        <div class="form-group">
                            <label for="modSeedB">Divisor (Number B):</label>
                            <input type="number" id="modSeedB" name="modSeedB" class="form-control" placeholder="e.g. 6" required>
                        </div>
                    </div>
                </div>

                <!-- Q3 Trig 1 Seed -->
                <div class="question-box">
                    <div class="question-header">
                        <span class="q-title">Challenge 3: Trigonometry (Sine) Setup</span>
                        <span class="q-marks">3 Marks</span>
                    </div>
                    <div class="form-group">
                        <label for="trigSeed1">Give me an angle in degrees:</label>
                        <div class="hint">e.g. 30, 45, 60, 90</div>
                        <input type="number" step="any" id="trigSeed1" name="trigSeed1" class="form-control" placeholder="e.g. 30" required>
                    </div>
                </div>

                <!-- Q4 Trig 2 Seed -->
                <div class="question-box">
                    <div class="question-header">
                        <span class="q-title">Challenge 4: Trigonometry (Cosine) Setup</span>
                        <span class="q-marks">3 Marks</span>
                    </div>
                    <div class="form-group">
                        <label for="trigSeed2">Give me another angle in degrees:</label>
                        <div class="hint">e.g. 45, 60, 90, 180</div>
                        <input type="number" step="any" id="trigSeed2" name="trigSeed2" class="form-control" placeholder="e.g. 60" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">Generate Challenges 🎲</button>
            </form>
        </div>
    </div>
</body>
</html>
