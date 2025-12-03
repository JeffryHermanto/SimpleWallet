// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract SimpleWallet {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint) private balances;

    event Deposit(address indexed user, uint amount);
    event Transfer(address indexed from, address indexed to, uint amount);
    event Withdraw(address indexed user, uint amount);

    function _deposit() private {
        require(msg.value > 0, "Jumlah depo harus lebih besar dari 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function deposit() external payable {
        _deposit();
    }

    receive() external payable {
        _deposit();
    }

    fallback() external payable {
        _deposit();
    }

    function getMyBalance() external view returns (uint) {
        return balances[msg.sender];
    }

    function getBalance(address user) external view returns (uint) {
        return balances[user];
    }

    function transfer(address to, uint amount) external {
        require(balances[msg.sender] >= amount, "Saldo tidak cukup");
        require(to != address(0), "Address Zero");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }

    function withdraw(uint amount) external {
        require(amount > 0, "Penarikan tidak bisa 0");
        require(balances[msg.sender] >= amount, "Saldo tidak cukup");
        balances[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer gagal");
        emit Withdraw(msg.sender, amount);
    }
}
