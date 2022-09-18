// Manager is someone who manages certain consents - this manager is usually a trust entity that can add people to certain owned consents
// please review the following code and make changes to make the code fully working
// 1. We have a function to updateManager - this function works with _managersToConsents and _managers in order to log active managers and to which consents is a certain manager; these variables need to change accordingly to changes pushed to updateManager function
// 2. We have some basic queries to see active managers, to check if a certain address is a manages and which consents does a certain manager manage (by address again)
// 3. We have a function _isManagerAllowedToChangeConsents -- what is its exact goal? is the function written properly? describe, fix, explain the code

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// contents of imports are not needed for this task
//import "./IManagers.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

//IManagers,
contract Managers is  Ownable {

    //variable _managersToConsents serves the purpose of keeping track which consents are managed by a certain manager
    mapping(address => uint256[]) private _managersToConsents;
    
    // variable _managers serves as a list of active managers
    address[] private _managers;

    //TASK 1 - create updateManager function
    // update manager function serves to edit managers rights
    function updateManager(address manager, uint256[] memory consentsIds) external onlyOwner override {

        // 1. logical assumption
        // we are updating manager with consents i.e. [1,2], what is the condition and what will happen to _managers
        uint index;
        uint length = _managers.length;
        bool isManager;

        for (uint i; i < length;) {
            if (_managers[i] == manager){
                index = i;
                isManager = true;
            }
            unchecked {++i;}
        }

        if (isManager) {
            if (consentsIds.length > 0) _managersToConsents[manager] = consentsIds;

            // 2. logical assumption
            // what if we are updating manager with empty array of consents he's manager to, what is the condition and what will happen to _managers, when he won't have anymore any consents under management
            else {
                delete _managers[index];
                delete _managersToConsents[manager];
            }
        }
        else {
            if (consentsIds.length > 0) {
                _managers.push(manager);
                _managersToConsents[manager] = consentsIds;
            }
        }

        // 3. logical assumption
        // is _managersToConsents going to change? how?
        //@dev It already changed in all the previous conditions, differently depending on the length of consentsId

        //emit ManagerWithConsentsChanged(manager, consentsIds, _msgSender());
    }

    //TASK 2 - fill in the following 3 functions
        
    function getManagers() external view override returns (address[] memory managers) {
        managers = _managers;
    }

    function isManager(address manager) external view override returns (bool) {
        uint length = _managers.length;
        for (uint i; i < length;) {
            if (_managers[i] == manager) return true;
        }

        return false;
    }

    function getManagerConsents(address manager) external view override returns (uint256[] memory consents) {
        consents = _managersToConsents[manager];
    }

    //TASK 3 - is the following function written correctly? (if not, can you fix it?) what does the following function do? (describe step-by-step)

    //@dev It is not written correctly
    //I can fix it
    // (description here)
    function _isManagerAllowedToChangeConsents(uint256[] memory consentsIds) internal view returns (bool) {
        //@dev Do we really want to check msg.sender? It could be the intended flow, but if this function is internal maybe we 
        //want to receive the address as an argument
        uint256[] memory managerConsents = _managersToConsents[_msgSender()];
        
        if (managerConsents.length > 0 && managerConsents.length > consentsIds.length - 1) {
            for (uint i; i < consentsIds.length;) {
                bool found;

                for (uint mi; mi < managerConsents.length;) {
                    if (consentsIds[i] == managerConsents[mi]) {
                        found = true;
                    }

                    unchecked {++i;}
                }

                if (!found) {
                    return false;
                }

                unchecked {++i;}
            }
            return true;
        }

        return false;
    }
}