GIT_ROOT = $(shell git rev-parse --show-toplevel)

LIB_COMPILER = clang
LIB_FLAGS = -fPIC -shared -Wall -Wextra -Werror -O2
LIB_SRC_DIR = src
LIB_SRC = $(shell ls $(LIB_SRC_DIR)/*.c)
LIB_NAME = libCML.so

TEST_COMPILER = clang++
TEST_FLAGS = -L $(GIT_ROOT)/src/
TEST_SRC_DIR = test
TEST_SRC = $(shell ls $(TEST_SRC_DIR)/*.cpp)
TEST_NAME = tests

help:
	@echo "Usage: make TARGET"
	@echo "TARGETS:"
	@echo "  compile   - compile the library"
	@echo "  install   - run the compile target and install the library to /usr/local/lib"
	@echo "  uninstall - remove the library from /usr/local/lib"
	@echo "  test      - run the compile target, install the library, compile the tests, and run them"
	@echo "  clean     - remove the library and tests"

compile:
	@$(LIB_COMPILER) $(LIB_FLAGS) $(LIB_SRC) -o $(LIB_NAME)

install: compile
	@if [ ! -f /usr/local/lib/$(LIB_NAME) ]; then \
		sudo mv $(LIB_NAME) /usr/local/lib/; \
		sudo ldconfig; \
	else \
		sudo rm /usr/local/lib/$(LIB_NAME); \
		sudo mv $(LIB_NAME) /usr/local/lib/; \
		sudo ldconfig; \
	fi

uninstall:
	@if [ -f /usr/local/lib/$(LIB_NAME) ]; then \
		sudo rm /usr/local/lib/$(LIB_NAME); \
		sudo ldconfig; \
	fi

test: compile install
	@$(TEST_COMPILER) $(TEST_FLAGS) $(TEST_SRC) -o $(TEST_NAME)
	@./$(TEST_NAME)

clean:
	@if [ -f $(GIT_ROOT)/$(LIB_NAME) ]; then \
		rm $(GIT_ROOT)/$(LIB_NAME); \
	fi
	@if [ -f $(GIT_ROOT)/$(TEST_NAME) ]; then \
		rm $(GIT_ROOT)/$(TEST_NAME); \
	fi

.PHONY: help compile install uninstall test clean