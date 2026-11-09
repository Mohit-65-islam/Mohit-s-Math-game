<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Answer Challenges - Mohit's Math Game</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header">
                <h1 class="title">Mohit's Math Game</h1>
                <p class="subtitle">Player: <strong><%= session.getAttribute("playerName") %></strong> &bull; Total Marks: 10</p>
                <span class="badge badge-normal">Difficulty: NORMAL</span>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="game" method="post">
                <input type="hidden" name="action" value="submit">

                <!-- Q1: Prime Number Question -->
                <div class="question-box">
                    <div class="question-header">
                        <span class="q-title">Q1: Prime Number Challenge</span>
                        <span class="q-marks">2 Marks</span>
                    </div>
                    <p style="margin-bottom: 12px; font-size: 0.95rem;">
                        Base number was modified with a random offset (&plusmn;1..10) to:
                        <strong style="color: #38bdf8; font-size: 1.25rem;"><%= session.getAttribute("q1Val") %></strong>
                    </p>
                    <div class="form-group">
                        <label for="ans1">Is <%= session.getAttribute("q1Val") %> a Prime Number?</label>
                        <select id="ans1" name="ans1" class="form-control" required>
                            <option value="" disabled selected>-- Select Your Answer --</option>
                            <option value="1">1 - Yes, it is Prime</option>
                            <option value="0">0 - No, it is Not Prime</option>
                        </select>
                    </div>
                </div>

                <!-- Q2: Modulus Question -->
                <div class="question-box">
                    <div class="question-header">
                        <span class="q-title">Q2: Modulus Operation Challenge</span>
                        <span class="q-marks">2 Marks</span>
                    </div>
                    <p style="margin-bottom: 12px; font-size: 0.95rem;">
                        Calculate remainder for the mutated values:
                        <strong style="color: #38bdf8; font-size: 1.25rem;"><%= session.getAttribute("q2ValA") %> % <%= session.getAttribute("q2ValB") %></strong>
                    </p>
                    <div class="form-group">
                        <label for="ans2">What is the remainder?</label>
                        <input type="number" id="ans2" name="ans2" class="form-control" placeholder="Enter integer remainder" required>
                    </div>
                </div>

                <!-- Q3: Sine Question -->
                <div class="question-box">
                    <div class="question-header">
                        <span class="q-title">Q3: Trigonometric Challenge (Sine)</span>
                        <span class="q-marks">3 Marks</span>
                    </div>
                    <p style="margin-bottom: 12px; font-size: 0.95rem;">
                        Calculate the sine value for modified angle:
                        <strong style="color: #38bdf8; font-size: 1.25rem;">sin(<%= session.getAttribute("q3Val") %>°)</strong>
                    </p>
                    <div class="form-group">
                        <label for="ans3">Your Answer (Decimal value, e.g. 0.5, -0.707):</label>
                        <input type="number" step="any" id="ans3" name="ans3" class="form-control" placeholder="Enter calculated value" required>
                    </div>
                </div>

                <!-- Q4: Cosine Question -->
                <div class="question-box">
                    <div class="question-header">
                        <span class="q-title">Q4: Trigonometric Challenge (Cosine)</span>
                        <span class="q-marks">3 Marks</span>
                    </div>
                    <p style="margin-bottom: 12px; font-size: 0.95rem;">
                        Calculate the cosine value for modified angle:
                        <strong style="color: #38bdf8; font-size: 1.25rem;">cos(<%= session.getAttribute("q4Val") %>°)</strong>
                    </p>
                    <div class="form-group">
                        <label for="ans4">Your Answer (Decimal value, e.g. 0.5, -0.707):</label>
                        <input type="number" step="any" id="ans4" name="ans4" class="form-control" placeholder="Enter calculated value" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">Submit Answers 🎯</button>
            </form>
        </div>
    </div>
</body>
</html>
