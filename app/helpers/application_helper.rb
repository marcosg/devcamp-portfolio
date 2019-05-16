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

  def nav_items
    [
      { title: 'Home'     ,     url: root_path       },
      { title: 'About Me' ,     url: about_me_path   },
      { title: 'Contact'  ,     url: contact_path    },
      { title: 'Blog'     ,     url: blogs_path      },
      { title: 'Portfolio',     url: portfolios_path }
    ]
  end

  def nav_helper tag_type, style

    nav_links = ''
    nav_items.each do |item|
      nav_links <<
          "<#{tag_type}>" +
            link_to(item[:title], item[:url], class: style + active?(item[:url])) +
          "</#{tag_type}>"
    end

    nav_links.html_safe
  end

  def active?(path)
    current_page?(path) ? ' active' : ''
  end

end
