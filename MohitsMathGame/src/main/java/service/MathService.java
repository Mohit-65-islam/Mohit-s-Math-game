package service;

public class MathService {

    /**
     * Checks whether a given number is prime.
     * Numbers less than 2 are not prime.
     * @param number input integer
     * @return 1 if prime, 0 otherwise
     */
    public static int isPrime(int number) {
        if (number < 2) {
            return 0;
        }
        for (int i = 2; i <= Math.sqrt(number); i++) {
            if (number % i == 0) {
                return 0;
            }
        }
        return 1;
    }

    /**
     * Calculates the modulus (remainder) of integer division: a % b.
     * Handles division by zero safely.
     * @param a dividend
     * @param b divisor
     * @return remainder of a % b
     * @throws ArithmeticException if b == 0
     */
    public static int calculateMod(int a, int b) {
        if (b == 0) {
            throw new ArithmeticException("Division by zero is not allowed.");
        }
        return a % b;
    }

    /**
     * Calculates sine of an angle given in degrees.
     * @param degree angle in degrees
     * @return sine value
     */
    public static double calculateSin(double degree) {
        double radians = Math.toRadians(degree);
        return Math.sin(radians);
    }

    /**
     * Calculates cosine of an angle given in degrees.
     * @param degree angle in degrees
     * @return cosine value
     */
    public static double calculateCos(double degree) {
        double radians = Math.toRadians(degree);
        return Math.cos(radians);
    }

    /**
     * Calculates tangent of an angle given in degrees.
     * Handles undefined angles (e.g. 90, 270 degrees where cos is 0).
     * @param degree angle in degrees
     * @return tangent value or Double.NaN if undefined
     */
    public static double calculateTan(double degree) {
        double normalized = Math.abs(degree) % 180;
        if (Math.abs(normalized - 90.0) < 1e-6) {
            return Double.NaN; // Undefined tangent
        }
        double radians = Math.toRadians(degree);
        return Math.tan(radians);
    }
}
