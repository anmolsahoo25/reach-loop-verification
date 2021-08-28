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

  A.interact.log(["Testing app", 0]);
  B.interact.log(["Testing app", 0]);

  exit();
});
