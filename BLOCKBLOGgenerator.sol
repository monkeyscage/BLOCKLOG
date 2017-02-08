
pragma solidity ^0.4.6;
 
contract logsIndex{
address public owner;
address public controller;
address[] public dapps;
address[] public blogs;
mapping(address => address[]) mydapps;
mapping(address => address[]) myblogs;
 
function logsIndex(){owner=msg.sender;}
function setOwner(address NewOwner){if(msg.sender!=owner)throw;owner=NewOwner;}
function setController(address NewController){if(msg.sender!=owner)throw;controller=NewController;}
function addDapp(address DappAddress,address creator){if(msg.sender!=owner)throw;mydapps[creator].push(DappAddress);dapps.push(DappAddress);}
function addBlog(address BlogAddress,address creator)returns(bool){if(msg.sender!=controller)throw;myblogs[creator].push(BlogAddress);blogs.push(BlogAddress);return true;}
function removeDapp(uint index){if(msg.sender!=owner)throw;dapps[index]=0x0;}
function removeBlog(uint index){if(msg.sender!=owner)throw;blogs[index]=0x0;}
function getDapp(uint index)constant returns(uint,address){uint t=dapps.length; return(t,dapps[index]);}
function getBlog(uint index)constant returns(uint,address){uint t=blogs.length; return(t,blogs[index]);}
function getMyBlog(address creator,uint index)constant returns(uint,address){uint t=myblogs[creator].length; return(t,myblogs[creator][index]);}
function getMyDapp(address creator,uint index)constant returns(uint,address){uint t=mydapps[creator].length; return(t,mydapps[creator][index]);}
}
 
 
contract BLOCKBLOGgenerator{
address public owner; //standard needed for Alpha Layer and generic augmentation
logsIndex logsindex;
mapping(address => address)public lastBlogGenerated;
//creation
function BLOCKBLOGgenerator(address mainindex) {
logsindex=logsIndex(mainindex);
owner=msg.sender;
}
 
//generate new BLOCKBLOG
function generateBLOCKBLOG(uint version) returns(bool){
address b;

if(version==1){
   b=new BLOCKBLOG(msg.sender);
}else{
   b=new universalBLOCKBLOG(msg.sender);
}

if(!logsindex.addBlog(b,msg.sender))throw;

logs.push(log(b,block.number));

lastBlogGenerated[msg.sender]=b;

return true;
}

//read the logs by index
function readLog(uint i)constant returns(uint,address,uint){
log l=logs[i];
return(logs.length,l.ethlink,l.blocknumber);
}

//the logs container
log[] logs;
//used to know in advance the logs structure
string public logInterface="a-Log|u-Block";

    struct log{
    address ethlink;
    uint blocknumber;
   }
 
//destroy blog
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}
 
 
}
 
contract BLOCKBLOG{
address public owner; //standard needed for Alpha Layer and generic augmentation
string standard="BLOCKLOG.1.0";
 
//creation
function BLOCKBLOG(address o) {
owner=o;
logs.push(log("Created Blog","1.0","","",o,block.number));
}

//change owner
function manager(address o)returns(bool){
if(msg.sender!=owner)throw;
logs.push(log("Owner changed:","","","",o,block.number));
owner=o;
return true;
}
 
//add a new post at the end of the log
function addPost(string title,string content,string media,string link,address ethlink) returns(bool){
if(msg.sender!=owner)throw;
logs.push(log(title,content,media,link,ethlink,block.number));
return true;
}
 
//add a new post at the end of the log
function addLogPost(string title,string content,string media,string link,address ethlink) returns(bool){
if(msg.sender!=owner)throw;
address a=new minilog(msg.sender,title,content,media,link,ethlink);
logs.push(log("","","","",a,block.number));
return true;
}
 
//add a new post at the end of the log
function addSwarmPost(address swarmlink) returns(bool){
if(msg.sender!=owner)throw;
logs.push(log("","","","",swarmlink,block.number));
return true;
}
 
//edit a specific post at a given index
function editPost(uint index,string title,string content,string media,string link,address ethlink) returns(bool){
if(msg.sender!=owner)throw;
logs[index]=log(title,content,media,link,ethlink,block.number);
return true;
}
 

 
//read the logs by index
function readLog(uint i)constant returns(uint,string,string,string,string,address,uint){
log l=logs[i];
return(logs.length,l.title,l.content,l.media,l.link,l.ethlink,l.blocknumber);
}


//the logs container
log[] logs;
string public logInterface="s-Title|s-Content|s-Media-|s-Link|a-EthLink|u-Block";

    struct log{
    string title;
    string content;
    string media;
    string link;
    address ethlink;
    uint blocknumber;
   }
 
 
//destroy blog
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}
 
}

contract universalBLOCKBLOG{
address public owner; //standard needed for Alpha Layer and generic augmentation
address public controller; //allowed to post, share and edit logs
string standard="BLOCKLOG.1.0";  //the blog standard

 
//creation
function universalBLOCKBLOG(address o) {
owner=o;
logs.push(log(o,block.number));
}

//change owner
function manager(address o)returns(bool){
if(msg.sender!=owner)throw;
owner=o;
return true;
}

//change owner
function setController(address o)returns(bool){
if(msg.sender!=owner)throw;
controller=o;
return true;
}
 
//add a new post at the end of the log
function shareLog(address ethlink) returns(bool){
if((msg.sender!=owner)&&(msg.sender!=controller))throw;
logs.push(log(ethlink,block.number));
return true;
}
 
//add a new post at the end of the log
function createLog() returns(bool){
if((msg.sender!=owner)&&(msg.sender!=controller))throw;
address a=new microlog(msg.sender);
logs.push(log(a,block.number));
return true;
}
 
//edit a specific post at a given index
function editPost(uint index,address ethlink) returns(bool){
if((msg.sender!=owner)&&(msg.sender!=controller))throw;
logs[index]=log(ethlink,block.number);
return true;
}
 
//read the logs by index
function readLog(uint i)constant returns(uint,address,uint){
log l=logs[i];
return(logs.length,l.ethlink,l.blocknumber);
}

//the logs container
log[] logs;
//used to know in advance the logs structure
string public logInterface="a-Log|u-Block";

    struct log{
    address ethlink;
    uint blocknumber;
   }
 
 
//destroy blog
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}
 
}

contract universalBox{
address public owner; //standard needed for Alpha Layer and generic augmentation
address public controller; //allowed to post, share and edit logs
string standard="BLOCKLOG.1.0";  //the blog standard
uint public logcount;
 
//creation
function universalBox(address o) {
owner=o;
logcount=1;
logs.push(log(o,block.number,0,1));
}

//change owner
function manager(address o)returns(bool){
if(msg.sender!=owner)throw;
owner=o;
return true;
}

//change owner
function setController(address o)returns(bool){
if(msg.sender!=owner)throw;
controller=o;
return true;
}
 
//add a new post at the end of the log
function shareLog(address ethlink) returns(bool){
if((msg.sender!=owner)&&(msg.sender!=controller))throw;
logs.push(log(ethlink,block.number));
return true;
}
 
//add a new post at the end of the log
function createLog() returns(bool){
if((msg.sender!=owner)&&(msg.sender!=controller))throw;
address a=new microlog(msg.sender);
logs.push(log(a,block.number,logcount-1,logcount+1));
logcount++;
return true;
}
 
//edit a specific post at a given index
function editPost(uint index,address ethlink) returns(bool){
if((msg.sender!=owner)&&(msg.sender!=controller))throw;
logs[index]=log(ethlink,block.number);
return true;
}

//delete a specific post at a given index
function deletePost(uint index,address ethlink) returns(bool){
if((msg.sender!=owner)&&(msg.sender!=controller))throw;
log l=logs[index];
logs[l.prev].next=l.next;
logs[l.next].next=l.prev;
return true;
}
 
//read the logs by index
function readLog(uint i)constant returns(uint,address,uint,uint,uint,uint){
log l=logs[i];
return(logs.length,l.ethlink,l.blocknumber,l.prev,l.next,logcount);
}

//the logs container
log[] logs;
//used to know in advance the logs structure
string public logInterface="a-Log|u-Block|u-PrevLog|u-NextLog|u-TotExposed";

    struct log{
    address ethlink;
    uint blocknumber;
    uint prev;
    uint next;
   }
 
 
//destroy blog
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}
 
}
 
contract minilog{
address public owner;
function log(address own,string title,string content,string media,string link,address ethlink){owner=own;}
}

contract microlog{
address public owner;
function log(address own){owner=own;}
}
