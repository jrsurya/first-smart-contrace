// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{

    SimpleStorage[] public listOfSimpleStorage;

    function createSimpleStorageContract() public {
        listOfSimpleStorage.push( new SimpleStorage());
    }

    function sfStored(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        //  Address
        // ABI (application Binary Interface)
        SimpleStorage mySimpleStorage =  listOfSimpleStorage[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);

    }

    function sfGet(uint256 _simpStorageIndex) public  view returns(uint) {
        SimpleStorage mySimpleStorage = listOfSimpleStorage[_simpStorageIndex];
        return mySimpleStorage.retrieve();
    }


}