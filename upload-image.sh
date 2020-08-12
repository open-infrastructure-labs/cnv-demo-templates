#!/bin/sh

virtctl image-upload dv centos-8-stream \
  --image-path CentOS-Stream-GenericCloud-8-20200113.0.x86_64.qcow2 \
  --size 10Gi \
  --storage-class hostpath-provisioner \
  --insecure
