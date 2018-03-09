pragma solidity ^0.4.19;

contract PizzaFactory {
    // Define owner
    address public linkPizzaPlace;
    
    // Define Payments
    uint public totalAmountPaid;
    
    function PizzaFactory(string _pizzaName) public {
        linkPizzaPlace = msg.sender;
        pizzaName = _pizzaName;
    }

    // Define Pizza in wei
    string public pizzaName = "Pepperoni";
    uint public pizzaPrice = 100;
    

    // Define Users
    mapping(address => uint) users;
    
    // Define Pay for Pizza
    function payPizza() public payable  {
        // Do not allow contract owner to pay for pizza
        require(msg.sender != linkPizzaPlace);
        
        // Save payment
        totalAmountPaid += msg.value;
        users[msg.sender] = msg.value;
        
    }
    
    // Define Make Pizza
    function orderPizza() public returns(string) {
        // Check if totalAmountPaid = pizzaPrice

        if (totalAmountPaid == pizzaPrice) {
            // Pay owner
            linkPizzaPlace.transfer(totalAmountPaid);
            totalAmountPaid = 0;

            // Return success message
            return "Pizza is being made! Thank you for your bussiness";
        } else {
            // Return fail message
            return "Pizza has not been paid for yet";
        }
    } 
    
    // Define amount pending (challenge)
    
}
