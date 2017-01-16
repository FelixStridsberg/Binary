TEST_PACKAGES = ounit

OCAMLFIND = ocamlfind
OCAMLOPT = ocamlopt

C_FLAGS = -package $(TEST_PACKAGES) -c -I src/ -I src/pages/

TEST_L_FLAGS = -linkpkg -package $(TEST_PACKAGES)

INTERFACES =				\
	src/binary.cmi

SOURCES =					\
	src/binary.cmx

TEST_SOURCES =				\
	$(SOURCES)				\
	test/test.cmx

lib: $(INTERFACES) $(SOURCES)

install: lib
	ocamlfind install binary src/*

test_runner: $(INTERFACES) $(TEST_SOURCES)
	$(OCAMLFIND) $(OCAMLOPT) $(TEST_L_FLAGS) -o $@ $(TEST_SOURCES)

%.cmi: %.mli
	$(OCAMLFIND) $(OCAMLOPT) $(C_FLAGS) $<

%.cmx: %.ml
	$(OCAMLFIND) $(OCAMLOPT) $(C_FLAGS) $<

clean:
	rm -f src/*.o src/*.cmx src/*.cmi
	rm -f test/*.o test/*.cmx test/*.cmi
