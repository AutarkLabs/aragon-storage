pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";


contract Storage is AragonApp {

    /// Events
    event Registered(bytes32 indexed key);

    struct DataEntry {
        bytes32 value
    }

    /// State: data registry
    mapping(bytes32 => DataEntry) internal registeredData;

    /// ACL
    bytes32 constant public REGISTER_DATA_ROLE = keccak256("REGISTER_DATA_ROLE");

    /// Custom aragon constructor
    function initialize() public onlyInit {
        initialized();
    }

    /**
     * @notice Set `_key` data tohome app to `app`
     * @param app App that will be set as home app
     */
    function registerData(bytes32 _key, bytes32 _value) external auth(REGISTER_DATA_ROLE) {
        // TODO: check that _app is an app proxy
        // TODO: check that _app is installed in this org
        bytes32 storage dataEntry = registeredData[_key];
        dataEntry.value = _value
        emit Registered(_app);
    }

    function getRegisteredData(bytes32 _key) external view returns(bytes32) {
        return registeredData[_key];
    }
}
