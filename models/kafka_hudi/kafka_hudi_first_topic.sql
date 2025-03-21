{{
  config(
    materialized = 'table',
    type = 'streaming',
    connector_properties = {
      'connector': 'hudi',
      'path': 's3a://metastore-bucket/hudi/first_topic',
      'hadoop.fs.s3a.endpoint': 'minio:9000',
      'hadoop.fs.s3a.path.style.access': 'true',
      'hadoop.fs.s3a.connection.ssl.enabled': 'false',
      'hadoop.fs.s3a.impl': 'org.apache.hadoop.fs.s3a.S3AFileSystem',
      'hoodie.datasource.write.recordkey.field': 'id',
      'hoodie.datasource.write.precombine.field': 'event_timestamp',
      'read.streaming.enabled': 'true',
      'read.streaming.check-interval': '3'
    }
    )
}}


select * from {{ source('kafka_source', 'first_topic') }}
