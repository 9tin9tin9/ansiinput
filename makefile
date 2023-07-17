CXX = clang
CXXFLAGS = -std=c11 -g -fsanitize=address
LDFLAGS =
TARGET_DIR = target
SRC_DIR = src
MODULES = main ansiinput
TARGET = main

# prerequisites for each module
# add the module even if there is no prerequisite
main = ansiinput.h
ansiinput = ansiinput.h

all: $(TARGET_DIR) ./$(TARGET_DIR)/$(TARGET)

run: all
	@./$(TARGET_DIR)/$(TARGET) $(ARGS)

$(TARGET_DIR):
	@if [[ ! -e $(TARGET_DIR) ]]; then mkdir $(TARGET_DIR); fi

OBJ = $(addprefix $(TARGET_DIR)/, $(addsuffix .o, $(MODULES)))

$(TARGET_DIR)/$(TARGET): $(OBJ)
	@echo linking $@
	@$(CXX) $(LDFLAGS) $(CXXFLAGS) $^ -o $@

.SECONDEXPANSION:

$(TARGET_DIR)/%.o: $(SRC_DIR)/%.c $$(addprefix $(SRC_DIR)/, $$($$*)) makefile
	@echo compiling $@
	@$(CXX) $(CXXFLAGS) $< -c -o $@

clean:
	rm -rf $(TARGET_DIR)

.PHONY: clean
