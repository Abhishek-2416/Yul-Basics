// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract IsPrime{

    //We are now creating a function to check if the given number is prime or not in yul
    function isPrime(uint256 x)public pure returns(bool p){
        p = true;
        assembly{
            //Generally to get half we write halfx =x/2 + 1;
            let halfX := add(div(x,2),1)
            //This is how we write a for loop in yul
            for {let i := 2} lt(i,halfX) {i := add(i,1)}{
                //Now instead of writing iszero(mod(x,i)) we can also write eq(mod(x,i),0) but writing the iszero is more conventional way
                if iszero(mod(x,i)){
                    p := 0
                    break
                }
            }
        }
    }

    function testPrime() external pure{
        require(isPrime(2));
        require(isPrime(3));
        require(!isPrime(4));//This is normal solidity so we can use the negatation sign while we cannot use that in yul
        require(!isPrime(15));//YUL has no ! sign or no negatation sound
        require(isPrime(21));
    }
}

contract IfComparison {
    function isTruthy() external pure returns (uint256 result) {
        result = 2;
        assembly {
            if 2 {
                result := 1
            }
        }

        return result; // returns 1
    }

    function isFalsy() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if 0 {
                result := 2
            }
        }

        return result; // returns 1
    }

    function negation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if iszero(0) {
                result := 2
            }
        }

        return result; // returns 2
    }

    function unsafe1NegationPart1() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if not(0) {
                result := 2
            }
        }

        return result; // returns 2
    }

    function bitFlip() external pure returns (bytes32 result) {
        assembly {
            result := not(2)
        }
    }

    function unsafe2NegationPart() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if not(2) {
                result := 2
            }
        }

        return result; // returns 2
    }

    function safeNegation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if iszero(2) {
                result := 2
            }
        }

        return result; // returns 1
    }

    function max(uint256 x, uint256 y) external pure returns (uint256 maximum) {
        assembly {
            if lt(x, y) {
                maximum := y
            }
            if iszero(lt(x, y)) {
                // there are no else statements
                maximum := x
            }
        }
    }

    // The rest:
    /*
    These are all bitwise operations,operations on 32 bit words

        | solidity | YUL       |
        +----------+-----------+
        | a && b   | and(a, b) |
        +----------+-----------+
        | a || b   | or(a, b)  |
        +----------+-----------+
        | a ^ b    | xor(a, b) |
        +----------+-----------+
        | a + b    | add(a, b) |
        +----------+-----------+
        | a - b    | sub(a, b) |
        +----------+-----------+
        | a * b    | mul(a, b) |
        +----------+-----------+
        | a / b    | div(a, b) |
        +----------+-----------+
        | a % b    | mod(a, b) |
        +----------+-----------+
        | a >> b   | shr(b, a) |
        +----------+-----------+
        | a << b   | shl(b, a) |
        +----------------------+

    */
}

/*-----------------------------------------------------------------NOTE--------------------------------------------------------------------------
Unlike other assembly languages yul does have for loops and these for loops are only avaliable on yul\

Yul exactly isny assembly but it is barely one level of abstraction abhove assembly 

In YUL we have if statements but we do not have else statements in yul we need to check condition in a way like this
    function max(uint256 x, uint256 y) external pure returns (uint256 maximum) {
        assembly {
            if lt(x, y) {
                maximum := y
            }
            if iszero(lt(x, y)) {
                // there are no else statements
                maximum := x
            }
        }
    }

We know we get overflow protection in soldity 0.8 and abhove but we obviously do not get that in yul, in YUL we do not get any overflow protection

-------------------------------------------------------------------------------------------------------------------------------------------------*/