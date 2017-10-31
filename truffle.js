module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8546,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      host: "localhost", // Connect to geth on the specified
      port: 8545,
      from: "0x4750a4bc51783648283370f8ab55f8b7493323d1", // default address to use for any transaction Truffle makes during migrations
        network_id: 4,
        gas: 4612388, // Gas limit used for deploys
        gasPrice: 1000000000
    }
  }
};
