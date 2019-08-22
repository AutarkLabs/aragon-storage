pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";


contract Storage is AragonApp {

    /// Events
    event Registered(bytes32 indexed key);

    /// State: data registry
    mapping(bytes32 => bytes32) internal registeredData;

    /// ACL
    bytes32 constant public REGISTER_DATA_ROLE = keccak256("REGISTER_DATA_ROLE");

    /// Custom aragon constructor
    function initialize() public onlyInit {
        initialized();
    }

    /**
     * @notice Set `_keys` data to `_values`
     * @param _keys Data item that will be stored in the registry
     * @param _values Data content to be stored
     */
    function changeMultipleSettings(bytes32[] _keys, bytes32[] _values) external auth(REGISTER_DATA_ROLE) {
        require(_keys.length == _values.length, "Keys and values length mismatch");
        for (uint8 i = 0; i < _keys.length; i++) {
            registerData(_keys[i], _values[i]);
        }
    }

    function getRegisteredData(bytes32 _key) external view returns(bytes32) {
        return registeredData[_key];
    }

    function registerData(bytes32 _key, bytes32 _value) internal {
        // TODO: check that _key is an app proxy
        // TODO: check that _key is installed in this org
        registeredData[_key] = _value;
        emit Registered(_key);
    }
}
