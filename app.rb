# -*- coding: utf-8 -*-
require 'bundler'
Bundler.require

module MongoSample
  class Application < Sinatra::Application

    configure :development do
      register Sinatra::Reloader
    end

    configure do
      enable :sessions, :logging
      set :session_secret, 'mongosample'
      set :haml, :format => :html5

      Mongoid.logger.level = production? ? Logger::WARN : Logger::DEBUG
      Mongoid.configure do |config|
        config.load!(File.expand_path 'mongoid.yml')
      end

      use OmniAuth::Builder do
        if ENV['CONSUMER_KEY'] and ENV['CONSUMER_SECRET']
          provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
        end

        if ENV['APP_ID'] and ENV['APP_SECRET']
          provider :facebook, ENV['APP_ID'],ENV['APP_SECRET'], :scope => 'email,read_stream'
        end
      end
    end

    Dir['models/*.rb'].each {|model| load model }

    get '/' do
      haml :index
    end

    get '/auth/:provider/callback' do
      @current_user = User.find_or_create_with_omniauth(request.env['omniauth.auth'])
      session[:uid] = @current_user.uid
      haml :home
    end

    get '/users' do
      @users = User.all
      haml :users
    end

    get '/logout' do
      session.clear
      redirect '/'
    end
  end
end
