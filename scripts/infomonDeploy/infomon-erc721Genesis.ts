import { HardhatRuntimeEnvironment } from 'hardhat/types';

const deploy = async ({ getNamedAccounts, deployments }: HardhatRuntimeEnvironment) => {
  const { deploy } = deployments;
  let { deployer } = await getNamedAccounts();

  await deploy('InfomonERC721', {
    from: deployer,
    log: true,
    args: ['Infomon Genesis NFT', 'INFOMONGENESIS', 'https://infomonpublicresource.blob.core.windows.net/pet-public/metadata-test-genesis/'],
  });
};

deploy.tags = ['InfomonNFT'];
deploy.dependencies = ['VerifyContracts'];

export default deploy;
