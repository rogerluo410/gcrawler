# Crawl google result by keywords
#
# Dependences:
#   gem 'wombat'
#

require 'wombat'
require 'uri'
require 'logger'
require_relative './utils'

LOGGER = Logger.new(STDOUT)

# Crawl action
class Crawler
  include Wombat::Crawler

  def query_str(val)
    setting
    path "/search?#{val}"
  end

  base_url "https://#{Utils.random_domain}/"

  private

  def setting
    proxy = Utils.random_proxy
    user_agent = Utils.random_user_agent
    mechanize.set_proxy(*proxy) if proxy.length == 2
    mechanize.user_agent = user_agent

    LOGGER.info "proxy: #{proxy}, user_agent: #{user_agent}"
  end
end

# Google crawler
class GoogleCrawler
  attr_accessor :exclude_hosts

  def initialize(proxies: [], black_domains: [], exclude_hosts: [])
    @exclude_hosts = exclude_hosts
    Utils.proxies = proxies
    Utils.black_domains = black_domains

    @crawler = Crawler.new
  end

  # search as url
  def search_as_url(*keywords, language: nil, num: nil, country: nil, start: 0, pause: 0)
    search_as_page(*keywords, language: language, num: num, country: country, start: start, pause: pause)

    filter_urls
  end

  # search as object with keys {'text', 'url'}
  def search_as_object(*keywords, language: nil, num: nil, country: nil, start: 0, pause: 0)
    search_as_page(*keywords, language: language, num: num, country: country, start: start, pause: pause)

    generate_objects
  end

  # search as page
  # Args:
  #   keywords (varargs): kw1, kw2, kw3, ...
  #   language (str, optional): Query language. Defaults to nil.
  #   num (uint, optional): Number of results per page(default is 10 per page). Defaults to nil.
  #   start (int, optional): Offset. Defaults to 0.
  #   country (str, optional): Query country, Defaults to None, example: countryCN or cn or CN.
  #   pause (uint, optional): Set crawling delay seconds bwtween two requests. 
  #                           Too short which may be forbidden by Google crawling monitor. Defaults to nil.
  #
  # Return:
  #   Mechanize::Page, see https://github.com/sparklemotion/mechanize
  #
  def search_as_page(*keywords, language: nil, num: nil, country: nil, start: 0, pause: 0)
    return if keywords.empty?

    query_str = "q=#{keywords.join('+')}&btnG=Search&gbv=1&safe=active&start=0"
    query_str += "&ln=#{language}" unless language.blank?
    query_str += "&num=#{num.to_i}" unless num.blank?
    query_str += "&cr=#{country}" unless country.blank?
    query_str.gsub!(/start=0/, "start=#{start}") unless start == 0

    @crawler.query_str(query_str)

    seconds = pause.zero? ? Utils.random_interval_time : pause
    LOGGER.info "Crawling query string is #{query_str}, will be crawling after #{seconds} seconds..."
    sleep(seconds)

    @crawler.crawl

    raise "Fetch on Google failed with code #{@crawler.response_code}" unless @crawler.response_code == 200

    LOGGER.info 'Crawl on Google successfully...'
  end

  private

  def filter_urls
    urls = @crawler.page&.links&.map do |link_node|
      uri_str = link_node.uri.to_s

      if uri_str.start_with?(%r{/url\?q=}) && !@exclude_hosts.include?(URI.parse(uri_str.split(%r{/url\?q=})[1])&.host)
        real_uri = uri_str.split(%r{/url\?q=})[1]
      end
      real_uri
    end

    urls.compact
  end

  def generate_objects
    objects = @crawler.page&.links&.map do |link_node|
      uri_str = link_node.uri.to_s

      if uri_str.start_with?(%r{/url\?q=}) && !@exclude_hosts.include?(URI.parse(uri_str.split(%r{/url\?q=})[1])&.host)
        node = { text: link_node.text,
                 url: uri_str.split(%r{/url\?q=})[1] }
      end

      node
    end

    objects.compact
  end
end
