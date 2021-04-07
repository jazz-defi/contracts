pragma solidity 0.6.12;

import "./libs/IBEP20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract DistributeReward {
    using SafeMath for uint256;

    address public constant marketing = 0x75F6f9A1Df9365eEe0d3a2c2660b79455359b5D5;
    address public constant owner = 0x580245401D70F578693b0aAe0A5e8F8b8e4B7C9E;
    address public constant mod1 = 0xf1E3e18C21BeBfad1ed7262817D55b4D87FAaE56;
    address public constant mod2 = 0xf31587f9A419BE4F5A80fCD9d62d3d4Cb4662573;
    IBEP20 public jazz;

    event SetModsAddress(address indexed user, address indexed newAddress);

    constructor(address _jazz) public {
        jazz = IBEP20(_jazz);
    }

    function distribute() external {
        uint256 balance = IBEP20(jazz).balanceOf(address(this));
        uint256 marketingReward = balance.mul(100).div(1000);
        uint256 mod1Reward =  balance.mul(100).div(1000);
        uint256 mod2Reward =  balance.mul(150).div(1000);
        uint256 ownerReward =  ((balance.sub(marketingReward)).sub(mod1Reward)).sub(mod2Reward);
        jazz.transfer(marketing, marketingReward);
        jazz.transfer(owner, ownerReward);
        jazz.transfer(mod1, mod1Reward);
        jazz.transfer(mod2, mod2Reward);
    }

}