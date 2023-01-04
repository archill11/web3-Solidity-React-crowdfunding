// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {

  struct Campaign {
    address owner;
    string title;
    string descriptin;
    uint256 target; // ������� ����� ������� ����� ������
    uint256 deadline;
    uint256 amountCollected; // ��������� �����
    string image;
    address[] donators;
    uint256[] donations;//651652652562
  }



  mapping(uint256 => Campaign) public campaigns; // ���� ��������

  uint256 public numberOfCampaigns = 0;

  /**
   * ������� ��������� ����� ��������
   */
  function createCampaign(address _owner, 
                          string memory _title, 
                          string memory _descriptin, 
                          uint256 _target, 
                          uint256 _deadline, 
                          string memory _image) public returns (uint256) {

    Campaign storage newCampaign = campaigns[numberOfCampaigns]; // ����� ������ ���� ��� ���� ��� ����� �������� 

    // �������� ��� deadline �������� 
    require(newCampaign.deadline < block.timestamp, "The deadline should be a data in the future.");

    newCampaign.owner = _owner;
    newCampaign.title = _title;
    newCampaign.descriptin = _descriptin;
    newCampaign.target = _target;
    newCampaign.deadline = _deadline;
    newCampaign.amountCollected = 0;
    newCampaign.image = _image;
  
    numberOfCampaigns++;

    return numberOfCampaigns - 1;
  }

  /**
   * ������� ��������� id �������� ������� ����� ������� ����������
   */
  function donateToCampaign(uint256 _id) public payable {
    uint256 amount = msg.value; // ����� ���������� �� ���������� ���������� 

    Campaign storage campaign = campaigns[_id];

    campaign.donators.push(msg.sender); // ����������� �� ���������� ����������
    campaign.donations.push(amount);

    (bool sent, ) = payable(campaign.owner).call{value: amount}("");

    if(sent) { // ���� ���������� ������� 
      campaign.amountCollected = campaign.amountCollected + amount;
    }
  }

  /**
   * ������� ��������� id ��������, ��������� ������� �� ����� �������� 
   */
  function getDonators(uint256 _id) view public returns (address[] memory, uint256[] memory) {
    return (campaigns[_id].donators, campaigns[_id].donations);
  }

  /**
   * ������� ���������� ��� �������� 
   */
  function getCampaigns() public view returns (Campaign[] memory) {

    Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns); // ������� ������ ������ ���������� ������ ���������� �������� 

    for(uint i = 0; i < numberOfCampaigns; i++) {
      Campaign storage item = campaigns[i];

      allCampaigns[i] = item;
    }

    return allCampaigns;
  }

}