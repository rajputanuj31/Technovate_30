// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./MedicineNFT.sol";

contract Medicine{

    struct order{
        address to;
        string name;
        uint256 stage;
        string trackHash;
        uint256 tokenID;
    }

    mapping(address => order) public orderMap;

    address[] public nftAddress;
    mapping(string => uint256) public nameMap;
    string[] public MedicineName;

    function createOrder(address _to, string memory _name) public{
        
        order memory order_new ;
        order_new.name = _name;
        
        order_new.stage = 0;

        MedicineNFT i_MedicineNFT = MedicineNFT(nftAddress[nameMap[_name]]);
        order_new.tokenID = i_MedicineNFT.count();

        orderMap[_to] = order_new;

    }

    function getTokenIdAssigned() public  view returns(uint256){
        return orderMap[msg.sender].tokenID;
    }

    function getMedicineAssigned() public  view returns(string memory){
        return orderMap[msg.sender].name;
    }

    function getHELPPLS (address _address) public view returns (uint256){
        return MedicineNFT(_address).count();
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
