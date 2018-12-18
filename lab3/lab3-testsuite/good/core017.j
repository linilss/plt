;; BEGIN HEADER

.class public core017
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

  invokestatic core017/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int x = 4 ;
  ldc 4
  istore 0
  ;; if (3 <= x && 4 != 2 && true)
  ldc 0
  ldc 0
  ldc 1
  ldc 3
  iload 0
  if_icmple L4
  pop
  ldc 0
  L4:
  ifeq L3
  ldc 1
  ldc 4
  ldc 2
  if_icmpne L5
  pop
  ldc 0
  L5:
  ifeq L3
  pop
  ldc 1
  L3:
  ifeq L2
  ldc 1
  ifeq L2
  pop
  ldc 1
  L2:
  ifeq L0
  ;; printBool (true);
  ldc 1
  invokestatic core017/printBool(Z)V
  goto L1
  L0:
  L1:
  ;; printBool (eq_bool (true, true)|| dontCallMe (1)) ;
  ldc 1
  ldc 1
  ldc 1
  invokestatic core017/eq_bool(ZZ)Z
  ifne L6
  ldc 1
  invokestatic core017/dontCallMe(I)Z
  ifne L6
  pop
  ldc 0
  L6:
  invokestatic core017/printBool(Z)V
  ;; printBool (4 > 50 && dontCallMe (2)) ;
  ldc 0
  ldc 1
  ldc 4
  ldc 50
  if_icmpgt L8
  pop
  ldc 0
  L8:
  ifeq L7
  ldc 2
  invokestatic core017/dontCallMe(I)Z
  ifeq L7
  pop
  ldc 1
  L7:
  invokestatic core017/printBool(Z)V
  ;; printBool (4 == x && eq_bool (true, false)&& true);
  ldc 0
  ldc 0
  ldc 1
  ldc 4
  iload 0
  if_icmpeq L11
  pop
  ldc 0
  L11:
  ifeq L10
  ldc 1
  ldc 0
  invokestatic core017/eq_bool(ZZ)Z
  ifeq L10
  pop
  ldc 1
  L10:
  ifeq L9
  ldc 1
  ifeq L9
  pop
  ldc 1
  L9:
  invokestatic core017/printBool(Z)V
  ;; printBool (implies (false, false)) ;
  ldc 0
  ldc 0
  invokestatic core017/implies(ZZ)Z
  invokestatic core017/printBool(Z)V
  ;; printBool (implies (false, true)) ;
  ldc 0
  ldc 1
  invokestatic core017/implies(ZZ)Z
  invokestatic core017/printBool(Z)V
  ;; printBool (implies (true, false)) ;
  ldc 1
  ldc 0
  invokestatic core017/implies(ZZ)Z
  invokestatic core017/printBool(Z)V
  ;; printBool (implies (true, true)) ;
  ldc 1
  ldc 1
  invokestatic core017/implies(ZZ)Z
  invokestatic core017/printBool(Z)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method

.method public static dontCallMe(I)Z
  .limit locals 100
  .limit stack  100
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return true ;
  ldc 1
  ireturn
return
.end method

.method public static printBool(Z)V
  .limit locals 100
  .limit stack  100
  ;; if (b)
  iload 0
  ifeq L12
  ;; printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V
  goto L13
  L12:
  ;; printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V
  L13:
return
.end method

.method public static implies(ZZ)Z
  .limit locals 100
  .limit stack  100
  ;; return not (x)|| eq_bool (x, y);
  ldc 1
  iload 0
  invokestatic core017/not(Z)Z
  ifne L14
  iload 0
  iload 1
  invokestatic core017/eq_bool(ZZ)Z
  ifne L14
  pop
  ldc 0
  L14:
  ireturn
return
.end method

.method public static not(Z)Z
  .limit locals 100
  .limit stack  100
  ;; bool r ;
  ;; if (x)
  iload 0
  ifeq L15
  ;; r = false ;
  ldc 0
  dup
  istore 1
  pop
  goto L16
  L15:
  ;; r = true ;
  ldc 1
  dup
  istore 1
  pop
  L16:
  ;; return r ;
  iload 1
  ireturn
return
.end method

.method public static eq_bool(ZZ)Z
  .limit locals 100
  .limit stack  100
  ;; bool r ;
  ;; if (x)
  iload 0
  ifeq L17
  ;; r = y ;
  iload 1
  dup
  istore 2
  pop
  goto L18
  L17:
  ;; r = not (y);
  iload 1
  invokestatic core017/not(Z)Z
  dup
  istore 2
  pop
  L18:
  ;; return r ;
  iload 2
  ireturn
return
.end method
