// SPDX-License-Identifier: MIT  

pragma solidity ^0.8.18 ;

contract ProposalContract{

address proposalOwner;
uint private counter;

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

function create(string calldata _title,string calldata _description,uint _total_vote_to_end) external{

    counter += 1;
    proposal_history[counter] = Proposal(_title,_description,0,0,0,_total_vote_to_end,false,true);
}




}
