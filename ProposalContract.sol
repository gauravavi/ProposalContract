// SPDX-License-Identifier: MIT  

pragma solidity ^0.8.18 ;

contract ProposalContract{

address proposalOwner;

struct Proposal{

    string tittle;  
    string description;
    uint approve;
    uint reject;
    uint pass;
    uint total_vote_to_end;
    bool current_state;
    bool is_active;

}

mapping(uint=>Proposal) proposal_history;




}
