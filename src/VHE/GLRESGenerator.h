//____________________________________________________________________________
/*!

\class    genie::GLRESGenerator

\brief    Glashow resonance event generator

\author   Costas Andreopoulos <costas.andreopoulos \at stfc.ac.uk>
          University of Liverpool & STFC Rutherford Appleton Lab

\created  Feb 15, 2008

\cpright  Copyright (c) 2003-2016, GENIE Neutrino MC Generator Collaboration
          For the full text of the license visit http://copyright.genie-mc.org
          or see $GENIE/LICENSE
*/
//____________________________________________________________________________

#ifndef _GLASHOW_RESONANCE_GENERATOR_H_
#define _GLASHOW_RESONANCE_GENERATOR_H_

#include <TPythia8.h>

#include "EVGCore/EventRecordVisitorI.h"

namespace genie {

class GLRESGenerator : public EventRecordVisitorI {

public :
  GLRESGenerator();
  GLRESGenerator(string config);
 ~GLRESGenerator();

  // implement the EventRecordVisitorI interface
  void ProcessEventRecord (GHepRecord * event) const;

  // overload the Algorithm::Configure() methods to load private data
  // members from configuration options
  void Configure(const Registry & config);
  void Configure(string config);

private:

  void LoadConfig(void);

  mutable TPythia8 * fPythia8;   ///< PYTHIA8 wrapper class
};

}      // genie namespace
#endif // _GLASHOW_RESONANCE_GENERATOR_H_
