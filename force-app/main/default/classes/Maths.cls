public with sharing class Maths {
    
    // Method to add two numbers
    public static Decimal add(Decimal num1, Decimal num2) {
        return num1 + num2;
    }

    // Method to subtract one number from another
    public static Decimal subtract(Decimal num1, Decimal num2) {
        return num1 - num2;
    }

    // Method to multiply two numbers
    public static Decimal multiply(Decimal num1, Decimal num2) {
        return num1 * num2;
    }

    // Method to divide one number by another
    public static Decimal divide(Decimal num1, Decimal num2) {
        if (num2 != 0) {
            return num1 / num2;
        } else {
            System.debug('Division by zero is not allowed.');
            return null; // or you can throw an exception
        }
    }
}