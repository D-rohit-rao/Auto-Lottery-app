//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0  <=0.9.0;

contract apptry
{
    
    address payable[]  public participants;  //payable keyword is used while
                                             //declaring acc addrs for payment 
    address public manager;

    address payable public winner;

                                             


constructor()             // adding manager to constructor
                          // as he is the one who will controle 
                          // so with constructor we can decalre
                          // about mager at first.
{
    manager =msg.sender;  //globale variable
}

 receive() external payable
{    require(msg.value >= 2 ether ,"Please pay minnimum 2 ether" );
    participants.push(payable(msg.sender));   
}

function getBalance() public view returns(uint)
{   require(msg.sender == manager , "Oo.. it seems you are not authorised");
    return address(this).balance; 
}

function random() internal view returns(uint)
{
 return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
}

function selectWinner() public 
{
     require(msg.sender==manager , "Oo.. it seems you are not authorised");     // this msg can be oly sent by manager
     require(participants.length>=3, "We are waiting for some more participants");  //minimum participarton    
     uint r = random();   //random function value will get stored in r.
     uint index = r % participants.length; //m percent will divid it, which reminder value be our position on index.
    
     winner = participants[index];
     winner.transfer(getBalance()) ;
     participants=new address payable[](0);    //for reset ////////////tp

}

 function All_participants() public view returns(address payable[] memory)
 {
     return  participants;
 }
}