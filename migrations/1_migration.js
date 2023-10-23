const VehicleMessageContract = artifacts.require("VehicleMessageContract");

module.exports = function(deployer) {
    deployer.deploy(VehicleMessageContract);
}