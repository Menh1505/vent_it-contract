
 async function main() {
     const Contract = await ethers.getContractFactory("Counter");
     console.log("Deploying contract to local Hardhat network...");
     const contract = await Contract.deploy();
     await contract.waitForDeployment();
     console.log("Contract deployed to address:", contract.target);
     return contract.target;
 }
 
 main()
     .then(() => process.exit(0))
     .catch((error) => {
         console.error("Error deploying contract:", error);
         process.exit(1);
     });