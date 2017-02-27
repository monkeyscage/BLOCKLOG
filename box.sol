contract universalOpenBox{
address public owner; //standard needed for Alpha Layer and generic augmentation
address public controller; //allowed to post, share and edit logs
string standard="OPENBOX.1.0";  //the blog standard
uint public logcount;
 
//creation
function universalOpenBox(address o) {
owner=o;
logcount=1;
logs.push(log(this,block.number,logcount-1,logcount+1));
}

//change owner
function manager(address o)returns(bool){
if(msg.sender!=owner)throw;
owner=o;
return true;
}
 
//add a new post at the end of the log
function shareLog(address ethlink) returns(bool){
log l=logs[logcount-1];
l.next=logcount;
logs.push(log(ethlink,block.number,logcount-1,logcount+1));
logcount++;
return true;
}
 

//delete a specific post at a given index
function deletePost(uint index,address ethlink) returns(bool){
if((msg.sender!=owner)&&(msg.sender!=controller))throw;
log l=logs[index];
if(l.prev>0)logs[l.prev].next=l.next;
logs[l.next].prev=l.prev;
logcount--;
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
