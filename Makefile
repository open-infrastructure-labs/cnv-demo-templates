NAMESPACE ?= default
FLAVOR ?= medium
KEY ?= $(HOME)/.ssh/id_rsa.pub
IMAGE_URL ?= https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2

all: centos-8-template.yml

centos-8-template.yml: centos-8-template.ytt.yml values.yml
	ytt -f $< -f values.yml -v namespace=$(NAMESPACE) \
		--data-value-file ssh_key=$(KEY) \
		--data-value image_url=$(IMAGE_URL) \
		--data-value flavor=$(FLAVOR) \
		> $@ || { rm -f $@; exit 1; }

apply: centos-8-template.yml
	oc apply -f $<

clean:
	rm -f centos-8-template.yml
