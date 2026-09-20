FROM ferlabcrsj/terracd:0.20.0

RUN apk add --no-cache aws-cli git

COPY terracd-aws/entrypoint-ssm.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint-ssm.sh

COPY terracd-aws/providers.tf /tmp/mirror-spec/providers.tf

RUN cd /tmp/mirror-spec \
 && terraform providers mirror \
      -platform=linux_amd64 \
      /usr/local/share/terraform/mirror \
 && cd /usr/local/share/terraform/mirror \
 && find . -name '*.zip' | while read -r archive; do \
      dir="$(dirname "$archive")"; \
      name="$(basename "$archive" .zip)"; \
      version="$(echo "$name" | cut -d_ -f2)"; \
      platform="$(echo "$name" | cut -d_ -f3,4)"; \
      mkdir -p "$dir/$version/$platform"; \
      unzip -q "$archive" -d "$dir/$version/$platform"; \
    done \
 && find . \( -name '*.zip' -o -name '*.json' \) -delete \
 && rm -rf /tmp/mirror-spec

COPY terracd-aws/cli.tfrc /root/.terraformrc
