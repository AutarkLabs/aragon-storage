pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";


contract HomePage is AragonApp {

    /// Events
    event WidgetAdded();
    event WidgetRemoved();
    event WidgetsReordered();
    event WidgetUpdated(uint8 indexed index, string indexed cId);

    /// Struct
    struct Widget {
        string cId;
        bool deleted;
    }

    /// State
    mapping(bytes32 => Widget) internal widgets;

    /// ACL
    /* Hardcoded constants to save gas
    bytes32 constant public ADD_ROLE = keccak256("ADD_ROLE");
    bytes32 constant public REMOVE_ROLE = keccak256("REMOVE_ROLE");
    bytes32 constant public REORDER_ROLE = keccak256("REORDER_ROLE");
    bytes32 constant public UPDATE_ROLE = keccak256("UPDATE_ROLE");
    */
    bytes32 constant public ADD_ROLE = 0x9fdb66370b2703c58b55fbb88662023f986df503f838f6ca75ff9f9bdabd694a;
    bytes32 constant public REMOVE_ROLE = 0x0a55cd9c498e2688378e5cd183217e75c0fa1cdbaa909387f565177cd47670f5;
    bytes32 constant public REORDER_ROLE = 0x0210352125167815ae2d54bb8e405f542b6cd4763cd039d14f046edad97dc03d;
    bytes32 constant public UPDATE_ROLE = 0x3ee192ac25847473237ced4bba57f848e1fd794930ff85b42823290580967205;

    /**
     * @notice Custom constructor to initialize aragon app
     */
    function initialize() external onlyInit {
        initialized();
    }

    /**
     * @notice Update widget `_index` to ipfs://`_cId`
     * @param _index Index of the widget
     * @param _addr IPFS hash of the widget's data
     */
    function updateWidget(uint8 _index, string _cId) external auth(UPDATE_ROLE) {
        Widget storage widget = widgets[_index];
        widget.cId = _cId;
        widget.deleted = false;
        emit WidgetUpdated(_index, _cId);
    }

    /**
     * @notice Get a widget's information
     * @param  _index index of the widget
     * @return cId the ipfs hash pointing to the content
     * @return deleted in case the widget was removed
     */
    function getWidget(uint8 _index) external view returns(string cId, bool deleted) {
        Widget memory widget = widgets[_index];
        cId = widget.cId;
        deleted = widget.deleted;
    }
}
