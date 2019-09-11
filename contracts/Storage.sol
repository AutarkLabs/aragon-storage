pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";


contract Storage is AragonApp {

    /// Events
    event Registered(bytes32 indexed key);
    event PinHash(string cid);
    event RegisterStorageProvider(string provider, string uri, uint64 port, address providerSetter);

    /// State: data registry
    mapping(bytes32 => string) internal registeredData;

    /// ACL
    bytes32 constant public REGISTER_DATA_ROLE = keccak256("REGISTER_DATA_ROLE");
    bytes32 constant public REGISTER_STORAGE_PROVIDER_ROLE = keccak256("REGISTER_STORAGE_PROVIDER_ROLE");

    string provider;
    string uri;
    uint64 port;

    /// Custom aragon constructor
    function initialize() public onlyInit {
        provider = "aragon_association";
        uri = "https://api.pinata.cloud";
        port = 5001;
        initialized();
    }

    /**
     * @notice Set `_key` data to `_value`
     * @param _key Data item that will be stored in the registry
     * @param _cid Data content to be stored
     */

    function registerData(bytes32 _key, string _cid) external auth(REGISTER_DATA_ROLE) {
        // TODO: check that _key is an app proxy
        // TODO: check that _key is installed in this org
        registeredData[_key] = _cid;
        emit Registered(_key);
        emit PinHash(_cid);
    }

    function getRegisteredData(bytes32 _key) external view returns(string) {
        return registeredData[_key];
    }

    function registerStorageProvider(string newProvider, string newUri, uint64 newPort) external auth(REGISTER_STORAGE_PROVIDER_ROLE) {
        provider = newProvider;
        uri = newUri;
        port = newPort;
        emit RegisterStorageProvider(provider, uri, newPort, msg.sender);
    }

    function getStorageProvider() external view returns(string, string, uint64) {
        return (
            provider,
            uri,
            port
        );
    }
}
