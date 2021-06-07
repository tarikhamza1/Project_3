pragma solidity ^0.5.0;

contract SalesContract {
string public title;
string public description;
uint public price;
uint public deposit;
address public seller;
address public buyer;
bool public verifyIdentity;


enum State { Created, Locked, Inactive, AwaitPayment }
State public state;
function Agreement(string memory _title, string memory _description, bool _verify, uint
_deposit, uint _value) public

{
}
modifier require(bool _condition) {
if (!_condition) revert();
_;
}
modifier onlyBuyer() {
if (msg.sender != buyer) revert();
_;
}
modifier onlySeller() {
if (msg.sender != seller) revert();
_;
}
modifier inState(State _state) {
if (state != _state) revert();
_;
}
event aborted();
function abort() public;
}