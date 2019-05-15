module ApplicationHelper
  def login_helper style = ''
    if signed_in?
      link_to 'Logout', destroy_user_session_path, method: :delete, class: style
    else
      (link_to 'Register', new_user_registration_path, class: style) +
      (link_to 'Login', new_user_session_path, class: style)
    end
  end

  def source_helper
    if !session[:source].blank?
      greeting = "Thanks for visiting me from #{session[:source]}"
      tag.p greeting, class: 'source-greeting'
    end
  end

  def copywrite_generator
    MgaligViewTool::Renderer.copywrite 'Marcos Galigarcia', 'All rights reserved'
  end

end
