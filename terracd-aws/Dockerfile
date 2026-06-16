FROM ferlabcrsj/terracd:0.19.0

RUN apk add --no-cache aws-cli git

COPY terracd-aws/entrypoint-ssm.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint-ssm.sh