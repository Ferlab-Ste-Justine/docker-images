FROM ferlabcrsj/terracd:0.19.0

RUN apk add --no-cache aws-cli git

COPY terracd-aws/entrypoint-ssm.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint-ssm.sh

COPY terracd-aws/providers.tf /tmp/mirror-spec/providers.tf

RUN cd /tmp/mirror-spec \
 && terraform providers mirror \
      -platform=linux_amd64 \
      /usr/local/share/terraform/mirror \
 && rm -rf /tmp/mirror-spec

COPY terracd-aws/cli.tfrc /root/.terraformrc
