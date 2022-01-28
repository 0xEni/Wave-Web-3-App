// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    event NewWave(address indexed from, uint256 timestamp, string message);

    /* Struct is a custom data type where we can customise what we want to hold inside it.*/

    struct Wave {
        address waver; // address of the user who waved.
        string message; //the message the user sent.
        uint256 timestamp; // the timestamp when the user waved.
    }

    // declare variable waves that stores array of structs.

    Wave[] waves;

    constructor() payable {
       console.log("We have been constructed!");
    }

    function wave(string memory _message ) public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        // this is where we store the wave data in the array

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(prizeAmount <= address(this).balance,"Trying to withdraw more money than the contract has.");
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }
    

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

}