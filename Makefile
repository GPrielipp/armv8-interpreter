CXX=clang++
CXXFLAGS=-g -Wall

SRCS=$(shell find src/ -type f -name *.cpp)
OBJS=$(SRCS:src/%.cpp=obj/%.o)

SRCDIRS=$(patsubst src/%, %, $(shell find src/ -type d))
OBJDIRS=$(SRCDIRS:%=obj/%)

TARGET=vm



all: pre-build $(TARGET)



define OBJ_template =
$(1): $(2) 
	@echo "Building $$@"
	$$(CXX) $$(CXXFLAGS) -c $$^ -o $$@ -MMD
	@echo ""
endef

$(foreach obj, $(OBJS), $(eval $(call OBJ_template,$(obj),$(obj:obj/%.o=src/%.cpp)) ))



pre-build:
	- @mkdir -p $(OBJDIRS) 2>/dev/null



$(TARGET): $(OBJS)
	@echo "Building $(TARGET)"
	$(CXX) $(CXXFLAGS) $^ -o $@ 
	@echo ""



clean:
	rm -rf obj/* $(TARGET) 



run: pre-build $(TARGET)
	@echo
	./$(TARGET)

.phony: pre-build 

