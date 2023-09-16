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
        address shipperAddress;
    }

    event orderCreated(
        address indexed to,
        string name
    );

    event medicineManufactured(
        address indexed to,
        address indexed supplier
    );

    event shipmentCompleted(
        address indexed to
    );
    
    mapping(address => order) public orderMap;

    address[] public nftAddress;
    mapping(string => uint256) public nameMap;
    string[] public MedicineName;

    mapping(address=>uint256) pending_orders;
    mapping(address=>address[]) shipping_orders;

    function createOrder(address _to, string memory _name) public{
        
        order memory order_new ;
        order_new.name = _name;
        
        order_new.stage = 0;

        MedicineNFT i_MedicineNFT = MedicineNFT(nftAddress[nameMap[_name]]);
        order_new.tokenID = i_MedicineNFT.count();

        orderMap[_to] = order_new;

        emit orderCreated(_to, _name);

    }

    function sendToSupplier(address _for, address _supplier, string memory updatedQR)public {

        order memory orderData = orderMap[_for];

        MedicineNFT i_MedicineNFT = MedicineNFT(nftAddress[nameMap[orderData.name]]);
        i_MedicineNFT.safeMint(_supplier,"");

        orderData.shipperAddress = _supplier;
        orderData.stage = 1;
        orderData.trackHash = updatedQR;
        orderMap[_for] = orderData;

        shipping_orders[_supplier].push(_for);

        pending_orders[_supplier]+=1;

        emit medicineManufactured(_for,_supplier);

    }

    function completeOrder(address _for, address from,  string memory updatedQR)public {
        for(uint256 i = 0 ; i < shipping_orders[msg.sender].length ; i ++){

            if(shipping_orders[msg.sender][i] == _for){
                
                pending_orders[msg.sender] -=1;
                shipping_orders[msg.sender][i] = address(0);

                order memory orderData = orderMap[_for];
                uint256 tokenId = orderData.tokenID;
                orderData.stage = 2;
                orderData.trackHash = updatedQR;

                MedicineNFT i_MedicineNFT = MedicineNFT(nftAddress[nameMap[orderData.name]]);
                i_MedicineNFT.safeTransferFrom(from,_for,tokenId);

            }
        }
        emit shipmentCompleted(_for);
    }

    function getShippingOrder()public view returns(address [] memory){
        return shipping_orders[msg.sender];
    }

    function getTokenIdAssigned() public  view returns(uint256){
        return orderMap[msg.sender].tokenID;
    }

    function getMedicineAssigned() public  view returns(string memory){
        return orderMap[msg.sender].name;
    }

    function getQR()  public view returns (string  memory) {
        return orderMap[msg.sender].trackHash;
    }

    function getStage() public view returns (uint256) {
        return orderMap[msg.sender].stage;
    }

    function getShipper() public view returns (address) {
        return orderMap[msg.sender].shipperAddress;
    }

    function getPendingOrders(address _shipper)public view returns (uint256){
        return pending_orders[_shipper];
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
