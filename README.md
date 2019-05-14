# Elasticsearch for Analytics Workflows

Hello! This repo is home for all the supplementary materials to go with my presentations on Elasticsearch with R and/or Python. If you have questions, you can ask me on Twitter- `@data_stephanie`.git sta


## Startup/Shutdown
After cloning this repo, if you have Docker installed and running, you can spin up your own Elasticsearch database on your local machine. Move into the top level of this repository after you clone it, and run the following at command line:

```
./supporting_materials/setup_texas.sh 5.5
```

(This will use Elasticsearch version 5.5.) Look inside that file for more detailed commentary on what the bash script is doing.
For the purposes of my demo, you can populate your database quickly using this command:

```
curl -X POST 'http://localhost:9200/utexas/_bulk' -H 'Content-Type: application/json' --data-binary @supporting_materials/ut_data.json
```

Note that if you want to spin up an elasticsearch database for your own data, you'll need to edit the `setup_texas.sh` file to include a JSON schema that is appropriate for your data. Once you've gone through this tutorial, I hope it will not be too complicated to learn to do that, but that's beyond the purview of this single workshop.

When you are done with whatever work you are doing, close down the database with this:

```
./supporting_materials/cleanup_local.sh
```

(Bash files (.sh) are executable files for Linux/Unix that will run commands. These will work on Mac or Linux machines. If you are using Windows, you may need to do different things.)

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

