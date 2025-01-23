# frozen_string_literal: true

require 'forwardable'
require 'uri'

# BEGIN
class Url
  include Comparable
  extend Forwardable

  def_delegators :@uri, :scheme, :host, :port

  attr_accessor :uri

  def initialize(uri)
    @uri = URI(uri)
  end

  def query_params
    return {} unless @uri.query
    URI.decode_www_form(@uri.query).to_h.transform_keys(&:to_sym)
  end

  def query_param(key, value = nil)
    query_params[key] || value
  end

  def <=>(other)
    query_params <=> other.query_params if [uri.scheme, uri.host, uri.port] == [other.scheme, other.host, other.port]
  end
end
# END
yandex = Url.new 'http://yandex.ru'
google = Url.new 'http://google.com'

puts yandex == google

