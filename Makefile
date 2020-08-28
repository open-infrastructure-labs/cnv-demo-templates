KEY ?= $(HOME)/.ssh/id_rsa.pub

VALUES = $(wildcard *-values.yml)
TEMPLATES = $(VALUES:-values.yml=-template.yml)
SRC_TEMPLATE = vm-template.ytt.yml

%-template.yml: %-values.yml $(SRC_TEMPLATE)
	ytt --ignore-unknown-comments \
		-f $(SRC_TEMPLATE) -f values.yml -f $< \
		--data-value-file ssh_key=$(KEY) \
		> $@ || { rm -f $@; exit 1; }

all: $(TEMPLATES)

apply: $(TEMPLATES)
	for template in $(TEMPLATES); do \
		oc apply -f $$template; \
	done

clean:
	rm -f $(TEMPLATES)
