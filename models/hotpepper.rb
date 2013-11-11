# -*- coding: utf-8 -*-
require 'open-uri'
require 'active_support/core_ext'

class HotPepper
  class << self
    def api_url
      'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/'
    end

    def api_key
      ENV['HOTPEPPER_APIKEY']
    end

    def default_params
      {key: api_key, range: 1, count: 50, format: 'xml'}
    end

    def search(params = {})
      params = default_params.merge params
      puts "#{api_url}?#{params.to_query}"
      result = Hash.from_xml(open("#{api_url}?#{params.to_query}").read)
      result['results']['shop']
    end
  end
end


