// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControl{
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);
    // role => account => bool
    mapping(bytes32 => mapping(address => bool)) public roles;
    //0xf23ec0bb4210edd5cba85afd05127efcd2fc6a781bfed49188da1081670b22d8
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("admin"));

    bytes32 private constant USER = keccak256(abi.encodePacked("user"));
    // 0xcb61ad33d3763aed2bc16c0f57ff251ac638d3d03ab7550adfd3e166c2e7adb6

    modifier onlyOwner(bytes32 _role){
        require(roles[_role][msg.sender], "not authorized");
        _;
    }
    constructor(){
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function _revokeRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }

    function grantRole(bytes32 _role, address _account) external onlyOwner(ADMIN){
        _grantRole(_role, _account);
    }

    function revokeRole(bytes32 _role, address _account) external onlyOwner(ADMIN){
        _revokeRole(_role, _account);
    }
}
