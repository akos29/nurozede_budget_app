class PagesController < ApplicationController
  def splash
    if user_signed_in?
      redirect_to groups_path # Redirect after login
    end
  end
end
