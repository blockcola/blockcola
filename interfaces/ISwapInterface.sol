pragma solidity ^0.5.0;

import "../Ownable.sol";

interface ISwapProxyInterface {
    function tokenToTrxSwapInput(uint256 tokens_sold, uint256 min_trx, uint256 deadline) external returns (uint256);
    function trxToTokenTransferInput(uint256 min_tokens, uint256 deadline, address recipient) external payable returns(uint256);
}

interface IJustFactoryInterface {
    function getExchange(address token) external view returns (address payable);
}

contract ISwapInterface is Ownable {
    IJustFactoryInterface public factory;

    function setFactory(address _factory) external onlyOwner returns (bool) {
        factory = IJustFactoryInterface(_factory);
    }

    /***********
    @dev returns the DBT
     */
    function tradeWithHint(address _asset, uint _amount, address _tokenToBurn, address _destAddress) external payable returns(uint256) {
        ISwapProxyInterface assetFactory = ISwapProxyInterface(factory.getExchange(_asset));
        uint256 trxcount = assetFactory.tokenToTrxSwapInput(_amount, 1, 10);
        ISwapProxyInterface tokenToBurnFactory = ISwapProxyInterface(factory.getExchange(_tokenToBurn));
        return tokenToBurnFactory.trxToTokenTransferInput.value(trxcount)(1, 10, _destAddress);
    }
}