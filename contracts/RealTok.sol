// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

// Interface to check token balance
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract RealTok is Ownable {
    // Struct to store plot metadata
    struct Plot { 
        uint256 plotId;
        string size;
        string location;
        bool electricityAvailable;
        string ownerName;
        string cnic;
        uint256 societyId;
        address owner;
    }

    // Mapping of plotId to plot details
    mapping(uint256 => Plot) private plotDetails;

    // Mapping of societyId to plotId array
    mapping(uint256 => uint256[]) private societyPlots;

    // ERC20 token contract for verification
    address public tokenContractAddress;

    // Auto-incrementing plot ID
    uint256 private plotIdCounter;

    // Event emitted on new plot creation
    event PlotCreated(
        address indexed societyOwner,
        uint256 plotId,
        uint256 societyId,
        string size,
        string location,
        bool electricityAvailable,
        string ownerName,
        string cnic,
        uint256 timestamp
    );

    // Event emitted when token contract address is updated
    event TokenContractAddressUpdated(address indexed owner, address newTokenContractAddress, uint256 timestamp);

    // Event emitted on plot ownership transfer
    event PlotOwnershipTransferred(uint256 indexed plotId, address indexed previousOwner, address indexed newOwner, string newOwnerName, string newCnic, uint256 timestamp);

    // Constructor to initialize token contract
    constructor(address _tokenContractAddress) Ownable(msg.sender) {
        tokenContractAddress = _tokenContractAddress;
        plotIdCounter = 1;
    }

    // Adds a new plot (onlyOwner)
    function addPlot(
        string memory size,
        string memory location,
        bool electricityAvailable,
        string memory ownerName,
        string memory cnic,
        uint256 societyId,
        address _plotowner
    ) public onlyOwner {
        uint256 plotId = plotIdCounter;
        Plot memory newPlot = Plot({
            plotId: plotId,
            size: size,
            location: location,
            electricityAvailable: electricityAvailable,
            ownerName: ownerName,
            cnic: cnic,
            societyId: societyId,
            owner: _plotowner
        });

        plotDetails[plotId] = newPlot;
        societyPlots[societyId].push(plotId);
        plotIdCounter++;

        emit PlotCreated(msg.sender, plotId, societyId, size, location, electricityAvailable, ownerName, cnic, block.timestamp);
    }

    // Transfers plot ownership (by owner or admin)
    function transferPlotOwnership(uint256 plotId, address newOwner, string memory newOwnerName, string memory newCnic) public {
        Plot storage plot = plotDetails[plotId];
        require(msg.sender == plot.owner || msg.sender == owner(), "Only the plot owner or contract owner can transfer ownership.");
        require(newOwner != address(0), "New owner cannot be zero address.");

        address previousOwner = plot.owner;
        plot.owner = newOwner;
        plot.ownerName = newOwnerName;
        plot.cnic = newCnic;

        emit PlotOwnershipTransferred(plotId, previousOwner, newOwner, newOwnerName, newCnic, block.timestamp);
    }

    // Returns plot details (only for verified token holders)
    function getPlotByIdVerified(uint256 plotId) public view returns (Plot memory) {
        require(isTokenHolder(msg.sender), "You must be a token holder to access plot details.");
        return plotDetails[plotId];
    }

    // Returns plot details (onlyOwner)
    function getPlotById(uint256 plotId) public view onlyOwner returns (Plot memory) {
        return plotDetails[plotId];
    }

    // Returns all plots (onlyOwner)
    function getAllPlots() public view onlyOwner returns (Plot[] memory) {
        uint256 totalPlots = plotIdCounter - 1;
        Plot[] memory allPlots = new Plot[](totalPlots);
        uint256 index = 0;

        for (uint256 plotId = 1; plotId < plotIdCounter; plotId++) {
            allPlots[index] = plotDetails[plotId];
            index++;
        }

        return allPlots;
    }

    // Returns plots by society ID (onlyOwner)
    function getPlotsBySocietyId(uint256 societyId) public view onlyOwner returns (Plot[] memory) {
        uint256[] storage plotIds = societyPlots[societyId];
        Plot[] memory plots = new Plot[](plotIds.length);
        for (uint256 i = 0; i < plotIds.length; i++) {
            plots[i] = plotDetails[plotIds[i]];
        }
        return plots;
    }

    // Updates the token contract address (onlyOwner)
    function updateTokenContractAddress(address newTokenContractAddress) public onlyOwner {
        tokenContractAddress = newTokenContractAddress;
        emit TokenContractAddressUpdated(msg.sender, newTokenContractAddress, block.timestamp);
    }

    // Checks if a user holds any tokens
    function isTokenHolder(address user) public view returns (bool) {
        IERC20 token = IERC20(tokenContractAddress);
        return token.balanceOf(user) > 0;
    }
}
