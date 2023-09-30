// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//This is how we can see the tradional storage varaible would look like 
contract StorageBasics{
    //This is how we do it in tradional way and lets see how to do the same in yul
    uint256 x;

    function setX(uint256 value) external {
        x = value;
    }

    function getX() external view returns(uint256){
        return x;
    }

    function getXYUL() external view returns(uint256 ret) {
        assembly{
            //x.slot referes to where we are storing it and not refering to the value which is inside of it
            //If we load it with sload , the sload will make it look inside it and return the value inside of x.slot
            ret := sload(x.slot)
        }
    } 

}
















/*----------------------------------------------------------------NOTE----------------------------------------------------------------------------
Here we are going to see how YUL handles storage variables 

We need to remember we need to use the variables s load and sstore

---------------------------------------------------------------------------------------------------------------------------------------------------*/