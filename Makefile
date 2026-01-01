#cyclone64

BUILD_DIR=build
SOURCE_DIR=src/cyclone

INSTALLDIR=$(N64_INST)

include $(N64_INST)/include/n64.mk

src := $(SOURCE_DIR)/common/core.cpp $(SOURCE_DIR)/common/random.cpp $(SOURCE_DIR)/common/contacts.cpp $(SOURCE_DIR)/common/pcontacts.cpp \
	$(SOURCE_DIR)/dynamics/world.cpp $(SOURCE_DIR)/dynamics/body.cpp $(SOURCE_DIR)/dynamics/pworld.cpp $(SOURCE_DIR)/dynamics/particle.cpp $(SOURCE_DIR)/dynamics/fgen.cpp $(SOURCE_DIR)/dynamics/pfgen.cpp $(SOURCE_DIR)/dynamics/joints.cpp $(SOURCE_DIR)/dynamics/plinks.cpp \
	$(SOURCE_DIR)/collision/collide_fine.cpp $(SOURCE_DIR)/collision/collide_coarse.cpp

incCommon := $(SOURCE_DIR)/common/precision.h $(SOURCE_DIR)/common/core.h $(SOURCE_DIR)/common/random.h $(SOURCE_DIR)/common/contacts.h $(SOURCE_DIR)/common/pcontacts.h
incDynamics :=	$(SOURCE_DIR)/dynamics/world.h $(SOURCE_DIR)/dynamics/body.h $(SOURCE_DIR)/dynamics/pworld.h $(SOURCE_DIR)/dynamics/particle.h $(SOURCE_DIR)/dynamics/fgen.h $(SOURCE_DIR)/dynamics/pfgen.h $(SOURCE_DIR)/dynamics/joints.h $(SOURCE_DIR)/dynamics/plinks.h
incCollision :=	$(SOURCE_DIR)/collision/collide_fine.h $(SOURCE_DIR)/collision/collide_coarse.h
inc :=	$(SOURCE_DIR)/cyclone.h

N64_CFLAGS += -std=gnu2x -Os -Isrc \
	-Wall -Wextra -Werror \
	-Wformat-signedness -fno-common \
	-Wshadow -Wdouble-promotion -Wformat-security -Wformat-overflow -Wformat-truncation

OBJ = $(BUILD_DIR)/common/core.o $(BUILD_DIR)/common/random.o $(BUILD_DIR)/common/contacts.o $(BUILD_DIR)/common/pcontacts.o \
	$(BUILD_DIR)/dynamics/world.o $(BUILD_DIR)/dynamics/body.o $(BUILD_DIR)/dynamics/pworld.o $(BUILD_DIR)/dynamics/particle.o $(BUILD_DIR)/dynamics/fgen.o $(BUILD_DIR)/dynamics/pfgen.o $(BUILD_DIR)/dynamics/joints.o $(BUILD_DIR)/dynamics/plinks.o \
	$(BUILD_DIR)/collision/collide_fine.o $(BUILD_DIR)/collision/collide_coarse.o

all: $(BUILD_DIR)/libcyclone64.a

# Static Library
$(BUILD_DIR)/libcyclone64.a: $(OBJ)
	@mkdir -p $(dir $@)
	@echo "    [LD_LIB] $<"
	$(N64_LD) -r -o $(BUILD_DIR)/libcyclone64.a $^

# Sources
$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.cpp
	@mkdir -p $(dir $@)
	@echo "    [CC_LIB] $<"
	$(N64_CC) -c $(CFLAGS) $(CXXFLAGS) -o $@ $<

install: all
	mkdir -p $(INSTALLDIR)/$(N64_TARGET)/include/cyclone64
	mkdir -p $(INSTALLDIR)/$(N64_TARGET)/include/cyclone64/common
	mkdir -p $(INSTALLDIR)/$(N64_TARGET)/include/cyclone64/dynamics
	mkdir -p $(INSTALLDIR)/$(N64_TARGET)/include/cyclone64/collision
	install -cv -m 0644 cyclone64-inst.mk $(INSTALLDIR)/include/cyclone64.mk

	for file in $(inc); do \
		install -Cv -m 0644 $$file $(INSTALLDIR)/$(N64_TARGET)/include/cyclone64; \
	done
	for file in $(incCommon); do \
		install -Cv -m 0644 $$file $(INSTALLDIR)/$(N64_TARGET)/include/cyclone64/common; \
	done
	for file in $(incDynamics); do \
		install -Cv -m 0644 $$file $(INSTALLDIR)/$(N64_TARGET)/include/cyclone64/dynamics; \
	done
	for file in $(incCollision); do \
		install -Cv -m 0644 $$file $(INSTALLDIR)/$(N64_TARGET)/include/cyclone64/collision; \
	done
	install -Cv -m 0644 $(BUILD_DIR)/libcyclone64.a $(INSTALLDIR)/$(N64_TARGET)/lib

clean:
	rm -rf $(BUILD_DIR)

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean
