# -*- coding: utf-8 -*-
require 'open-uri'
require 'active_support'

class LocTouch
  class << self
    def api_url
      'https://api.loctouch.com/v1/spots/search'
    end

    def default_params
      {limit: 50}
    end

    def search(params = {})
      params = default_params.merge params
      ActiveSupport::JSON.decode(open("#{api_url}?#{params.to_query}").read)
    end
  end
end



