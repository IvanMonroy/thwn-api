module Api
  class WorkController < ApplicationController
    #skip_before_filter :verify_authenticity_token
    respond_to :json
    def all
    end
    def default_serializer_options
      { root: false }
    end
  end
end