// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract YulTypes{
    //This is how we normally return a uint in solidity ,this function has an execution cost of 337 gas uints
    function getNumber() external pure returns(uint){
        return 42;
    }

    //This is how we do it in yul or inline assembly , this function has an execution cost of 328 gas uints
    function getNumbers() external pure returns(uint){
        uint x;

        assembly{
            x := 42
        }

        return x;
    }

    //Now let us do the same function to return a hexadecimal
    function getHex() external pure returns(uint){
        uint x;

        assembly{
            x := 0xa
        }

        return x;
    }

    //Now if we do the similar way and use it to return string that might be an error
    //Now this function will get compiled but will give an error as it wont be executed as it will run out of Gas
    function getString() external pure returns(string memory){
        string memory myString = "";

        assembly{
            myString := "Hello World"
        }

        return myString;
    }

    //Now lets see how to do this properly, As we know each type is of bytes32
    //We also need to keep in mind it wont take longer strings which is more than 32 bytes 
    function getString2() external pure returns(string memory){
        bytes32 myString = "";

        assembly{
            myString := "Hello World"
        }

        //return myString; if we just return the myString we will get the output in bytes which will be something like 0x32-34834282q340823037427243
        return string(abi.encode(myString)); // This will return it normally Hello World
    }

    function representation() external pure returns(bool){
        bool x;

        assembly{
            x := 0 //0 is for false and 1 is for true
        }

        return x;
    }


}

/*----------------------------------------------------------NOTES-----------------------------------------------------------------------------------
   Yul has only one type and that is 32bit or 256bits type

    execution cost is 465 gas  for address
    execution cost is 422 gas for uint8
    execution cost is 416 for uint256
    execution cost is 422 gas for bool

--> Yul has only 1 type it is the 32byte or 256bit word that we are used to seeing
    therefore, a int will be converted to a byte(hex)

--> using inline assembly will help us save gas

--> A string is not bytes32 by default

--> Yul just makes a interpretation when u use a string,int,address etc since it is of bytes32 

--> Incase of integer i can give the input in the assembly code in the form of uint or a hex but the output will 
    depend on the return type eg like return type is int therefore the input type of hex is converted to int and
    then returned 
----------------------------------------------------------------------------------------------------------------------------------------------------*/