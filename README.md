## ElasticSearch with Cluster Docker file

This is a highly configurable elastic search docker file.   
**Supports Elasticsearch version  1.7.2**  
Configuration driven clustering is supported.


### Available Features
Installed plugins:

- [AWS Cloud](https://github.com/elastic/elasticsearch-cloud-aws) - Allows usage of AWS API for unicast discovery and S3 repositories for snapshots.  
Supports version 2.7.1

- [BigDesk](http://bigdesk.org/): Provides live charts and statistics for an Elasticsearch cluster. You can open a browser and navigate to `http://localhost:9200/_plugin/bigdesk/` it will open Bigdesk and auto-connect to the ES node. 

- [Elasticsearch Head](http://mobz.github.io/elasticsearch-head/): A web front end for an Elasticsearch cluster. Open `http://localhost:9200/_plugin/head/` and it will run it as a plugin within the Elasticsearch cluster.


### How to use this image

#### Clone the repository

#### Build

		cd Elasticsearch_Cluster
        docker build -t elastic_search .

#### Run 

     docker run --name elasticsearch -d -p 9200:9200 -p 9300:9300 elastic_search

 
**Available configurations :**  

   Environment variables are accepted as a means to provide further configuration. They are updated inside `elasticsearch.yml`

   Options : 	  
	1. `ES_CLUSTER_NAME` : Name of your es cluster.  
	2. `ES_CLOUD_AWS_ACCESS__KEY` : AWS access key.  
	3. `ES_CLOUD_AWS_SECRET__KEY` : AWS access secret.   
	4. `ES_CLOUD_AWS_REGION` : AWS region name.  
	5. `ES_DISCOVERY_EC2_GROUPS` : AWS ec2 discovery group.  

For example :  
		**Note** - change placeholders as par your configuration.

		docker run --name elasticsearch \
			-d -p 9200:9200 -p 9300:9300 \
			-v /home/ubuntu/elasticsearch/data: <es_data_path> \
			-e ES_CLUSTER_NAME= <es_cluster_name> \
			-e ES_CLOUD_AWS_ACCESS__KEY= <aws_access_key> \
			-e ES_CLOUD_AWS_SECRET__KEY= <aws_secrete_key> \
			-e ES_CLOUD_AWS_REGION= <aws_cloud_region> \
			-e ES_DISCOVERY_EC2_GROUPS=<aws_ec2_group> elastic_search