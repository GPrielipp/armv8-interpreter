CXX=clang++
CXXFLAGS=-g -Wall

SRCDIR=src
OBJDIR=obj

SRCS=$(shell find $(SRCDIR)/ -type f -name *.cpp)
OBJS=$(SRCS:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)

SRCDIRS=$(patsubst $(SRCDIR)/%, %, $(shell find $(SRCDIR)/ -type d))
OBJDIRS=$(SRCDIRS:%=$(OBJDIR)/%)

TARGET=vm



all: pre-build $(TARGET)



define OBJ_template =
$(1): $(2) 
	@echo "Building $$@"
	$$(CXX) $$(CXXFLAGS) -c $$^ -o $$@ -MMD
	@echo ""
endef

$(foreach obj, $(OBJS), $(eval $(call OBJ_template,$(obj),$(obj:$(OBJDIR)/%.o=$(SRCDIR)/%.cpp)) ))



pre-build:
	- @mkdir -p $(OBJDIRS) 2>/dev/null



$(TARGET): $(OBJS)
	@echo "Building $(TARGET)"
	$(CXX) $(CXXFLAGS) $^ -o $@ 
	@echo ""



clean:
	rm -rf $(OBJDIR)/* $(TARGET) 



run: pre-build $(TARGET)
	@echo
	./$(TARGET)

.phony: pre-build 

