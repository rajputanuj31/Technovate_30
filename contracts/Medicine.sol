// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Medicine{

    struct order{
        address to;
        string name;
        uint256 stage;
        string trackHash;
    }
    order order1;

    address[] public nftAddress;
    mapping(string => uint256) public nameMap;
    mapping(address => order) public orderMap;
    string[] public MedicineName;

    function createOrder(address _to,string memory _name,uint256 _stage) public{
         order1 = order(_to,_name,_stage, "");
    }


    function addNFTAddressName(address _nftAddress,string memory _str) public {
        nftAddress.push(_nftAddress);
        nameMap[_str] = MedicineName.length;
        MedicineName.push(_str);
    }
    
    function getNFTaddress (uint256 index) public view returns (address){
        return nftAddress[index];
    }

    function getMedicineName(uint256 index) public view returns (string memory){
        return MedicineName[index];
    }

    function getIndex(string memory _name) public view returns (uint256){
        return nameMap[_name];
    }
}