class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    photos_path
  end

  def after_update_path_for(_resource)
    photos_path
  end
end
