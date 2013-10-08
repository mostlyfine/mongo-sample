# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/spec_helper'

describe 'App' do
  include Rack::Test::Methods

  def app
    @app ||= MongoSample::Application
  end

  it 'should respond to /' do
    get '/'
    last_response.should be_ok
  end

  it 'should respond to /users' do
    get '/users'
    last_response.should be_ok
  end
end


