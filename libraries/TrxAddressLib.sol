pragma solidity ^0.5.0;

library TrxAddressLib {

    /**
    * @dev returns the address used within the protocol to identify TRX
    * @return the address assigned to TRX
     */
    function trxAddress() internal pure returns(address) {
        return 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    }
}