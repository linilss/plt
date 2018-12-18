;; BEGIN HEADER

.class public return_in_if_right
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

  invokestatic return_in_if_right/main()I
  pop
  return

.end method

;; END HEADER

.method public static g()I
  .limit locals 100
  .limit stack  100
  ;; if (false)
  ldc 0
  ifeq L0
  ;; return 12 ;
  ldc 12
  ireturn
  goto L1
  L0:
  ;; return 11 ;
  ldc 11
  ireturn
  L1:
  ;; return 10 ;
  ldc 10
  ireturn
return
.end method

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; printInt (g ());
  invokestatic return_in_if_right/g()I
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
