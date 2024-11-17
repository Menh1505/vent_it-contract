require("dotenv").config();
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";

const config: HardhatUserConfig = {
    solidity: {
    version: "0.8.20",
    settings: {
        optimizer: {
            enabled: false,
            runs: 200
        },
        evmVersion: "london",
        viaIR: false,
            metadata: {
                bytecodeHash: "ipfs"
            }
        }
    },
    paths: {
        sources: "./contracts",
        tests: "./test",
        cache: "./cache",
        artifacts: "./artifacts"
    },
    namedAccounts: {
        deployer: {
            default: 0
        }
    }
};

export default config;