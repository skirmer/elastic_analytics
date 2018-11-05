# Elasticsearch for Analytics Workflows

Hello! This repo is home for all the supplementary materials to go with my presentations on Elasticsearch with R and/or Python. If you have questions, you can ask me on Twitter- @data_stephanie.


## Startup/Shutdown
After cloning this repo, if you have Docker installed and running, you can spin up your own Elasticsearch database on your local machine. Run the following at command line:

```
./supporting_materials/setup_texas.sh 5.5
```

(This will use Elasticsearch version 5.5.) When you are done with whatever work you are doing, close down the database with this:

```
./supporting_materials/cleanup_local.sh
```

(Bash files (.sh) are executable files for Linux/Unix that will run commands. These will work on any Mac or Linux machines. If you are using Windows, you may need to do different things.)

***

## Other Contents
In the `supporting_materials` folder you'll find:

 * The `ut_grad_earn.feather` data file - University of Texas graduates earnings data by major, campus, and degree.  
 * The `ut_data.json` data file - the same as the above, just converted to JSON format.
 * The schema for the database: `data_mapping.json`  

All the materials are specific for the tutorials, but you can use these as examples and templates for your own work! 

***

## Reference and Further Reading

### ES Query Language  

* http://elasticsearch-cheatsheet.jolicode.com/  
* https://elasticsearch-dsl.readthedocs.io/en/latest/search_dsl.html  
* https://www.elastic.co/guide/en/elasticsearch/reference/current/_introducing_the_query_language.html  
* https://www.elastic.co/guide/en/elasticsearch/reference/6.4/query-dsl-bool-query.html  
* https://www.elastic.co/guide/en/elasticsearch/reference/6.4/query-filter-context.html  


### Library Docs

* https://elasticsearch-py.readthedocs.io/en/master/index.html  
* https://github.com/ropensci/elastic  
* https://github.com/UptakeOpenSource/uptasticsearch – Make improvements, the packages are always looking for contributors!  

***

## Data Credit
The data being used in this tutorial is from data.world, and comes out of the hard work done by Annie Millerbernd of the San Antonio Express-News. You can learn more about it and see the original dataset here: https://data.world/amillerbernd/ut-system-post-grad-earnings

