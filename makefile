##############################################################################################
# cc65 floating point lib
##############################################################################################

all: runtime.lib floattest.prg floattest

runtime.lib: float.s floatc.c float.inc
	ca65 -t c64 float.s -o float.o
	cc65 floatc.c -o floatc.s
	ca65 floatc.s -o floatc.o
	ar65 a runtime.lib float.o floatc.o

floattest.prg: runtime.lib math.h float.h floattest.c
#	cl65 -Osir floattest.c runtime.lib -o floattest.prg
	cl65 -I . floattest.c runtime.lib -o floattest.prg
#	cc65 floattest.c -o floattest.s

floattest: floattest.c math.h float.h
	gcc -O2 -W -Wall -Wextra -o floattest -lm floattest.c

run: floattest.prg
	x64sc -autostartprgmode 1 floattest.prg
	
clean:
	$(RM) floattest.s runtime.lib floatc.s floattest.prg floattest
	$(RM) *~
	$(RM) *.prg *.o *.map *.lbl *.log *.lst *.d64

