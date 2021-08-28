'reach 0.1';

const ParticipantInterface = {
    log: Fun(true, Null)
};

export const main = Reach.App(() => {
  const A = Participant('A', {
    ...ParticipantInterface
  });

  deploy();

  // Enter consensus step to execute while loop
  A.publish();

  var [] = [];                 // not binding any mutable loop variables 
  invariant(balance() <= 100); // loop invariant L = balance() <= 100
  while(balance() < 100) {     // loop condition C = balance() <  100
      commit();                // commit consensus step, so all participants agree on control-flow
      A.pay(10);               // transer tokens and enter consensus step
      [] = [];                 // no updates to mutable variables
      continue;                // continue dominated by consensus communication at pay
  }

  // Transfer tokens back to A
  transfer(100).to(A);
  commit();

  // Exit program
  exit();
});
