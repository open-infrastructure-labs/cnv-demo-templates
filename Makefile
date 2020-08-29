NETWORK_NAME ?= public

VALUES = $(wildcard values-*.yml)
TEMPLATES = \
	    $(patsubst values-%.yml, %-template-pod.yml, $(VALUES)) \
	    $(patsubst values-%.yml, %-template-bridge.yml, $(VALUES))

SRC_TEMPLATE = vm-template.ytt.yml

BUILD_COMMAND = \
		NM=$@; NM=$${NM\#*template-}; NM=$${NM%.yml}; \
		ytt --ignore-unknown-comments \
		-f $(SRC_TEMPLATE) -f values.yml -f $< \
		-v network_mode=$$NM \
		-v network_name=$(NETWORK_NAME) \
		> $@ || { rm -f $@; exit 1; }

%-template-pod.yml: values-%.yml $(SRC_TEMPLATE)
	@echo $@; \
	   $(BUILD_COMMAND)
%-template-bridge.yml: values-%.yml $(SRC_TEMPLATE)
	@echo $@; \
	   $(BUILD_COMMAND)

all: $(TEMPLATES)

apply: $(TEMPLATES)
	for template in $(TEMPLATES); do \
		oc apply -f $$template; \
	done

clean:
	rm -f $(TEMPLATES)
