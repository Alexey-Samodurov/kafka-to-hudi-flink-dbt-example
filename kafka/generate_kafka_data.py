import random
import time
from datetime import datetime, timedelta
from kafka import KafkaProducer
import json
from multiprocessing import Process


# Функция для генерации данных
def generate_data(n):
    data = []
    start_date = datetime.now() - timedelta(days=365)
    end_date = datetime.now()
    for _ in range(n):
        row = {
            "id": random.randint(1, 1000000),
            "event_timestamp": (start_date + timedelta(
                                   seconds=random.randint(0, int((end_date - start_date).total_seconds())))
                               ).strftime("%Y-%m-%d %H:%M:%S.%f")[:-3],
        }
        data.append(row)
    return data


def publish_to_kafka(topic, data):
    producer = KafkaProducer(
        bootstrap_servers='kafka:9092',
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )

    try:
        for row in data:
            producer.send(topic, value=row)
            time.sleep(1)
            print(f"Сообщение отправлено в {topic}: {row}")
    except Exception as e:
        print(f"Ошибка при отправке сообщения в {topic}: {e}")
    finally:
        producer.close()


if __name__ == "__main__":
    data_first_topic = generate_data(10000)
    data_second_topic = generate_data(10000)

    topic_first = "first-topic"
    topic_second = "second-topic"

    process_first = Process(target=publish_to_kafka, args=(topic_first, data_first_topic))
    process_second = Process(target=publish_to_kafka, args=(topic_second, data_second_topic))

    process_first.start()
    process_second.start()

    process_first.join()
    process_second.join()

    print("Все данные отправлены в оба топика.")
