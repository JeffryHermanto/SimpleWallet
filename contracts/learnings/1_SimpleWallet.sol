// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract SimpleWallet {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint) private balances;

    // user bisa menyimpan saldo ke sc (*)
    // user bisa melihat saldonya sendiri dan saldo user lain
    // user bisa mentransfer saldo dia ke user lain (*)
    // user bisa menarik kembali saldonya (*)
    // (*) = butuh event
}