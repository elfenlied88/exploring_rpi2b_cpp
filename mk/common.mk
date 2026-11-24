ROOT  := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)
NAME  := $(notdir $(CURDIR))
BUILD := $(ROOT)/build/$(NAME)
BIN   := $(ROOT)/bin/$(NAME)

CXXFLAGS += -std=c++17 -Wall -Wextra -O2 -g -I$(ROOT)/include -MMD -MP

SRCS := $(wildcard *.cpp)
OBJS := $(SRCS:%.cpp=$(BUILD)/%.o)

all: $(BIN)

$(BIN): $(OBJS)
	@mkdir -p $(dir $@)
	$(CXX) $^ $(LDFLAGS) -o $@

$(BUILD)/%.o: %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD) $(BIN)

-include $(OBJS:.o=.d)
.PHONY: all clean
