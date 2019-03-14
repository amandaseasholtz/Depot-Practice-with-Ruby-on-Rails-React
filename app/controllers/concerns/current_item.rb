module CurrentItem

  private

  def set_item
    @current_item = LineItem.find(session[:li])
  rescue ActiveRecord::RecordNotFound
    @current_item = LineItem.order("created_at").last
    session[:li] = @current_item.id
  end

end
