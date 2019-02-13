//===----------------------------------------------------------------------===//
//
// Author: Zaheer Gauhar <zaheer.gauhar@pm.me>
// *******Copyright: Secure Systems Group, Aalto University https://ssg.aalto.fi/**********
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include <llvm/CAUTH/Cauth.h>
#include <llvm/Support/raw_ostream.h>
#include "llvm/Support/CommandLine.h"

using namespace llvm;

static cl::opt<bool> EnableCAuth("cauth", cl::Hidden,
                                      cl::desc("Canary Authentication"),
                                      cl::init(false));

static cl::opt<bool> EnableCAuthMod("cauth-mod", cl::Hidden,
                                      cl::desc("Canary Authentication with custom modifier"),
                                      cl::init(false));

static cl::opt<bool> EnableTest("test", cl::Hidden,
                                      cl::desc("Test pass for MIR"),
                                      cl::init(false));


bool llvm::CAUTH::useCAuth() {
  return EnableCAuth;
}

bool llvm::CAUTH::useCAuthMod() {
  return EnableCAuthMod;
}

bool llvm::CAUTH::useTest() {
  return EnableTest;
}
