# SFDC streaming

This is a quick & dirty example that shows how to capture changes in Salesforce.com, in real-time, and publish them to a Kafka topic.


## Quick Start

### Create PushTopic
First, it's necessary to create a topic based on an SOQL query. To do that, tweak the snippet of Apex code and execute it:

    PushTopic pushTopic = new PushTopic();
    pushTopic.Name = 'BookingStatusUpdates';
    pushTopic.Query = 'SELECT Id, salesforceBookingStatus__c FROM Booking__c WHERE customerId__c != '0052p000009Ka2zAAC'';
    pushTopic.Description = 'Booking status updates submited by Customer Support agent';
    pushTopic.ApiVersion = 49.0;
    pushTopic.isActive = true;
    pushTopic.NotifyForOperationCreate = false;
    pushTopic.NotifyForOperationUpdate = true;
    pushTopic.NotifyForOperationUndelete = false;
    pushTopic.NotifyForOperationDelete = false;
    pushTopic.NotifyForFields = 'Select';
    insert pushTopic;
    
For more information visit: https://developer.salesforce.com/docs/atlas.en-us.api_streaming.meta/api_streaming/code_sample_java_create_pushtopic.htm


### Update credential details
Then edit the properties file (`src/main/java/io/woolford/resources/application.properties`) - add your own SFDC login, and Kafka broker.

* `sfdc.password` - the concatenation of the password *and* the SFDC security token.
* `sfdc.replay` - the position in the stream from which you want to receive event messages.
If not specified, EMP Connector fetches events starting from the earliest retained event message (-2 option).

### Dependencies
This project depends on the `emp-connector` artifact from `com.salesforce.conduit`.
This dependency doesn't exist in Maven Central. You could install it locally:

    git clone https://github.com/forcedotcom/EMP-Connector.git
    cd EMP-Connector
    mvn clean install


### Build and run the project

    mvn clean package
    nohup java -jar target/sfdc-streaming-1.1.jar --stopic=/topic/BookingStatusUpdates --ktopic=salesforce_booking_status --replay=-2 &

That's it! Changes to contacts will be published, in JSON format, to the 'contact-updates' Kafka topic.

## Docker

### Build the image

    docker build -t kafka/salesforce .
    
### Run container

    docker run -p 9000:9000 kafka/salesforce --stopic=/topic/BookingStatusUpdates --ktopic=salesforce_booking_status --replay=-2

## Deployment

### Harbor

#### Log in from Docker client

    docker login harbor.hometogo.rocks

#### Tag an image for this project:

    docker tag kafka/salesforce harbor.hometogo.rocks/salesforce_kafka_producer/connector:1.0
    
#### Push an image to this project:

    docker push harbor.hometogo.rocks/salesforce_kafka_producer/connector:1.0

### Kubernetes

#### Useful commands

    kubectl apply -f <path to yaml> -n salesforce
    kubectl delete -f <path to yaml> -n salesforce
    kubectl get pods -n salesforce
    kubectl describe pod <pod name> -n salesforce
    kubectl logs <pod name> -n salesforce -f --tail 100
    kubectl get deployments -n salesforce
    kubectl scale deployment <deployment name> -n salesforce --replicas=x (better practive to change yml)
    kubectl delete deployment <deployment name> -n salesforce
    kubectl -n salesforce rollout restart deployment <deployment name>
    kubectl exec -it <pod name> -n salesforce -- /bin/sh

#### Tips

    kubectl get pod -n salesforce | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n salesforce
