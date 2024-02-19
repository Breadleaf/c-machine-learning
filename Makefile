GIT_ROOT = $(shell git rev-parse --show-toplevel)

LIB_COMPILER = clang
LIB_FLAGS = -fPIC -shared -Wall -Wextra -Werror -O2
LIB_NAME = libCML.so
LIB_SRC_DIR = $(GIT_ROOT)/src
LIB_SHARED_OBJECT_FILES = $(shell ls $(LIB_SRC_DIR)/*.c)
LIB_SHARED_OBJECT_INSTALL_DIR = /usr/lib
LIB_INCLUDE_FILES = $(shell ls $(LIB_SRC_DIR)/*.h)
LIB_INCLUDE_INSTALL_DIR = /usr/include/CML

TEST_COMPILER = clang++
# TEST_FLAGS = -I$(GIT_ROOT)/$(LIB_SRC_DIR)/ -L /usr/lib -lCML
TEST_FLAGS = -I $(LIB_INCLUDE_INSTALL_DIR) -L $(LIB_SHARED_OBJECT_INSTALL_DIR) -lCML
TEST_SRC_DIR = test
TEST_SRC = $(shell ls $(TEST_SRC_DIR)/*.cpp)
TEST_NAME = tests

help:
	@echo "Usage: make TARGET"
	@echo "TARGETS:"
	@echo "  help       - display this help"
	@echo "  compile    - compile the library"
	@echo "  install    - run compile target and install the library and headers"
	@echo "  uninstall  - uninstall the library and headers"
	@echo "  test       - run compile target, compile the tests and run them"
	@echo "  clean      - remove the library and tests from the head of the git repository"

compile:
	@$(LIB_COMPILER) $(LIB_FLAGS) $(LIB_SHARED_OBJECT_FILES) -o $(LIB_NAME)

install: compile
	@if [ ! -d $(LIB_INCLUDE_INSTALL_DIR) ]; then \
		sudo mkdir $(LIB_INCLUDE_INSTALL_DIR); \
	fi
	@for file in $(LIB_INCLUDE_FILES); do \
		sudo cp $$file $(LIB_INCLUDE_INSTALL_DIR); \
	done
	@if [ ! -f $(LIB_SHARED_OBJECT_INSTALL_DIR)/$(LIB_NAME) ]; then \
		sudo mv $(LIB_NAME) $(LIB_SHARED_OBJECT_INSTALL_DIR)/; \
		sudo ldconfig; \
	else \
		sudo rm $(LIB_SHARED_OBJECT_INSTALL_DIR)/$(LIB_NAME); \
		sudo mv $(LIB_NAME) $(LIB_SHARED_OBJECT_INSTALL_DIR)/; \
		sudo ldconfig; \
	fi
	@echo "Installed $(LIB_NAME)"

uninstall:
	@if [ -d $(LIB_INCLUDE_INSTALL_DIR) ]; then \
		sudo rm -r $(LIB_INCLUDE_INSTALL_DIR); \
	fi
	@if [ -f $(LIB_SHARED_OBJECT_INSTALL_DIR)/$(LIB_NAME) ]; then \
		sudo rm $(LIB_SHARED_OBJECT_INSTALL_DIR)/$(LIB_NAME); \
		sudo ldconfig; \
	fi
	@echo "Uninstalled $(LIB_NAME)"

test:
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