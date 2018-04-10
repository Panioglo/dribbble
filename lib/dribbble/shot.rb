require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'
require 'dribbble/utils/updatable'
require 'dribbble/utils/deletable'
require 'dribbble/attachment'

module Dribbble
  class Shot < Dribbble::Base
    include Dribbble::Utils::Findable
    include Dribbble::Utils::Creatable
    include Dribbble::Utils::Updatable
    include Dribbble::Utils::Deletable

    has_many :attachments, :buckets, :likes, :projects
    has_many :rebounds, as: Dribbble::Shot

    def self.available_fields
      %i(title image description tags team_id rebound_source_id low_profile)
    end

    def self.after_create(res)
      res.code == 202 ? res.headers[:location].split('/').last : false
    end

    def create_attachments
      html_post "/shots/#{id}/attachments"
    end

    def delete_attachment(attachment_id)
      html_delete "/shots/#{id}/attachments/#{attachment_id}"
    end
  end
end
