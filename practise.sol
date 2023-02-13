// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract wallet
{
    address public manager;
    address payable[] public players;

    constructor()
    {
        manager = msg.sender;
    }

    receive() external payable
    {
        require(msg.value==1 ether);
        players.push(payable(msg.sender));
    }

    function getbalance() public view returns(uint)
    {
        require(msg.sender==manager);
        return address(this).balance;
    }

    function generaterandom() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players.length)));
    }

    function selectwinner() public
    {
        require(players.length >= 3);
        require(msg.sender==manager);
        uint r = generaterandom();
        uint temp = r % players.length;
        address payable winner;
        winner = players[temp];
        winner.transfer(getbalance());
        players=new address payable[](0);

    }


}