# Gcrawler

Google search crawler for Ruby version.

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

```

Function args definition: 

    search_as_page:
        Args:
            keywords (varargs): kw1, kw2, kw3, ...
            language (str, optional): Query language. Defaults to nil.
            num (uint, optional): Number of results per page(default is 10 per page). Defaults to nil.
            start (int, optional): Offset. Defaults to 0.
            country (str, optional): Query country, Defaults to None, example: countryCN or cn or CN
    
        Return:
            Mechanize::Page, see https://github.com/sparklemotion/mechanize


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
