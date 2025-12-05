package com.paiad.kafka.sample;

import org.apache.kafka.clients.producer.*;

import java.util.Properties;
import java.util.concurrent.ExecutionException;

/**
 * 生产者
 */
public class ProducerQuickStart {

    public static void main(String[] args) throws ExecutionException, InterruptedException {

        //1.kafka链接配置信息
        Properties prop = new Properties();
        //kafka链接地址
        prop.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG,"localhost:9092");
        //key和value的序列化
        prop.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG,"org.apache.kafka.common.serialization.StringSerializer");
        prop.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG,"org.apache.kafka.common.serialization.StringSerializer");

        //2.创建kafka生产者对象
        KafkaProducer<String,String> producer = new KafkaProducer<String,String>(prop);

        //3.发送消息
        /**
         * 第一个参数 ：topic
         * 第二个参数：消息的key
         * 第三个参数：消息的value
         */
        ProducerRecord<String,String> kvProducerRecord = new ProducerRecord<String,String>("topic-first","key-001","hello kafka");
        producer.send(kvProducerRecord);

        //4.关闭消息通道  必须要关闭，否则消息发送不成功
        producer.close();

    }

}
