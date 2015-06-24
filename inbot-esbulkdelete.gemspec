Gem::Specification.new do |s|
  s.name        = 'inbot-esbulkdelete'
  s.version     = '1.0'
  s.date        = '2015-06-24'
  s.summary     = "script to bulk delete documents in elasticsearch that match a query"
  s.description = "Elasticsearch 1.6 removed the delete by query feature. This script implements the recommended practice of a scroll query and bulk delete."
  s.authors     = ["Jilles van Gurp"]
  s.email       = 'incoming@jillesvangurp.xom'
  s.files       = ["esbulkdelete.rb"]
  s.homepage    = 'https://github.com/inbot/inbot-esbulkdelete'
  s.licenses    = ['Expat']
end
