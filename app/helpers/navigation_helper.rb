module NavigationHelper

  def internal_page? (url)
    external = ['', '/'].include? url
    !external
  end

end
