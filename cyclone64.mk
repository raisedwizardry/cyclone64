CYCLONE64_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

N64_LDFLAGS := $(CYCLONE64_DIR)/build/libcyclone64.a $(N64_LDFLAGS)
N64_C_AND_CXX_FLAGS += -I$(CYCLONE64_DIR)/src