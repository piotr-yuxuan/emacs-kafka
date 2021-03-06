# emacs-kafka
A Kafka CLI porcelain for Emacs, inspired by Magit.

Starting a local kafka-broker, zookeeper, and console consumer/producer in emacs comint modes.

Using magit-popup to play around kafka-topics, consumer-groups CLI commands.

![Alt text](/images/all.png?raw=true "Screenshots")

## Requirements

* Install [Magit](https://github.com/magit/magit) Popup
* Download [Kafka](https://kafka.apache.org/downloads.html)

Magit popup can also be installed through Melpa

## Install
Clone the repository and append the following in your ~/.emacs

	```
	(add-to-list "/path/to/emacs-kafka")
	(require 'kafka-cli)
	```
Replace /path/to/ with the location where you cloned it.

## Start the services
* Customize the variables
  1. kafka-cli-bin-path
  2. kafka-cli-config-path

``` emacs-lisp
(setq kafka-cli-bin-path "/path/to/kafka-0.10/bin")
(setq kafka-cli-config-path "/path/to/kafka-0.10/config")
```

By default kafka and zookeeper url points to localhost, to configure that

``` emacs-lisp
(setq kafka-url "hostname:port")
(setq zookeeper-url "hostname:port")
```

* M-x run-zookeeper RET
Should start the zookeeper service in localhost:2181

* M-x run-kafkabroker RET
Should start a local broker running in localhost:9092

Configure what topics to consume
``` emacs-lisp
(setq kafka-consumer-whitelist-topics "path.path.topic")
```

* M-x run-kafkaconsumer RET
Should start a console consumer
You can run M-x list-processes RET, to see if these processes are running.

## Kafka CLI
* M-x kafka-cli RET, Gives a popup with different options dealing with topics.
* Supports listing, deleting, adding, editing, describing topics.
* Supports overview of kafka, zk, consumer processes in a custom mode.
