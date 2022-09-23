module Utils
  @domains = File.readlines(File.join(File.dirname(__FILE__), './data/domains.txt'))
  @user_agents = File.readlines(File.join(File.dirname(__FILE__), './data/user_agents.txt'))
  @proxies = []
  @black_domains = []

  class << self
    attr_reader :proxies, :black_domains

    def proxies=(proxies)
      @proxies = proxies unless proxies.empty?
    end

    def black_domains=(black_domains)
      @black_domains = black_domains unless black_domains.empty?
    end

    def random_domain
      (@domains - @black_domains).sample.gsub(/[\r\n]+/, '')
    end

    def random_user_agent
      @user_agents.sample.gsub(/[\r\n]+/, '')
    end

    def random_interval_time
      (20..59).to_a.sample
    end

    def random_proxy
      proxy = @proxies.sample
      return [proxy[:ip], proxy[:port].to_i] unless proxy.nil?

      []
    end
  end
end
