# NFT Template Contract that works out of the box!
This Replit template allows users to immediately deploy and play with an ERC721 NFT contract that is ready to mint, trade, and withdraw on approved marketplaces. This replit features an easy to use interface website for interacting with the contract once it is deployed. 

Features include:
- Hot reloading
- Solidity error checking
- Deploying multiple contracts
- UI for testing out contracts
- A mixin contract architecture that allows users to plug-and-play the features they'd like included for their NFT.

## Getting started
**Just press the `Run ▶️` button!**

- You should only need to do this once (and might take like 15s). This will install all relevant packages, start up the contract deployment UI, and compile your `contract.sol` file.

- `contract.sol` is just an import file that brings in the `NFT.sol` contract, which is the 'atomic unit' contract that can be deployed and actually played with. 

- Pressing `cmd-s` or `ctrl-s` (windows) will reload the UI.

We have preinstalled packages from `@openzeppelin/contracts`. To install other solidity packages that are distributed on npm, make sure you install them using the Package Installer 📦 in the sidebar

## Basic contract
Implements the barebones methods needed to have a functioning `NFT.sol`, so that users can start out with a simpler implementation and build up to more complex contracts if they wish. To use this implementation, remove the mixins from the contract declaration and replace any `overrides(FooMixin, BarMixin)` in `NFT.sol` with just `overrides`.

## Mixins
These are single-purpose implementations of the same base contract `ERC721Tradable.sol`. Each comes with a corresponding role that is automatically granted to the deploying address, but can be added to other accounts via the `grantRole()` contract call or removed via the `revokeRole()` call.

There are several different mixins users can choose to add or remove from their implementation:
 - **MinterMixin**: Adds minting utils and some gas-saving and a Solidity counter to avoid messing up tokenId generation. Also includes logic for having a maximum amount of tokens to mint in the collection. Finally, add a special minter role that gives only role-havers the ability to mint tokens, conceptually an on-chain allowlist for minting.
 - **OperatorMixin**: Adds some gas-saving features by allowing third-parties such as OpenSea to transact on an owner's behalf by granting them an Operator role.
 - **WithdrawMixin**: Your 10K Snail PFP collection finished minting in 30 seconds, now what? You want to cash in on that sweet fake internet money? Welllll its going to be stuck in the smart contract **forever** if you don't include this mixin or something similar to it.


## Future work

Harden the mixin architecture further to make it easier to extend and add more interesting implementations that can be plugged in easily.

Some thoughts so far include splitting out minting into more subfeatures like:
- 1 mint per account
- Mass minting to save gas
- Randomizing tokenIds

Some other mixins could be:
- Burn mixin 
- Pausable mixin
- An on-chain renderer mixin for 8-bit art

## Feedback

I'm always open to feedback on the approach and execution. Let me know if you think there are better patterns we can employ here. 
