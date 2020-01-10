(module
  ;; 0-64 reserved for param block
  (memory (export "memory") 10 1000)

  (func $core_hchacha20 (param $out_ptr i32) (param $in_ptr i32) (param $key_ptr i32)
    (local $i i32)
    (local $x0 i32)
    (local $x1 i32)
    (local $x2 i32)
    (local $x3 i32)
    (local $x4 i32)
    (local $x5 i32)
    (local $x6 i32)
    (local $x7 i32)
    (local $x8 i32)
    (local $x9 i32)
    (local $x10 i32)
    (local $x11 i32)
    (local $x12 i32)
    (local $x13 i32)
    (local $x14 i32)
    (local $x15 i32)

    (set_local $x0 (i32.const 0x61707865))
    (set_local $x1 (i32.const 0x3320646e))
    (set_local $x2 (i32.const 0x79622d32))
    (set_local $x3 (i32.const 0x6b206574))

    (set_local $x4 (i32.load (get_local $key_ptr)))
    (set_local $x5 (i32.load (i32.add (get_local $key_ptr) (i32.const 4))))
    (set_local $x6 (i32.load (i32.add (get_local $key_ptr) (i32.const 8))))
    (set_local $x7 (i32.load (i32.add (get_local $key_ptr) (i32.const 12))))
    (set_local $x8 (i32.load (i32.add (get_local $key_ptr) (i32.const 16))))
    (set_local $x9 (i32.load (i32.add (get_local $key_ptr) (i32.const 20))))
    (set_local $x10 (i32.load (i32.add (get_local $key_ptr) (i32.const 24))))
    (set_local $x11 (i32.load (i32.add (get_local $key_ptr) (i32.const 28))))
    (set_local $x12 (i32.load (get_local $in_ptr)))
    (set_local $x13 (i32.load (i32.add (get_local $in_ptr) (i32.const 4))))
    (set_local $x14 (i32.load (i32.add (get_local $in_ptr) (i32.const 8))))
    (set_local $x15 (i32.load (i32.add (get_local $in_ptr) (i32.const 12))))

    (set_local $i (i32.const 0))
    (block $end_loopa
      (loop $start_loop
        (br_if $end_loop (i32.le_u (get_local $i) (i32.const 10)))
        ;; See https://github.com/jedisct1/libsodium/blob/master/src/libsodium/crypto_core/hchacha20/core_hchacha20.c
        ;; See https://github.com/jedisct1/libsodium/blob/master/src/libsodium/crypto_core/hsalsa20/ref2/core_hsalsa20_ref2.c#L17
        ;; See https://github.com/mafintosh/xsalsa20/blob/master/xsalsa20.wat#L173

        ;; QUARTERROUND(x0, x4,  x8, x12);
        ;; A += B; D = ROTL32(D ^ A, 16);
        ;; C += D; B = ROTL32(B ^ C, 12);
        ;; A += B; D = ROTL32(D ^ A,  8);
        ;; C += D; B = ROTL32(B ^ C,  7);

        ;; QUARTERROUND(x1, x5,  x9, x13);
        ;; A += B; D = ROTL32(D ^ A, 16);
        ;; C += D; B = ROTL32(B ^ C, 12);
        ;; A += B; D = ROTL32(D ^ A,  8);
        ;; C += D; B = ROTL32(B ^ C,  7);

        ;; QUARTERROUND(x2, x6, x10, x14);
        ;; A += B; D = ROTL32(D ^ A, 16);
        ;; C += D; B = ROTL32(B ^ C, 12);
        ;; A += B; D = ROTL32(D ^ A,  8);
        ;; C += D; B = ROTL32(B ^ C,  7);

        ;; QUARTERROUND(x3, x7, x11, x15);
        ;; A += B; D = ROTL32(D ^ A, 16);
        ;; C += D; B = ROTL32(B ^ C, 12);
        ;; A += B; D = ROTL32(D ^ A,  8);
        ;; C += D; B = ROTL32(B ^ C,  7);

        ;; QUARTERROUND(x0, x5, x10, x15);
        ;; A += B; D = ROTL32(D ^ A, 16);
        ;; C += D; B = ROTL32(B ^ C, 12);
        ;; A += B; D = ROTL32(D ^ A,  8);
        ;; C += D; B = ROTL32(B ^ C,  7);

        ;; QUARTERROUND(x1, x6, x11, x12);
        ;; A += B; D = ROTL32(D ^ A, 16);
        ;; C += D; B = ROTL32(B ^ C, 12);
        ;; A += B; D = ROTL32(D ^ A,  8);
        ;; C += D; B = ROTL32(B ^ C,  7);

        ;; QUARTERROUND(x2, x7,  x8, x13);
        ;; A += B; D = ROTL32(D ^ A, 16);
        ;; C += D; B = ROTL32(B ^ C, 12);
        ;; A += B; D = ROTL32(D ^ A,  8);
        ;; C += D; B = ROTL32(B ^ C,  7);

        ;; QUARTERROUND(x3, x4,  x9, x14);
        ;; A += B; D = ROTL32(D ^ A, 16);
        ;; C += D; B = ROTL32(B ^ C, 12);
        ;; A += B; D = ROTL32(D ^ A,  8);
        ;; C += D; B = ROTL32(B ^ C,  7);

        (set_local $i (i32.add (get_local $i) (i32.const 1)))
      )
    )

    (i32.store (get_local $out_ptr) (get_local $x0))
    (i32.store (i32.add (get_local $out_ptr) (i32.const 4)) (get_local $x1))
    (i32.store (i32.add (get_local $out_ptr) (i32.const 8)) (get_local $x2))
    (i32.store (i32.add (get_local $out_ptr) (i32.const 12)) (get_local $x3))
    (i32.store (i32.add (get_local $out_ptr) (i32.const 16)) (get_local $x12))
    (i32.store (i32.add (get_local $out_ptr) (i32.const 20)) (get_local $x13))
    (i32.store (i32.add (get_local $out_ptr) (i32.const 24)) (get_local $x14))
    (i32.store (i32.add (get_local $out_ptr) (i32.const 28)) (get_local $x15))
  )

  (func (export "core_hchacha20") (param $out_ptr i32) (param $in_ptr i32) (param $key_ptr i32)
    (call $core_hchacha20 (get_local $out_ptr) (get_local $in_ptr) (get_local $key_ptr))
  )
)
