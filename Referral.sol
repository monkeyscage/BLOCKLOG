pragma solidity 0.4.8;

contract referralContract{

    address public owner;
    uint public referrals;
    uint public referrals2;
    uint public status;

    mapping(address => bool)public isreferral2Address;
    mapping(address => bool)public isreferralAddress;
    mapping(address => address)public referralReferrer;
    mapping(address => uint)public myReferred;

    function referralContract(){owner=msg.sender; status=0;}

    function setStatus(uint u){status=u;}

    function setReferral(address me,address ref){
       if((status<2)&&(me!=ref)&&((isreferral2Address[ref])||(ref==owner))){
          referrals++;
          isreferralAddress[me]=true;
          referralReferrer[me]=ref;
          myReferred[ref]++;
          if(status<1){
             isreferral2Address[me]=true;
             if(ref!=owner)referrals2++;
          }
       }else{throw;}
    }
}
