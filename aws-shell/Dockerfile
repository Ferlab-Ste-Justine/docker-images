FROM amazon/aws-cli:latest

ARG KUBECTL_VERSION=v1.35.5

RUN yum update && yum install -y git unzip

RUN curl -fsSL https://downloads.rclone.org/v1.74.4/rclone-v1.74.4-linux-amd64.zip -o /tmp/rclone.zip && \
    unzip /tmp/rclone.zip -d /tmp && \
    mv /tmp/rclone-v1.74.4-linux-amd64/rclone /usr/local/bin/rclone && \
    chmod +x /usr/local/bin/rclone && \
    rm -rf /tmp/rclone.zip /tmp/rclone-v1.74.4-linux-amd64

RUN curl -fsSL https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip -o /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/terraform && \
    rm -f /tmp/terraform.zip

RUN yum install -y python3.11 python3.11-pip \
    && python3.11 -m pip install awscurl \
    && yum clean all && rm -rf /var/cache/yum

RUN curl -fsSLo /usr/local/bin/kubectl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
 && curl -fsSLo /usr/local/bin/kubectl.sha256 "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256" \
 && echo "$(cat /usr/local/bin/kubectl.sha256)  /usr/local/bin/kubectl" | sha256sum -c - \
 && chmod +x /usr/local/bin/kubectl \
 && rm /usr/local/bin/kubectl.sha256

RUN dnf install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm

COPY aws-shell/aws_*.sh /usr/local/bin/