package controller;

import dao.ScoreDAO;
import model.GameScore;
import service.MathService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@WebServlet("/game")
public class GameServlet extends HttpServlet {

    private final Random random = new Random();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("leaderboard".equalsIgnoreCase(action)) {
            showLeaderboard(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("start".equalsIgnoreCase(action)) {
            String playerName = request.getParameter("playerName");
            if (playerName == null || playerName.trim().isEmpty()) {
                playerName = "Player";
            }
            session.setAttribute("playerName", playerName.trim());
            session.setAttribute("currentStep", 1);
            session.setAttribute("phase", "input"); // "input" or "quiz"
            session.setAttribute("totalScore", 0);

            // Detailed question history for final review
            List<Map<String, Object>> history = new ArrayList<>();
            session.setAttribute("history", history);

            request.getRequestDispatcher("question.jsp").forward(request, response);

        } else if ("generate_q1".equalsIgnoreCase(action)) {
            // STEP 1: PRIME - User gives a number
            try {
                int seed = Integer.parseInt(request.getParameter("primeSeed"));
                int offset = getRandomOffset();
                int mutatedVal = Math.max(1, seed + offset);

                int correctAns = MathService.isPrime(mutatedVal); // 1 or 0

                session.setAttribute("q1_seed", seed);
                session.setAttribute("q1_offset", offset);
                session.setAttribute("q1_val", mutatedVal);
                session.setAttribute("q1_correct", correctAns);

                session.setAttribute("phase", "quiz");
                request.getRequestDispatcher("question.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Please enter a valid integer.");
                request.getRequestDispatcher("question.jsp").forward(request, response);
            }

        } else if ("answer_q1".equalsIgnoreCase(action)) {
            int userChoice = Integer.parseInt(request.getParameter("q1_answer")); // 1 or 0
            int correctAns = (Integer) session.getAttribute("q1_correct");
            int mutatedVal = (Integer) session.getAttribute("q1_val");

            boolean isCorrect = (userChoice == correctAns);
            int marks = isCorrect ? 2 : 0;

            int totalScore = (Integer) session.getAttribute("totalScore") + marks;
            session.setAttribute("totalScore", totalScore);

            recordHistory(session, "Q1: Prime Number", 
                    "Is " + mutatedVal + " prime?", 
                    String.valueOf(userChoice), 
                    String.valueOf(correctAns), 
                    isCorrect, marks, 2);

            // Move to Step 2 (Modulus)
            session.setAttribute("currentStep", 2);
            session.setAttribute("phase", "input");
            request.getRequestDispatcher("question.jsp").forward(request, response);

        } else if ("generate_q2".equalsIgnoreCase(action)) {
            // STEP 2: MODULUS - User gives 2 numbers
            try {
                int seedA = Integer.parseInt(request.getParameter("modSeedA"));
                int seedB = Integer.parseInt(request.getParameter("modSeedB"));
                if (seedB == 0) seedB = 3;

                int offsetA = getRandomOffset();
                int mutatedA = seedA + offsetA;
                int mutatedB = Math.max(1, Math.abs(seedB)); // Avoid divisor 0

                int correctAns = MathService.calculateMod(mutatedA, mutatedB);

                // Generate 4 distinct MCQ options
                List<Integer> options = generateModOptions(correctAns, mutatedB);

                session.setAttribute("q2_seedA", seedA);
                session.setAttribute("q2_seedB", seedB);
                session.setAttribute("q2_valA", mutatedA);
                session.setAttribute("q2_valB", mutatedB);
                session.setAttribute("q2_correct", correctAns);
                session.setAttribute("q2_options", options);

                session.setAttribute("phase", "quiz");
                request.getRequestDispatcher("question.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Please enter valid integers.");
                request.getRequestDispatcher("question.jsp").forward(request, response);
            }

        } else if ("answer_q2".equalsIgnoreCase(action)) {
            int userChoice = Integer.parseInt(request.getParameter("q2_answer"));
            int correctAns = (Integer) session.getAttribute("q2_correct");
            int valA = (Integer) session.getAttribute("q2_valA");
            int valB = (Integer) session.getAttribute("q2_valB");

            boolean isCorrect = (userChoice == correctAns);
            int marks = isCorrect ? 2 : 0;

            int totalScore = (Integer) session.getAttribute("totalScore") + marks;
            session.setAttribute("totalScore", totalScore);

            recordHistory(session, "Q2: Modulus", 
                    valA + " % " + valB, 
                    String.valueOf(userChoice), 
                    String.valueOf(correctAns), 
                    isCorrect, marks, 2);

            // Move to Step 3 (Trigonometry 1)
            session.setAttribute("currentStep", 3);
            session.setAttribute("phase", "input");
            request.getRequestDispatcher("question.jsp").forward(request, response);

        } else if ("generate_q3".equalsIgnoreCase(action)) {
            // STEP 3: TRIGONOMETRY 1 - User gives digit, operator (sin/cos/tan), angle
            try {
                double digit = Double.parseDouble(request.getParameter("trigDigit"));
                String op = request.getParameter("trigOp"); // "sin", "cos", "tan"
                double angle = Double.parseDouble(request.getParameter("trigAngle"));

                int offset = getRandomOffset();
                double mutatedDigit = digit + offset;

                double trigVal = calculateTrig(op, angle);
                double correctAns = mutatedDigit * trigVal;
                correctAns = Math.round(correctAns * 100.0) / 100.0; // round to 2 decimal places

                List<Double> options = generateTrigOptions(correctAns);

                session.setAttribute("q3_digit", digit);
                session.setAttribute("q3_mutatedDigit", mutatedDigit);
                session.setAttribute("q3_op", op);
                session.setAttribute("q3_angle", angle);
                session.setAttribute("q3_correct", correctAns);
                session.setAttribute("q3_options", options);

                session.setAttribute("phase", "quiz");
                request.getRequestDispatcher("question.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Please enter valid numbers.");
                request.getRequestDispatcher("question.jsp").forward(request, response);
            }

        } else if ("answer_q3".equalsIgnoreCase(action)) {
            double userChoice = Double.parseDouble(request.getParameter("q3_answer"));
            double correctAns = (Double) session.getAttribute("q3_correct");
            double mutatedDigit = (Double) session.getAttribute("q3_mutatedDigit");
            String op = (String) session.getAttribute("q3_op");
            double angle = (Double) session.getAttribute("q3_angle");

            boolean isCorrect = Math.abs(userChoice - correctAns) < 0.05;
            int marks = isCorrect ? 3 : 0;

            int totalScore = (Integer) session.getAttribute("totalScore") + marks;
            session.setAttribute("totalScore", totalScore);

            recordHistory(session, "Q3: Trigonometry (Challenge 1)", 
                    mutatedDigit + " × " + op + "(" + angle + "°)", 
                    String.valueOf(userChoice), 
                    String.valueOf(correctAns), 
                    isCorrect, marks, 3);

            // Move to Step 4 (Trigonometry 2)
            session.setAttribute("currentStep", 4);
            session.setAttribute("phase", "input");
            request.getRequestDispatcher("question.jsp").forward(request, response);

        } else if ("generate_q4".equalsIgnoreCase(action)) {
            // STEP 4: TRIGONOMETRY 2 - User gives digit, operator (sin/cos/tan), angle
            try {
                double digit = Double.parseDouble(request.getParameter("trigDigit"));
                String op = request.getParameter("trigOp");
                double angle = Double.parseDouble(request.getParameter("trigAngle"));

                int offset = getRandomOffset();
                double mutatedDigit = digit + offset;

                double trigVal = calculateTrig(op, angle);
                double correctAns = mutatedDigit * trigVal;
                correctAns = Math.round(correctAns * 100.0) / 100.0;

                List<Double> options = generateTrigOptions(correctAns);

                session.setAttribute("q4_digit", digit);
                session.setAttribute("q4_mutatedDigit", mutatedDigit);
                session.setAttribute("q4_op", op);
                session.setAttribute("q4_angle", angle);
                session.setAttribute("q4_correct", correctAns);
                session.setAttribute("q4_options", options);

                session.setAttribute("phase", "quiz");
                request.getRequestDispatcher("question.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Please enter valid numbers.");
                request.getRequestDispatcher("question.jsp").forward(request, response);
            }

        } else if ("answer_q4".equalsIgnoreCase(action)) {
            double userChoice = Double.parseDouble(request.getParameter("q4_answer"));
            double correctAns = (Double) session.getAttribute("q4_correct");
            double mutatedDigit = (Double) session.getAttribute("q4_mutatedDigit");
            String op = (String) session.getAttribute("q4_op");
            double angle = (Double) session.getAttribute("q4_angle");

            boolean isCorrect = Math.abs(userChoice - correctAns) < 0.05;
            int marks = isCorrect ? 3 : 0;

            int totalScore = (Integer) session.getAttribute("totalScore") + marks;
            session.setAttribute("totalScore", totalScore);

            recordHistory(session, "Q4: Trigonometry (Challenge 2)", 
                    mutatedDigit + " × " + op + "(" + angle + "°)", 
                    String.valueOf(userChoice), 
                    String.valueOf(correctAns), 
                    isCorrect, marks, 3);

            // All 4 questions complete! Save to Database via JDBC PreparedStatement
            String playerName = (String) session.getAttribute("playerName");
            GameScore gameScore = new GameScore(playerName, totalScore, "NORMAL");
            ScoreDAO.saveScore(gameScore);

            // Forward to final Result Page
            request.getRequestDispatcher("result.jsp").forward(request, response);

        } else if ("leaderboard".equalsIgnoreCase(action)) {
            showLeaderboard(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    private void showLeaderboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<GameScore> topScores = ScoreDAO.getTopScores();
        request.setAttribute("topScores", topScores);
        request.getRequestDispatcher("leaderboard.jsp").forward(request, response);
    }

    private int getRandomOffset() {
        int offset = (random.nextBoolean() ? 1 : -1) * (random.nextInt(10) + 1);
        return offset;
    }

    private double calculateTrig(String op, double angle) {
        if ("cos".equalsIgnoreCase(op)) {
            return MathService.calculateCos(angle);
        } else if ("tan".equalsIgnoreCase(op)) {
            return MathService.calculateTan(angle);
        } else {
            return MathService.calculateSin(angle);
        }
    }

    private List<Integer> generateModOptions(int correctAns, int divisor) {
        Set<Integer> set = new LinkedHashSet<>();
        set.add(correctAns);
        int attempts = 0;
        while (set.size() < 4 && attempts < 50) {
            attempts++;
            int delta = (random.nextBoolean() ? 1 : -1) * (random.nextInt(Math.max(2, divisor)) + 1);
            int fake = correctAns + delta;
            if (fake >= 0) {
                set.add(fake);
            }
        }
        int filler = 1;
        while (set.size() < 4) {
            set.add(correctAns + (filler++));
        }
        List<Integer> list = new ArrayList<>(set);
        Collections.shuffle(list);
        return list;
    }

    private List<Double> generateTrigOptions(double correctAns) {
        Set<Double> set = new LinkedHashSet<>();
        set.add(correctAns);
        double[] deltas = { -1.5, 1.0, -0.75, 2.0, -2.5, 0.5 };
        for (double d : deltas) {
            if (set.size() >= 4) break;
            double fake = Math.round((correctAns + d) * 100.0) / 100.0;
            set.add(fake);
        }
        List<Double> list = new ArrayList<>(set);
        Collections.shuffle(list);
        return list;
    }

    private void recordHistory(HttpSession session, String title, String problem, 
                              String userAns, String correctAns, boolean isCorrect, int marks, int maxMarks) {
        List<Map<String, Object>> history = (List<Map<String, Object>>) session.getAttribute("history");
        if (history == null) {
            history = new ArrayList<>();
            session.setAttribute("history", history);
        }
        Map<String, Object> item = new HashMap<>();
        item.put("title", title);
        item.put("problem", problem);
        item.put("userAns", userAns);
        item.put("correctAns", correctAns);
        item.put("isCorrect", isCorrect);
        item.put("marks", marks);
        item.put("maxMarks", maxMarks);
        history.add(item);
    }
}
