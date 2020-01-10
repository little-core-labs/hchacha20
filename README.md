# hchacha20
[![Actions Status](https://github.com/bcomnes/hchacha20/workflows/tests/badge.svg)](https://github.com/bcomnes/hchacha20/actions)

WIP - nothing to see here

```
npm install hchacha20
```

## Notes:

Reference for hchacha20:

Sodium: https://github.com/jedisct1/libsodium/blob/927dfe8e2eaa86160d3ba12a7e3258fbc322909c/src/libsodium/crypto_core/hchacha20/core_hchacha20.c

Needed to implement: https://github.com/jedisct1/libsodium/blob/927dfe8e2eaa86160d3ba12a7e3258fbc322909c/src/libsodium/crypto_aead/xchacha20poly1305/sodium/aead_xchacha20poly1305.c#L121-L144

Reference for hsalsa20:

Sodium: https://github.com/jedisct1/libsodium/blob/master/src/libsodium/crypto_core/hsalsa20/ref2/core_hsalsa20_ref2.c#L17

WAT: https://github.com/mafintosh/xsalsa20/blob/master/xsalsa20.wat#L173

## Usage

``` js
const hchacha20 = require('hchacha20')
```

## See also


- [xchacha20-js](https://github.com/paragonie/xchacha20-js)

## License

MIT
