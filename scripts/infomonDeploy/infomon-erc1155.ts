import { HardhatRuntimeEnvironment } from 'hardhat/types';

const deploy = async ({ getNamedAccounts, deployments }: HardhatRuntimeEnvironment) => {
  const { deploy } = deployments;
  let { deployer } = await getNamedAccounts();

  await deploy('InfomonERC1155', {
    from: deployer,
    log: true,
    args: ['https://infomonpublicresource.blob.core.windows.net/pet-public/metadata-test-1155/'],
  });
};

deploy.tags = ['InfomonERC1155'];
deploy.dependencies = ['VerifyContracts'];

export default deploy;
