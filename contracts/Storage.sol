pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";


contract Storage is AragonApp {

    /// Events
    event Registered(address homeApp);

    /// State
    address public homeApp;

    /// ACL
    bytes32 constant public REGISTER_DATA_ROLE = keccak256("REGISTER_DATA_ROLE");

    function initialize() public onlyInit {
        initialized();
    }

    /**
     * @notice Set home app to `app`
     * @param app App that will be set as home app
     */
    function setApp(address _app) external auth(REGISTER_DATA_ROLE) {
        // TODO: check that _app is an app proxy
        // TODO: check that _app is installed in this org
        homeApp = app;
        emit Register(_app);
    }
}
