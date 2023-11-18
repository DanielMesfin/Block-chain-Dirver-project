// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DirveShare {
    struct Access {
        address user;
        bool access;
    }
    mapping(address => string[]) value;
    mapping(address => mapping(address => bool)) ownerShip;
    mapping(address => Access[]) public  accessList;
    mapping(address => mapping(address => bool)) previsouData;

    function add(address _userAddress, string calldata url) external {
        value[_userAddress].push(url);
    }

    function allow(address userAddress) external {
        ownerShip[msg.sender][userAddress] = true;
        if (previsouData[msg.sender][userAddress] == true) {
            for (uint256 i = 0; i < accessList[msg.sender].length; i++) {
                if (accessList[msg.sender][i].user == userAddress) {
                    accessList[msg.sender][i].access = true;
                }
            }
        } else {
            accessList[msg.sender].push(Access(userAddress, true));
            previsouData[msg.sender][userAddress] = true;
        }
    }

    function disAllow(address userAddress) external {
        ownerShip[msg.sender][userAddress] = false;
            for (uint256 i = 0; i < accessList[msg.sender].length; i++) {
                if (accessList[msg.sender][i].user == userAddress) {
                    accessList[msg.sender][i].access = false;
                }
            
        }
    }
    function display(address _user ) external  view  returns(string[] memory){
        require(_user==msg.sender || ownerShip[_user][msg.sender]==true, "You have not access");
        return  value[_user];
        
    }
    function shareAccess() external view  returns (Access[] memory){
        return accessList[msg.sender];
    }
}
