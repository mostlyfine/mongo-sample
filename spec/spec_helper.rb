# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', 'app.rb')
require 'rubygems'
require 'rack/test'
require 'rspec'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

