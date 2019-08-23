pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";


contract Storage is AragonApp {

    /// Events
    event Registered(bytes32 indexed key);
    event RegisterStorageProvider(string provider, string uri, address providerSetter);

    /// State: data registry
    mapping(bytes32 => string) internal registeredData;

    /// ACL
    bytes32 constant public REGISTER_DATA_ROLE = keccak256("REGISTER_DATA_ROLE");
    bytes32 constant public REGISTER_STORAGE_PROVIDER_ROLE = keccak256("REGISTER_STORAGE_PROVIDER_ROLE");

    string provider;
    string uri;

    /// Custom aragon constructor
    function initialize() public onlyInit {
        initialized();
    }

    /**
     * @notice Set `_key` data to `_value`
     * @param _key Data item that will be stored in the registry
     * @param _value Data content to be stored
     */

    function registerData(bytes32 _key, string _value) external auth(REGISTER_DATA_ROLE) {
        // TODO: check that _key is an app proxy
        // TODO: check that _key is installed in this org
        registeredData[_key] = _value;
        emit Registered(_key);
    }

    function getRegisteredData(bytes32 _key) external view returns(string) {
        return registeredData[_key];
    }

    function registerStorageProvider(string newProvider, string newUri) external auth(REGISTER_STORAGE_PROVIDER_ROLE) {
        provider = newProvider;
        uri = newUri;
        emit RegisterStorageProvider(provider, uri, msg.sender);
    }

    function getStorageProvider() external view returns(string, string) {
        return (
            provider,
            uri
        );
    }
}
