require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'
require 'dribbble/utils/updatable'

module Dribbble
  class Project < Dribbble::Base
    include Dribbble::Utils::Findable
    include Dribbble::Utils::Creatable
    include Dribbble::Utils::Updatable

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get("/projects/#{id}/shots", attrs)
    end
  end
end
