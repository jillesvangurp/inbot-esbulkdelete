#!/usr/bin/env ruby
require 'elasticsearch'

def bulkdelete(host, query, page_size)
  client = Elasticsearch::Client.new log: false, host: host

  scrolltime='10m'

  results = client.search search_type: 'scan', scroll: scrolltime, size: page_size, body: query, fields: []

  while results = client.scroll(scroll_id: results['_scroll_id'], scroll: scrolltime) and not results['hits']['hits'].empty? do
    bulk_items=[]
    results['hits']['hits'].each { | hit |
      bulk_items << { delete: { _index: hit['_index'], _type: hit['_type'], _id: hit['_id']  } }
    }
    client.bulk body: bulk_items
  end
end


query={
  query: {
    filtered: {
      filter: {
        match_all: {}
      }
    }
  }
}

bulkdelete(host: 'localhost:9200',query: query, page_size: 1000)
