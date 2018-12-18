;; BEGIN HEADER

.class public large_program_fac
.super java/lang/Object

.method public <init>()V
  .limit locals 1

  aload_0
  invokespecial java/lang/Object/<init>()V
  return

.end method

.method public static main([Ljava/lang/String;)V
  .limit locals 1
  .limit stack  1

  invokestatic large_program_fac/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; printInt (fac (10)) ;
  ldc 10
  invokestatic large_program_fac/fac(I)I
  invokestatic Runtime/printInt(I)V
  ;; printInt (rfac (10)) ;
  ldc 10
  invokestatic large_program_fac/rfac(I)I
  invokestatic Runtime/printInt(I)V
  ;; printInt (mfac (10)) ;
  ldc 10
  invokestatic large_program_fac/mfac(I)I
  invokestatic Runtime/printInt(I)V
  ;; printInt (ifac (10)) ;
  ldc 10
  invokestatic large_program_fac/ifac(I)I
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method

.method public static fac(I)I
  .limit locals 100
  .limit stack  100
  ;; int r ;
  ;; int n ;
  ;; r = 1 ;
  ldc 1
  dup
  istore 1
  pop
  ;; n = a ;
  iload 0
  dup
  istore 2
  pop
  ;; while (n > 0)
  L0:
  ldc 1
  iload 2
  ldc 0
  if_icmpgt L2
  pop
  ldc 0
  L2:
  ifeq L1
  ;; r = r * n ;
  iload 1
  iload 2
  imul
  dup
  istore 1
  pop
  ;; n = n - 1 ;
  iload 2
  ldc 1
  isub
  dup
  istore 2
  pop
  goto L0
  L1:
  ;; return r ;
  iload 1
  ireturn
return
.end method

.method public static rfac(I)I
  .limit locals 100
  .limit stack  100
  ;; int f ;
  ;; if (n == 0)
  ldc 1
  iload 0
  ldc 0
  if_icmpeq L5
  pop
  ldc 0
  L5:
  ifeq L3
  ;; f = 1 ;
  ldc 1
  dup
  istore 1
  pop
  goto L4
  L3:
  ;; f = n * rfac (n - 1);
  iload 0
  iload 0
  ldc 1
  isub
  invokestatic large_program_fac/rfac(I)I
  imul
  dup
  istore 1
  pop
  L4:
  ;; return f ;
  iload 1
  ireturn
return
.end method

.method public static mfac(I)I
  .limit locals 100
  .limit stack  100
  ;; int f ;
  ;; if (n == 0)
  ldc 1
  iload 0
  ldc 0
  if_icmpeq L8
  pop
  ldc 0
  L8:
  ifeq L6
  ;; f = 1 ;
  ldc 1
  dup
  istore 1
  pop
  goto L7
  L6:
  ;; f = n * nfac (n - 1);
  iload 0
  iload 0
  ldc 1
  isub
  invokestatic large_program_fac/nfac(I)I
  imul
  dup
  istore 1
  pop
  L7:
  ;; return f ;
  iload 1
  ireturn
return
.end method

.method public static nfac(I)I
  .limit locals 100
  .limit stack  100
  ;; int f ;
  ;; if (n != 0)
  ldc 1
  iload 0
  ldc 0
  if_icmpne L11
  pop
  ldc 0
  L11:
  ifeq L9
  ;; f = mfac (n - 1)* n ;
  iload 0
  ldc 1
  isub
  invokestatic large_program_fac/mfac(I)I
  iload 0
  imul
  dup
  istore 1
  pop
  goto L10
  L9:
  ;; f = 1 ;
  ldc 1
  dup
  istore 1
  pop
  L10:
  ;; return f ;
  iload 1
  ireturn
return
.end method

.method public static ifac(I)I
  .limit locals 100
  .limit stack  100
  ;; return ifac2f (1, n);
  ldc 1
  iload 0
  invokestatic large_program_fac/ifac2f(II)I
  ireturn
return
.end method

.method public static ifac2f(II)I
  .limit locals 100
  .limit stack  100
  ;; int f ;
  ;; if (l == h)
  ldc 1
  iload 0
  iload 1
  if_icmpeq L14
  pop
  ldc 0
  L14:
  ifeq L12
  ;; f = l ;
  iload 0
  dup
  istore 2
  pop
  goto L13
  L12:
  ;; if (l > h)
  ldc 1
  iload 0
  iload 1
  if_icmpgt L17
  pop
  ldc 0
  L17:
  ifeq L15
  ;; f = 1 ;
  ldc 1
  dup
  istore 2
  pop
  goto L16
  L15:
  ;; int m ;
  ;; m = (l + h)/ 2 ;
  iload 0
  iload 1
  iadd
  ldc 2
  idiv
  dup
  istore 3
  pop
  ;; f = ifac2f (l, m)* ifac2f (m + 1, h);
  iload 0
  iload 3
  invokestatic large_program_fac/ifac2f(II)I
  iload 3
  ldc 1
  iadd
  iload 1
  invokestatic large_program_fac/ifac2f(II)I
  imul
  dup
  istore 2
  pop
  L16:
  L13:
  ;; return f ;
  iload 2
  ireturn
return
.end method
