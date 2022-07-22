//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract GameContext is Ownable {
    struct ContextData {
        uint256 waitingForOpponentTimeout;
        uint256 moveTimeout;
        uint8 scoreThreshold;
        uint8 roundThreshold;
        uint256 ownerTipRate;
        uint256 referralTipRate;
        uint256 claimTimeout;
    }

    mapping(uint256 => ContextData) internal _contexts;
    uint256 internal _currentContextIndex;

    constructor(ContextData memory context) {
        _contexts[_currentContextIndex] = context;
    }

    function getCurrentContext() external view returns(ContextData memory) {
        return _contexts[_currentContextIndex];
    }

    function updateContext(ContextData calldata context) external payable onlyOwner {
        _currentContextIndex++;
        _contexts[_currentContextIndex] = context;
        emit ContextUpdate(_currentContextIndex);
    }

    event ContextUpdate(uint256 newIndex);
}
