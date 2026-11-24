PROJECTS := $(notdir $(patsubst %/,%,$(wildcard src/*/)))

all: $(PROJECTS)

$(PROJECTS):
	$(MAKE) -C src/$@

clean:
	@for p in $(PROJECTS); 
		do $(MAKE) -C src/$$p clean;
	done

.PHONY: all clean $(PROJECTS)
