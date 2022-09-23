require 'gcrawler'

proxies = [
  { ip: '127.0.0.1', port: '7890' }
]

exclude_hosts = [
  'accounts.google.com',
  'support.google.com'
]

google_crawler = GoogleCrawler.new(proxies: proxies, exclude_hosts: exclude_hosts)

# Output: Mechanize::Page, see https://github.com/sparklemotion/mechanize
pp google_crawler.search_as_page('お肉とチーズの専門店', 'ミートダルマ札幌店')

# Output: [{text: , url:}, ...]
pp google_crawler.search_as_object('お肉とチーズの専門店', 'ミートダルマ札幌店', country: 'ja')

# Output: ['url1', 'url2', ...]
pp google_crawler.search_as_url('お肉とチーズの専門店', 'ミートダルマ札幌店', country: 'ja')
