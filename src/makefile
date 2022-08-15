#!/bin/make

IVERILOG ?=iverilog
VVP 	 ?=vvp
GTKWAVE  ?=gtkwave

.PHONY: clean gtkwave
.SUFFIXES: .out .vcd .v .gtkwave
all:
	echo 'TODO: 後で書く'
%_test.out: %_test.v %.v 
	$(IVERILOG) -o $@ -s $*_test  $^
%.vcd: %.out
	$(VVP) $^
%.gtkwave: %.vcd
	$(GTKWAVE) $^
clean:
	rm -f *.out *.vcd
