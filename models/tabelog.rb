# -*- coding: utf-8 -*-
require 'open-uri'
require 'active_support/core_ext'

class Tabelog
  class << self
    def api_url
      'http://api.tabelog.com/Ver2.1/RestaurantSearch'
    end

    def api_key
      ENV['TABELOG_APIKEY']
    end

    def default_params
      {Key: api_key, ResultSet: 'large'}
    end

    def search(params = {})
      params = default_params.merge params
      result = Hash.from_xml(open("#{api_url}?#{params.to_query}").read)
      result['RestaurantInfo']['Item']
    end
  end
end

