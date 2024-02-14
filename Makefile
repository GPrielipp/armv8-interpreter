CXX=clang++
CXXFLAGS=-g -Wall

SRCS=$(shell find src/ -type f -name *.cpp)
OBJS=$(SRCS:src/%.cpp=obj/%.o)

SRCDIRS=$(patsubst src/%, %, $(shell find src/ -type d))
OBJDIRS=$(SRCDIRS:%=obj/%)

TARGET=vm



define OBJ_template =
$(1): $(2) 
	@echo ""
	@echo "Building $$@"
	$$(CXX) $$(CXXFLAGS) -c $$^ -o $$@ -MMD
endef

$(foreach obj, $(OBJS), $(eval $(call OBJ_template,$(obj),$(obj:obj/%.o=src/%.cpp)) ))



all: pre-build $(TARGET)
	mv $(TARGET) bin/$(TARGET)



pre-build:
	- @mkdir -p $(OBJDIRS) 2>/dev/null



$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@ 



clean:
	rm -rf obj/* bin/*



run: pre-build $(TARGET)
	@echo
	./$(TARGET)

.phony: pre-build all

