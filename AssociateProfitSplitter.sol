pragma solidity ^0.5.0;
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

// lvl 1: equal split
contract AssociateProfitSplitter {
    using SafeMath for uint;
    address payable employee_one;
    address payable employee_two;
    address payable employee_three;

    // @TODO: Create three payable addresses representing `employee_one`, `employee_two` and `employee_three`.

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        // @TODO: Split `msg.value` into three
        uint amount = msg.value.div(3); // Your code here!
        uint remainder = msg.value.sub(amount.mul(3));
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);
        // @TODO: take care of a potential remainder by sending back to HR (`msg.sender`)
        // Your code here!
        msg.sender.transfer(remainder);
    }

    function() external payable {
        // @TODO: Enforce that the `deposit` function is called in the fallback function!
        // Your code here!

    }
}



