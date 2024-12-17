class Public::FormSectionsController < ApplicationController
  
  def index
    @form_categories = FormCategory.all

    render json: {
      categories: @form_categories
    }
  end

  def get_categories
    @section = FormSection.find(eng_name: param[:id]).first rescue nil

    if @section
      @categories = @section.form_categories
    end

    render json: {
      section: @section,
      categories: @categories
    }
  end

  private 

    def set_form_section

    end
end
