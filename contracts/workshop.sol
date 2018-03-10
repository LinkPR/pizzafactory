// Specify solidity compiler version
pragma solidity ^0.4.19;

// Create contract
contract PizzaFactory {
    
    // Define owner
    address public owner;
    
    // Pizza information
    string public pizzaName;
    uint public pizzaPrice = 100;

    // Save Amount Paid
    uint public totalAmountPaid;
    
    // Users who will pay for the pizza
    mapping(address => uint) users;
    
    // Initialize Contract
    function PizzaFactory(string _pizzaName, uint _pizzaPrice) public {
        // Save the contract owner
        owner = msg.sender;

        // Set pizza information
        pizzaName = _pizzaName;
        pizzaPrice = _pizzaPrice;
    }

    // Pay for Pizza
    function payPizza() public payable returns(string)  {
        // Do not allow contract owner to pay for pizza
        require(msg.sender != owner);
        
        // Validate that the payment is more than 0
        require(msg.value > 0);
        
        // Save payment
        totalAmountPaid += msg.value;
        users[msg.sender] = msg.value;
        
        // Return a success message
        return "Payment received, thank you!";
    }
    
    // Make Pizza
    function orderPizza() public returns(string) {
        // Check if totalAmountPaid = pizzaPrice
        if (totalAmountPaid == pizzaPrice) {

            // Pay owner
            owner.transfer(totalAmountPaid);
            totalAmountPaid = 0;

            // Return success message
            return "Pizza is being made! Thank you for your bussiness.";

        } else {

            // Otherwise return fail message
            return "Pizza has not been paid for yet.";

        }
        
    } 
    
    // Challenge Round!

    // Get amount pending 
    function getAmountPending() public view returns(uint) {
        return pizzaPrice - totalAmountPaid;
    }
    
    // Get User Payment Amount
    function getMyPaymentAmount() public view returns(uint) {
        return users[msg.sender];
    }
    
}
