# You should be using Cabal as the build system, but this demonstrates
# how to manage a simpla Haskell program with a Makefile similar to C programs.

SRC=./app/Main.hs
MGR=cabal
BIN=$(cabal list-bin pkg:read-args-exp)
INTERPRETER=runghc

build:
	${MGR} build

run:
	${MGR} run

run-interpreted:
	#${INTERPRETER} ${SRC}
	@echo "Does not work yet because there is no easy way to list and inject dependencies"

build-tar:
	${MGR} sdist

clean:
	${MGR} clean

install-bin:
	${MGR} install
