Role.create(name: 'Admin') if Role.where(name: 'Admin')
Role.create(name: 'Public User') if Role.where(name: 'Public User')

#create request types
request_types = [{name: "नामांतरण"}, {name: "बटवारा (पिता-पुत्र)"}, {name: "बटवारा (आपसी सहमति)"}, {name: "फौती"}]
request_types.each { |rt| RequestType.create(rt) if RequestType.where(rt).blank? }

#create participant types
participant_types = [
  {name: "क्रेता"}, {name: "विक्रेता"}, {name: "करांदा-आम"}, {name: "फौत व्यक्ति"},
  {name: "वारसान"}, {name: "मूल भू स्वामी"}, {name: "नए हिस्सेदार"}, {name: "मूल भू स्वामी एवं हिस्सेदार"}
]
participant_types.each { |pt| ParticipantType.create(pt) if ParticipantType.where(pt).blank? }

# create form_sections
sections = [
  {eng_name: "Revenue", hindi_name: "राजस्व"}, 
  {eng_name: "Govt Employee", hindi_name: "सरकारी कर्मचारी"}
]
sections.each { |section| FormSection.create(section) if FormSection.where(section).blank? }

rev_section = FormSection.where(eng_name: "Revenue", hindi_name: "राजस्व")[0] rescue nil
categories = [
  {hindi_name: "लोकसेवा फॉर्म", eng_name: 'Loksewa Form', description: "यहॉं पर लोकसेवा से सम्बन्धित फार्म उपलब्ध है जैसे:- स्थाई निवास प्रमाण पत्र, जाति प्रमाण पत्र, डिजिटल जाति प्रमाण पत्र, जन्म मृत्यु प्रमाण पत्र, सम्बल आवेदन पत्र, ई डब्ल्यू एस आवेदन पत्र, बी पी एल आवेदन पत्र, आय प्रमाण पत्र, डिजिटल प्रतिलिपि (खसरा/नक्शा/आदेश) आवेदन, रिकार्डरूम प्रतिलिपि (खसरा/नक्शा/आदेश) आवेदन आदि।"}, 
  {hindi_name: "पीएम किसान फॉर्म", eng_name: 'PM Kisan Form', description: "यहॉं पर पीएम पोर्टल से सम्बन्धित फॉर्म उपलब्ध है जैसे:- हितग्राही आवेदन (अपात्र से पात्र), पटवारी प्रतिवेदन, तहसीलदार पत्र, नायब तहसीलदार पत्र, पटवारी प्रतिवेदन (अपात्रता), आधार लिंकिंग/एन पी सी आई फॉर्म आदि।"},
  {hindi_name: "नामांतरण फॉर्म", eng_name: 'Namantaran Form', description: "यहॉं पर हितग्राही के राजस्व रिकॉर्ड में क्रय/विक्रय नामान्तरण से सम्बन्धित फॉर्म उपलब्ध है।"},
  {hindi_name: "फौती फॉर्म", eng_name: 'Fouti Form', description: "यहॉं पर हितग्राही के राजस्व रिकॉर्ड में फौती नामान्तरण से सम्बन्धित फॉर्म उपलब्ध है।"},
  {hindi_name: "सीमांकन फॉर्म", eng_name: 'Seemankan Form', description: "यहॉं पर हितग्राही के राजस्व रिकॉर्ड में भूमि सीमांकन से सम्बन्धित फॉर्म उपलब्ध है।"},
  {hindi_name: "राजस्व फॉर्म", eng_name: 'Revenue Form', description: "यहॉं पर राजस्व के कार्य से सम्बन्धित पटवारी हेतु फार्म उपलब्ध है जैसे:- फॉर्म सी, फसल बुआई प्रमाण पत्र, पट्टा भूमि विक्रय हेतु अनुमति आवेदन, विक्रय इकरारनामा फॉर्म, राजस्व वसूली फॉर्म आदि।"},
  {hindi_name: "नाबालिगी खारिज फार्म", eng_name: 'Nabaligi Form', description: "यहॉं पर हितग्राही के राजस्व रिकॉर्ड में दर्ज नाबालिग किसान को बालिग दर्ज करने से सम्बन्धित फॉर्म उपलब्ध है।"},
]



if rev_section.present?
  categories.each { | category | rev_section.form_categories.create(category) if rev_section.form_categories.where(category).blank? }
end

govtemp_section =  FormSection.where(eng_name: "Govt Employee", hindi_name: "सरकारी कर्मचारी").first
if govtemp_section.present?
  category = {hindi_name: "सरकारी कर्मचारी फॉर्म", eng_name: 'Govt Employee Form', description: "यहॉं पर सरकारी कर्मचारी से सम्बन्धित फार्म उपलब्ध है जैसे:- अर्जित अवकाश आवेदन फॉर्म, फॉर्म 16, फॉर्म 12(C), चिकित्सा प्रमाण पत्र (मेडिकल अवकाश), चिकित्सा प्रमाण पत्र (मेडिकल फिटनेस) आदि।"}
  govtemp_section.form_categories.create(category) if govtemp_section.form_categories.where(category).blank?
end

revenue_forms = {
  "Loksewa Form" => [
    {eng_name: "Income Certificate", form_name: "LK Income Certificate", hindi_name: "आय प्रमाण पत्र", },
    {eng_name: "Domicile Certificate", form_name: "LK Domicile Certificate", hindi_name: "स्थाई निवास प्रमाण पत्र"},
    {eng_name: "Cast Certificate", form_name: "LK Cast Certificate", hindi_name: "जाति प्रमाण पत्र"},
    {eng_name: "Digital Cast Certificate", form_name: "LK Digital Cast Certificate", hindi_name: "डिजिटल जाति प्रमाण पत्र"},
    {eng_name: "Birth And Death Certificate", form_name: "LK Birth And Death Certificate", hindi_name: "जन्म मृत्यु प्रमाण पत्र"},
    {eng_name: "Sambal Form", form_name: "LK Sambal Form",hindi_name: "सम्बल आवेदन पत्र"},
    {eng_name: "EWS Form", form_name: "LK EWS Form",hindi_name: "ई डब्ल्यू एस आवेदन पत्र"},
    {eng_name: "BPL Form", form_name: "LK BPL Form",hindi_name: "बी पी एल आवेदन पत्र"},
    {eng_name: "Marriage Form", form_name: "LK Marriage Form",hindi_name: "विवाह पंजीयन फॉर्म"},
    {eng_name: "Digital Copy Application", form_name: "LK Digital Copy Application",hindi_name: "डिजिटल प्रतिलिपि (खसरा/नक्शा/आदेश) आवेदन"},
    {eng_name: "Record Room Copy Application", form_name: "LK Record Room Copy Application", hindi_name: "रिकार्डरूम प्रतिलिपि (खसरा/नक्शा/आदेश) आवेदन"},
  ],
  "PM Kisan Form"  => [
    {eng_name: "Applicant Application", form_name: "PM Applicant Application", hindi_name: "आवेदक का आवेदन"},
    {eng_name: "Patwari Prativedan", form_name: "PM Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन"},
    {eng_name: "Tehsildar Letter", form_name: "PM Tehsildar Letter", hindi_name: "तहसीलदार पत्र"},
    {eng_name: "Nayab Tehsildar Letter", form_name: "PM Nayab Tehsildar Letter", hindi_name: "नायब तहसीलदार पत्र"},
    {eng_name: "Patwari Prativedan Ineligibility", form_name: "PM Patwari Prativedan Ineligibility", hindi_name: "पटवारी प्रतिवेदन (अपात्रता)"},
    {eng_name: "Aadhar Seeding NPCI Form", form_name: "PM Aadhar Seeding NPCI Form", hindi_name: "आधार लिंकिंग/एन पी सी आई फॉर्म"},
  ],
  "Namantaran Form" => [
    {eng_name: "Ordersheet First", form_name: "NM Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम"},
    {eng_name: "Ordersheet Second", form_name: "NM Ordersheet Second", hindi_name: "ऑर्डरशीट द्वितीय"},
    {eng_name: "Applicant Application", form_name: "NM Applicant Application", hindi_name: "आवेदक आवेदन"},
    {eng_name: "Non Applicant Application", form_name: "NM Non Applicant Application", hindi_name: "अनावेदक आवेदन"},
    {eng_name: "Applicant Affidavit", form_name: "NM Applicant Affidavit", hindi_name: "आवेदक शपथ पत्र"},
    {eng_name: "Non Applicant Affidavit", form_name: "NM Non Applicant Affidavit", hindi_name: "अनावेदक शपथ पत्र"},
    {eng_name: "Ishtihar", form_name: "NM Ishtihar", hindi_name: "इश्तिहार"},
    {eng_name: "Kathan", form_name: "NM Kathan", hindi_name: "कथन"},
    {eng_name: "Talwana", form_name: "NM Talwana", hindi_name: "तलवाना"},
    {eng_name: "Patwari Prativedan", form_name: "NM Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन"}
  ],
  "Fouti Form" => [ 
    {eng_name: "Ordersheet First", form_name: "FT Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम"},
    {eng_name: "Ordersheet Second", form_name: "FT Ordersheet Second", hindi_name: "ऑर्डरशीट द्वितीय"},
    {eng_name: "Applicant Application", form_name: "FT Applicant Application", hindi_name: "आवेदक आवेदन"},
    {eng_name: "Applicant Affidavit", form_name: "FT Applicant Affidavit", hindi_name: "आवेदक शपथ पत्र"},
    {eng_name: "Ishtihar", form_name: "FT Ishtihar", hindi_name: "इश्तिहार"},
    {eng_name: "Talwana", form_name: "FT Talwana", hindi_name: "तलवाना"},
    {eng_name: "Patwari Prativedan", form_name: "FT Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन"}
  ],
  "Seemankan Form" => [
    {eng_name: "Ordersheet First", form_name: "SM Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम"},
    {eng_name: "RI Letter", form_name: "SM RI Letter", hindi_name: "आर आई पत्र"},
    {eng_name: "Seemankan Form1", form_name: "Seemankan Form1", hindi_name: "सीमांकन फॉर्म - प्रथम"},
    {eng_name: "Seemankan Form2", form_name: "Seemankan Form2", hindi_name: "सीमांकन फॉर्म - द्वितीय"},
    {eng_name: "Seemankan Form3", form_name: "Seemankan Form3", hindi_name: "सीमांकन फॉर्म - तृतीय"},
    {eng_name: "Seemankan Suchna Patra", form_name: "Seemankan Suchna Patra", hindi_name: "सीमांकन सूचना पत्र"}
  ],
  "Revenue Form" => [
    {eng_name: "Form C", form_name: "PT Form C", hindi_name: "फॉर्म सी"},
    {eng_name: "Crop Sowing", form_name: "PT Crop Sowing", hindi_name: "फसल बुआई प्रमाण पत्र"},
    {eng_name: "Lease Land Sell Permission", form_name: "PT Lease Land Sell Permission", hindi_name: "पट्टा भूमि विक्रय हेतु अनुमति आवेदन"},
    {eng_name: "Land Selling Ikrarnama", form_name: "PT Land Selling Ikrarnama", hindi_name: "विक्रय इकरारनामा फॉर्म"},
    {eng_name: "Revenue Demand Form", form_name: "PT Revenue Demand Form", hindi_name: "राजस्व वसूली फॉर्म"},
    {eng_name: "TRS Kharif Form", form_name: "PT TRS Kharif Form", hindi_name: "टीआरएस खरीफ फॉर्म"},
    {eng_name: "TRS Rabi Form", form_name: "PT TRS Rabi Form", hindi_name: "टीआरएस रबी फॉर्म"},
    {eng_name: "Crop Cutting Form", form_name: "PT Crop Cutting Form", hindi_name: "फसल कटाई प्रयोग फॉर्म"},

    {eng_name: 'Record Correction Report', hindi_name: 'अभिलेख दुरुस्ती प्रतिवेदन', form_name: 'Record Correction Report'},
    {eng_name: 'Illegal Colony Report', hindi_name: 'अवैध कॉलोनी प्रतिवेदन', form_name: 'Illegal Colony Report'},
    {eng_name: 'Report for Registration of Tubewell/Well', hindi_name: 'नलकूप/कुआ दर्ज करने का प्रतिवेदन', form_name: 'Tubewell Registration Report'},
    {eng_name: 'Report for De-irrigation of Irrigated Land', hindi_name: 'सिंचित से असिंचित दर्ज किये जाने का प्रतिवेदन', form_name: 'Report for Deirrigation'},
    {eng_name: 'Report For Will', hindi_name: 'वसीयत हेतु प्रतिवेदन', form_name: 'Report For Will'},
    {eng_name: 'Revenue Notice', hindi_name: 'राजस्व मामले में नोटिस', form_name: 'Revenue Notice'},
  
    {hindi_name: 'पीएम किसान सेल्फ रजिस्ट्रेशन प्रतिवेदन', eng_name: 'PM Kisan Self Registration Prativedan', form_name: 'PM Kisan Self Registration Prativedan'},
    {hindi_name: 'फसल क्षति पत्रक', eng_name: 'Fasal Kshati Patrak', form_name: 'Fasal Kshati Patrak'},
    {hindi_name: 'एम पी भूलेख रजिस्ट्रेशन फॉर्म', eng_name: 'MP Bhulekh Registration Form', form_name: 'MP Bhulekh Registration Form'},
  ],
  "Nabaligi Form" => [ 
    {eng_name: "Ordersheet First", form_name: "NB Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम"},
    {eng_name: "Ordersheet Second", form_name: "NB Ordersheet Second", hindi_name: "ऑर्डरशीट द्वितीय"},
    {eng_name: "Applicant Application", form_name: "NB Applicant Application", hindi_name: "आवेदक आवेदन"},
    {eng_name: "Applicant Affidavit", form_name: "NB Applicant Affidavit", hindi_name: "आवेदक शपथ पत्र"},
    {eng_name: "Ishtihar", form_name: "NB Ishtihar", hindi_name: "इश्तिहार"},
    {eng_name: "Patwari Prativedan", form_name: "NB Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन"}
  ],
}

rev_form_section = FormSection.where(eng_name: "Revenue", hindi_name: "राजस्व").first
if rev_form_section.present?
  rev_form_section.form_categories.each do | category | 
    forms = revenue_forms[category.eng_name];
    forms && forms.each  do |form| 
      category.blank_forms.create(form) if category.blank_forms.where(form).blank? 
    end
    # forms.each { |form| category.blank_forms.create(form) if category.blank_forms.where(form).blank? }
  end 
end


# create form for govt employee section
govt_emp_forms = [
  {eng_name: "Earning Leave Application", form_name: 'EMP Earning Leave Application', hindi_name: "अर्जित अवकाश आवेदन"},
  {eng_name: "Form 16", form_name: "EMP Form 16", hindi_name: "फॉर्म 16"},
  {eng_name: "Form 12C", form_name: "EMP Form 12C", hindi_name: "फॉर्म 12(C)"},
  {eng_name: "Medical Leave Form 4", form_name: "EMP Medical Leave Form 4", hindi_name: "चिकित्सा प्रमाण पत्र (मेडिकल अवकाश)"},
  {eng_name: "Medical Leave Form 3", form_name: "EMP Medical Leave Form 3",hindi_name: "चिकित्सा प्रमाण पत्र (मेडिकल फिटनेस)"},
]

emp_category =  FormCategory.where(hindi_name: "सरकारी कर्मचारी फॉर्म", eng_name: 'Govt Employee Form').first
if emp_category.present?
  govt_emp_forms.each do | form | 
    emp_category.blank_forms.create(form) if emp_category.blank_forms.where(form).blank?
  end 
end


