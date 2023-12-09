// TokenSwap.sol

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    address public token1;
    address public token2;
    address public owner;
    
    event Swap(address indexed sender, uint256 amount, address indexed swappedToken);

    constructor(address _token1, address _token2) {
        token1 = _token1;
        token2 = _token2;
        owner = msg.sender;
    }

    function swap(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");

        require(
            IERC20(token1).transferFrom(msg.sender, address(this), amount),
            "TransferFrom failed"
        );
        
        require(
            IERC20(token2).transfer(msg.sender, amount),
            "Transfer failed"
        );

        emit Swap(msg.sender, amount, token2);
    }

    function withdrawToken1(uint256 amount) external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(
            IERC20(token1).transfer(owner, amount),
            "Transfer failed"
        );
    }

    function withdrawToken2(uint256 amount) external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(
            IERC20(token2).transfer(owner, amount),
            "Transfer failed"
        );
    }
}
