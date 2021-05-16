// SPDX-License-Identifier: LearnSolidity
pragma solidity >=0.4.22 <0.9.0;

contract HotelRoom {
   //Enums restrict a variable to have one of only a few predefined values.
  enum RoomStatus { Vacent, Occupied } 
  RoomStatus currentStatus;
  address payable public owner;

  constructor() public{
    owner = msg.sender;
    currentStatus = RoomStatus.Vacent;
  }
  
  event Occupy(address _occupant, uint _value);

  modifier onlyWhileVacant {
    require(currentStatus == RoomStatus.Vacent, "Pardon, the room you are looking for is Currently occupied.");
    _;
  }
  modifier costs(uint _amount){
     require(msg.value >= _amount, "Not enough Ether provided.");
     _;
  }

  //function book() payable onlyWhileVacant costs(2 ether)
    receive() payable public onlyWhileVacant costs(2 ether){
    //check price
    require(msg.value >= 2 ether, "Not enough Ether provided");
    //check status
    require(currentStatus == RoomStatus.Vacent, "Pardon, the room you are looking for is Currently occupied.");
     currentStatus = RoomStatus.Occupied;
      owner.transfer(msg.value);
      emit Occupy(msg.sender, msg.value);
  }
}
