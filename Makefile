ifdef OS
	EXT=.exe
else
	EXT=
endif

BUILD=gprbuild$(EXT)
CLEAN=gprclean$(EXT)

.PHONY : all compil_lib compil_tests clean run_tests

all: run_tests

compil_lib::
	$(BUILD) -j4 -g -gnatef $(LIB_GPR)

compil_tests::
	$(BUILD) -j4 -g -gnatef $(TEST_GPR)

clean::
	$(CLEAN) $(LIB_GPR)
	$(CLEAN) $(TEST_GPR)

run_tests: compil_tests
	$(RUN)
