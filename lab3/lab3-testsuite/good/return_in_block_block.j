;; BEGIN HEADER

.class public return_in_block_block
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

  invokestatic return_in_block_block/main()I
  pop
  return

.end method

;; END HEADER

.method public static niam()I
  .limit locals 100
  .limit stack  100
  ;; return 99 ;
  ldc 99
  ireturn
  ;; printInt (2);
  ldc 2
  invokestatic Runtime/printInt(I)V
  ;; printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V
return
.end method

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; printInt (niam ());
  invokestatic return_in_block_block/niam()I
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
  ;; printInt (3);
  ldc 3
  invokestatic Runtime/printInt(I)V
  ;; printInt (4);
  ldc 4
  invokestatic Runtime/printInt(I)V
return
.end method
