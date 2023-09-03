// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract MessageFacet {
    bytes32 internal constant NAMESPACE = keccak256("message.facet");
    
    struct Storage {
        string message;
    }
    
    // Event for logging message changes
    event MessageSet(string newMessage);

    function getStorage() internal pure returns(Storage storage s) {
        bytes32 position = NAMESPACE;
        assembly {
            s.slot := position
        }
    }

    function setMessage(string calldata _msg) external {
        Storage storage s = getStorage();
        s.message = _msg;
        
        emit MessageSet(_msg); // Emitting event when message is set
    }

    function getMessage() external view returns (string memory) {
        return getStorage().message;
    }
}