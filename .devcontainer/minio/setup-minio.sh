#!/bin/bash

set -x

required_buckets=("metastore-bucket" "flink-checkpoints")

until (mc config host add minio http://minio:9000 minioadmin minioadmin) do sleep 5; done

for bucket in "${required_buckets[@]}"; do
  mc mb minio/$bucket --ignore-existing
done
