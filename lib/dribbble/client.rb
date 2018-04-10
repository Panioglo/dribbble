require 'dribbble/base'
require 'dribbble/shot'
require 'dribbble/user'
require 'dribbble/project'
require 'dribbble/errors'

require 'rest_client'
require 'json'

module Dribbble
  class Client < Dribbble::Base
    include Dribbble::Utils

    def initialize(token = nil)
      token = token.is_a?(Hash) ? token[:token] : token
      @token = token
      fail Dribbble::Error::MissingToken if @token.nil?
    end

    # Get authenticated user's likes
    def likes(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/likes', attrs), 'shot'
    end

    # Get authenticated user's followers
    def projects(attrs = {})
      Dribbble::Project.batch_new token, html_get('/user/projects', attrs)
    end

    # Get authenticated user's popular shots
    def popular_shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/popular_shots', attrs)
    end

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/shots', attrs)
    end

    # Get a single User or the authenticated one
    def user(oauth_token=nil)
      url = '/user'
      url += "?access_token=#{oauth_token}" unless oauth_token.nil?
      Dribbble::User.new @token, html_get(url)
    end
  end
end
