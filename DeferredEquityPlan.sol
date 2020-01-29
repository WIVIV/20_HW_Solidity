pragma solidity ^0.5.0;
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

// lvl 3: equity plan
contract DeferredEquityPlan {
    using SafeMath for uint;
    address human_resources;
    //uint fakenow = now;
    


    address payable employee; // bob
    bool active = true; // this employee is active at the start of the contract

    // @TODO: Set the total shares and annual distribution
    // Your code here!
    uint total_shares = 1000;
    uint annual_distribution = 250;
    

    uint start_time = now; // permanently store the time this contract was initialized
    ///uint start_time = fakenow; // permanently store the time this contract was initialized

    // @TODO: Set the `unlock_time` to be 365 days from now
    // Your code here!
    uint public unlock_time = start_time.add(365 days);
    //uint public unlock_time = fakenow + 365 days;
    
    uint public distributed_shares; // starts at 0

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, 'You are not authorised!');
        require(active == true, 'Contract is not active.');

        // @TODO: Add "require" statements to enforce that:
        // 1: `unlock_time` is less than or equal to `now`
        // 2: `distributed_shares` is less than the `total_shares`
        // Your code here!
        //require(unlock_time <= fakenow);
        require(unlock_time <= start_time,'Shares have not vested yet');
        require(distributed_shares < total_shares,'All shares have been distributed');

        // @TODO: Add 365 days to the `unlock_time`
        // Your code here!
        unlock_time += 365 days;
        
        // @TODO: Calculate the shares distributed by using the function (now - start_time) / 365 days * the annual distribution
        // Make sure to include the parenthesis around (now - start_time) to get accurate results!
        // Your code here!
        distributed_shares = ((now.sub(start_time)).div(365 days)) * annual_distribution;
        //distributed_shares = ((fakenow - start_time) / 365 days) * annual_distribution;

        // double check in case the employee does not cash out until after 5+ years
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract at-will
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, 'You are not authorised!');
        active = false;
    }

    //function fastforward() public {
    //    fakenow += 100 days;
    //}

    // Since we do not need to handle Ether in this contract, revert any Ether sent to the contract directly
    function() external payable {
        revert('Wrong contract!');
    }
}
