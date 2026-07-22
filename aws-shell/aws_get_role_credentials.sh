#!/bin/sh

DURATION=${DURATION-3600}
RANDOM_VAL=$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 10; echo)

aws sts assume-role \
  --role-arn "arn:aws:iam::${AWS_ACCOUNT}:role/$1" \
  --role-session-name "user-access-$RANDOM_VAL" \
  --duration-seconds $DURATION