# Introduction

Elasticsearch 1.5.3 deprecates the ability to delete documents by query over some performance concerns. The feature will be removed in 2.0. This ruby script implements delete using scan & scroll search and a bulk delete, as recommended.

# Disclaimer

This script deletes stuff. There is no confirmation step, dry-run, or other mechanism to protect you from yourself. So triple check your query before running this :-). Consider yourself warned.

# usage

```
bundle install
# delete all documents matching the query in any index/type
./esbulkdelete.rb -q '{"query":{"filtered":{"term":{"foo":"bar"}}}}'
# use a custom host (default is localhost:9200)
./esbulkdelete.rb -h localhost:1234 -q '{"query":{"filtered":{"term":{"foo":"bar"}}}}'

# use a custom host (default is localhost:9200), index, type
./esbulkdelete.rb -h localhost:1234 -q '{"query":{"filtered":{"term":{"foo":"bar"}}}}' -i tests -t test
```
