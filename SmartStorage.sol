// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract SimpleStorage{
   
    uint   myFavoriteNumber ; // default value is 0
    uint256 [] listOfFavoriteNumbers;

    struct Person{
        uint256 favoriteNumber;
        string name;
    }
    
    Person [] public favoritePersons;

    mapping (string=> uint256) public nameToFavoriteNumber;

   function store(uint _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
   }

   function retrieve() public  view returns (uint){
       return  myFavoriteNumber;
   }

   function addPerson(string memory _name, uint256  _favoriteNumber) public {
      
      favoritePersons.push( Person(_favoriteNumber,_name));
      nameToFavoriteNumber[_name] =_favoriteNumber;
   }
   
}