module NavigationHelper

  def internal_page? (url)
    ['', '/'].include? url
  end

end
