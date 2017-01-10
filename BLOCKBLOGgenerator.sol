
pragma solidity ^0.4.6;


contract BLOCKBLOGgenerator{
address public owner; //standard needed for Alpha Layer and generic augmentation
mapping(address => address)public lastBlogGenerated;
//creation
function BLOCKBLOGgenerator() {
owner=msg.sender;
}

//generate new BLOCKBLOG
function generateBLOCKBLOG() returns(bool){
address b=new BLOCKBLOG(msg.sender);
lastBlogGenerated[msg.sender]=b;
return true;
}

//destroy blog
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}


}

contract BLOCKBLOG{
address public owner; //standard needed for Alpha Layer and generic augmentation

//creation
function BLOCKBLOG(address o) {
owner=o;
logs.push(log("Created Blog","1.0","","",o,block.number));
}

//add a new post at the end of the log
function addPost(string title,string content,string media,string link,address ethlink) returns(bool){
if(msg.sender!=owner)throw;
logs.push(log(title,content,media,link,ethlink,block.number));
return true;
}

//edit a specific post at a given index
function editPost(uint index,string title,string content,string media,string link,address ethlink) returns(bool){
if(msg.sender!=owner)throw;
logs[index]=log(title,content,media,link,ethlink,block.number);
return true;
}

//the logs container
log[] logs;

    struct log{
    string title;
    string content;
    string media;
    string link;
    address ethlink;
    uint blocknumber;
   }

//read the logs by index
function readLog(uint i)constant returns(uint,string,string,string,string,address,uint){
log l=logs[i];
uint u=logs.length;
uint b=l.blocknumber;
return(u,l.title,l.content,l.media,l.link,l.ethlink,b);
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
