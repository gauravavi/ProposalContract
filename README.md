# Proposal Contract

What does Proposal Contract do:

1.  This contract is a simple voting system for proposals created by the owner. 
2.  In proposals, we have a description for the explanation of the proposal. We also have variables for holding numbers of approve, reject and pass votes. We also have couple of additional     fields that helps us to track more information about our proposals.
3.  The owner can create a new proposal with a description and a vote limit, and other users can vote to approve, reject or pass the proposal. 
4.  The contract calculates the current state of the proposal based on the number of votes, and ends the proposal when the vote limit is reached. 
5.  The contract also keeps a history of all the proposals and their outcomes, and prevents users from voting more than once.
6.  The contract uses some modifiers to restrict access and check conditions, and some helper functions to implement the logic.
