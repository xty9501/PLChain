pragma solidity ^0.8.7;
contract P2PLending {
    struct Loan {
        address borrower;
        uint amount;
        uint interestRate;
        uint repaymentPeriod;
    }

    address public lender;
    mapping(address => Loan) public loans;

    constructor(address _lender) public {
        lender = _lender;
    }

    function applyForLoan(uint _amount, uint _interestRate, uint _repaymentPeriod) public {
        // Check if the borrower already has an active loan
        require(loans[msg.sender].amount == 0, "You already have an active loan.");

        // Create a new loan for the borrower
        loans[msg.sender].borrower = msg.sender;
        loans[msg.sender].amount = _amount;
        loans[msg.sender].interestRate = _interestRate;
        loans[msg.sender].repaymentPeriod = _repaymentPeriod;
    }

    function repayLoan(uint _amount) public {
        // Get the loan information
        Loan memory loan = loans[msg.sender];

        // Check if the borrower has an active loan
        require(loan.amount > 0, "You do not have an active loan.");

        // Check if the amount being repaid is less than or equal to the outstanding loan amount
        require(loan.amount >= _amount, "The amount you are trying to repay is higher than your outstanding loan.");

        // Repay the loan
        loan.amount -= _amount;
    }

    function getLoan(address _borrower) public view returns (uint, uint, uint) {
        // Get the loan information
        Loan memory loan = loans[_borrower];

        // Return the loan details
        return (loan.amount, loan.interestRate, loan.repaymentPeriod);
    }
}

}