FROM flink:1.17.2-scala_2.12-java11

USER root

RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.2/hadoop-aws-3.3.2.jar \
    && wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.11.183/aws-java-sdk-s3-1.11.183.jar \
    && wget https://repo1.maven.org/maven2/org/apache/flink/flink-s3-fs-hadoop/1.17.2/flink-s3-fs-hadoop-1.17.2.jar \
    && wget https://repo1.maven.org/maven2/org/apache/hudi/hudi-flink1.17-bundle/0.15.0/hudi-flink1.17-bundle-0.15.0.jar \
    && wget https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/3.4.0/kafka-clients-3.4.0.jar \
    && wget https://repo1.maven.org/maven2/org/apache/flink/flink-connector-kafka/1.17.2/flink-connector-kafka-1.17.2.jar \
    && wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-core/3.3.2/hadoop-mapreduce-client-core-3.3.2.jar \
    && wget https://repo1.maven.org/maven2/org/apache/parquet/parquet-avro/1.12.3/parquet-avro-1.12.3.jar \
    && mv *.jar /opt/flink/lib/

USER flink
