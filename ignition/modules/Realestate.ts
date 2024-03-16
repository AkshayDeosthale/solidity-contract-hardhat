import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const RealestateModule = buildModule("RealestateModule", (m) => {
  const realestate = m.contract("Realestate");

  return { realestate };
});

export default RealestateModule;
