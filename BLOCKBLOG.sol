pragma solidity ^0.4.6;

contract BLOCKBLOG{
address public owner; //standard needed for Alpha Layer and generic augmentation

//creation
function BLOCKBLOG(address o) {
owner=o;
logs.push(log("BLOCKLOG:","blog","1.0","created",o,block.number));
}

//add a new post at the end of the log
function addPost(string title,string headline,string content,string media,address ethlink,string link) returns(bool){
if(msg.sender!=owner)throw;
logs.push(log(title,headline,content,media,ethlink,link,block.number));
return true;
}

//edit a specific post at a given index
function editPost(uint index,string title,string headline,string content,string media,address ethlink,string link) returns(bool){
if(msg.sender!=owner)throw;
logs[index]=log(title,headline,content,media,ethlink,link,block.number);
return true;
}

//the logs container
log[] logs;

    struct log{
    string title;
    string headline;
    string content;
    string media;
    address ethlink;
    uint blocknumber;
   }

//read the logs by index
function readLog(uint i)constant returns(uint,string,string,string,string,uint){
log l=logs[i];
return(logs.length,l.title,l.headline,l.content,l.media,l.ethlink,l.link,l.blocknumber);
}

//change owner
function manager(address o)returns(bool){
if(msg.sender!=owner)throw;
logs.push(log("Owner changed:","","","",o,block.number));
owner=o;
return true;
}

//destroy blog
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}

} 
