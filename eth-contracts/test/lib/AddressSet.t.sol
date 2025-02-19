// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AddressSet} from "../../src/lib/AddressSet.sol";

contract AddressSetTest is Test {
    using AddressSet for AddressSet.Set;

    AddressSet.Set tokenSet;

    function setUp() public {
    }

    function test_insert(address randomAddress) public {
        tokenSet.insert(randomAddress);
        assert(tokenSet.contains(randomAddress));
    }

    function test_remove(address randomAddress1, address randomAddress2) public {
        tokenSet.insert(randomAddress1);
        tokenSet.insert(randomAddress2);
        tokenSet.remove(randomAddress1);
        assert(!tokenSet.contains(randomAddress1));
        assert(tokenSet.contains(randomAddress2));
    }

//    function test_Increment() public {
//        counter.increment();
//        assertEq(counter.number(), 1);
//    }
//
//    function testFuzz_SetNumber(uint256 x) public {
//        counter.setNumber(x);
//        assertEq(counter.number(), x);
//    }
}
