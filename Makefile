#cyclone64

BUILD_DIR=build
SOURCE_DIR=src/cyclone
GL_SOURCE_DIR=src/gl

src := $(SOURCE_DIR)/common/core.cpp $(SOURCE_DIR)/common/random.cpp $(SOURCE_DIR)/common/contacts.cpp $(SOURCE_DIR)/common/pcontacts.cpp \
	$(SOURCE_DIR)/dynamics/world.cpp $(SOURCE_DIR)/dynamics/body.cpp $(SOURCE_DIR)/dynamics/pworld.cpp $(SOURCE_DIR)/dynamics/particle.cpp $(SOURCE_DIR)/dynamics/fgen.cpp $(SOURCE_DIR)/dynamics/pfgen.cpp $(SOURCE_DIR)/dynamics/joints.cpp $(SOURCE_DIR)/dynamics/plinks.cpp \
	$(SOURCE_DIR)/collision/collide_fine.cpp $(SOURCE_DIR)/collision/collide_coarse.cpp
inc := $(SOURCE_DIR)/common/precision.h common/core.h $(SOURCE_DIR)/common/random.h $(SOURCE_DIR)/common/contacts.h $(SOURCE_DIR)/common/pcontacts.h \
	$(SOURCE_DIR)/dynamics/world.h $(SOURCE_DIR)/dynamics/body.h $(SOURCE_DIR)/dynamics/pworld.h $(SOURCE_DIR)/dynamics/particle.h $(SOURCE_DIR)/dynamics/fgen.h $(SOURCE_DIR)/dynamics/pfgen.h $(SOURCE_DIR)/dynamics/joints.h $(SOURCE_DIR)/dynamics/plinks.h \
	$(SOURCE_DIR)/collision/collide_fine.h $(SOURCE_DIR)/collision/collide_coarse.h \
	$(SOURCE_DIR)/cyclone.h

CXXFLAGS = -O2 -Iinclude -fPIC -Isrc

OBJ = $(BUILD_DIR)/common/core.o $(BUILD_DIR)/common/random.o $(BUILD_DIR)/common/contacts.o $(BUILD_DIR)/common/pcontacts.o \
	$(BUILD_DIR)/dynamics/world.o $(BUILD_DIR)/dynamics/body.o $(BUILD_DIR)/dynamics/pworld.o $(BUILD_DIR)/dynamics/particle.o $(BUILD_DIR)/dynamics/fgen.o $(BUILD_DIR)/dynamics/pfgen.o $(BUILD_DIR)/dynamics/joints.o $(BUILD_DIR)/dynamics/plinks.o \
	$(BUILD_DIR)/collision/collide_fine.o $(BUILD_DIR)/collision/collide_coarse.o

all: $(BUILD_DIR)/libcyclone64.a

# Static Library
$(BUILD_DIR)/libcyclone64.a: $(OBJ)
	@mkdir -p $(dir $@)
	@echo "    [LD_LIB] $<"
	$(LD) -r -o $(BUILD_DIR)/libcyclone64.a $^

# Sources
$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.cpp
	@mkdir -p $(dir $@)
	@echo "    [CC_LIB] $<"
	$(CXX) -c $(CFLAGS) $(CXXFLAGS) -o $@ $<

clean:
	rm -rf $(BUILD_DIR)

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean
