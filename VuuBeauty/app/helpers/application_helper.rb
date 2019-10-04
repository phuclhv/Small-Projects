module ApplicationHelper

  # Returns the full title on a per-page basis.
  # This will be available in all the views!
  def full_title(page_title = '')
    base_title = "Beauty Training System"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
