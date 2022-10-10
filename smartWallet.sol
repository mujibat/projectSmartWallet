
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract smartWallet {

    //to send and receive ether
    address payable public owner;

    mapping(address => uint) Amount;

    //stores the address of the deployer
    constructor() {
        owner = payable(msg.sender);
    }
    //to receive ether
    receive() external payable{}

     modifier onlyOwner(){
 
        // require is used whether the
        // owner is the person who has
        // deployed the contract or not
        require(owner == msg.sender);
        _;
    }

    event SendEther (
        address indexed user,
        uint256 etherAmount,
        uint256 time
    );

    function sendEther(address payable receiver, uint amount)
       public payable onlyOwner {
           
         // receiver account balance should be > 0
           require( receiver.balance>0);
            
         // amount should not be negative ,
         // otherwise it throw error
           require(amount >0);
            
           Amount[owner] -= amount;
           Amount[receiver] += amount;
         emit SendEther(msg.sender, msg.value, block.timestamp);
      }
       
         // Defining a function to deposit ether    
         function depositEther() public payable{
            
           // Depositing ether in owners
         // account directly
           Amount[owner] += msg.value;
      }

    //external function called to withdraw ether and send from this wallet to the recipient
    //function withdraw(uint _amount) external {

        // tto ransfer ether
       // payable(msg.sender).transfer(_amount);

    //}

    
    //to check the balance
    function getBalance() external view returns (uint) {

        return address(this).balance;

    }
}