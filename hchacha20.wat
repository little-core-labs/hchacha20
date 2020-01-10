(module
  ;; 0-64 reserved for param block
  (memory (export "memory") 10 1000)

  ;; Reference https://github.com/jedisct1/libsodium/blob/41c7e47efd879e31504dbe9b2a46426f4551ac60/src/libsodium/crypto_core/hchacha20/core_hchacha20.c#L17
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
    (block $end_loop
      (loop $start_loop
        (br_if $end_loop (i32.le_u (get_local $i) (i32.const 10)))
        ;; See https://github.com/jedisct1/libsodium/blob/master/src/libsodium/crypto_core/hchacha20/core_hchacha20.c
        ;; See https://github.com/jedisct1/libsodium/blob/master/src/libsodium/crypto_core/hsalsa20/ref2/core_hsalsa20_ref2.c#L17
        ;; See https://github.com/mafintosh/xsalsa20/blob/master/xsalsa20.wat#L173

        ;; #define QUARTERROUND(A, B, C, D)     \
        ;; do {                               \
        ;;   A += B; D = ROTL32(D ^ A, 16); \
        ;;   C += D; B = ROTL32(B ^ C, 12); \
        ;;   A += B; D = ROTL32(D ^ A,  8); \
        ;;   C += D; B = ROTL32(B ^ C,  7); \
        ;; } while(0)

        (set_local $A (i32.add (get_local $A) (get_local $B)))
        (set_local $D (i32.rotl (i32.xor (get_local $D) (get_local $A)) (i32.const 16)))
        (set_local $C (i32.add (get_local $C) (get_local $D)))
        (set_local $B (i32.rotl (i32.xor (get_local $B) (get_local $C)) (i32.const 12)))
        (set_local $A (i32.add (get_local $A) (get_local $B)))
        (set_local $D (i32.rotl (i32.xor (get_local $D) (get_local $A)) (i32.const 8)))
        (set_local $C (i32.add (get_local $C) (get_local $D)))
        (set_local $B (i32.rotl (i32.xor (get_local $B) (get_local $C)) (i32.const 7)))

        ;; QUARTERROUND(x0, x4, x8, x12);
        ;; x0 += x4; x12 = ROTL32(x12 ^ x0, 16);
        ;; x8 += x12; x4 = ROTL32(x4 ^ x8, 12);
        ;; x0 += x4; x12 = ROTL32(x12 ^ x0,  8);
        ;; x8 += x12; x4 = ROTL32(x4 ^ x8,  7);
        (set_local $x0 (i32.add (get_local $x0) (get_local $x4)))
        (set_local $x12 (i32.rotl (i32.xor (get_local $x12) (get_local $x0)) (i32.const 16)))
        (set_local $x8 (i32.add (get_local $x8) (get_local $x12)))
        (set_local $x4 (i32.rotl (i32.xor (get_local $x4) (get_local $x8)) (i32.const 12)))
        (set_local $x0 (i32.add (get_local $x0) (get_local $x4)))
        (set_local $x12 (i32.rotl (i32.xor (get_local $x12) (get_local $x0)) (i32.const 8)))
        (set_local $x8 (i32.add (get_local $x8) (get_local $x12)))
        (set_local $x4 (i32.rotl (i32.xor (get_local $x4) (get_local $x8)) (i32.const 7)))


        ;; QUARTERROUND(x1, x5,  x9, x13);
        ;; x1 += x5; x13 = ROTL32(x13 ^ x1, 16);
        ;; x9 += x13; x5 = ROTL32(x5 ^ x9, 12);
        ;; x1 += x5; x13 = ROTL32(x13 ^ x1,  8);
        ;; x9 += x13; x5 = ROTL32(x5 ^ x9,  7);
        (set_local $x1 (i32.add (get_local $x1) (get_local $x5)))
        (set_local $x13 (i32.rotl (i32.xor (get_local $x13) (get_local $x1)) (i32.const 16)))
        (set_local $x9 (i32.add (get_local $x9) (get_local $x13)))
        (set_local $x5 (i32.rotl (i32.xor (get_local $x5) (get_local $x9)) (i32.const 12)))
        (set_local $x1 (i32.add (get_local $x1) (get_local $x5)))
        (set_local $x13 (i32.rotl (i32.xor (get_local $x13) (get_local $x1)) (i32.const 8)))
        (set_local $x9 (i32.add (get_local $x9) (get_local $x13)))
        (set_local $x5 (i32.rotl (i32.xor (get_local $x5) (get_local $x9)) (i32.const 7)))

        ;; QUARTERROUND(x2, x6, x10, x14);
        ;; x2 += x6; x14 = ROTL32(x14 ^ x2, 16);
        ;; x10 += x14; x6 = ROTL32(x6 ^ x10, 12);
        ;; x2 += x6; x14 = ROTL32(x14 ^ x2,  8);
        ;; x10 += x14; x6 = ROTL32(x6 ^ x10,  7);
        (set_local $x2 (i32.add (get_local $x2) (get_local $x6)))
        (set_local $x14 (i32.rotl (i32.xor (get_local $x14) (get_local $x2)) (i32.const 16)))
        (set_local $x10 (i32.add (get_local $x10) (get_local $x14)))
        (set_local $x6 (i32.rotl (i32.xor (get_local $x6) (get_local $x10)) (i32.const 12)))
        (set_local $x2 (i32.add (get_local $x2) (get_local $x6)))
        (set_local $x14 (i32.rotl (i32.xor (get_local $x14) (get_local $x2)) (i32.const 8)))
        (set_local $x10 (i32.add (get_local $x10) (get_local $x14)))
        (set_local $x6 (i32.rotl (i32.xor (get_local $x6) (get_local $x10)) (i32.const 7)))

        ;; QUARTERROUND(x3, x7, x11, x15);
        ;; x3 += x7; x15 = ROTL32(x15 ^ x3, 16);
        ;; x11 += x15; x7 = ROTL32(x7 ^ x11, 12);
        ;; x3 += x7; x15 = ROTL32(x15 ^ x3,  8);
        ;; x11 += x15; x7 = ROTL32(x7 ^ x11,  7);
        (set_local $x3 (i32.add (get_local $x3) (get_local $x7)))
        (set_local $x15 (i32.rotl (i32.xor (get_local $x15) (get_local $x3)) (i32.const 16)))
        (set_local $x11 (i32.add (get_local $x11) (get_local $x15)))
        (set_local $x7 (i32.rotl (i32.xor (get_local $x7) (get_local $x11)) (i32.const 12)))
        (set_local $x3 (i32.add (get_local $x3) (get_local $x7)))
        (set_local $x15 (i32.rotl (i32.xor (get_local $x15) (get_local $x3)) (i32.const 8)))
        (set_local $x11 (i32.add (get_local $x11) (get_local $x15)))
        (set_local $x7 (i32.rotl (i32.xor (get_local $x7) (get_local $x11)) (i32.const 7)))

        ;; QUARTERROUND(x0, x5, x10, x15);
        ;; x0 += x5; x15 = ROTL32(x15 ^ x0, 16);
        ;; x10 += x15; x5 = ROTL32(x5 ^ x10, 12);
        ;; x0 += x5; x15 = ROTL32(x15 ^ x0,  8);
        ;; x10 += x15; x5 = ROTL32(x5 ^ x10,  7);
        (set_local $x0 (i32.add (get_local $x0) (get_local $x5)))
        (set_local $x15 (i32.rotl (i32.xor (get_local $x15) (get_local $x0)) (i32.const 16)))
        (set_local $x10 (i32.add (get_local $x10) (get_local $x15)))
        (set_local $x5 (i32.rotl (i32.xor (get_local $x5) (get_local $x10)) (i32.const 12)))
        (set_local $x0 (i32.add (get_local $x0) (get_local $x5)))
        (set_local $x15 (i32.rotl (i32.xor (get_local $x15) (get_local $x0)) (i32.const 8)))
        (set_local $x10 (i32.add (get_local $x10) (get_local $x15)))
        (set_local $x5 (i32.rotl (i32.xor (get_local $x5) (get_local $x10)) (i32.const 7)))

        ;; QUARTERROUND(x1, x6, x11, x12);
        ;; x1 += x6; x12 = ROTL32(x12 ^ x1, 16);
        ;; x11 += x12; x6 = ROTL32(x6 ^ x11, 12);
        ;; x1 += x6; x12 = ROTL32(x12 ^ x1,  8);
        ;; x11 += x12; x6 = ROTL32(x6 ^ x11,  7);
        (set_local $x1 (i32.add (get_local $x1) (get_local $x6)))
        (set_local $x12 (i32.rotl (i32.xor (get_local $x12) (get_local $x1)) (i32.const 16)))
        (set_local $x11 (i32.add (get_local $x11) (get_local $x12)))
        (set_local $x6 (i32.rotl (i32.xor (get_local $x6) (get_local $x11)) (i32.const 12)))
        (set_local $x1 (i32.add (get_local $x1) (get_local $x6)))
        (set_local $x12 (i32.rotl (i32.xor (get_local $x12) (get_local $x1)) (i32.const 8)))
        (set_local $x11 (i32.add (get_local $x11) (get_local $x12)))
        (set_local $x6 (i32.rotl (i32.xor (get_local $x6) (get_local $x11)) (i32.const 7)))

        ;; QUARTERROUND(x2, x7,  x8, x13);
        ;; x2 += x7; x13 = ROTL32(x13 ^ x2, 16);
        ;; x8 += x13; x7 = ROTL32(x7 ^ x8, 12);
        ;; x2 += x7; x13 = ROTL32(x13 ^ x2,  8);
        ;; x8 += x13; x7 = ROTL32(x7 ^ x8,  7);
        (set_local $x2 (i32.add (get_local $x2) (get_local $x7)))
        (set_local $x13 (i32.rotl (i32.xor (get_local $x13) (get_local $x2)) (i32.const 16)))
        (set_local $x8 (i32.add (get_local $x8) (get_local $x13)))
        (set_local $x7 (i32.rotl (i32.xor (get_local $x7) (get_local $x8)) (i32.const 12)))
        (set_local $x2 (i32.add (get_local $x2) (get_local $x7)))
        (set_local $x13 (i32.rotl (i32.xor (get_local $x13) (get_local $x2)) (i32.const 8)))
        (set_local $x8 (i32.add (get_local $x8) (get_local $x13)))
        (set_local $x7 (i32.rotl (i32.xor (get_local $x7) (get_local $x8)) (i32.const 7)))

        ;; QUARTERROUND(x3, x4,  x9, x14);
        ;; x3 += x4; x14 = ROTL32(x14 ^ x3, 16);
        ;; x9 += x14; x4 = ROTL32(x4 ^ x9, 12);
        ;; x3 += x4; x14 = ROTL32(x14 ^ x3,  8);
        ;; x9 += x14; x4 = ROTL32(x4 ^ x9,  7);
        (set_local $x3 (i32.add (get_local $x3) (get_local $x4)))
        (set_local $x14 (i32.rotl (i32.xor (get_local $x14) (get_local $x3)) (i32.const 16)))
        (set_local $x9 (i32.add (get_local $x9) (get_local $x14)))
        (set_local $x4 (i32.rotl (i32.xor (get_local $x4) (get_local $x9)) (i32.const 12)))
        (set_local $x3 (i32.add (get_local $x3) (get_local $x4)))
        (set_local $x14 (i32.rotl (i32.xor (get_local $x14) (get_local $x3)) (i32.const 8)))
        (set_local $x9 (i32.add (get_local $x9) (get_local $x14)))
        (set_local $x4 (i32.rotl (i32.xor (get_local $x4) (get_local $x9)) (i32.const 7)))

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
