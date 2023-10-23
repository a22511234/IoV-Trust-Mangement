// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VehicleMessageContract {
    struct Vehicle {
        uint256 id;
        uint256 score; // 使用固定點表示分數，例如乘以 10，以處理小數部分
    }

    struct Message {
        uint256 id;
        uint256 vehicleId;
        string alertType;
        uint256 numAck;
        uint256 numNack;
    }

    mapping(uint256 => Vehicle) public vehicles;
    mapping(uint256 => Message) public messages;

    uint256 public vehicleCount;
    uint256 public messageCount;

    event VehicleAdded(uint256 indexed vehicleId, uint256 score);
    event MessageAdded(uint256 indexed messageId, uint256 vehicleId, string alertType);

    function addVehicle(uint256 _id, uint256 _score) public {
        vehicles[_id] = Vehicle(_id, _score);
        vehicleCount++;
        emit VehicleAdded(_id, _score);
    }

    function updateVehicleScore(uint256 _id, uint256 _newScore) public {
        require(_newScore >= 0, "Score must be non-negative.");
        require(vehicles[_id].id == _id, "Vehicle does not exist.");
        vehicles[_id].score = _newScore;
        emit VehicleAdded(_id, _newScore);
    }

    function addMessage(uint256 _id, uint256 _vehicleId, string memory _alertType) public {
        require(vehicles[_vehicleId].id == _vehicleId, "Vehicle does not exist.");
        messages[_id] = Message(_id, _vehicleId, _alertType, 0, 0);
        messageCount++;
        emit MessageAdded(_id, _vehicleId, _alertType);
    }
    function getVehicleScore(uint256 _vehicleId) public view returns (uint256) {
        require(vehicles[_vehicleId].id == _vehicleId, "Vehicle does not exist.");
        return vehicles[_vehicleId].score;
    }
}