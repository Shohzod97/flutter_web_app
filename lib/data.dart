var invent7 = 0;
var invent15 = 0;
var invent35 = 0;

var countPeople = 0;
var rewardRef = 0;
var pointsMP = 0;

void setReawrdMP() {
  countPeople = invent7 + invent15 + invent35;
  pointsMP = invent7*50 + invent15*110 + invent35*280;
  rewardRef = invent7*1500 + invent15*4000 + invent35*7000;
}

//////
var rewardPercent = 10;
var leftB = 0;
var rightB = 0;
num rewardTO = 0.0;

void setTOReward() {
  // var formdata = formstate.currentState;
  var min = leftB<rightB? leftB : rightB;
  print(min);
  rewardTO = (min/50)*7000*rewardPercent*0.01;
  print(rewardTO);

}

///////////

var currentQual = '';
var rewardQual = 0;

void setQualReward() => {

  if(leftB==3000 && rightB==3000) {
    currentQual = 'Серебро',
    rewardQual = 18000,
  },

  if(leftB==6000 && rightB==6000) {
    currentQual = 'Золото',
    rewardQual = 36000,
  },

  if(leftB==12000 && rightB==12000) {
    currentQual = 'Бриллиант',
    rewardQual = 72000,
  },
};

///////////////////

var premiumPercent = 26.5;

var premium35 = 0;   //кол-во купленных за 35 т.
var premium40 = 0;
num premiumReward = 0.0;

void setPremiumReward() {
  if((premium35+premium40)>=7)
    premiumReward = (premium35*35000 + premium40*40000)*premiumPercent*0.01;
  else
    premiumReward=0;
}
