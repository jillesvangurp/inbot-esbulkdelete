#!/usr/bin/env ruby
require 'elasticsearch'
require 'json'
require 'optparse'

def bulkdelete(host, query, page_size, index, type)
  client = Elasticsearch::Client.new log: false, host: host

  scrolltime='10m'

  results = client.search search_type: 'scan', scroll: scrolltime, size: page_size, body: query, fields: [], index: index, type: type
  puts "results: #{results.inspect}"
  while results = client.scroll(scroll_id: results['_scroll_id'], scroll: scrolltime) and not results['hits']['hits'].empty? do
    bulk_items=[]
    results['hits']['hits'].each { | hit |
      bulk_items << { delete: { _index: hit['_index'], _type: hit['_type'], _id: hit['_id']  } }
    }
    puts "bulk deleting #{bulk_items.length}"
    client.bulk body: bulk_items
  end
  puts "done"
end


#bulkdelete(host: 'localhost:9200',query: query, page_size: 1000)

options = {
  host: 'localhost:9200',
  index: '',
  type: ''
}

OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-h", "--host [HOST]", "Run verbosely") do | h |
    options[:host] = h
  end
  opts.on("-q", "--query QUERY", "Run verbosely") do | q |
    options[:query] = JSON.parse q
  end
  opts.on("-i", "--index INDEX", "Run verbosely") do | i |
    options[:index] = i
  end
  opts.on("-t", "--type TYPE", "Run verbosely") do | t |
    options[:type] = t
  end
end.parse!


if options[:query]
  puts options
  bulkdelete(options[:host], options[:query], 1000, options[:index], options[:type])
else
  puts "specify valid json query with -q"
end
