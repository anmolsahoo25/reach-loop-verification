'reach 0.1';

const ParticipantInterface = {
  log: Fun(true, Null)
};

export const main = Reach.App(() => {
  const A = Participant('A', {
    ...ParticipantInterface
  });

  const B = Participant('B', {
    ...ParticipantInterface
  });

  deploy();

  // Enter consensus step to execute while loop
  A.publish();

  var [] = [];                          // not binding any mutable loop variables 
  invariant(balance() <= 100);          // loop invariant L = balance() <= 100
  while(balance() < 100) {              // loop condition C = balance() <  100
      if(balance() > 90) {              // pay difference if value > 90 
        commit();
        const toPay = 100 - balance();  
        A.pay(toPay); 
        A.interact.log(["A paid", toPay]);
      } else {                          // else pay 10 tokens
        commit();
        A.pay(10);                      
        A.interact.log(["A paid", 10]);
      }

      [] = [];                          // no updates to mutable variables
      continue;                         // continue loop
  }

  // Transfer tokens back to A
  transfer(100).to(A);
  commit();

  // Exit program
  exit();
});
