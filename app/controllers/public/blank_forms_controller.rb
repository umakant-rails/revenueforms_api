class Public::BlankFormsController < ApplicationController

  def index 
    @forms = BlankForm.all.order('form_category_id ASC')

    @forms = @forms.map{ |form| form.attributes.merge({
      cat_eng_name: form.form_category.eng_name,
      cat_hindi_name: form.form_category.hindi_name,
    })}

    render json: {
      forms: @forms
    }
  end

  def get_districts
    @districts = District.order("code ASC")

    render json: { districts: @districts }
  end

  def get_tehsils
    @district = District.find(params[:district_id]) rescue nil
    @tehsils = @district ? @district.tehsils.order("code ASC") : nil
    render json: { tehsils: @tehsils }
  end

  def get_villages
    @tehsil = Tehsil.find(params[:tehsil_id]) rescue nil
    @villages = @tehsil ? @tehsil.villages.order("village_code ASC") : nil
    @villages = @villages.map { | village |
      village.attributes.merge({district: village.district.name, tehsil: village.tehsil.name})
    }
    render json: { villages: @villages }
  end
end
