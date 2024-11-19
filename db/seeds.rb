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
  {hindi_name: 'लोकसेवा फॉर्म', eng_name: 'Loksewa Form'},
  {hindi_name: 'पी एम किसान फॉर्म', eng_name: 'PM Kisan Form'},
  {hindi_name: "नामांतरण फॉर्म", eng_name: 'Namantaran Form'},
  {hindi_name: "फौती फॉर्म", eng_name: 'Fouti Form'},
  {hindi_name: "सीमांकन फॉर्म", eng_name: 'Seemankan Form'},
  {hindi_name: "अन्य फॉर्म (पटवारी)", eng_name: 'Other Form'}
]
if rev_section.present?
  categories.each { | category | rev_section.form_categories.create(category) if rev_section.form_categories.where(category).blank? }
end

govtemp_section =  FormSection.where(eng_name: "Govt Employee", hindi_name: "सरकारी कर्मचारी").first
if govtemp_section.present?
  category = {hindi_name: "सरकारी कर्मचारी फॉर्म", eng_name: 'Govt Employee Form'}
  govtemp_section.form_categories.create(category) if govtemp_section.form_categories.where(category).blank?
end

revenue_forms = {
  "Loksewa Form" => [
    {eng_name: "Income Certificate", hindi_name: "आय प्रमाण पत्र", },
    {eng_name: "Domicile Certificate", hindi_name: "स्थाई निवास प्रमाण पत्र"},
    {eng_name: "Cast Certificate", hindi_name: "जाति प्रमाण पत्र"},
    {eng_name: "Digital Cast Certificate", hindi_name: "डिजिटल जाति प्रमाण पत्र"},
    {eng_name: "Birth And Death Certificate", hindi_name: "जन्म मृत्यु प्रमाण पत्र"},
    {eng_name: "Sambal Form", hindi_name: "सम्बल आवेदन पत्र"},
    {eng_name: "EWS Form", hindi_name: "ई डब्ल्यू एस आवेदन पत्र"},
    {eng_name: "BPL Form", hindi_name: "बी पी एल आवेदन पत्र"},
    {eng_name: "Application For Digital Copy", hindi_name: "डिजिटल प्रतिलिपि (खसरा/नक्शा/आदेश) आवेदन"},
    {eng_name: "Application For Record Room Copy", hindi_name: "रिकार्डरूम प्रतिलिपि (खसरा/नक्शा/आदेश) आवेदन"},
  ],
  "PM Kisan Form"  => [
    {eng_name: "Applicant Application", hindi_name: "आवेदक का आवेदन"},
    {eng_name: "Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन"},
    {eng_name: "Tehsildar Letter", hindi_name: "तहसीलदार पत्र"},
    {eng_name: "Nayab Tehsildar Letter", hindi_name: "नायब तहसीलदार पत्र"},
    {eng_name: "Patwari Prativedan Ineligiblity", hindi_name: "पटवारी प्रतिवेदन (अपात्रता)"},
    {eng_name: "Gram Secretary Death Certificate", hindi_name: "मृत्यु प्रमाण पत्र (ग्राम सचिव)"},
    {eng_name: "Aadhar Seeding NPCI Form", hindi_name: "आधार लिंकिंग/एन पी सी आई फॉर्म"},
  ],
  "Namantaran Form" => [
    {eng_name: "Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम"},
    {eng_name: "Ordersheet Second", hindi_name: "ऑर्डरशीट द्वितीय"},
    {eng_name: "Applicant Application", hindi_name: "आवेदक आवेदन"},
    {eng_name: "Non Applicant Application", hindi_name: "अनावेदक आवेदन"},
    {eng_name: "Applicant Affidavit", hindi_name: "आवेदक शपथ पत्र"},
    {eng_name: "Non Applicant Affidavit", hindi_name: "अनावेदक शपथ पत्र"},
    {eng_name: "Ishtihar", hindi_name: "इश्तिहार"},
    {eng_name: "Kathan", hindi_name: "कथन"},
    {eng_name: "Talwana", hindi_name: "तलवाना"},
    {eng_name: "Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन"}
  ],
  "Fouti Form" => [ 
    {eng_name: "Ordersheet First", hindi_name: "ऑर्डरशीट प्रथम"},
    {eng_name: "Ordersheet Second", hindi_name: "ऑर्डरशीट द्वितीय"},
    {eng_name: "Applicant Application", hindi_name: "आवेदक आवेदन"},
    {eng_name: "Applicant Affidavit", hindi_name: "आवेदक शपथ पत्र"},
    {eng_name: "Ishtihar", hindi_name: "इश्तिहार"},
    {eng_name: "Talwana", hindi_name: "तलवाना"},
    {eng_name: "Patwari Prativedan", hindi_name: "पटवारी प्रतिवेदन"}
  ],
  "Seemankan Form" => [
    {eng_name: "Seemankan Form1", hindi_name: "सीमांकन फॉर्म - प्रथम"},
    {eng_name: "Seemankan Form2", hindi_name: "सीमांकन फॉर्म - द्वितीय"},
    {eng_name: "Seemankan Form3", hindi_name: "सीमांकन फॉर्म - तृतीय"},
    {eng_name: "Seemankan Suchna Patra", hindi_name: "सीमांकन सूचना पत्र"}
  ],
  "Other Form" => [
    {eng_name: "Form C", hindi_name: "फॉर्म सी"},
    {eng_name: "Crop Sowing", hindi_name: "फसल बुआई प्रमाण पत्र"},
    {eng_name: "Lease Land Sell Permission Form", hindi_name: "पट्टा भूमि विक्रय हेतु अनुमति आवेदन"},
    {eng_name: "Land Selling Ikrarnama Form", hindi_name: "विक्रय इकरारनामा फॉर्म"},
    {eng_name: "Revenue Demand Form", hindi_name: "राजस्व वसूली फॉर्म"}
  ]
}

rev_form_section = FormSection.where(eng_name: "Revenue", hindi_name: "राजस्व").first
if rev_form_section.present?
  rev_form_section.form_categories.each do | category | 
    forms = revenue_forms[category.eng_name];
    forms.each { |form| category.blank_forms.create(form) if category.blank_forms.where(form).blank? }
  end 
end


# create form for govt employee section
govt_emp_forms = [
  {eng_name: "Earning Leave Application Form", hindi_name: "अर्जित अवकाश आवेदन फॉर्म"},
  {eng_name: "Form 16", hindi_name: "फॉर्म 16"},
  {eng_name: "Form 12C", hindi_name: "फॉर्म 12(C)"},
  {eng_name: "Medical Leave Form 4", hindi_name: "चिकित्सा प्रमाण पत्र (मेडिकल अवकाश)"},
  {eng_name: "Medical Leave Form 3", hindi_name: "चिकित्सा प्रमाण पत्र (मेडिकल फिटनेस)"},
]

emp_category =  FormSection.where(hindi_name: "सरकारी कर्मचारी फॉर्म", eng_name: 'Govt Employee Form').first
if emp_category.present?
  govt_emp_forms.each do | form | 
    emp_category.blank_forms.create(form) if emp_category.blank_forms.where(form).blank?
  end 
end


