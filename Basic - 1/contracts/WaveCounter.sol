// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WaveCounter {
    uint256 totalWaves;

    function wave() public {
        totalWaves++;
    }

    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}
