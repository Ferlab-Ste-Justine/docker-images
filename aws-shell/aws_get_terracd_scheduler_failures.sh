#!/bin/sh

aws sqs receive-message \
  --queue-url "$(aws sqs get-queue-url --queue-name terracd-pipeline-scheduler-dlq-$1 --query QueueUrl --output text)" \
  --message-attribute-names All \
  --max-number-of-messages 10