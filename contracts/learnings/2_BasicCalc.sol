// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract BasicCalc {
    uint myNumber = 100;

    function setNumber(uint newNumber) public {
        myNumber = newNumber;
    }

    function getNumber() public view returns (uint) {
        return myNumber;
    }

    function addNumber(uint number) public {
        myNumber += number;
    }

    function substract(uint number) public {
        myNumber -= number;
    }

    function multiply(uint number) public {
        myNumber *= number;
    }
}
