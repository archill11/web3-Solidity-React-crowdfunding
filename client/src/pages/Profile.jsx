import React from 'react'
import { DisplayCampaigns } from '../components/DisplayCampaigns';
import { useStateContext } from '../context';

const Profile = () => {
  const [isLoading, setIsLoading] = React.useState(false);
  const [campaigns, setCampaigns] = React.useState([]);

  const { address, contract, getUserCampaigns } = useStateContext();

  const fetchCampaigns = async () => {
    setIsLoading(true);
    const data = await getUserCampaigns();
    setCampaigns(data);
    setIsLoading(false);
  }

  React.useEffect(() => {
    if(contract) fetchCampaigns();
  }, [address, contract]);


  return (
    <DisplayCampaigns title="All Campaigns"
                      isLoading={isLoading}
                      campaigns={campaigns}
    />
  )
}

export {Profile}