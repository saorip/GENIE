//____________________________________________________________________________
/*
 Copyright (c) 2003-2017, GENIE Neutrino MC Generator Collaboration
 For the full text of the license visit http://copyright.genie-mc.org
 or see $GENIE/LICENSE

 Author: Costas Andreopoulos <costas.andreopoulos \at stfc.ac.uk>
         University of Liverpool & STFC Rutherford Appleton Lab - May 13, 2005

 For the class documentation see the corresponding header file.

 Important revisions after version 2.0.0 :

*/
//____________________________________________________________________________

#include "EVGCore/InteractionListGeneratorI.h"

using namespace genie;

//___________________________________________________________________________
InteractionListGeneratorI::InteractionListGeneratorI() :
Algorithm()
{

}
//___________________________________________________________________________
InteractionListGeneratorI::InteractionListGeneratorI(string name) :
Algorithm(name)
{

}
//___________________________________________________________________________
InteractionListGeneratorI::InteractionListGeneratorI(
                                                string name, string config) :
Algorithm(name, config)
{

}
//___________________________________________________________________________
InteractionListGeneratorI::~InteractionListGeneratorI()
{

}
//___________________________________________________________________________
