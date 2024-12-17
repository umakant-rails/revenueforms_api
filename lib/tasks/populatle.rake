require 'simple_xlsx_reader'

desc 'Populate models with sample data'
task :populate_villages => [ :environment ] do

  workbook = SimpleXlsxReader.open '/home/rails/react_work/revenueform_api/lib/tasks/villagemaster.xlsx'
  worksheets = workbook.sheets
  puts "Found #{worksheets.count} worksheets"

  district_eng, tehsil_eng = '', ''
  district, tehsil = nil , nil
  created_district = 0;

  worksheets.each do |worksheet|
    num_rows = 0
    worksheet.rows.each_with_index do |row, index|
      if index > 0
       
        # create if a new district found
        if district_eng != row[1]
          params = {code: row[0].split("-")[0], name: row[0].split("-")[1], name_eng: row[1]}
          if District.where(params).blank?
            district = District.create!(params)
            print ("A new district created: #{row[0]}")
            created_district = created_district + 1
          else
            district = District.where(code: row[0].split("-")[0], name_eng: row[1]).first rescue nil
          end
        end

        if created_district > 10
          break;
        end

        # create if a new teshil found
        if tehsil_eng != row[3]
          params = {code: row[2].split("-")[0], name: row[2].split("-")[1], name_eng: row[3]}
          if Tehsil.where(params).blank?
            tehsil = district.tehsils.create!(params)
            print ("A new teshil created: #{row[2]}")
          else
            tehsil = district.tehsils.where(code: row[2].split("-")[0], name_eng: row[3]).first rescue nil
          end
        end

        village_params = {
          district_id: district.id,
          tehsil_id: tehsil.id,
          ri_code: row[4].split("-")[0].to_i,
          ri: row[4].split("-")[1],
          ri_eng: row[5],
          halka_number: row[6].split("-")[0], #.to_i,
          halka_name: row[6].split("-")[1],
          halka_name_eng: row[7],
          village_code: row[8].split("-")[0], #.to_i,
          village: row[8].split("-")[1],
          village_eng: row[9],
          bhucode_lr: row[10],
          lgd_code: row[11],
          data_available_since: row[12],
          map_available: row[13],
          ulb_name: row[14],
          village_type: row[15],
          is_khasra_available: row[16],
          khasra_count: row[17].to_i,
          total_area_khasra: row[18],
          map_parcel_count: row[19].to_i,
          total_area_map: row[20],
          aabaadi_survey: row[21],
          ulnpin_plot: row[22].to_i,
          ulpin_khasra: row[23].to_i,
          patwari_name: row[24],
          mobile: row[25].to_i,
        }

        if tehsil.villages.where(village_code: row[8].split("-")[0], village_eng: row[9]).blank?
          tehsil.villages.create!(village_params)
        end
        puts "#{index} is entered"
      end
    end
  end
end
