module ProductValidation
  extend ActiveSupport::Concern
  included do
    #validate :delete_entry, :on => :destroy

  end


end