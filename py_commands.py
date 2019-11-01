import json
import uptasticsearch
from elasticsearch import Elasticsearch
from elasticsearch_dsl import Search
from pandas.io.json import json_normalize

# curl http://localhost:9200/utexas/_mapping > fields.json
# cat fields.json

query_dict = {"query": {"match_all": {}}}
query_string = '{"query": {"match_all": {}}}'

# Uptasticsearch
uptasticsearch.es_search(
   es_host="http://localhost:9200",
   query_body=query_string,
   es_index="utexas",
   max_hits = 10
)

# Elasticsearch-py
es = Elasticsearch(['http://localhost:9200'])
res = es.search(
   index="utexas", 
   body= query_dict,
   size = 10
)

#res['hits']['hits']
json_normalize(res['hits']['hits'])

# Elasticsearch-dsl
res2 = Search(using = es).query("match", _index = 'utexas').execute()
#res2.to_dict()['hits']['hits']
json_normalize(res2.to_dict()['hits']['hits'])


# Additional Queries
match_one = """{ 
  "query": { "match": { "ciptitle.raw": "COMPUTER SCIENCE"} }
}"""

match_one_greater_one = """{  
"query": 
   { "bool" : { 
      "must" : [ { "match": { "ciptitle.raw": "COMPUTER SCIENCE" } } 
      		   , { "range" : { "cellcount" : { "gt" : 0 } } } ] 
   } } 
}"""

match_two_greater_one = """{  
"query": 
   { "bool" : { 
      "must" : [ { "match": { "ciptitle.raw": "COMPUTER SCIENCE" } }
               , { "match": { "institution_id": "3599" } } 
      		   , { "range" : { "cellcount" : { "gt" : 0 } } } ] 
   } } 
}"""

query_and_filter = """{ "query":
   { "bool": { 
      "must": [ 
         { "match": { "ciptitle.raw": "AREA STUDIES" } }
         , { "match": { "deglevel": "Baccalaureate" } } 
      ] , 
      "filter": [ 
         { "match": {"institution_id": "3599" } } 
      ] 
   } } 
}"""

query_and_sort = """{ "query": 
	{ "bool" : { 
		"must" : [ { "range": { "p50_earnings": { "gte" : 75000 } } }
				 , { "match": { "institution_id": "3658" } }
       		     , { "range": { "cellcount" : { "gt" : 0 } } } ] 
	} 
},
"sort": {
   "ciptitle.raw": "asc" 
   }
}"""

summarize_one = """{
	"aggs": {
		"common_majors": {
			"terms": {
				"field": "ciptitle.raw" 
			}
		}
	}
}"""

json_normalize(res['aggregations']['common_majors']['buckets'])