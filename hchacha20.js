
module.exports = loadWebAssembly

loadWebAssembly.supported = typeof WebAssembly !== 'undefined'

function loadWebAssembly (opts) {
  if (!loadWebAssembly.supported) return null

  var imp = opts && opts.imports
  var wasm = toUint8Array('AGFzbQEAAAABBwFgA39/fwADAwIAAAUFAQEK6AcHGwIGbWVtb3J5AgAOY29yZV9oY2hhY2hhMjAAAQqpBgKbBgERf0Hl8MGLBiEEQe7IgZkDIQVBstqIywchBkH0yoHZBiEHIAIoAgAhCCACQQRqKAIAIQkgAkEIaigCACEKIAJBDGooAgAhCyACQRBqKAIAIQwgAkEUaigCACENIAJBGGooAgAhDiACQRxqKAIAIQ8gASgCACEQIAFBBGooAgAhESABQQhqKAIAIRIgAUEMaigCACETQQAhAwJAA0AgA0EKTQ0BIAQgCGohBCAQIARzQRB3IRAgDCAQaiEMIAggDHNBDHchCCAEIAhqIQQgECAEc0EIdyEQIAwgEGohDCAIIAxzQQd3IQggBSAJaiEFIBEgBXNBEHchESANIBFqIQ0gCSANc0EMdyEJIAUgCWohBSARIAVzQQh3IREgDSARaiENIAkgDXNBB3chCSAGIApqIQYgEiAGc0EQdyESIA4gEmohDiAKIA5zQQx3IQogBiAKaiEGIBIgBnNBCHchEiAOIBJqIQ4gCiAOc0EHdyEKIAcgC2ohByATIAdzQRB3IRMgDyATaiEPIAsgD3NBDHchCyAHIAtqIQcgEyAHc0EIdyETIA8gE2ohDyALIA9zQQd3IQsgBCAJaiEEIBMgBHNBEHchEyAOIBNqIQ4gCSAOc0EMdyEJIAQgCWohBCATIARzQQh3IRMgDiATaiEOIAkgDnNBB3chCSAFIApqIQUgECAFc0EQdyEQIA8gEGohDyAKIA9zQQx3IQogBSAKaiEFIBAgBXNBCHchECAPIBBqIQ8gCiAPc0EHdyEKIAYgC2ohBiARIAZzQRB3IREgDCARaiEMIAsgDHNBDHchCyAGIAtqIQYgESAGc0EIdyERIAwgEWohDCALIAxzQQd3IQsgByAIaiEHIBIgB3NBEHchEiANIBJqIQ0gCCANc0EMdyEIIAcgCGohByASIAdzQQh3IRIgDSASaiENIAggDXNBB3chCCADQQFqIQMLCyAAIAQ2AgAgAEEEaiAFNgIAIABBCGogBjYCACAAQQxqIAc2AgAgAEEQaiAQNgIAIABBFGogETYCACAAQRhqIBI2AgAgAEEcaiATNgIACwoAIAAgASACEAAL')
  var ready = null

  var mod = {
    buffer: wasm,
    memory: null,
    exports: null,
    realloc: realloc,
    onload: onload
  }

  onload(function () {})

  return mod

  function realloc (size) {
    mod.exports.memory.grow(Math.max(0, Math.ceil(Math.abs(size - mod.memory.length) / 65536)))
    mod.memory = new Uint8Array(mod.exports.memory.buffer)
  }

  function onload (cb) {
    if (mod.exports) return cb()

    if (ready) {
      ready.then(cb.bind(null, null)).catch(cb)
      return
    }

    try {
      if (opts && opts.async) throw new Error('async')
      setup({instance: new WebAssembly.Instance(new WebAssembly.Module(wasm), imp)})
    } catch (err) {
      ready = WebAssembly.instantiate(wasm, imp).then(setup)
    }

    onload(cb)
  }

  function setup (w) {
    mod.exports = w.instance.exports
    mod.memory = mod.exports.memory && mod.exports.memory.buffer && new Uint8Array(mod.exports.memory.buffer)
  }
}

function toUint8Array (s) {
  if (typeof atob === 'function') return new Uint8Array(atob(s).split('').map(charCodeAt))
  return new (require('buf' + 'fer').Buffer)(s, 'base64')
}

function charCodeAt (c) {
  return c.charCodeAt(0)
}
