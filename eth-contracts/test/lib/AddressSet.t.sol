// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AddressSet} from "../../src/lib/AddressSet.sol";

contract AddressSetTest is Test {
    using AddressSet for AddressSet.Set;

    AddressSet.Set tokenSet;

    function setUp() public {}

    function test_shouldBeAbleToInsertItems(address randomAddress) public {
        if (randomAddress != address(0)) {
            tokenSet.insert(randomAddress);
            assert(tokenSet.contains(randomAddress));
        }
    }

    /// forge-config: default.allow_internal_expect_revert = true
    function test_shouldNotBeAbleToInsertZeroAddress() public {
        vm.expectRevert("UnorderedKeySet(100) - Key cannot be 0x0");
        tokenSet.insert(address(0));
    }

    /// forge-config: default.allow_internal_expect_revert = true
    function test_shouldRevertIfInsertingDuplicateItems(address randomAddress) public {
        if (randomAddress != address(0)) {
            vm.expectRevert("UnorderedAddressSet(101) - Address (key) already exists in the set.");
            tokenSet.insert(randomAddress);
            tokenSet.insert(randomAddress);
        }
    }

    function test_shouldBeAbleToRemoveItems(address randomAddress1, address randomAddress2) public {
        if (
            randomAddress1 != randomAddress2 && address(randomAddress1) != address(0)
                && address(randomAddress2) != address(0)
        ) {
            tokenSet.insert(randomAddress1);
            tokenSet.insert(randomAddress2);
            tokenSet.remove(randomAddress1);
            assert(!tokenSet.contains(randomAddress1));
            assert(tokenSet.contains(randomAddress2));
        }
    }

    /// forge-config: default.allow_internal_expect_revert = true
    function test_shouldRevertIfRemovingNonExistentItems(address randomAddress) public {
        if (randomAddress != address(0)) {
            vm.expectRevert("UnorderedKeySet(102) - Address (key) does not exist in the set.");
            tokenSet.remove(randomAddress);
        }
    }

    function test_shouldBeAbleToGetSizeAfterInserting(address randomAddress1, address randomAddress2) public {
        if (randomAddress1 != randomAddress2 && randomAddress1 != address(0) && randomAddress2 != address(0)) {
            tokenSet.insert(randomAddress1);
            tokenSet.insert(randomAddress2);
            assert(tokenSet.size() == 2);
        }
    }

    function test_shouldBeAbleToGetSizeAfterRemoving(
        address randomAddress1,
        address randomAddress2,
        address randomAddress3
    ) public {
        if (
            randomAddress1 != randomAddress2 && randomAddress2 != randomAddress3 && randomAddress1 != randomAddress3
                && randomAddress1 != address(0) && randomAddress2 != address(0) && randomAddress3 != address(0)
        ) {
            tokenSet.insert(randomAddress1);
            tokenSet.insert(randomAddress2);
            tokenSet.insert(randomAddress3);
            tokenSet.remove(randomAddress1);
            assert(tokenSet.size() == 2);
        }
    }

    function test_shouldBeAbleToGetSizeAfterRemovingAllItems(address randomAddress1, address randomAddress2) public {
        if (randomAddress1 != randomAddress2 && randomAddress1 != address(0) && randomAddress2 != address(0)) {
            tokenSet.insert(randomAddress1);
            tokenSet.insert(randomAddress2);
            tokenSet.remove(randomAddress1);
            tokenSet.remove(randomAddress2);
            assert(tokenSet.size() == 0);
        }
    }

    function test_shouldReturnTrueIfAddressExists(address randomAddress) public {
        if (randomAddress != address(0)) {
            tokenSet.insert(randomAddress);
            assert(tokenSet.contains(randomAddress));
        }
    }

    function test_shouldReturnFalseIfAddressDoesNotExist(address randomAddress1, address randomAddress2) public {
        if (randomAddress1 != address(0) && randomAddress1 != randomAddress2) {
            tokenSet.insert(randomAddress1);
            assert(!tokenSet.contains(randomAddress2));
        }
    }

    function test_shouldBeAbleToReferenceByIndex(address randomAddress1, address randomAddress2) public {
        if (randomAddress1 != randomAddress2 && randomAddress1 != address(0) && randomAddress2 != address(0)) {
            tokenSet.insert(randomAddress1);
            tokenSet.insert(randomAddress2);
            assert(tokenSet.keyAtIndex(0) == randomAddress1);
            assert(tokenSet.keyAtIndex(1) == randomAddress2);
        }
    }

    function test_shouldBeAbleToGetValues(address randomAddress1, address randomAddress2) public {
        if (randomAddress1 != randomAddress2 && randomAddress1 != address(0) && randomAddress2 != address(0)) {
            tokenSet.insert(randomAddress1);
            tokenSet.insert(randomAddress2);
            address[] memory values = tokenSet.values();
            assert(values.length == 2);
            assert(values[0] == randomAddress1);
            assert(values[1] == randomAddress2);
        }
    }
}
