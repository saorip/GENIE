#
# This is the main GENIE project Makefile.
# Each package has its own Makefile which is invoked by this one.
# Machine specific flags and locations are read from 'make/Make.include'.
# Configuration options are read from 'make/Make.config' generated by the 'configure' script.
# 
# Author: Costas Andreopoulos <costas.andreopoulos \at stfc.ac.uk>
#

SHELL = /bin/sh
NAME = all
MAKEFILE = Makefile

# Include machine specific flags and locations (inc. files & libs)
#
include $(GENIE)/src/make/Make.include

# define composite targets
#
BUILD_TARGETS =    print-make-info \
		   make-bin-lib-dir \
		   save-build-env \
		   autogenerated-headers \
		   base-framework \
		   utils \
		   evgen-framework \
		   core-medium-energy-range \
		   test-medium-energy-range \
		   vle-extension \
		   flux-drivers \
		   geom-drivers \
		   nucleon-decay \
		   neutron-osc \
		   reweight \
		   mueloss \
		   masterclass \
		   doxygen-doc \
		   apps \
		   install-scripts
INSTALL_TARGETS =  print-makeinstall-info \
		   check-previous-installation \
		   make-install-dirs \
		   copy-install-files

# define targets

all:     $(BUILD_TARGETS)
install: $(INSTALL_TARGETS)

print-make-info: FORCE
	@echo " "
	@echo " "
	@echo "***** Building GENIE from source tree at: $(GENIE)"
	@echo "***** The source tree corresponds to GENIE version $(GVERSION)"
	@echo " "

print-makeinstall-info: FORCE
	@echo " "
	@echo " "
	@echo "***** Installing GENIE version $(GVERSION) at $(GENIE_INSTALLATION_PATH)"
	@echo " "

base-framework: FORCE
	@echo " "
	@echo "** Building base-framework..."
	cd ${GENIE}/src && \
	cd Algorithm &&  $(MAKE) && cd .. && \
	cd Messenger &&  $(MAKE) && cd .. && \
	cd Registry && $(MAKE) && \
	cd ${GENIE}

utils: FORCE
	@echo " "
	@echo "** Building utility libraries..."
	cd ${GENIE}/src && \
	cd Numerical &&      $(MAKE) && cd .. && \
	cd CrossSections &&  $(MAKE) && cd .. && \
	cd PDG &&            $(MAKE) && cd .. && \
	cd Utils &&          $(MAKE) && \
	cd ${GENIE}

nucleon-decay:
	@echo " "
	@echo "** Building nucleon decay library..."
ifeq ($(strip $(GOPT_ENABLE_NUCLEON_DECAY)),YES)
	cd ${GENIE}/src && \
	cd NucleonDecay && \
	$(MAKE) && \
	cd ${GENIE}
else
	@echo " "
	@echo "** Nucleon decay was not enabled. Skipping..."
endif

neutron-osc:
	@echo " "
	@echo "** Building neutron oscillation library..."
ifeq ($(strip $(GOPT_ENABLE_NEUTRON_OSC)),YES)
	cd ${GENIE}/src && \
	cd NeutronOsc && \
	$(MAKE) && \
	cd ${GENIE}
else
	@echo " "
	@echo "** Neutron oscillation was not enabled. Skipping..."
endif

reweight:
	@echo " "
	@echo "** Building event reweighting library..."
ifeq ($(strip $(GOPT_ENABLE_RWGHT)),YES)
	cd ${GENIE}/src && \
	cd ReWeight && \
	$(MAKE) && \
	cd ${GENIE}
else
	@echo " "
	@echo "** Event reweighting was not enabled. Skipping..."
endif

evgen-framework: FORCE
	@echo " "
	@echo "** Building evgen-framework..."
	cd ${GENIE}/src && \
	cd BaryonResonance &&    $(MAKE) && cd .. && \
	cd Base &&               $(MAKE) && cd .. && \
	cd EVGCore &&            $(MAKE) && cd .. && \
	cd EVGDrivers &&         $(MAKE) && cd .. && \
	cd Interaction &&        $(MAKE) && cd .. && \
	cd GHEP &&               $(MAKE) && cd .. && \
	cd Ntuple &&             $(MAKE) && \
	cd ${GENIE}

core-medium-energy-range: FORCE
	@echo " "
	@echo "** Building core medium energy range physics models..."
	cd ${GENIE}/src && \
	cd AlvarezRuso &&        $(MAKE) && cd .. && \
	cd BergerSehgal &&       $(MAKE) && cd .. && \
	cd BodekYang &&          $(MAKE) && cd .. && \
	cd Charm &&              $(MAKE) && cd .. && \
	cd Coherent &&           $(MAKE) && cd .. && \
	cd Decay &&              $(MAKE) && cd .. && \
	cd Diffractive &&        $(MAKE) && cd .. && \
	cd DIS &&                $(MAKE) && cd .. && \
	cd Elastic &&            $(MAKE) && cd .. && \
	cd ElFF &&               $(MAKE) && cd .. && \
	cd EVGModules &&         $(MAKE) && cd .. && \
	cd Fragmentation &&      $(MAKE) && cd .. && \
	cd GiBUU &&              $(MAKE) && cd .. && \
	cd HadronTransport &&    $(MAKE) && cd .. && \
	cd Interfaces &&         $(MAKE) && cd .. && \
	cd LlewellynSmith &&     $(MAKE) && cd .. && \
	cd MEC &&                $(MAKE) && cd .. && \
	cd NuE &&                $(MAKE) && cd .. && \
	cd Nuclear &&            $(MAKE) && cd .. && \
	cd PartonModel &&        $(MAKE) && cd .. && \
	cd PDF &&                $(MAKE) && cd .. && \
	cd QEL &&                $(MAKE) && cd .. && \
	cd ReinSehgal &&         $(MAKE) && cd .. && \
	cd RES &&                $(MAKE) && cd .. && \
	cd Types &&              $(MAKE) && cd .. && \
	cd VHE &&                $(MAKE) && cd .. && \
	cd SingleKaon &&         $(MAKE) && \
	cd ${GENIE}

test-medium-energy-range: FORCE
	@echo " "
	@echo "** Building tested medium energy range physics models..."
	cd ${GENIE}/src && \
	cd NuGamma &&            $(MAKE) && \
	cd ${GENIE}

vle-extension: FORCE
ifeq ($(strip $(GOPT_ENABLE_VLE_EXTENSION)),YES)
	@echo " "
	@echo "** Building VLE extension..."
	cd ${GENIE}/src/VLE && \
	$(MAKE) && \
	cd ${GENIE}
else
	@echo " "
	@echo "** The VLE extension was not enabled. Skipping..."
endif

flux-drivers: FORCE
ifeq ($(strip $(GOPT_ENABLE_FLUX_DRIVERS)),YES)
	@echo " "
	@echo "** Building flux-drivers..."
	cd ${GENIE}/src/FluxDrivers && \
	$(MAKE) && \
	cd ${GENIE}
else
	@echo " "
	@echo "** Building flux-drivers was not enabled. Skipping..."
endif

geom-drivers: FORCE
ifeq ($(strip $(GOPT_ENABLE_GEOM_DRIVERS)),YES)
	@echo " "
	@echo "** Building geometry-drivers..."
	cd ${GENIE}/src/Geo && \
	$(MAKE) && \
	cd ${GENIE}
else
	@echo " "
	@echo "** Building geometry-drivers was not enabled. Skipping..."
endif

mueloss: FORCE
ifeq ($(strip $(GOPT_ENABLE_MUELOSS)),YES)
	@echo " "
	@echo "** Building MuELoss utility package..."
	cd ${GENIE}/src/MuELoss && \
	$(MAKE) && \
	cd ${GENIE}
else
	@echo " "
	@echo "** Mueloss was not enabled. Skipping..."
endif

masterclass: FORCE
ifeq ($(strip $(GOPT_ENABLE_MASTERCLASS)),YES)
	@echo " "
	@echo "** Building Masterclass package..."
	cd ${GENIE}/src/Masterclass && \
	$(MAKE) && \
	cd ${GENIE}
else
	@echo " "
	@echo "** Masterclass was not enabled. Skipping..."
endif

# This target is used for generating the doxygen documentation
# during the genie build. 
# It only does so if the option has been enabled explicitly by the user.
doxygen-doc: FORCE
ifeq ($(strip $(GOPT_ENABLE_DOXYGEN_DOC)),YES)
	@echo " "
	@echo "** Building doxygen documentation..."
	cd ${GENIE}/src/scripts && \
	$(MAKE) doxygen && \
	cd ${GENIE};
else
endif

# Use this target  to generate the doxygen documentation at any
# point, independently of your local genie build.
doxygen: FORCE
	@echo " "
	@echo "** Building doxygen documentation..."
	cd ${GENIE}/src/scripts \
	$(MAKE) doxygen && \
	cd ${GENIE}

apps: FORCE
	@echo " "
	@echo "** Building GENIE applications..."
	cd ${GENIE}/src/Apps && \
	$(MAKE) all && \
	cd ${GENIE}

install-scripts: FORCE
	@echo " "
	@echo "** Installing scripts..."
	cd ${GENIE}/src/scripts && \
	$(MAKE) install && \
	cd ${GENIE}

all-libs: base-framework \
	  utils \
	  physics-models-modules \
	  event-generation-modules \
	  flux-drivers \
	  geom-drivers \
	  mueloss 

save-build-env: FORCE
	@echo " "
	@echo "** Taking a snapshot of the build environment..."
	perl ${GENIE}/src/scripts/setup/genie-build-env-snapshot

autogenerated-headers: FORCE
	@echo " "
	@echo "** Adding automatically generated code..."
	perl ${GENIE}/src/scripts/setup/genie-write-gbuild
	perl ${GENIE}/src/scripts/setup/genie-write-gversion

make-bin-lib-dir: FORCE
	@echo " "
	@echo "** Creating GENIE lib and bin directories..."
	cd ${GENIE} && \
	[ -d bin ] || mkdir bin && chmod 755 bin && \
	[ -d lib ] || mkdir lib && chmod 755 lib;

check-previous-installation: FORCE
	@echo " "
	@echo "** Testing for existing GENIE installation at specified installation location..."
ifeq ($(strip $(GENIE_PREVIOUS_INSTALLATION)),YES)
	$(error Previous installation exists at your specified installation path: $(GENIE_INSTALLATION_PATH). Trgy '$(MAKE) distclean' first)
endif

make-install-dirs: FORCE
	@echo " "
	@echo "** Creating directory structure for GENIE installation..."
	[ -d ${GENIE_INSTALLATION_PATH} ] || mkdir ${GENIE_INSTALLATION_PATH}
	cd ${GENIE_INSTALLATION_PATH}
	[ -d ${GENIE_BIN_INSTALLATION_PATH}     ] || mkdir ${GENIE_BIN_INSTALLATION_PATH}
	[ -d ${GENIE_LIB_INSTALLATION_PATH}     ] || mkdir ${GENIE_LIB_INSTALLATION_PATH}
	[ -d ${GENIE_INCBASE_INSTALLATION_PATH} ] || mkdir ${GENIE_INCBASE_INSTALLATION_PATH}
	mkdir ${GENIE_INC_INSTALLATION_PATH}
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Algorithm
	mkdir ${GENIE_INC_INSTALLATION_PATH}/AlvarezRuso
	mkdir ${GENIE_INC_INSTALLATION_PATH}/BaryonResonance
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Base
	mkdir ${GENIE_INC_INSTALLATION_PATH}/BergerSehgal
	mkdir ${GENIE_INC_INSTALLATION_PATH}/BodekYang
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Charm
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Coherent
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Conventions
	mkdir ${GENIE_INC_INSTALLATION_PATH}/CrossSections
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Decay
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Diffractive
	mkdir ${GENIE_INC_INSTALLATION_PATH}/DIS
	mkdir ${GENIE_INC_INSTALLATION_PATH}/EVGCore
	mkdir ${GENIE_INC_INSTALLATION_PATH}/EVGDrivers
	mkdir ${GENIE_INC_INSTALLATION_PATH}/EVGModules
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Elastic
	mkdir ${GENIE_INC_INSTALLATION_PATH}/ElFF
	mkdir ${GENIE_INC_INSTALLATION_PATH}/FluxDrivers
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Fragmentation
	mkdir ${GENIE_INC_INSTALLATION_PATH}/GHEP
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Geo
	mkdir ${GENIE_INC_INSTALLATION_PATH}/GiBUU
	mkdir ${GENIE_INC_INSTALLATION_PATH}/HadronTransport
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Interaction
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Interfaces
	mkdir ${GENIE_INC_INSTALLATION_PATH}/LlewellynSmith
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Masterclass
	mkdir ${GENIE_INC_INSTALLATION_PATH}/MEC
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Messenger
	mkdir ${GENIE_INC_INSTALLATION_PATH}/MuELoss
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Ntuple
	mkdir ${GENIE_INC_INSTALLATION_PATH}/NuE
	mkdir ${GENIE_INC_INSTALLATION_PATH}/NuGamma
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Nuclear
	mkdir ${GENIE_INC_INSTALLATION_PATH}/NucleonDecay
	mkdir ${GENIE_INC_INSTALLATION_PATH}/NeutronOsc
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Numerical
	mkdir ${GENIE_INC_INSTALLATION_PATH}/PDF
	mkdir ${GENIE_INC_INSTALLATION_PATH}/PDG
	mkdir ${GENIE_INC_INSTALLATION_PATH}/PartonModel
	mkdir ${GENIE_INC_INSTALLATION_PATH}/QEL
	mkdir ${GENIE_INC_INSTALLATION_PATH}/RES
	mkdir ${GENIE_INC_INSTALLATION_PATH}/ReWeight
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Registry
	mkdir ${GENIE_INC_INSTALLATION_PATH}/ReinSehgal
	mkdir ${GENIE_INC_INSTALLATION_PATH}/SingleKaon
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Types
	mkdir ${GENIE_INC_INSTALLATION_PATH}/Utils
	mkdir ${GENIE_INC_INSTALLATION_PATH}/VLE
	mkdir ${GENIE_INC_INSTALLATION_PATH}/VHE

copy-install-files: FORCE
	@echo " "
	@echo "** Copying libraries/binaries/headers to installation location..."
	cp ${GENIE_BIN_PATH}/* ${GENIE_BIN_INSTALLATION_PATH} && \
	cd ${GENIE}/src && \
	cd Algorithm &&              $(MAKE) install && cd .. && \
	cd AlvarezRuso &&            $(MAKE) install && cd .. && \
	cd BaryonResonance &&        $(MAKE) install && cd .. && \
	cd Base &&                   $(MAKE) install && cd .. && \
	cd BergerSehgal &&           $(MAKE) install && cd .. && \
	cd BodekYang &&              $(MAKE) install && cd .. && \
	cd Charm &&                  $(MAKE) install && cd .. && \
	cd Coherent &&               $(MAKE) install && cd .. && \
	cd Conventions &&            $(MAKE) install && cd .. && \
	cd CrossSections &&          $(MAKE) install && cd .. && \
	cd Decay &&                  $(MAKE) install && cd .. && \
	cd Diffractive &&            $(MAKE) install && cd .. && \
	cd DIS &&                    $(MAKE) install && cd .. && \
	cd Elastic &&                $(MAKE) install && cd .. && \
	cd ElFF &&                   $(MAKE) install && cd .. && \
	cd EVGCore &&                $(MAKE) install && cd .. && \
	cd EVGModules &&             $(MAKE) install && cd .. && \
	cd EVGDrivers &&             $(MAKE) install && cd .. && \
	cd FluxDrivers &&            $(MAKE) install && cd .. && \
	cd Fragmentation &&          $(MAKE) install && cd .. && \
	cd GHEP &&                   $(MAKE) install && cd .. && \
	cd Geo &&                    $(MAKE) install && cd .. && \
	cd GiBUU &&                  $(MAKE) install && cd .. && \
	cd HadronTransport &&        $(MAKE) install && cd .. && \
	cd Interaction &&            $(MAKE) install && cd .. && \
	cd Interfaces &&             $(MAKE) install && cd .. && \
	cd LlewellynSmith &&         $(MAKE) install && cd .. && \
	cd Masterclass &&            $(MAKE) install && cd .. && \
	cd MEC &&                    $(MAKE) install && cd .. && \
	cd Messenger &&              $(MAKE) install && cd .. && \
	cd MuELoss &&                $(MAKE) install && cd .. && \
	cd Nuclear &&                $(MAKE) install && cd .. && \
	cd NucleonDecay &&           $(MAKE) install && cd .. && \
	cd NeutronOsc &&             $(MAKE) install && cd .. && \
	cd Ntuple &&                 $(MAKE) install && cd .. && \
	cd NuE &&                    $(MAKE) install && cd .. && \
	cd NuGamma &&                $(MAKE) install && cd .. && \
	cd Numerical &&              $(MAKE) install && cd .. && \
	cd PartonModel &&            $(MAKE) install && cd .. && \
	cd PDF &&                    $(MAKE) install && cd .. && \
	cd PDG &&                    $(MAKE) install && cd .. && \
	cd QEL &&                    $(MAKE) install && cd .. && \
	cd RES &&                    $(MAKE) install && cd .. && \
	cd Registry &&               $(MAKE) install && cd .. && \
	cd ReinSehgal &&             $(MAKE) install && cd .. && \
	cd ReWeight &&               $(MAKE) install && cd .. && \
	cd SingleKaon &&             $(MAKE) install && cd .. && \
	cd Types &&                  $(MAKE) install && cd .. && \
	cd Utils &&                  $(MAKE) install && cd .. && \
	cd VLE &&                    $(MAKE) install && cd .. && \
	cd VHE &&                    $(MAKE) install && cd .. && \
	cd ${GENIE}

purge: FORCE
	@echo " "
	@echo "** Purging..."
	cd ${GENIE}/src && \
	cd Algorithm &&                     $(MAKE) purge && cd .. && \
	cd AlvarezRuso &&                   $(MAKE) purge && cd .. && \
	cd BaryonResonance &&               $(MAKE) purge && cd .. && \
	cd Base &&                          $(MAKE) purge && cd .. && \
	cd BergerSehgal &&                  $(MAKE) purge && cd .. && \
	cd BodekYang &&                     $(MAKE) purge && cd .. && \
	cd Charm &&                         $(MAKE) purge && cd .. && \
	cd Coherent &&                      $(MAKE) purge && cd .. && \
	cd CrossSections &&                 $(MAKE) purge && cd .. && \
	cd Decay &&                         $(MAKE) purge && cd .. && \
	cd Diffractive &&                   $(MAKE) purge && cd .. && \
	cd DIS &&                           $(MAKE) purge && cd .. && \
	cd Elastic &&                       $(MAKE) purge && cd .. && \
	cd ElFF &&                          $(MAKE) purge && cd .. && \
	cd EVGCore &&                       $(MAKE) purge && cd .. && \
	cd EVGModules &&                    $(MAKE) purge && cd .. && \
	cd EVGDrivers &&                    $(MAKE) purge && cd .. && \
	cd FluxDrivers &&                   $(MAKE) purge && cd .. && \
	cd Fragmentation &&                 $(MAKE) purge && cd .. && \
	cd GHEP &&                          $(MAKE) purge && cd .. && \
	cd Geo &&                           $(MAKE) purge && cd .. && \
	cd GiBUU &&                         $(MAKE) purge && cd .. && \
	cd HadronTransport &&               $(MAKE) purge && cd .. && \
	cd Interaction &&                   $(MAKE) purge && cd .. && \
	cd Interfaces &&                    $(MAKE) purge && cd .. && \
	cd LlewellynSmith &&                $(MAKE) purge && cd .. && \
	cd Masterclass &&                   $(MAKE) purge && cd .. && \
	cd MEC &&                           $(MAKE) purge && cd .. && \
	cd Messenger &&                     $(MAKE) purge && cd .. && \
	cd MuELoss &&                       $(MAKE) purge && cd .. && \
	cd Nuclear &&                       $(MAKE) purge && cd .. && \
	cd NucleonDecay &&                  $(MAKE) purge && cd .. && \
	cd NeutronOsc &&                    $(MAKE) purge && cd .. && \
	cd Ntuple &&                        $(MAKE) purge && cd .. && \
	cd NuGamma &&                       $(MAKE) purge && cd .. && \
	cd NuE &&                           $(MAKE) purge && cd .. && \
	cd Numerical &&                     $(MAKE) purge && cd .. && \
	cd PartonModel &&                   $(MAKE) purge && cd .. && \
	cd PDF &&                           $(MAKE) purge && cd .. && \
	cd PDG &&                           $(MAKE) purge && cd .. && \
	cd QEL &&                           $(MAKE) purge && cd .. && \
	cd RES &&                           $(MAKE) purge && cd .. && \
	cd Registry &&                      $(MAKE) purge && cd .. && \
	cd ReinSehgal &&                    $(MAKE) purge && cd .. && \
	cd ReWeight &&                      $(MAKE) purge && cd .. && \
	cd SingleKaon &&                    $(MAKE) purge && cd .. && \
	cd Utils &&                         $(MAKE) purge && cd .. && \
	cd Types &&                         $(MAKE) purge && cd .. && \
	cd VLE &&                           $(MAKE) purge && cd .. && \
	cd VHE &&                           $(MAKE) purge && cd .. && \
	cd ${GENIE}

clean: clean-files clean-dir clean-etc

clean-files: FORCE
	@echo " "
	@echo "** Cleaning..."
	cd ${GENIE}/src && \
	cd Algorithm &&                     $(MAKE) clean && cd .. && \
	cd AlvarezRuso &&                   $(MAKE) clean && cd .. && \
	cd BaryonResonance &&               $(MAKE) clean && cd .. && \
	cd Base &&                          $(MAKE) clean && cd .. && \
	cd BergerSehgal &&                  $(MAKE) clean && cd .. && \
	cd BodekYang &&                     $(MAKE) clean && cd .. && \
	cd Charm &&                         $(MAKE) clean && cd .. && \
	cd Coherent &&                      $(MAKE) clean && cd .. && \
	cd CrossSections &&                 $(MAKE) clean && cd .. && \
	cd Decay &&                         $(MAKE) clean && cd .. && \
	cd Diffractive &&                   $(MAKE) clean && cd .. && \
	cd DIS &&                           $(MAKE) clean && cd .. && \
	cd Elastic &&                       $(MAKE) clean && cd .. && \
	cd ElFF &&                          $(MAKE) clean && cd .. && \
	cd EVGCore &&                       $(MAKE) clean && cd .. && \
	cd EVGModules &&                    $(MAKE) clean && cd .. && \
	cd EVGDrivers &&                    $(MAKE) clean && cd .. && \
	cd FluxDrivers &&                   $(MAKE) clean && cd .. && \
	cd Fragmentation &&                 $(MAKE) clean && cd .. && \
	cd GHEP &&                          $(MAKE) clean && cd .. && \
	cd Geo &&                           $(MAKE) clean && cd .. && \
	cd GiBUU &&                         $(MAKE) clean && cd .. && \
	cd HadronTransport &&               $(MAKE) clean && cd .. && \
	cd Interaction &&                   $(MAKE) clean && cd .. && \
	cd LlewellynSmith &&                $(MAKE) clean && cd .. && \
	cd Masterclass &&                   $(MAKE) clean && cd .. && \
	cd MEC &&                           $(MAKE) clean && cd .. && \
	cd Messenger &&                     $(MAKE) clean && cd .. && \
	cd MuELoss &&                       $(MAKE) clean && cd .. && \
	cd Nuclear &&                       $(MAKE) clean && cd .. && \
	cd NucleonDecay &&                  $(MAKE) clean && cd .. && \
	cd NeutronOsc &&                    $(MAKE) clean && cd .. && \
	cd Ntuple &&                        $(MAKE) clean && cd .. && \
	cd NuGamma &&                       $(MAKE) clean && cd .. && \
	cd NuE &&                           $(MAKE) clean && cd .. && \
	cd Numerical &&                     $(MAKE) clean && cd .. && \
	cd PartonModel &&                   $(MAKE) clean && cd .. && \
	cd PDF &&                           $(MAKE) clean && cd .. && \
	cd PDG &&                           $(MAKE) clean && cd .. && \
	cd QEL &&                           $(MAKE) clean && cd .. && \
	cd RES &&                           $(MAKE) clean && cd .. && \
	cd Registry &&                      $(MAKE) clean && cd .. && \
	cd ReinSehgal &&                    $(MAKE) clean && cd .. && \
	cd ReWeight &&                      $(MAKE) clean && cd .. && \
	cd SingleKaon &&                    $(MAKE) clean && cd .. && \
	cd Utils &&                         $(MAKE) clean && cd .. && \
	cd VLE &&                           $(MAKE) clean && cd .. && \
	cd VHE &&                           $(MAKE) clean && cd .. && \
	cd Apps &&                          $(MAKE) clean && cd .. && \
	cd scripts &&                       $(MAKE) clean && cd .. && \
	cd $(GENIE) && \
    [ ! -d ./bin ] || $(RM) ./bin/* && \
	cd $(GENIE)

clean-dir: FORCE
	@echo "Deleting GENIE lib and bin directories..." && \
	cd $(GENIE) && \
	[ ! -d ./bin ] || rmdir ./bin && \
	[ ! -d ./lib ] || rmdir ./lib 

clean-etc: FORCE
	cd $(GENIE) && \
	rm -f ./*log && \
	cd ${GENIE}

distclean: FORCE
	@echo " "
	@echo "** Cleaning GENIE installation... "
	[ ! -d ${GENIE_INSTALLATION_PATH}/include/GENIE ] || rm -rf ${GENIE_INSTALLATION_PATH}/include/GENIE/
	cd ${GENIE}/src/ && \
	cd Algorithm &&                      $(MAKE) distclean && cd .. && \
	cd AlvarezRuso &&                    $(MAKE) distclean && cd .. && \
	cd BaryonResonance &&                $(MAKE) distclean && cd .. && \
	cd Base &&                           $(MAKE) distclean && cd .. && \
	cd BergerSehgal &&                   $(MAKE) distclean && cd .. && \
	cd BodekYang &&                      $(MAKE) distclean && cd .. && \
	cd Charm &&                          $(MAKE) distclean && cd .. && \
	cd Coherent &&                       $(MAKE) distclean && cd .. && \
	cd CrossSections &&                  $(MAKE) distclean && cd .. && \
	cd Decay &&                          $(MAKE) distclean && cd .. && \
	cd Diffractive &&                    $(MAKE) distclean && cd .. && \
	cd DIS &&                            $(MAKE) distclean && cd .. && \
	cd Elastic &&                        $(MAKE) distclean && cd .. && \
	cd ElFF &&                           $(MAKE) distclean && cd .. && \
	cd EVGCore &&                        $(MAKE) distclean && cd .. && \
	cd EVGModules &&                     $(MAKE) distclean && cd .. && \
	cd EVGDrivers &&                     $(MAKE) distclean && cd .. && \
	cd FluxDrivers &&                    $(MAKE) distclean && cd .. && \
	cd Fragmentation &&                  $(MAKE) distclean && cd .. && \
	cd GHEP &&                           $(MAKE) distclean && cd .. && \
	cd Geo &&                            $(MAKE) distclean && cd .. && \
	cd GiBUU &&                          $(MAKE) distclean && cd .. && \
	cd HadronTransport &&                $(MAKE) distclean && cd .. && \
	cd Interaction &&                    $(MAKE) distclean && cd .. && \
	cd Interfaces &&                     $(MAKE) distclean && cd .. && \
	cd LlewellynSmith &&                 $(MAKE) distclean && cd .. && \
	cd Masterclass &&                    $(MAKE) distclean && cd .. && \
	cd MEC &&                            $(MAKE) distclean && cd .. && \
	cd Messenger &&                      $(MAKE) distclean && cd .. && \
	cd MuELoss &&                        $(MAKE) distclean && cd .. && \
	cd Nuclear &&                        $(MAKE) distclean && cd .. && \
	cd NucleonDecay &&                   $(MAKE) distclean && cd .. && \
	cd NeutronOsc &&                     $(MAKE) distclean && cd .. && \
	cd Ntuple &&                         $(MAKE) distclean && cd .. && \
	cd NuGamma &&                        $(MAKE) distclean && cd .. && \
	cd NuE &&                            $(MAKE) distclean && cd .. && \
	cd Numerical &&                      $(MAKE) distclean && cd .. && \
	cd PartonModel &&                    $(MAKE) distclean && cd .. && \
	cd PDF &&                            $(MAKE) distclean && cd .. && \
	cd PDG &&                            $(MAKE) distclean && cd .. && \
	cd QEL &&                            $(MAKE) distclean && cd .. && \
	cd RES &&                            $(MAKE) distclean && cd .. && \
	cd Registry &&                       $(MAKE) distclean && cd .. && \
	cd ReinSehgal &&                     $(MAKE) distclean && cd .. && \
	cd ReWeight &&                       $(MAKE) distclean && cd .. && \
	cd SingleKaon &&                     $(MAKE) distclean && cd .. && \
	cd Types &&                          $(MAKE) distclean && cd .. && \
	cd Utils &&                          $(MAKE) distclean && cd .. && \
	cd VLE &&                            $(MAKE) distclean && cd .. && \
	cd VHE &&                            $(MAKE) distclean && cd .. && \
	cd Apps &&                           $(MAKE) distclean && cd .. && \
	cd scripts &&                        $(MAKE) distclean && \
	cd ${GENIE}

FORCE:

