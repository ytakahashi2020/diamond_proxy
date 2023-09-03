// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract CalculateFacet {
    bytes32 internal constant NAMESPACE = keccak256("calculate.facet");

    struct Storage {
        uint256 number;
    }

    event NumberSet(uint256 oldValue, uint256 newValue);
    event NumberAdded(uint256 addedValue, uint256 newValue);

    function getStorage() internal pure returns(Storage storage s) {
        bytes32 position = NAMESPACE;
        assembly {
            s.slot := position
        }
    }

    function setNumber(uint256 _number) external {
        Storage storage s = getStorage();
        uint256 oldNumber = s.number;
        s.number = _number;
        emit NumberSet(oldNumber, _number);
    }

    function incrementNumber(uint256 _number) external {
        Storage storage s = getStorage();
        s.number += _number;
        emit NumberAdded(_number, s.number);
    }

    function getNumber() external view returns (uint256) {
        return getStorage().number;
    }
}