// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";

contract SVGNFT is ERC721URIStorage {
    uint256 public tokenCounter;

    event CreatedSVGNFT(uint256 indexed tokenId, string tokenURI);

    constructor() ERC721("SVGNFT", "SVGNFT") {
        tokenCounter = 0;
    }

    function mint(string memory _svg) public {
        _safeMint(msg.sender, tokenCounter);
        string memory imgURI = svgToImageURI(_svg);
        string memory tokenURI = formatTokenURI(imgURI);
        _setTokenURI(tokenCounter, tokenURI);
        emit CreatedSVGNFT(tokenCounter, tokenURI);
        tokenCounter = tokenCounter += 1;
    }

    function svgToImageURI(string memory svg)
        public
        pure
        returns (string memory _imageURI)
    {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        _imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    function formatTokenURI(string memory _imgURI)
        public
        pure
        returns (string memory _tokenURI)
    {
        string memory baseURL = "data:application/json;base64,";
        _tokenURI = string(
            abi.encodePacked(
                baseURL,
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"SVG NFT"', // You can add whatever name here
                            '"description":"An NFT based on SVG!"',
                            '"attributes":""',
                            '"image":"',
                            _imgURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
