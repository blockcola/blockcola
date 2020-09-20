pragma solidity ^0.5.0;

import "./Ownable.sol";

interface IJustSwapInterface {
    function getTokenToTrxInputPrice(uint256 tokens_sold) external view returns (uint256);
    function getTrxToTokenInputPrice(uint256 trx_sold) external view returns (uint256);
    function getTrxToTokenOutputPrice(uint256 tokens_bought) external view returns (uint256);
    function getTokenToTrxOutputPrice(uint256 trx_bought) external view returns (uint256);
}

interface IJustFactory {
    function getExchange(address token) external view returns (address payable);
    function getToken(address exchange) external view returns (address);
}

contract PriceOracleTest is Ownable {

    uint256 sunzi = 1000000;
    IJustFactory public factory;

    function setFactory(address _factory) external onlyOwner returns (bool) {
        factory = IJustFactory(_factory);
    }

    /***********
    @dev returns the asset price in TRX
     */
    function getAssetPrice(address _asset) external view returns(uint256) {
        IJustSwapInterface oracle = IJustSwapInterface(factory.getExchange(_asset));
        return oracle.getTokenToTrxInputPrice(sunzi);
    }

    function getTrxToTokenInput(address _asset) external view returns(uint256) {
        IJustSwapInterface oracle = IJustSwapInterface(factory.getExchange(_asset));
        return oracle.getTrxToTokenInputPrice(sunzi);
    }

    function getTrxToTokenOutput(address _asset) external view returns(uint256) {
        IJustSwapInterface oracle = IJustSwapInterface(factory.getExchange(_asset));
        return oracle.getTrxToTokenOutputPrice(sunzi);
    }

    function getTokenToTrxOutput(address _asset) external view returns(uint256) {
        IJustSwapInterface oracle = IJustSwapInterface(factory.getExchange(_asset));
        return oracle.getTokenToTrxOutputPrice(sunzi);
    }

    function getAssetPriceFromExchange(address _oracle) external view returns(uint256) {
        IJustSwapInterface oracle = IJustSwapInterface(_oracle);
        return oracle.getTokenToTrxInputPrice(sunzi);
    }
}