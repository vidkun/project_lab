module CanAdmin
  extend ActiveSupport::Concern

  private
    def can_admin?
      redirect_to root_path unless current_user.is_admin?
    end 
end   
