public with sharing class BankAccount {
    
    private Decimal Balance = 0;
    private static Decimal TotalBalance = 0;

    // Constructor (optional if specific setup is required)
    public BankAccount() {
        // Initialize if needed
    }

    // Method to deposit an amount
    public void deposit(Decimal amount) {
        if (amount > 0) {
            Balance += amount;
            TotalBalance += amount;
        } else {
            System.debug('Deposit amount must be greater than 0.');
        }
    }

    // Method to withdraw an amount
    public void withdrawal(Decimal amount) {
        if (amount > 0 && amount <= Balance) {
            Balance -= amount;
            TotalBalance -= amount;
        } else if (amount > Balance) {
            System.debug('Insufficient funds for withdrawal.');
        } else {
            System.debug('Withdrawal amount must be greater than 0.');
        }
    }

    // Method to get the current balance
    public Decimal getBalance() {
        return Balance;
    }

    // Optional debug method
    public void debugBalance() {
        System.debug('Current Balance: ' + getBalance());
    }
}