ActiveAdmin.register Category do
  menu label: "#{I18n.t('activerecord.models.category')} 관리"
  config.sort_order = "position_asc"
  config.paginate   = false

  controller do
  end

  scope -> { "전체" }, :all

  filter :title_cont, label: "#{I18n.t('activerecord.attributes.category.title')} 필터"

  reorderable

  index as: :reorderable_table do
    id_column
    column :image do |category| image_tag(category.image_path, class: "admin-index-image") end
    column :title
    column :created_at
    column :updated_at

    actions
  end

  show do
    attributes_table do
      row :image do |category| image_tag(category.image_path, class: "admin-show-image") end
      row :id
      row :title
      row :body
      row :position
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
      f.input :position
      f.input :image
    end
    f.actions
  end
end
