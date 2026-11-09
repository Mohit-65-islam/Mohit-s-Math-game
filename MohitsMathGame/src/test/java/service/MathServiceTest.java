package service;

/**
 * Unit Test Runner for MathService as required by TASK 09
 */
public class MathServiceTest {

    public static void main(String[] args) {
        System.out.println("==========================================");
        System.out.println("Running MathService Automated Test Suite");
        System.out.println("==========================================");

        int passed = 0;
        int failed = 0;

        // Test 1: Prime 7 -> 1
        if (MathService.isPrime(7) == 1) {
            System.out.println("[PASS] Prime check for 7: Expected 1, Got 1");
            passed++;
        } else {
            System.err.println("[FAIL] Prime check for 7");
            failed++;
        }

        // Test 2: Prime 8 -> 0
        if (MathService.isPrime(8) == 0) {
            System.out.println("[PASS] Prime check for 8: Expected 0, Got 0");
            passed++;
        } else {
            System.err.println("[FAIL] Prime check for 8");
            failed++;
        }

        // Test 3: Prime 1 -> 0
        if (MathService.isPrime(1) == 0) {
            System.out.println("[PASS] Prime check for 1: Expected 0, Got 0");
            passed++;
        } else {
            System.err.println("[FAIL] Prime check for 1");
            failed++;
        }

        // Test 4: Modulus 17 % 5 -> 2
        if (MathService.calculateMod(17, 5) == 2) {
            System.out.println("[PASS] Modulus 17 % 5: Expected 2, Got 2");
            passed++;
        } else {
            System.err.println("[FAIL] Modulus 17 % 5");
            failed++;
        }

        // Test 5: Sine 30° -> 0.5
        if (Math.abs(MathService.calculateSin(30) - 0.5) < 1e-4) {
            System.out.println("[PASS] Sine 30 degrees: Expected 0.5, Got " + MathService.calculateSin(30));
            passed++;
        } else {
            System.err.println("[FAIL] Sine 30 degrees");
            failed++;
        }

        // Test 6: Cosine 60° -> 0.5
        if (Math.abs(MathService.calculateCos(60) - 0.5) < 1e-4) {
            System.out.println("[PASS] Cosine 60 degrees: Expected 0.5, Got " + MathService.calculateCos(60));
            passed++;
        } else {
            System.err.println("[FAIL] Cosine 60 degrees");
            failed++;
        }

        // Test 7: Tangent 45° -> 1.0
        if (Math.abs(MathService.calculateTan(45) - 1.0) < 1e-4) {
            System.out.println("[PASS] Tangent 45 degrees: Expected 1.0, Got " + MathService.calculateTan(45));
            passed++;
        } else {
            System.err.println("[FAIL] Tangent 45 degrees");
            failed++;
        }

        // Test 8: Divisor 0 Exception handling
        try {
            MathService.calculateMod(10, 0);
            System.err.println("[FAIL] Divisor 0 did not throw exception");
            failed++;
        } catch (ArithmeticException e) {
            System.out.println("[PASS] Divisor 0 threw ArithmeticException as expected: " + e.getMessage());
            passed++;
        }

        System.out.println("==========================================");
        System.out.println("Summary: " + passed + " Passed, " + failed + " Failed");
        System.out.println("==========================================");
    }
}
