import React from 'react';
import { DisplayCampaigns } from "../components/DisplayCampaigns";
import { useStateContext } from '../context';


const Home = () => {
  const [isLoading, setIsLoading] = React.useState(false);
  const [campaigns, setCampaigns] = React.useState([]);

  const { address, contract, getCampaigns } = useStateContext();

  const fetchCampaigns = async () => {
    setIsLoading(true);
    const data = await getCampaigns();
    setCampaigns(data);
    setIsLoading(false);
  }

  React.useEffect(() => {
    if(contract) fetchCampaigns();
  }, [address, contract]);


  return (
    <DisplayCampaigns 
      title="All Campaigns"
      isLoading={isLoading}
      campaigns={campaigns}
    />
  )
}

export {Home}