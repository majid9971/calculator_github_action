package com.cybage.alm;

/**
 * Hello world!
 *
 */
public class App {

    public int sum(int a, int b) {
        return a + b;
    }

    public int minus(int a, int b) {
        return a - b; 
    }

    public int divide(int a, int b) {
        return a / b;
    }

    public int multiply(int a, int b) {
        return a * b;
    }

    // Duplicated method to trigger SonarQube quality gate failure due to code duplication
    public int sumCopy(int x, int y) {
        return x + y;
    }

    public int minusCopy(int x, int y) {
        return x - y; 
    }

    public int divideCopy(int x, int y) {
        return x / y;
    }

    public int multiplyCopy(int x, int y) {
        return x * y;
    }
}
