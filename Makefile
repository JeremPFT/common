# CUSTOM
PROJECT=<<PROJECT_NAME>>
EXE=<<EXEC_NAME>>
## CUSTOM

ifdef OS
	EXT=.exe
else
	EXT=
endif

define checkExistence
	test -f $(1) || { echo "file '$(1)' not found"; exit 1; }
endef

define buildRun
	$(BUILD) -P$(PROJECT).gpr -XBUILD=$(1)
	( BUILD=$(1) $(EXE) )
endef

#
# build cmd config
#

BUILD_EXEC=gprbuild$(EXT)
BUILD_ARGS=-j0 -k
BUILD=$(BUILD_EXEC) $(BUILD_ARGS)
# -j0 (use the maximum number of simultaneous compilation jobs)
# -k (keep going after compilation errors)

#
# clean cmd config
#

CLEAN_EXEC=gprclean$(EXT)
CLEAN_ARGS=
CLEAN=$(CLEAN_EXEC) $(CLEAN_ARGS)

#
# targets
#

.PHONY : all compil_lib compil_tests clean run_tests

all: run_tests

dbg:
	$(call buildRun,DEBUG)

prod:
	$(call buildRun,PRODUCTION)

autocheck::
#	@$(call checkExistence, $(BUILD_EXEC))
#	@$(call checkExistence, $(CLEAN_EXEC))

compil: autocheck
	$(BUILD)

run: autocheck
	@$(call checkExistence,$(subst \,/,$(HOME))/tmp/bin/$(EXE))
	cd $(subst \,/,$(HOME))/tmp/bin && ./$(EXE)


clean: autocheck
	$(CLEAN)
	-@rm -r bin obj
