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
    })

    // deploy app
    deploy();
    
    // enter both participants in consensus steps
    // so that participants stay consistent across
    // loop iterations
    A.publish();
    commit();
    B.publish();

    var [shareA, shareB, round] = [0, 0, 0];                  // binding loop variables
    invariant(shareA == shareB);                              // loop invariant
    while(round < 5) {                                        // loop condition
        A.interact.log(["Round: ", round]);                   
        A.interact.log(["Share A", "Share B"]);               
        A.interact.log([shareA, shareB]);                     

        commit();                                             

        const roundValue = round * 100;                       // amount A pays

        A.pay(roundValue);                                    
        A.interact.log(["A pays: ", roundValue]);             

        var [shareBL] = [shareB];                             // binding loop variables for nested loop
        invariant(shareBL <= shareA + roundValue);            // loop invariant
        while(shareBL < shareA + roundValue) {                // loop condition
            const toPayB = shareA + roundValue - shareBL;     // difference B needs to pay
            if(toPayB < 50) {
                commit();   
                B.pay(toPayB);
                B.interact.log(["B pays: ", toPayB]);
                [shareBL] = [shareBL + toPayB];     
                continue;
            } else {                                          // B pays 50
                commit();
                B.pay(50);                                  
                B.interact.log(["B pays: ", 50]);
                [shareBL] = [shareBL + 50];
                continue;
            };
        }
        assert(shareBL == shareA + roundValue);               // inner loop assertion

        [round, shareA, shareB] =                     
          [round + 1, shareA + roundValue, shareBL];
        continue;
    }
    assert(shareA == shareB);                                 // outer loop assertion

    A.interact.log(["Share A", "Share B"]);
    A.interact.log([shareA, shareB]);

    transfer(balance()).to(A);
    commit();

    // exit app
    exit();
});
