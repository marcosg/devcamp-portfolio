module ApplicationHelper
  def login_helper
    if signed_in?
      link_to 'Logout', destroy_user_session_path, method: :delete
    else
      (link_to 'Register', new_user_registration_path) + ' | ' +
      (link_to 'Login', new_user_session_path)
    end
  end

  def source_helper
    if !session[:source].blank?
      greeting = "Thanks for visiting me from #{session[:source]}"
      tag.p greeting, class: 'source-greeting'
    end
  end

end
