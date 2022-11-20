ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :category_id, :price, :description
  permit_params :name, :category_id, :price, :description, :image
  #
  # or
  form do |f|
    #   f.semantic_errors
    #   f.inputs
    # end
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size: '50x50') : ''
    end
    f.actions
  end
  #
  # permit_params do
  #   permitted = [:name, :category_id, :price, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
