#If you have clang, it seems to generate a faster compile as of the beginning of 2018
CC=g++
#CC=x86_64-w64-mingw32-g++-posix
#CC=clang++
CFLAGS=-c -DNDEBUG -Ofast -flto -g3 -Wall -Wno-sign-compare -m64 -march=native -std=c++11 -Isrc -Isrc/general -Isrc/learning
LDFLAGS=-flto -Wall
SOURCES=$(wildcard Winter/src/general/*.cc Winter/src/learning/*.cc Winter/src/*.cc)
OBJECTS=$(SOURCES:.cc=.o)
EXECUTABLE:=Winter-heroku

all: $(SOURCES) $(EXECUTABLE)

target no_bmi: CFLAGS += -DNO_BMI
no_bmi: all

target ancient: CFLAGS=-c -DNDEBUG -O3 -Wall -Wno-sign-compare -m64 -DNO_BMI -std=c++11 -Isrc -Isrc/general -Isrc/learning
target ancient: LDFLAGS=-Wall -static
ancient: all

target old: CFLAGS=-c -DNDEBUG -O3 -Wall -Wno-sign-compare -m64 -msse4.2 -DNO_BMI -std=c++11 -Isrc -Isrc/general -Isrc/learning
target old: LDFLAGS=-Wall -static
old: all

target new: CFLAGS=-c -DNDEBUG -O3 -Wall -Wno-sign-compare -m64 -mavx2 -mbmi -mbmi2 -std=c++11 -Isrc -Isrc/general -Isrc/learning
target new: LDFLAGS=-Wall -static
new: all

$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@ -lpthread

.cc.o:
	$(CC) $(CFLAGS) $< -o $@

clean: clean-src clean-general clean-learning

clean-src:
	rm -rf Winter/src/*.o
	
clean-general:
	rm -rf Winter/src/general/*.o
	
clean-learning:
	rm -rf Winter/src/learning/*.o
