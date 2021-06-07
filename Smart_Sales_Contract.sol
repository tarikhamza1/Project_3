pragma solidity ^0.5.0;


import “./sales_contract.sol”;

contract Agreement is SalesContract

{
    address payable public seller;
    address payable public buyer;
    uint public value;
    State public state;
     constructor() public payable {
        buyer = msg.sender;
        price = msg.value / 2;
     }
function Purchase(string memory _title, string memory _description, bool _verify) payable public

{
    Purchase(_title, _description, _verify);
    seller.transfer (msg.value / 2);
    state = State.Locked;
}
event purchaseConfirmed();
event itemReceived();

/// Abort the purchase and reclaim the ether, can only be called by the seller before the contract is locked.

function abort() public
onlySeller
inState(State.Created)
{
emit aborted();
state = State.Inactive;
if (!seller.send(address(this).balance))
revert();
}

/// Confirm the purchase as buyer, the ether will be locked until confirmreceived is called


function confirmPurchase() public
inState(State.Created)
require(msg.value == 2 * value)
payable
{
emit purchaseConfirmed();
buyer = msg.sender;
state = State.Locked;
}

/// The buyer confirms that she/he received the item, this will release the locked ether


function confirmReceived() public
onlyBuyer
inState(State.Locked)
{
emit itemReceived();

// It is important to change the state first because otherwise, the contracts called using 'send' below can call in again here


state = State.Inactive;

// This actually allows both the buyer and the seller to block the refund.

if (!buyer.send(deposit) || !seller.send(address(this).balance))
revert();
}
}