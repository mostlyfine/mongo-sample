# -*- coding: utf-8 -*-
require 'mongoid'

class User
  include Mongoid::Document
  include Mongoid::Timestamps::Updated
  include Mongoid::Timestamps::Created

  field :uid, type: String
  field :name, type: String
  field :screen_name, type: String
  field :image, type: String

  def self.find_or_create_with_omniauth(auth)
    user = where(uid: auth['uid']).first
    unless user
      user = create! do |user|
        user.uid = auth['uid']
        user.name = auth['info']['name']
        user.screen_name = auth['info']['nickname']
        user.image = auth['info']['image']
      end
    end
    user
  end
end
