<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mohit's Math Game - Challenge</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .progress-bar-container {
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            height: 8px;
            border-radius: 4px;
            margin: 16px 0 24px 0;
            overflow: hidden;
        }
        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, #4f46e5, #06b6d4);
            border-radius: 4px;
            transition: width 0.3s ease;
        }
        .mcq-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin: 18px 0;
        }
        .mcq-option {
            background: rgba(15, 23, 42, 0.7);
            border: 2px solid rgba(255, 255, 255, 0.15);
            border-radius: 10px;
            padding: 16px;
            display: flex;
            align-items: center;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .mcq-option:hover {
            border-color: #38bdf8;
            background: rgba(56, 189, 248, 0.1);
        }
        .mcq-option input[type="radio"] {
            margin-right: 12px;
            accent-color: #38bdf8;
            transform: scale(1.3);
        }
        .mcq-label {
            font-size: 1.15rem;
            font-weight: 700;
            color: #f8fafc;
        }
        .highlight-box {
            background: rgba(56, 189, 248, 0.1);
            border-left: 4px solid #38bdf8;
            padding: 14px 18px;
            border-radius: 8px;
            margin: 14px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <%
                int step = (Integer) session.getAttribute("currentStep");
                String phase = (String) session.getAttribute("phase"); // "input" or "quiz"
                String playerName = (String) session.getAttribute("playerName");
                int progress = (step - 1) * 25 + (phase.equals("quiz") ? 15 : 0);
            %>

            <div class="header">
                <h1 class="title">Mohit's Math Game</h1>
                <p class="subtitle">Player: <strong><%= playerName %></strong> &bull; Question <strong><%= step %> of 4</strong></p>
                <div class="progress-bar-container">
                    <div class="progress-bar-fill" style="width: <%= progress %>%;"></div>
                </div>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-msg"><%= request.getAttribute("error") %></div>
            <% } %>

            <!-- ========================================== -->
            <!-- QUESTION 1: PRIME NUMBER                   -->
            <!-- ========================================== -->
            <% if (step == 1) { %>
                <div class="question-header">
                    <span class="q-title">Challenge 1: Prime Number</span>
                    <span class="q-marks">2 Marks</span>
                </div>

                <% if ("input".equals(phase)) { %>
                    <!-- Step 1 Phase 1: Provide seed -->
                    <p style="margin-bottom: 14px; color: #94a3b8;">
                        Give a number. The system will add or subtract a random value (&plusmn;1..10) to create your challenge!
                    </p>
                    <form action="game" method="post">
                        <input type="hidden" name="action" value="generate_q1">
                        <div class="form-group">
                            <label for="primeSeed">Give me a number for prime check:</label>
                            <input type="number" id="primeSeed" name="primeSeed" class="form-control" placeholder="e.g. 17" required autofocus>
                        </div>
                        <button type="submit" class="btn btn-primary">Generate Challenge 🎲</button>
                    </form>

                <% } else { %>
                    <!-- Step 1 Phase 2: Choose 1 (Prime) or 0 (Not Prime) -->
                    <div class="highlight-box">
                        <p style="color: #94a3b8; font-size: 0.9rem;">Your input modified with random offset is:</p>
                        <h2 style="color: #38bdf8; font-size: 2rem; margin: 4px 0;"><%= session.getAttribute("q1_val") %></h2>
                        <p style="color: #e2e8f0; font-weight: 600;">Is this number a Prime Number?</p>
                    </div>

                    <form action="game" method="post">
                        <input type="hidden" name="action" value="answer_q1">
                        <div class="mcq-container">
                            <label class="mcq-option">
                                <input type="radio" name="q1_answer" value="1" required>
                                <span class="mcq-label">1 &nbsp;<small style="color: #94a3b8; font-size: 0.9rem;">(Prime)</small></span>
                            </label>
                            <label class="mcq-option">
                                <input type="radio" name="q1_answer" value="0" required>
                                <span class="mcq-label">0 &nbsp;<small style="color: #94a3b8; font-size: 0.9rem;">(Not Prime)</small></span>
                            </label>
                        </div>
                        <button type="submit" class="btn btn-primary">Next Challenge ➡️</button>
                    </form>
                <% } %>
            <% } %>

            <!-- ========================================== -->
            <!-- QUESTION 2: MODULUS OPERATION              -->
            <!-- ========================================== -->
            <% if (step == 2) { %>
                <div class="question-header">
                    <span class="q-title">Challenge 2: Modulus Operation</span>
                    <span class="q-marks">2 Marks</span>
                </div>

                <% if ("input".equals(phase)) { %>
                    <!-- Step 2 Phase 1: Provide seeds -->
                    <p style="margin-bottom: 14px; color: #94a3b8;">
                        Enter two numbers for modulus. The system will alter them by (&plusmn;1..10) to create a challenge!
                    </p>
                    <form action="game" method="post">
                        <input type="hidden" name="action" value="generate_q2">
                        <div class="grid-2">
                            <div class="form-group">
                                <label for="modSeedA">Dividend (A):</label>
                                <input type="number" id="modSeedA" name="modSeedA" class="form-control" placeholder="e.g. 23" required autofocus>
                            </div>
                            <div class="form-group">
                                <label for="modSeedB">Divisor (B):</label>
                                <input type="number" id="modSeedB" name="modSeedB" class="form-control" placeholder="e.g. 5" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Generate Challenge 🎲</button>
                    </form>

                <% } else { %>
                    <!-- Step 2 Phase 2: Choose remainder from 4 MCQ options -->
                    <div class="highlight-box">
                        <p style="color: #94a3b8; font-size: 0.9rem;">Calculate the remainder of the mutated problem:</p>
                        <h2 style="color: #38bdf8; font-size: 2rem; margin: 4px 0;">
                            <%= session.getAttribute("q2_valA") %> % <%= session.getAttribute("q2_valB") %> = ?
                        </h2>
                        <p style="color: #e2e8f0; font-weight: 600;">Select the correct remainder:</p>
                    </div>

                    <form action="game" method="post">
                        <input type="hidden" name="action" value="answer_q2">
                        <div class="mcq-container">
                            <%
                                List<Integer> options = (List<Integer>) session.getAttribute("q2_options");
                                char optLetter = 'A';
                                for (Integer opt : options) {
                            %>
                                <label class="mcq-option">
                                    <input type="radio" name="q2_answer" value="<%= opt %>" required>
                                    <span class="mcq-label"><%= optLetter++ %>) &nbsp;<%= opt %></span>
                                </label>
                            <% } %>
                        </div>
                        <button type="submit" class="btn btn-primary">Next Challenge ➡️</button>
                    </form>
                <% } %>
            <% } %>

            <!-- ========================================== -->
            <!-- QUESTION 3: TRIGONOMETRY 1                 -->
            <!-- ========================================== -->
            <% if (step == 3) { %>
                <div class="question-header">
                    <span class="q-title">Challenge 3: Trigonometry (Challenge 1)</span>
                    <span class="q-marks">3 Marks</span>
                </div>

                <% if ("input".equals(phase)) { %>
                    <!-- Step 3 Phase 1: Provide digit, operator, angle -->
                    <p style="margin-bottom: 14px; color: #94a3b8;">
                        Enter a normal digit, choose a trigonometric operator, and enter an angle in degrees.
                    </p>
                    <form action="game" method="post">
                        <input type="hidden" name="action" value="generate_q3">
                        <div class="form-group">
                            <label for="trigDigit">Normal Digit (Coefficient):</label>
                            <input type="number" step="any" id="trigDigit" name="trigDigit" class="form-control" placeholder="e.g. 4" required autofocus>
                        </div>
                        <div class="grid-2">
                            <div class="form-group">
                                <label for="trigOp">Trigonometric Operator:</label>
                                <select id="trigOp" name="trigOp" class="form-control" required>
                                    <option value="sin">sin (Sine)</option>
                                    <option value="cos">cos (Cosine)</option>
                                    <option value="tan">tan (Tangent)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="trigAngle">Angle in Degrees (°):</label>
                                <input type="number" step="any" id="trigAngle" name="trigAngle" class="form-control" placeholder="e.g. 30" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Generate Challenge 🎲</button>
                    </form>

                <% } else { %>
                    <!-- Step 3 Phase 2: Choose answer from 4 MCQ options -->
                    <div class="highlight-box">
                        <p style="color: #94a3b8; font-size: 0.9rem;">Your digit was modified with random offset (&plusmn;1..10):</p>
                        <h2 style="color: #38bdf8; font-size: 2rem; margin: 4px 0;">
                            <%= session.getAttribute("q3_mutatedDigit") %> &times; <%= session.getAttribute("q3_op") %>(<%= session.getAttribute("q3_angle") %>°) = ?
                        </h2>
                        <p style="color: #e2e8f0; font-weight: 600;">Select the correct value (rounded to 2 decimal places):</p>
                    </div>

                    <form action="game" method="post">
                        <input type="hidden" name="action" value="answer_q3">
                        <div class="mcq-container">
                            <%
                                List<Double> options = (List<Double>) session.getAttribute("q3_options");
                                char optLetter = 'A';
                                for (Double opt : options) {
                            %>
                                <label class="mcq-option">
                                    <input type="radio" name="q3_answer" value="<%= opt %>" required>
                                    <span class="mcq-label"><%= optLetter++ %>) &nbsp;<%= opt %></span>
                                </label>
                            <% } %>
                        </div>
                        <button type="submit" class="btn btn-primary">Next Challenge ➡️</button>
                    </form>
                <% } %>
            <% } %>

            <!-- ========================================== -->
            <!-- QUESTION 4: TRIGONOMETRY 2                 -->
            <!-- ========================================== -->
            <% if (step == 4) { %>
                <div class="question-header">
                    <span class="q-title">Challenge 4: Trigonometry (Challenge 2)</span>
                    <span class="q-marks">3 Marks</span>
                </div>

                <% if ("input".equals(phase)) { %>
                    <!-- Step 4 Phase 1: Provide digit, operator, angle -->
                    <p style="margin-bottom: 14px; color: #94a3b8;">
                        Final challenge! Enter another digit, operator, and angle.
                    </p>
                    <form action="game" method="post">
                        <input type="hidden" name="action" value="generate_q4">
                        <div class="form-group">
                            <label for="trigDigit">Normal Digit (Coefficient):</label>
                            <input type="number" step="any" id="trigDigit" name="trigDigit" class="form-control" placeholder="e.g. 6" required autofocus>
                        </div>
                        <div class="grid-2">
                            <div class="form-group">
                                <label for="trigOp">Trigonometric Operator:</label>
                                <select id="trigOp" name="trigOp" class="form-control" required>
                                    <option value="cos">cos (Cosine)</option>
                                    <option value="sin">sin (Sine)</option>
                                    <option value="tan">tan (Tangent)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="trigAngle">Angle in Degrees (°):</label>
                                <input type="number" step="any" id="trigAngle" name="trigAngle" class="form-control" placeholder="e.g. 60" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Generate Challenge 🎲</button>
                    </form>

                <% } else { %>
                    <!-- Step 4 Phase 2: Choose answer from 4 MCQ options -->
                    <div class="highlight-box">
                        <p style="color: #94a3b8; font-size: 0.9rem;">Your digit was modified with random offset (&plusmn;1..10):</p>
                        <h2 style="color: #38bdf8; font-size: 2rem; margin: 4px 0;">
                            <%= session.getAttribute("q4_mutatedDigit") %> &times; <%= session.getAttribute("q4_op") %>(<%= session.getAttribute("q4_angle") %>°) = ?
                        </h2>
                        <p style="color: #e2e8f0; font-weight: 600;">Select the correct value (rounded to 2 decimal places):</p>
                    </div>

                    <form action="game" method="post">
                        <input type="hidden" name="action" value="answer_q4">
                        <div class="mcq-container">
                            <%
                                List<Double> options = (List<Double>) session.getAttribute("q4_options");
                                char optLetter = 'A';
                                for (Double opt : options) {
                            %>
                                <label class="mcq-option">
                                    <input type="radio" name="q4_answer" value="<%= opt %>" required>
                                    <span class="mcq-label"><%= optLetter++ %>) &nbsp;<%= opt %></span>
                                </label>
                            <% } %>
                        </div>
                        <button type="submit" class="btn btn-primary">Finish &amp; View Result 🏁</button>
                    </form>
                <% } %>
            <% } %>

        </div>
    </div>
</body>
</html>
