# Gcrawler

[![Gem Version](https://badge.fury.io/rb/gcrawler.svg)](https://badge.fury.io/rb/gcrawler)
[![Coverage Status](https://coveralls.io/repos/github/rogerluo410/gcrawler/badge.svg?branch=master)](https://coveralls.io/github/rogerluo410/gcrawler?branch=master)
[![GitHub license](https://img.shields.io/github/license/rogerluo410/gcrawler)](https://img.shields.io/github/license/rogerluo410/gcrawler)

Google search crawler for Ruby version. Crawling each links' text and url by keywords on Google.com.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gcrawler'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install gcrawler

## Usage

```ruby
    require 'gcrawler'

    # Set proxy server, multiple IPs should be much safer than single IP.
    proxies = [
        { ip: '127.0.0.1', port: '7890' },
        ...
    ]

    # Exclude the hosts from results' links.
    exclude_hosts = [
        'accounts.google.com',
        'support.google.com'
    ]

    # Disable to search in the black domains.
    black_domains = [
        'www.google.at',
        'www.google.bf'
    ]

    google_crawler = GoogleCrawler.new(
        proxies: proxies, 
        black_domains: black_domains, 
        exclude_hosts: exclude_hosts
    )

    # Output: Mechanize::Page, see https://github.com/sparklemotion/mechanize
    pp google_crawler.search_as_page('お肉とチーズの専門店', 'ミートダルマ札幌店')

    # Output: [{text: , url:}, ...]
    pp google_crawler.search_as_object('お肉とチーズの専門店', 'ミートダルマ札幌店', country: 'ja')

    # Output: ['url1', 'url2', ...]
    pp google_crawler.search_as_url('お肉とチーズの専門店', 'ミートダルマ札幌店', country: 'ja')

    # Get the second page:
    pp google_crawler.search_as_url('お肉とチーズの専門店', 'ミートダルマ札幌店', country: 'ja', start: 10)

```

Function Input and Output definition: 

    search_as_page:
        Args:
            keywords (varargs): kw1, kw2, kw3, ...
            language (str, optional): Query language. Defaults to nil.
            num (uint, optional): Number of results per page(default is 10 per page). Defaults to nil.
            start (int, optional): Offset. Defaults to 0.
            country (str, optional): Query country, Defaults to None, example: countryCN or cn or CN.
            pause (uint, optional): Set crawling delay seconds between two crawling requests. 
                                    Too short which may be forbidden by Google crawling monitor. 
                                    Defaults to 0.
    
        Return:
            Mechanize::Page, see https://github.com/sparklemotion/mechanize

  
    search_as_url:
        Args:
            keywords (varargs): kw1, kw2, kw3, ...
            language (str, optional): Query language. Defaults to nil.
            num (uint, optional): Number of results per page(default is 10 per page). Defaults to nil.
            start (int, optional): Offset. Defaults to 0.
            country (str, optional): Query country, Defaults to None, example: countryCN or cn or CN.
            pause (uint, optional): Set crawling delay seconds between two crawling requests. 
                                    Too short which may be forbidden by Google crawling monitor. 
                                    Defaults to 0.
    
        Return:
            ['url1', 'url2', ...]

    
    search_as_object:
        Args:
            keywords (varargs): kw1, kw2, kw3, ...
            language (str, optional): Query language. Defaults to nil.
            num (uint, optional): Number of results per page(default is 10 per page). Defaults to nil.
            start (int, optional): Offset. Defaults to 0.
            country (str, optional): Query country, Defaults to None, example: countryCN or cn or CN.
            pause (uint, optional): Set crawling delay seconds between two crawling requests. 
                                    Too short which may be forbidden by Google crawling monitor. 
                                    Defaults to 0.
    
        Return:
            [{text: xxx, url: xxx}, ...]


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/gcrawler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/gcrawler/blob/master/CODE_OF_CONDUCT.md).

## Inspiration

gcrawler is greatly inspired by [Python version](https://github.com/howie6879/magic_google) for Ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gcrawler project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gcrawler/blob/master/CODE_OF_CONDUCT.md).
