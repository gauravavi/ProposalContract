// SPDX-License-Identifier: MIT  

pragma solidity ^0.8.18 ;

contract ProposalContract{

address proposalOwner;
uint private counter;
address[] private voter_addresses;

struct Proposal{

    string title;  
    string description;
    uint approve;
    uint reject;
    uint pass;
    uint total_vote_to_end;
    bool current_state;
    bool is_active;

}

mapping(uint=>Proposal) proposal_history;

constructor() {
    proposalOwner=msg.sender;
    voter_addresses.push(msg.sender);
}

modifier onlyOwner()
{
    require(proposalOwner==msg.sender, "Only Owner of the contract can create a proposal!");
    _;
}
modifier isActive(){
    require (proposal_history[counter].is_active==true,"Voting has completerd for theis proposal!");
    _;
}

modifier newVoter(address _address){
    require(!isVoted(_address) ,"You have alreadt Voted for this Proposal!");
    _;
}

function create(string calldata _title,string calldata _description,uint _total_vote_to_end) external onlyOwner{

    counter += 1;
    proposal_history[counter] = Proposal(_title,_description,0,0,0,_total_vote_to_end,false,true);
}

function setOwner(address new_owner) external onlyOwner{

    proposalOwner = new_owner;
}

function vote(uint choice) external isActive newVoter(msg.sender) {

    Proposal storage proposal = proposal_history[counter];
    uint total_vote = proposal.approve + proposal.pass+proposal.reject;

    voter_addresses.push(msg.sender);

    if(choice==1){
        proposal.approve +=1;
        proposal.current_state = calculateCurrentState();
    }else if(choice==2){
        proposal.reject +=1;
        proposal.current_state = calculateCurrentState();
    }else if(choice==0){
        proposal.pass +=1;
        proposal.current_state = calculateCurrentState();

    }

    if((proposal.total_vote_to_end - total_vote == 1) &&(choice==1 
    || choice==2 ||choice==0 )){

        proposal.is_active = false;
        voter_addresses = [proposalOwner];
    }
}

function calculateCurrentState() private view returns(bool){

    Proposal storage proposal = proposal_history[counter];

    uint approve = proposal.approve;
    uint reject = proposal.reject;
    uint pass = proposal.pass;

    /*if(proposal.pass%2 == 1){

        pass+=1;
    }

    pass = pass/2;
    */

    if((approve+pass) > reject)
    {
        return true;
    }
    else{
        return false;
    }

}

function isVoted(address _address)private view returns(bool){

        for(uint i=0;i<voter_addresses.length;i++){
                if(voter_addresses[i]==_address){
                    return true;
                }


        }
        return false;

}

function terminateProposal()external onlyOwner isActive{

    proposal_history[counter].is_active = false;
}

function getCurrentProposal()external view returns(Proposal memory){

    return proposal_history[counter];
}

function getProposal(uint number) external view returns(Proposal memory){
    return proposal_history[number];
}

}
