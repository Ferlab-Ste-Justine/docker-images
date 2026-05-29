FROM amazonlinux:2023

# Small image with the `lfs` userspace CLI (lustre-client package) +
# findutils, for k8s CronJobs that manage FSx Lustre HSM state.
#
# coreutils omitted on purpose: AL2023 ships `coreutils-single` (a
# busybox-style single-binary build) which provides rm/df/basename/cat
# etc. and conflicts with the full `coreutils` package. The single
# variant is sufficient for cron scripts.
RUN dnf install -y lustre-client findutils \
 && dnf clean all \
 && rm -rf /var/cache/dnf \
 && lfs --version

CMD ["/bin/bash"]
