class PagesController < ApplicationController
  def splash
    return unless user_signed_in?

    redirect_to groups_path # Redirect after login
  end
end
