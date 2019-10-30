install.packages(c("uptasticsearch", "jsonlite","elastic"))

uptasticsearch::get_fields(es_host = "http://localhost:9200", es_indices = "utexas")

query_string <- '{"query": {"match_all":{}}}'

# Uptasticsearch
test_up <- uptasticsearch::es_search(
  es_host = "http://localhost:9200"
  , es_index = "utexas"
  , query_body = query_string
  , size = 10)

# Elastic
conn = elastic::connect(es_host = "http://localhost:9200")

test_e <- elastic::Search(index = "utexas" 
                          , body = query_string
                          , size = 10
                          , raw = TRUE
                          , conn = conn)

jsonlite::fromJSON(test_e)$hits$hits


# Elastic without query language
test_e <- elastic::Search(
  index = "utexas"
  , q = "grad_cohort:*"
  , size = 10
  , conn = conn
  , raw = TRUE)

jsonlite::fromJSON(test_e)


# Additional Queries
match_one = '{ 
  "query": { "match": { "ciptitle.raw": "COMPUTER SCIENCE"} }
}'

match_one_greater_one = '{  
"query": 
   { "bool" : { 
      "must" : [ { "match": { "ciptitle.raw": "COMPUTER SCIENCE" } } 
      		   , { "range" : { "cellcount" : { "gt" : 0 } } } ] 
   } } 
}'

match_two_greater_one = '{  
"query": 
   { "bool" : { 
      "must" : [ { "match": { "ciptitle.raw": "COMPUTER SCIENCE" } }
               , { "match": { "institution_id": "3599" } } 
      		   , { "range" : { "cellcount" : { "gt" : 0 } } } ] 
   } } 
}'

query_and_filter = '{ "query":
   { "bool": { 
      "must": [ 
         { "match": { "ciptitle.raw": "AREA STUDIES" } }
         , { "match": { "deglevel": "Baccalaureate" } } 
      ] , 
      "filter": [ 
         { "match": {"institution_id": "3599" } }
      ] 
   } } 
}'

query_and_sort = '{ "query": 
	{ "bool" : { 
		"must" : [ { "range": { "p50_earnings": { "gte" : 75000 } } }
				 , { "match": { "institution_id": "3658" } }
       		     , { "range": { "cellcount" : { "gt" : 0 } } } ] 
	} 
},
"sort": {
   "ciptitle.raw": "asc" 
   }
}'

summarize_one = '{
	"aggs": {
		"common_majors": {
			"terms": {
				"field": "ciptitle.raw" 
			}
		}
	}
}'
