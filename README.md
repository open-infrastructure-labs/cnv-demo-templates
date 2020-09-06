# CNV demo playbooks and templates

## Image uploading

The `upload-images.yml` playbook populates our [MinIO][] instance with
vm disk images. The playbook will:

- Check if an image exists or not
- Check if an image needs to be replaced because the `source_url` has changed
- Download remote images to a local cache directory
- Upload images from local cache to minio

The playbook relies on the [minio client][].

[minio]: https://min.io/
[minio client]: https://docs.min.io/docs/minio-client-quickstart-guide.html

## Templates

The `Makefile` will generate operating-system specific templates from 
[vm-template.ytt.yml](vm-template.ytt.yml), which is a [ytt][]
template.

As of this writing, you will get templates for:

- CentOS 8
- Cirros
- Fedora 32
- RHEL 8.2
- Ubuntu Focal (20.04)

For each operating system, you get a template that uses the default pod
network, and a template that uses the "public" bridged network. The list of
generated templates is:

- `centos-8-template-bridge.yml`
- `centos-8-template-pod.yml`
- `cirros-template-bridge.yml`
- `cirros-template-pod.yml`
- `fedora-32-template-bridge.yml`
- `fedora-32-template-pod.yml`
- `rhel-8-template-bridge.yml`
- `rhel-8-template-pod.yml`
- `ubuntu-focal-template-bridge.yml`
- `ubuntu-focal-template-pod.yml`

You can use `oc process` to render a template into a usable object definition,
which you can then apply using `oc apply`:

```
oc process centos-8-template-pod.yml NAME=test1 SSH_KEY="$(cat ~/.ssh/id_rsa.pub)" |
oc apply -f-
```

[ytt]: https://get-ytt.io/
