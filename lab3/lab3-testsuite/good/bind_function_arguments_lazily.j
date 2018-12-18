;; BEGIN HEADER

.class public bind_function_arguments_lazily
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

  invokestatic bind_function_arguments_lazily/main()I
  pop
  return

.end method

;; END HEADER

.method public static snd(II)I
  .limit locals 100
  .limit stack  100
  ;; return y ;
  iload 1
  ireturn
return
.end method

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int x = 0 ;
  ldc 0
  istore 0
  ;; int r = snd (1, x);
  ldc 1
  iload 0
  invokestatic bind_function_arguments_lazily/snd(II)I
  istore 1
  ;; printInt (r);
  iload 1
  invokestatic Runtime/printInt(I)V
  ;; return r ;
  iload 1
  ireturn
return
.end method
