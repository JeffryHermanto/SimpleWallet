// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Evoting {
    address public owner;
    bool sudahBisaVoting;
    bool votingSelesai;

    constructor() {
        owner = msg.sender;
        sudahBisaVoting = false;
        votingSelesai = false;
    }

    struct Kandidat {
        address alamatKandidat;
        uint jumlahSuara;
    }

    Kandidat[] public kandidats;

    mapping(address => bool) public kandidatTerdaftar;
    mapping(address => bool) public userSudahMemilih;

    function tambahKandidat(address alamat) public {
        require(msg.sender == owner, "Anda bukan owner");
        require(!kandidatTerdaftar[alamat], "Kandidat sudah terdaftar");
        kandidats.push(Kandidat(alamat, 0));
        kandidatTerdaftar[alamat] = true;
    }

    function statusVoting(bool status) public {
        require(msg.sender == owner, "Anda bukan owner");
        sudahBisaVoting = status;
    }

    function totalKandidat() public view returns (uint) {
        return kandidats.length;
    }

    function votingSudahSelesai() public {
        votingSelesai = true;
        sudahBisaVoting = false;
    }

    function voting(uint urutanKandidat) public {
        require(sudahBisaVoting, "Belum waktunya voting");
        require(urutanKandidat < kandidats.length, "Kandidat tidak ditemukan");
        require(!userSudahMemilih[msg.sender], "Anda sudah voting");
        require(msg.sender != owner, "Owner tidak bisa voting");
        kandidats[urutanKandidat].jumlahSuara++;
        userSudahMemilih[msg.sender] = true;
    }

    function siapaYangMenang() public view returns (address, uint) {
        require(!sudahBisaVoting, "Masih proses voting");
        require(kandidats.length > 2, "Kandidat tidak valid");
        require(votingSelesai, "Voting belum dilaksanakan");

        uint suaraTertinggi = 0;
        uint indexPemenang = 0;

        for (uint i = 0; i < kandidats.length; i++) {
            if (kandidats[i].jumlahSuara > suaraTertinggi) {
                suaraTertinggi = kandidats[i].jumlahSuara;
                indexPemenang = i;
            }
        }

        return (
            kandidats[indexPemenang].alamatKandidat,
            kandidats[indexPemenang].jumlahSuara
        );
    }
}
