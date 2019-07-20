# Simple Fundraising Solidity Example

The idea of this simple example is create a smart contract to collect fundraising.

## Participants

We have 2 type of participants in our contract:

* The founder: account who wants to collect money for the project
* The investors: accounts who send money to the contract in order to collaborate with the project

## Attributes

This contract have 2 attributes:

* Time: the time the collecting phase will be available
* Goal: the minimum amount to be collected in wei

## Rules

These are the rules:

* The owner of the contract is the address who deploys the contract
* The founder is the owner of the contract
* The investors are any account who invest/send money to the fundraising contract
