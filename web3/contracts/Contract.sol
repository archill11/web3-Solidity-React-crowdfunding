// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {

  struct Campaign {
    address owner;
    string title;
    string descriptin;
    uint256 target; // целевая ссума которую хотим достич
    uint256 deadline;
    uint256 amountCollected; // собранная сумма
    string image;
    address[] donators;
    uint256[] donations;//651652652562
  }



  mapping(uint256 => Campaign) public campaigns; // мапа компаний

  uint256 public numberOfCampaigns = 0;

  /**
   * Функция добавляет новую компанию
   */
  function createCampaign(address _owner, 
                          string memory _title, 
                          string memory _descriptin, 
                          uint256 _target, 
                          uint256 _deadline, 
                          string memory _image) public returns (uint256) {

    Campaign storage newCampaign = campaigns[numberOfCampaigns]; // берем размер мапы как ключ для новой компании 

    // проверка что deadline валидный 
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
   * Функция принимает id компании которой хотим сделать транзакцию
   */
  function donateToCampaign(uint256 _id) public payable {
    uint256 amount = msg.value; // сумма транзакции из глобальной переменной 

    Campaign storage campaign = campaigns[_id];

    campaign.donators.push(msg.sender); // отправитель из глобальной переменной
    campaign.donations.push(amount);

    (bool sent, ) = payable(campaign.owner).call{value: amount}("");

    if(sent) { // если транзакция успешна 
      campaign.amountCollected = campaign.amountCollected + amount;
    }
  }

  /**
   * Функция принимает id компании, донатеров которой мы хотим получить 
   */
  function getDonators(uint256 _id) view public returns (address[] memory, uint256[] memory) {
    return (campaigns[_id].donators, campaigns[_id].donations);
  }

  /**
   * Функция возвращает все компании 
   */
  function getCampaigns() public view returns (Campaign[] memory) {

    Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns); // создаем пустой массив количесвом равным количеству компаний 

    for(uint i = 0; i < numberOfCampaigns; i++) {
      Campaign storage item = campaigns[i];

      allCampaigns[i] = item;
    }

    return allCampaigns;
  }

}