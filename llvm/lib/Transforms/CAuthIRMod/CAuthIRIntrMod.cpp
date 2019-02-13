//===----------------------------------------------------------------------===//
//
// Author: Zaheer Ahmed Gauhar <zaheer.gauhar@pm.me>
// ***Copyright: Secure Systems Group, Aalto University https://ssg.aalto.fi/***
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include <llvm/CAUTH/CauthIntr.h>
#include "llvm/IR/IRBuilder.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Constant.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;
using namespace CAUTH;

#define DEBUG_TYPE "CauthIRIntrMod:"

namespace {

struct CauthIRIntrMod : public FunctionPass {
  
  public:
    static char ID;
    CauthIRIntrMod() : FunctionPass(ID){}
    bool runOnFunction(Function &F) override;

};

} // anonymous namespace

char CauthIRIntrMod::ID = 0;
static RegisterPass<CauthIRIntrMod> X("cauth-ir-intr", "CAuth IR Intrinsics Pass");

bool CauthIRIntrMod::runOnFunction(Function &F) {
  auto &C = F.getContext();

  for (auto &BB:F){
    for (auto &I: BB) {
      
      const auto IOpcode = I.getOpcode();

      switch(IOpcode) {
        default:
          break;
        case Instruction::Alloca: {
          
          errs()<<DEBUG_TYPE;
          I.dump();
          auto AI = dyn_cast<AllocaInst>(&I);
          assert(AI != nullptr);          
          
          break;
        }        
      }
    }
  }

  return true;
}

