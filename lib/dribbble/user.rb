require 'dribbble/utils/findable'

module Dribbble
  class User < Dribbble::Base
    include Dribbble::Utils::Findable

    has_many :buckets, :projects, :shots
    has_many :likes, as: Dribbble::Shot, key: 'shot'
    has_many :followers, as: Dribbble::User, key: 'follower'
    has_many :following, as: Dribbble::User, key: 'followee'

    def teams
      Dribbble::Team.batch_new token, @raw['teams']
    end

    def following?(other_user_id = nil)
      if other_user_id
        html_get "/users/#{id}/following/#{other_user_id}"
      else
        html_get "/user/following/#{id}"
      end
      true
    rescue RestClient::ResourceNotFound
      false
    end

    def follow!
      res = html_put "/users/#{id}/follow"
      res.code == 204 ? true : false
    end

    def unfollow!
      res = html_delete "/users/#{id}/follow"
      res.code == 204 ? true : false
    end
  end
end
