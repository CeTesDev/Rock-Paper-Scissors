// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract RockPaperScissors {

    address private owner;

    uint private randNonce = 0;

    event playResult(int8 result, uint fundBalance);
    error maxBetBalance(uint maxBalance);

    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    function isOwner() public view returns(bool) {
        return msg.sender == owner;
    }

    constructor() payable {
        owner = msg.sender;
    }

    receive() external payable {}

    ///This function compares rps of sender and rps number of owner
    ///Here, first param is 0 or 1 or 2 (that is, RPS) and second param is any number that it's modula 3 will be 0,1,2(RPS)
    function compareRPS(uint _rps, uint _rpsNum) internal pure returns(int8) {
        if(_rps == _rpsNum % 3)
            return 0;
        else if((2 + _rpsNum - _rps) % 3 == 0)
            return 1;
        return -1;
    }

    function randomNumber() internal returns(uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce)));
    }

    function play(uint rps_num) public payable {
        if(address(this).balance < msg.value * 2)
            revert maxBetBalance(address(this).balance / 2);
        
        uint _targetRPSNum = randomNumber();
        int8 _result = compareRPS(rps_num, _targetRPSNum);
        
        if(_result == 0){
            emit playResult(_result, msg.value);
            payable(msg.sender).transfer(msg.value);
        } else if(_result == 1){
            emit playResult(_result, msg.value * 2);
            payable(msg.sender).transfer(msg.value * 2);
        }else {
            emit playResult(_result, 0);
        }
    }

    function withdraw(uint amount) external onlyOwner {
        require(address(this).balance > amount, "Balance is not enough");
        payable(msg.sender).transfer(amount);
    }
}