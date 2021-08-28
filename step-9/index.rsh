'reach 0.1';

const Interface = {
    log: Fun(true, Null)
}

export const main = Reach.App(() => {
    const A = Participant('A', {
        ...Interface
    });
    
    const B = Participant('B', {
        ...Interface
    });

    deploy();

    A.publish();

    const k = 100 + 10;

    var [poolA, poolB, round] = [100,10,0];
    invariant(balance() == 0 && poolA + poolB == k);
    while(round < 5) {
        commit();

        A.interact.log(["Round: ", round]);

        const toSwapA = 10;
        const balanceA = poolA - toSwapA;

        const balanceB = k - balanceA;
        const toSwapB = balanceB - poolB;

        A.publish();

        A.interact.log(["Swap A", "Swap B"]);
        A.interact.log([toSwapA, toSwapB]);
        A.interact.log(["Balance A", "Balance B"]);
        A.interact.log([balanceA, balanceB]);

        [round, poolA, poolB] = [round + 1, balanceA, balanceB];
        continue;
    }
    assert(poolA + poolB == k);

    commit();

    exit();
});
