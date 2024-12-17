class Public::FormCategoriesController < ApplicationController

  def index
    @categories = FormCategory.all
    render json: {categories: @categories}
  end

  def get_forms
    @category = FormCategory.where(eng_name: params[:id]).first rescue nil
    @categories = FormCategory.all()
    @forms = @category.blank_forms if @category
    @forms = @forms.map{ |form| form.attributes.merge(category: form.form_category.eng_name)}

    render json: {
      categories: @categories,
      category: @category,
      forms: @forms
    }
  end

end
