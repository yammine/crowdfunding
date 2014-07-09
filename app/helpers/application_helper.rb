module ApplicationHelper

  def link_to_add_field(label, f, association)
    new_object = f.object.send(association).new
    # new_object = @campaign.reward_levels.new
    id         = new_object.object_id # random unique number
    fields = f.fields_for(association, new_object, child_index: id) do |rl|
      render(association.to_s.singularize + "_fields", f: rl)
      # want to render "reward_level_fields"
    end

    link_to(label, "javascript:void(0);", class: "btn btn-primary add_fields",
            data: { id: id, fields: fields.gsub("\n", "") })
  end


end
