// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AddressSet} from "../src/lib/AddressSet.sol";

contract AddressSet is Test {
    using AddressSet for AddressSet.Set;

    AddressSet.Set public set;

    function setUp() public {
        set = AddressSet.Set();
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
