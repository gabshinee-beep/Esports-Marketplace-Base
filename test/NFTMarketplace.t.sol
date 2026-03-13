// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../src/NFTMarketplace.sol";

contract MockNFT is ERC721 {
    constructor() ERC721("MockNFT", "MNFT") {}
    function mint(address to_, uint256 tokenId_) external {
        _mint(to_, tokenId_);
    }
}

contract NFTMarketplaceTest is Test {
    NFTMarketplace marketplace;
    MockNFT nft;
    address user = makeAddr("user");
    address buyer = makeAddr("buyer");
    uint256 tokenId = 1;
    uint256 price = 1 ether;

    function setUp() public {
        marketplace = new NFTMarketplace();
        nft = new MockNFT();
        nft.mint(user, tokenId);
    }

    function testListAndBuyNFT() public {
        vm.startPrank(user);
        nft.approve(address(marketplace), tokenId);
        marketplace.listNFT(address(nft), tokenId, price);
        vm.stopPrank();

        vm.deal(buyer, price);
        vm.prank(buyer);
        marketplace.buyNFT{value: price}(address(nft), tokenId);

        assertEq(nft.ownerOf(tokenId), buyer);
        assertEq(user.balance, price);
    }
}