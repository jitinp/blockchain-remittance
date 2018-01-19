pragma solidity ^0.4.0;

// main contract to send Remittance across users
contract remitter {
    address sender;
    address recipient;
    
    // send money to beneficiary
    function send(address _recipient, uint _amount) {
        sender = msg.sender;
        recipient = _recipient;
        
        BankInstance senderBank = new BankInstance(sender);
        BankInstance recipientBank = new BankInstance(recipient);
    }
}

// bank contract for sender and recipient
contract BankInstance {
    uint _balance;
    address user;
    
    function BankInstance(address _address) {
        user = _address;
    }
    
    // get KYC of customer
    function getKYC() constant returns(bool) {
        kyc kycInstance = new kyc(user);
        return kycInstance.retrieveKYC();
    }
    
    // get Balance of customer
    function getBalance() constant returns(uint) {
        return _balance;
    }
    
    // send money
    function sendMoney(uint _amount) {
        _balance -= _amount;
    }
    
    // recieve money
    function recieveMoney(uint _amount) {
        _balance += _amount;
    }
}

// maybe another contract for KYC???
contract kyc {
    
    address kycUser;
    
    function kyc(address _user) {
        kycUser = _user;
    }
    
    modifier isUser() {
        if(msg.sender != kycUser)
            throw;
        _;
    }
    
    function retrieveKYC() constant isUser returns(bool) {
        return true;
    }
}