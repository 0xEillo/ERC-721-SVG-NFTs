const fs = require("fs");

async function main() {
  console.log("----------------------------------------------------");

  const SVGNFT = await ethers.getContractFactory("SVGNFT");
  const svgNFT = await SVGNFT.deploy();

  console.log("NFT contract deployed to: ", svgNFT.address);

  console.log("Let's create an NFT now!");
  let filepath = "./images/frog.svg";
  let svg = fs.readFileSync(filepath, { encoding: "utf8" });
  console.log(
    `We will use ${filepath} as our SVG, and this will turn into a tokenURI. `
  );
  tx = await svgNFT.mint(svg);
  await tx.wait(1);
  console.log(`You've made your first NFT!`);
  console.log(`You can view the tokenURI here ${await svgNFT.tokenURI(0)}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
