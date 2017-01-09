
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




pragma solidity ^0.4.6;

contract BLOCKBLOG{
address public owner; //standard needed for Alpha Layer and generic augmentation

//creation
function BLOCKBLOG(address o) {
owner=o;
logs.push(log(o,"Created Blog","1.0","",block.number));
}

//add a new post at the end of the log
function addPost(string title,string content,string media,address ethlink) returns(bool){
if(msg.sender!=owner)throw;
logs.push(log(ethlink,title,content,media,block.number));
return true;
}

//edit a specific post at a given index
function editPost(uint index,string title,string content,string media,address ethlink) returns(bool){
if(msg.sender!=owner)throw;
logs[index]=log(ethlink,title,content,media,block.number);
return true;
}

//the logs container
log[] logs;

    struct log{
            address ethlink;
    string title;
    string content;
    string media;

    uint blocknumber;
   }

//read the logs by index
function readLog(uint i)constant returns(uint,address,string,string,string,uint){
log l=logs[i];
return(logs.length,l.ethlink,l.title,l.content,l.media,l.blocknumber);
}

//change owner
function manager(address o)returns(bool){
if(msg.sender!=owner)throw;
logs.push(log(o,"Owner changed:","","",block.number));
owner=o;
return true;
}

//destroy blog
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}

} 
