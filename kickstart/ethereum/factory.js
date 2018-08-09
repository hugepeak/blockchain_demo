import web3 from "./web3";
import CampaignFactory from "./build/CampaignFactory.json";

const instance = new web3.eth.Contract(
  JSON.parse(CampaignFactory.interface),
  "0x54202B1ceAE4F3734a7fF5b01e13940183934a19"
);

export default instance;
