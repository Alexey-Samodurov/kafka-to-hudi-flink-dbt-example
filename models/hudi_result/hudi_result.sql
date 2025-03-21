{{
  config(
    materialized = 'table',
    type = 'streaming',
    connector_properties = {
      'connector': 'hudi',
      'path': 's3a://metastore-bucket/hudi/result/',
      'hadoop.fs.s3a.endpoint': 'minio:9000',
      'hadoop.fs.s3a.path.style.access': 'true',
      'hadoop.fs.s3a.connection.ssl.enabled': 'false',
      'hadoop.fs.s3a.impl': 'org.apache.hadoop.fs.s3a.S3AFileSystem',
      'hoodie.datasource.write.recordkey.field': 'id',
      'hoodie.datasource.write.precombine.field': 'event_timestamp'
    }
    )
}}

select
    id,
    CAST(event_timestamp AS TIMESTAMP(3)) AS event_timestamp
from {{ ref("kafka_hudi_first_topic") }}
union all
select
    id,
    CAST(event_timestamp AS TIMESTAMP(3)) AS event_timestamp
 from {{ ref("kafka_hudi_second_topic") }}
