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

    // user bisa melihat saldonya sendiri dan saldo user lain
    // user bisa mentransfer saldo dia ke user lain (*)
    // user bisa menarik kembali saldonya (*)
}
