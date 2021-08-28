import { loadStdlib } from '@reach-sh/stdlib';
import * as backend from './build/index.main.mjs';
const stdlib = loadStdlib(process.env);

(async () => {
  console.log("[LOG] App: starting application");

  const startBalance = stdlib.parseCurrency(1000);
  const accA = await stdlib.newTestAccount(startBalance);
  const accB = await stdlib.newTestAccount(startBalance);
  const ctcA = accA.deploy(backend);  
  const ctcB = accA.attach(backend, ctcA.getInfo());

  const ParticipantInterface = (who) => {
      log: (msg, value) => console.log(`[LOG] ${who}: ${msg} ${value}`)
  };

  await Promise.all([
    backend.A(ctcA, {
      ...ParticipantInterface("A")
    }),
    backend.B(ctcB, {
      ...ParticipantInterface("B")
    }),
  ]);

  console.log("[LOG] App: exiting application");
})();
