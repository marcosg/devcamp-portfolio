module BlogsHelper
  def blog_status_style(blog)
    'opacity: 0.5; color: red' if blog.draft?
  end
end
