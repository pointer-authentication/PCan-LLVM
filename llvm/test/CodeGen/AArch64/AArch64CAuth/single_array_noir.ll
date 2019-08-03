; RUN: llc -verify-machineinstrs -mtriple=aarch64-none-linux-gnu -mattr=v8.3a -cauth=arr -cauth-noir < %s | FileCheck %s
; XFAIL: *

@__canary_chk_fail = private unnamed_addr constant [41 x i8] c"\0A***Canary Check Failed***\0AExiting....\0A\0A\00", align 1

; CHECK-LABEL: @simple
; // Make sure we and store the canary
; CHECK: mov	[[MOD1:x[0-9]+]], sp
; CHECK: movk [[MOD1]], #{{[0-9]+}}, lsl #48
; CHECK: pacga x19, xzr, [[MOD1]]
; CHECK: str x19, [[CAN_ADDR:.*$]]
; CHECK: bl expose
; // Make sure the canary is loaded!
; CHECK: ldr [[CAN:x[0-9]+]], [[CAN_ADDR]]
; // Make sure the reference canary is re-created from scratch!
; CHECK: mov [[MOD2:x[0-9]+]], sp
; CHECK: movk [[MOD2]], #{{[0-9]+}}, lsl #48
; CHECK: pacga [[REF_CAN:x[0-9]+]], xzr, [[MOD2]]
; // Finally, just check the canary...
; CHECK: cmp [[CAN]], [[REF_CAN]]
; CHECK: ret
define hidden void @simple() {
entry:
  %0 = call i64 @llvm.cauth.pro.mod(i64 1)
  %cauth_alloc = alloca i64
  %pga = call i64 @llvm.ca.pacga(i64 %0)
  store i64 %pga, i64* %cauth_alloc, align 8
  %a = alloca [32 x i8]
  %arraydecay1 = getelementptr inbounds [32 x i8], [32 x i8]* %a, i32 0, i32 0
  call void @expose(i8* %arraydecay1)
  %1 = call i64 @llvm.cauth.epi.mod(i64 1)
  %2 = load i64, i64* %cauth_alloc
  %ega = call i64 @llvm.ca.pacga(i64 %1)
  %cmp = icmp eq i64 %2, %ega
  br i1 %cmp, label %cauth.ret, label %cauth.fail

cauth.ret:                                        ; preds = %entry
  ret void

cauth.fail:                                       ; preds = %entry
  %printfCall = call i32 (...) @printf([41 x i8]* @__canary_chk_fail)
  call void @exit(i32 1)
  ret void
}

declare hidden void @expose(i8*)

; Function Attrs: nounwind readnone
declare i64 @llvm.cauth.pro.mod(i64) #0

; Function Attrs: nounwind readnone
declare i64 @llvm.ca.pacga(i64) #0

; Function Attrs: nounwind readnone
declare i64 @llvm.cauth.epi.mod(i64) #0

declare i32 @printf(...)

declare void @exit(i32)

attributes #0 = { nounwind readnone }