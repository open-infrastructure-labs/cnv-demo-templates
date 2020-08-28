# CNV demo playbooks and templates

## Image uploading

The `upload-images.yml` playbook populates our [MinIO][] instance with
vm disk images. The playbook will:

- Check if an image exists or not
- Check if an image needs to be replaced because the `source_url` has changed
- Download remote images to a local cache directory
- Upload images from local cache to minio

[minio]: https://min.io/

## Templates

The `Makefile` will generate operating-system specific templates from 
[vm-template.ytt.yml](vm-template.ytt.yml), which is a [ytt][]
template. You can upload the generated templates by running `make
apply`, which simply runs `oc apply -f <template>` for each generated
template.

Once the templates have been uploaded to OpenShift, they will be
available in the "Templates" popup when creating a new virtual machine
via the OpenShift web console, or you can create a vm from the command
line using `oc process` and `oc apply`, like this:

```
oc process rhel-8 NAME=my-test-vm | oc apply -f-
```

[ytt]: https://get-ytt.io/
