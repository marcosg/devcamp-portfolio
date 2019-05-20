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

  def alerts
    # :alert and :notice included by rails, add additional types in application_controller
    alert_types = {error: :error,
                   warning: :warning,
                   alert: :warning,
                   notice: :notice,
                   success: :success,
    }
    alerts=[]
    alert_image = nil

    # show alerts in order of alert_types
    alert_types.each do |type, image|
      if flash[type]
        alerts.push flash[type]
        alert_image ||= image
      end
    end
    alert_generator(alerts, alert_image) unless alerts.empty?
  end

  def alert_generator msgs, image = nil
    gritter_images = [:success, :warning, :notice, :error, :progress]
    image = :notice unless gritter_images.include?(image)
    msgs = Array.wrap(msgs) 
    if msgs.count > 1
      message = "<ul class='pl-3'> #{msgs.map{ |m| '<li>' + m + '</li>' }.join()} </ul>"
    else
      message = msgs.join()
    end
    js add_gritter(message,
                   title: image.to_s.pluralize(msgs.count).titleize,
                   sticky: image == :error,
                   image: image
       )
  end
end
