class CampaignDecorator < Draper::Decorator
  delegate_all

  def target
    "$#{object.target}"
  end

  def end_date
    object.end_date.strftime("%d %B, %Y")
  end

  def cancel_button
    h.button_to "Cancel", h.campaign_path(object, campaign: {state: :cancelled}), 
    method: :patch, class: "btn btn-danger", data: {confirm: "Are you sure?"}
  end

  def publish_button
    h.button_to "Publish", h.campaign_path(object, campaign: {state: :published}),
    method: :patch, class: "btn btn-success", data: {confirm: "Are you sure?"}
  end


  def label
     if object.draft?
      # %span.label.label-warning Draft
      title     = "Draft"
      css_class = "label-default"
    elsif object.published?
      # %span.label.label-success.label-lg Live
      title     = "Published"
      css_class = "label-success"
    elsif object.expired?
      title     = "Expired"
      css_class = "label-warning"
      # %span.label.label-info.label-lg Expired
    elsif object.cancelled?
      title     = "Cancelled"
      css_class = "label-danger"
      # %span.label.label-danger.label-lg Cancelled
    end
    h.content_tag(:span, title, class: "label #{css_class}")
  end

  def action_button
    if show_published
      publish_button
    elsif show_cancel
      cancel_button
    end
  end

  def show_cancel
    object.published? && (h.can? :cancel, object)
  end

  def show_published
    object.draft? && (h.can? :publish, object)
  end

  # link_to "Publish", campaign_path(@campaign, campaign: {state: :published}), method: :patch, class: "btn btn-info getaway"
  # link_to "Cancel", campaign_path(@campaign, campaign: {state: :cancelled}), method: :patch, class: "btn btn-danger", data: {confirm: "Are you sure?"}

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
