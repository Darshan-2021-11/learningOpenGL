# Taken from
# https://github.com/gwu-cs-os/evening_os_hour/blob/master/f19/10.2-makefiles

BINARY=main
CODEDIRS=src
INCDIRS=include

CC=g++
OPT=-O0
# generate files that encode make rules for the .h dependencies
DEPFLAGS=-MP -MD
# automatically add the -I onto each include directory
CFLAGS=-Wall -Werror -Wpedantic -g $(foreach D,$(INCDIRS),-I$(D)) $(OPT) $(DEPFLAGS)
LIBS=-lglfw -lGL -lX11 -lpthread -lXrandr -lXi -ldl

# for-style iteration (foreach) and regular expression completions (wildcard)
CXXFILES=$(foreach D,$(CODEDIRS),$(wildcard $(D)/*.cpp))
# regular expression replacement
OBJECTS=$(patsubst %.cpp,%.o,$(CXXFILES))
DEPFILES=$(foreach D,$(CODEDIRS),$(wildcard $(D)/*.d))

all: $(BINARY)

$(BINARY): $(OBJECTS)
	$(CC) $(LIBS) -o $@ $^

# only want the .cpp file dependency here, thus $< instead of $^.
#
%.o:%.cpp
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf $(BINARY) $(OBJECTS) $(DEPFILES)

# shell commands are a set of keystrokes away
distribute: clean
	tar zcvf dist.tgz *

# @ silences the printing of the command
# $(info ...) prints output
diff:
	$(info The status of the repository, and the volume of per-file changes:)
	@git status
	@git diff --stat

# include the dependencies
include $(DEPFILES)

# add .PHONY so that the non-targetfile - rules work even if a file with the same name exists.
.PHONY: all clean distribute diff
