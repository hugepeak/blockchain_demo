import web3 from "./web3";
import CampaignFactory from "./build/CampaignFactory.json";

const instance = new web3.eth.Contract(
  JSON.parse(CampaignFactory.interface),
  "0x51ec572F78ED6E05250F133dAC1E63DD69Ef63F6"
);

export default instance;
