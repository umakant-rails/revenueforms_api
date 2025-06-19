class Public::BlankFormsController < ApplicationController

  def index 
    @forms = BlankForm.all.order('form_category_id ASC')
    @categories = FormCategory.all
    @forms = @forms.map{ |form| form.attributes.merge({
      cat_eng_name: form.form_category.eng_name,
      cat_hindi_name: form.form_category.hindi_name,
    })}

    render json: {
      forms: @forms,
      categories: @categories
    }
  end

  def get_districts
    # @districts = District.order("code ASC")
    # @districts = District.select('districts.id, districts.name, districts.name_eng, COUNT(villages.id) AS villages_count, SUM(villages.total_area_khasra) as area').joins(:villages).group('districts.id')
    @districts = District.joins(:villages).group('districts.id, districts.name, districts.name_eng')
      .select('districts.id, districts.name, districts.name_eng, 
        COUNT(villages.id) AS villages_count, 
        SUM(villages.total_area_khasra) as area
      ')

    tmp_district = @districts.map do | d | 
      {id: d.id, name: d.name, name_eng: d.name_eng, tehsils: d.tehsils.count, villages: d.villages_count, area: d.area}
    end

    render json: { districts: tmp_district }
  end

  def get_tehsils
    @district = District.find(params[:district_id]) rescue nil
    @tehsils = @district ? @district.tehsils.order("code ASC") : nil
    render json: { tehsils: @tehsils }
  end

  def get_tehsil_villages
    @tehsil = Tehsil.find(params[:tehsil_id]) rescue nil
    @villages = @tehsil ? @tehsil.villages.order("village_eng ASC") : nil
    @villages = @villages.map { | village |
      village.attributes.merge({district: village.district.name, tehsil: village.tehsil.name})
    }
    render json: { villages: @villages }
  end
  
  def get_district_villages
    @district = District.find(params[:district_id]) rescue nil
    # @villages = @district ? @district.villages.order("teshil_id, halka_number ASC") : nil
    # @villages = @villages.map { | village |
    #   village.attributes.merge({tehsil: village.tehsil.name})
    # }
    @tehsils = @district.tehsils
    @villages = @district.villages.includes(:tehsil).order(:tehsil_id, :halka_number).map { |village|  
      village.attributes.merge({tehsil: village.tehsil.name}) 
    }
    # @villages = Village.includes(:tehsil).where(district_id: params[:district_id]).order(:tehsil_id, :halka_number)map { |village|  
    #   village.attributes.merge({tehsil: village.tehsil.name}) 
    # }
    render json: { villages: @villages, tehsils: @tehsils }
  end

  def search_villages
    query = params[:query]
    @villages = Village.where("LOWER(village_eng) like ? or lgd_code like ? or village like ?", 
      "%#{query.downcase}%", "%#{query.downcase}%", "%#{query.downcase}%").map { |village|  
      village.attributes.merge({tehsil: village.tehsil.name, district: village.district.name}) 
    } 
    render json: { villages: @villages}
  end

end
