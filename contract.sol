pragma solidity ^0.4.21;

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
        require(loans[msg.sender].amount == 0, "You already have an active loan.");
        loans[msg.sender].borrower = msg.sender;
        loans[msg.sender].amount = _amount;
        loans[msg.sender].interestRate = _interestRate;
        loans[msg.sender].repaymentPeriod = _repaymentPeriod;
    }

    function repayLoan(uint _amount) public {
        Loan memory loan = loans[msg.sender];
        require(loan.amount > 0, "You do not have an active loan.");
        require(loan.amount >= _amount, "The amount you are trying to repay is higher than your outstanding loan.");
        loan.amount -= _amount;
    }

    function getLoan(address _borrower) public view returns (uint, uint, uint) {
        Loan memory loan = loans[_borrower];
        return (loan.amount, loan.interestRate, loan.repaymentPeriod);
    }
}