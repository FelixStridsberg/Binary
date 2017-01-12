TEST_PACKAGES = ounit

CC = ocamlfind ocamlopt

C_FLAGS = -package $(TEST_PACKAGES) -c -I src/ -I src/pages/
L_FLAGS =

TEST_L_FLAGS = -linkpkg -package $(TEST_PACKAGES)

INTERFACES =				\
	src/binary.cmi

SOURCES =					\
	src/binary.cmx

TEST_SOURCES =				\
	$(SOURCES)				\
	test/test.cmx

lib: $(INTERFACES) $(SOURCES)
	mkdir -p dist/
	cp src/binary.cm* dist/

test_runner: $(INTERFACES) $(TEST_SOURCES)
	$(CC) $(TEST_L_FLAGS) -o $@ $(TEST_SOURCES)

%.cmi: %.mli
	$(CC) $(C_FLAGS) $<

%.cmx: %.ml
	$(CC) $(C_FLAGS) $<

clean:
	rm -f src/*.o src/*.cmx src/*.cmi
	rm -f test/*.o test/*.cmx test/*.cmi
