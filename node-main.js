// node-main.js
const fs = require("fs");
const wasmBytes = fs.readFileSync("./techdraw.wasm");

(async () => {
  const { instance } = await WebAssembly.instantiate(wasmBytes, {
    env: {
      /* ggf. Imports für RTS/WASI/FFI */
    },
  });

  // Beispiel: C-Style Export
  const ptr = instance.exports.hs_render_sensor_svg();
  // Hier: String aus dem WASM-Heap lesen (abhängig vom Runtime-Layout

  const svg = readCStringFromMemory(instance.exports, ptr); //Hilfsfunktion
  fs.writeFileSync("sensor-from-wasm.svg", svg);
})();
