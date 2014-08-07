require 'uri'
require 'rattributes'

class RailsDbConfigResolver
  class DatabaseConfig

    include Rattributes.new(:adapter, :host, :port, :username, :password, :database, :pool)

    def self.from_url(url_string)
      url = URI.parse(url_string)

      pool = (url.query.match(/pool=(\d+)/)[1] if url.query)
      database = url.path[1..-1]

      new(
        adapter: url.scheme,
        host: url.host,
        port: url.port,
        username: url.user,
        password: url.password,
        database: database,
        pool: pool
      )
    end

    class << self
      alias_method :from_hash, :new
    end

    def initialize(*)
      super

      @pool = cast_to_integer_or_nil(@pool)
    end

    def to_hash
      {
        adapter: @adapter,
        host: @host,
        port: @port,
        username: @username,
        password: @password,
        database: @database,
        pool: @pool
      }
    end

    def to_url
      URI::Generic.build(build_url_hash).to_s
    end

    def merge(other)
      my_hash = to_hash
      other_hash = other.to_hash.reject { |_, value| value.nil? }
      self.class.from_hash(my_hash.merge(other_hash))
    end

  private

    def build_url_hash
      {
        scheme: @adapter,
        host: @host,
        port: @port,
        path: "/#{@database}"
      }.tap do |hash|
        hash[:query] = "pool=#{@pool}" if @pool
        hash[:userinfo] = [@username, @password].compact.join(':') if @username || @password
      end

    end

    def cast_to_integer_or_nil(object)
      return nil unless object.is_a?(Numeric) || /^\d+$/.match(object)
      object.to_i
    end

  end
end