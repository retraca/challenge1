// Manager is someone, who manages certain consents - this manager is usually a trust entity that can add people to certain owned consents
// please review the following code and make changes to make the code fully working
// 1. We have a function to updateManager - this function works with _managersToConsents and _managers in order to log active managers and to which consents is a certain manager; these variables need to change accordingly to changes pushed to updateManager function
// 2. We have some basic queries to see active managers, to check if a certain address is a manages and which consents does a certain manager manage (by address again)
// 3. We have a function _isManagerAllowedToChangeConsents -- what is its exact goal? is the function written properly? describe, fix, explain the code

pragma solidity ^0.8.0;

// contents of imports are not needed for this task
import "./IManagers.sol";
import "./Ownable.sol";

contract Managers is IManagers, Ownable {

    //variable _managersToConsents serves the purpose of keeping track which consents are managed by a certain manager
    mapping(address => uint32[]) private _managersToConsents;
    
    // variable _managers serves as a list of active managers
    address[] private _managers;

    //TASK 1 - create updateManager function
    // update manager function serves to edit managers rights
    function updateManager(address manager, uint32[] memory consentsIds) external onlyOwner override {


        // 1. logical assumption
        // we are updating manager with consents i.e. [1,2], what is the condition and what will happen to _managers

        if ( && ) {

        }

        // 2. logical assumption
        // what if we are updating manager with empty array of consents he's manager to, what is the condition and what will happen to _managers, when he won't have anymore any consents under management

        else if ( && ) {

        }

        // 3. logical assumption
        // is _managersToConsents going to change? how?
        
        _managersToConsents[ ] = ;

        //
        emit ManagerWithConsentsChanged(manager, consentsIds, _msgSender());
    }

    //TASK 2 - fill in the following 3 functions
        
    function getManagers() external view override returns (address[] memory) {
        // we want to get a list of all active managers
        return ;
    }

    function isManager(address manager) external view override returns (bool) {
        // is he still a manager, does he have some consents he manages?

        return ;
    }

    function getManagerConsents(address manager) external view override returns (uint32[] memory) {
        // which consents he manages?
        
        return ;
    }

    //TASK 3 - is the following function written correctly? (if not, can you fix it?) what does the following function do? (describe step-by-step)

    function _isManagerAllowedToChangeConsents(uint32[] memory consentsIds) internal view returns (bool) {
        uint32 [] memory managerConsents = _managersToConsents[_msgSender()];
        bool result = false;
        if (managerConsents.length > 0 && managerConsents.length >= consentsIds.length) {
            for (uint32 i = 0; i < consentsIds.length; i++) {
                bool found = false;
                for (uint32 mi = 0; mi < managerConsents.length; mi++) {
                    if (consentsIds[i] == managerConsents[mi]) {
                        found = true;
                    }
                }
                if (found == false) {
                    return false;
                }
            }
            result = true;
        }
        return result;
    }
}
