//===----------------------------------------------------------------------===//
//
// Author: Zaheer Ahmed Gauhar <zaheer.gauhar@pm.me>
//         Hans Liljestrand <hans@liljestrand.dev>
// ***Copyright: Secure Systems Group, Aalto University https://ssg.aalto.fi/***
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

def int_cauth_pro_mod : Intrinsic<[llvm_i64_ty], [], [IntrNoMem]>;
def int_cauth_epi_mod : Intrinsic<[llvm_i64_ty], [], [IntrNoMem]>;

def int_ca_pacga : Intrinsic<[llvm_i64_ty], [llvm_i64_ty], [IntrNoMem]>;
def int_ca_pacda : Intrinsic<[llvm_anyptr_ty],
                             [LLVMMatchType<0>, llvm_i64_ty],
                             [IntrNoMem]>;
def int_ca_autda : Intrinsic<[llvm_anyptr_ty],
                             [LLVMMatchType<0>, llvm_i64_ty],
                             [IntrNoMem]>;

