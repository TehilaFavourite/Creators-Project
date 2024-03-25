// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./CreatorsToken.sol";

contract NFTSales {
    mapping(address => Sale) public nftSales;

    struct Sale {
        address nftAddress;
        uint256 pricePerToken;
        uint256 tokensForSale;
        uint256 amountSold;
    }

    event CreateSaleEvent(
        address indexed creator,
        address indexed nftAddress,
        uint256 indexed pricePerToken,
        uint256 tokensForSale
    );
    event BuyNFTEvent(
        address indexed buyer,
        address indexed nftAddress,
        uint256 indexed buyAmount,
        uint256 totalPrice
    );

    constructor() {}

    function createSale(
        address _nftAddress,
        uint256 _pricePerToken,
        uint256 _tokensForSale
    ) external {
        require(
            nftSales[_nftAddress].nftAddress == address(0),
            "NFT sale already exists"
        );
        nftSales[_nftAddress] = Sale({
            nftAddress: _nftAddress,
            pricePerToken: _pricePerToken,
            tokensForSale: _tokensForSale,
            amountSold: 0
        });
        emit CreateSaleEvent(
            msg.sender,
            _nftAddress,
            _pricePerToken,
            _tokensForSale
        );
    }

    function buyNFT(address _nftAddress, uint256 _buyAmount) external payable {
        Sale storage sale = nftSales[_nftAddress];
        require(sale.nftAddress != address(0), "NFT sale does not exist");
        require(_buyAmount <= sale.tokensForSale, "Not enough tokens for sale");
        uint256 totalPrice = sale.pricePerToken * _buyAmount;
        require(msg.value >= totalPrice, "Insufficient funds sent");

        // Transfer NFT to buyer
        CreatorsToken nft = CreatorsToken(_nftAddress);
        nft.safeTransferFrom(address(this), msg.sender, _buyAmount);

        // Update sale info
        sale.amountSold += _buyAmount;
        sale.tokensForSale -= _buyAmount;

        emit BuyNFTEvent(msg.sender, _nftAddress, _buyAmount, totalPrice);
    }
}
