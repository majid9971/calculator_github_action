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

    // Introduced larger duplicated code blocks

    // Duplicated sum method
    public int sumCopy1(int x, int y) {
        int result = x + y;
        return result;
    }

    public int sumCopy2(int x, int y) {
        int result = x + y;
        return result;
    }

    public int sumCopy3(int x, int y) {
        int result = x + y;
        return result;
    }

    // Duplicated minus method
    public int minusCopy1(int x, int y) {
        int result = x - y; 
        return result;
    }

    public int minusCopy2(int x, int y) {
        int result = x - y; 
        return result;
    }

    public int minusCopy3(int x, int y) {
        int result = x - y; 
        return result;
    }

    // Duplicated divide method
    public int divideCopy1(int x, int y) {
        int result = x / y;
        return result;
    }

    public int divideCopy2(int x, int y) {
        int result = x / y;
        return result;
    }

    public int divideCopy3(int x, int y) {
        int result = x / y;
        return result;
    }

    // Duplicated multiply method
    public int multiplyCopy1(int x, int y) {
        int result = x * y;
        return result;
    }

    public int multiplyCopy2(int x, int y) {
        int result = x * y;
        return result;
    }

    public int multiplyCopy3(int x, int y) {
        int result = x * y;
        return result;
    }
}
