require 'docx'
require 'rubyXL'

class FontConvertor

  def replace_symbols_kruti_to_unicode(modified_substring, array_one, array_two) 
    if ( modified_substring != "" ) 
      array_one.each_with_index do | ar_element, index |
        idx = 0
        while(idx != nil) do
          modified_substring = modified_substring.gsub(ar_element , array_two[index] )
          idx = modified_substring.index(ar_element)
        end
      end

      modified_substring = modified_substring.gsub( /±/ , "Zं" )  # at some places  ì  is  used eg  in "कर्कंधु,पूर्णांक".
      modified_substring = modified_substring.gsub( /Æ/ , "र्f" )   # at some places  Æ  is  used eg  in "धार्मिक".

      position_of_i = modified_substring.index( "f" )

      while ( position_of_i != nil ) do
        character_next_to_i = modified_substring[position_of_i + 1].chr rescue ""
        character_to_be_replaced = "f" + character_next_to_i
        modified_substring = modified_substring.gsub( character_to_be_replaced , character_next_to_i + "ि" ) 
        position_of_i = modified_substring.index( /f/)
      end 

      modified_substring = modified_substring.gsub( /Ç/ , "fa" )  # at some places  Ç  is  used eg  in "किंकर".
      modified_substring = modified_substring.gsub( /É/ , "र्fa" )  # at some places  É  is  used eg  in "शर्मिंदा"

      position_of_i = modified_substring.index( "fa" )

      while ( position_of_i != nil ) do
        character_next_to_ip2 = modified_substring[position_of_i + 2].chr rescue ""
        character_to_be_replaced = "fa" + character_next_to_ip2
        modified_substring = modified_substring.gsub( character_to_be_replaced , character_next_to_ip2 + "िं" ) 
        position_of_i = modified_substring.index( /fa/ ) # search for i ahead of the current position.
        ##look up to again if problem
      end # end of while-02 loop

      modified_substring = modified_substring.gsub( /Ê/ , "ीZ" )  # at some places  Ê  is  used eg  in "किंकर".
      position_of_wrong_ee = modified_substring.index( "ि्" ) 

      while ( position_of_wrong_ee != nil ) do
        consonent_next_to_wrong_ee = modified_substring[position_of_i + 2].chr rescue ""
        character_to_be_replaced = "ि्" + consonent_next_to_wrong_ee 
        modified_substring = modified_substring.gsub( character_to_be_replaced , "्" + consonent_next_to_wrong_ee + "ि" ) 
        position_of_wrong_ee = modified_substring.index( /ि्/) # search for 'wrong ee' ahead of the current position. 
      end # end of while-03 loop

      # Eliminating reph "Z" and putting 'half - r' at proper position for this.
      set_of_matras = "अ आ इ ई उ ऊ ए ऐ ओ औ ा ि ी ु ू ृ े ै ो ौ ं : ँ ॅ" 

      position_of_R = modified_substring.index( "Z" )

      # alert(" 1. modified_substring = "+modified_substring )
      # alert(" 2. position_of_R = "+position_of_R )

      while ( position_of_R != nil ) do
        probable_position_of_half_r = position_of_R - 1 
        #alert(" 3. probable_position_of_half_r = "+probable_position_of_half_r )
        character_at_probable_position_of_half_r = modified_substring[probable_position_of_half_r].chr
        #alert(" 4. character_at_probable_position_of_half_r = "+character_at_probable_position_of_half_r )

        #************************************************************
        # trying to find non-maatra position left to current O (ie, half -r).
        #************************************************************

        while ( set_of_matras.scan(character_at_probable_position_of_half_r).length > 0 ) do
          probable_position_of_half_r = probable_position_of_half_r - 1 
          character_at_probable_position_of_half_r = modified_substring[probable_position_of_half_r]
       
        end # end of while-05

        previous_to_position_of_half_r = probable_position_of_half_r - 1 


        if (previous_to_position_of_half_r > 0)  
          character_previous_to_position_of_half_r = modified_substring[previous_to_position_of_half_r]
          while (character_previous_to_position_of_half_r.scan("्").length > 0) do 
            probable_position_of_half_r = previous_to_position_of_half_r - 1 
            character_at_probable_position_of_half_r = modified_substring[probable_position_of_half_r]
            previous_to_position_of_half_r = probable_position_of_half_r - 1 
            character_previous_to_position_of_half_r = modified_substring[previous_to_position_of_half_r]
          end
        end

        character_to_be_replaced = modified_substring[probable_position_of_half_r , ( position_of_R - probable_position_of_half_r ) ]
        new_replacement_string = "र्" + character_to_be_replaced  
        character_to_be_replaced = character_to_be_replaced + "Z" 
        modified_substring = modified_substring.gsub( character_to_be_replaced , new_replacement_string ) 
        position_of_R = modified_substring.index( "Z" ) 
      end
    end
    return modified_substring
  end

  def replace_symbols_unicode_to_kruti(modified_substring, array_one, array_two) 
    if (modified_substring != "" )

      modified_substring = modified_substring.gsub(/त्र्य/, "«य" )
      modified_substring = modified_substring.gsub( /श्र्य/ , "Ü‍‍zय" )
      modified_substring = modified_substring.gsub( /क़/ , "क़" )
      modified_substring = modified_substring.gsub( /ख़‌/ , "ख़" )
      modified_substring = modified_substring.gsub( /ग़/ , "ग़" )
      modified_substring = modified_substring.gsub( /ज़/ , "ज़" )
      modified_substring = modified_substring.gsub( /ड़/ , "ड़" )
      modified_substring = modified_substring.gsub( /ढ़/ , "ढ़" )
      modified_substring = modified_substring.gsub( /ऩ/ , "ऩ" )
      modified_substring = modified_substring.gsub( /फ़/ , "फ़" )
      modified_substring = modified_substring.gsub( /य़/ , "य़" )
      modified_substring = modified_substring.gsub( /ऱ/ , "ऱ" )

      position_of_f = modified_substring.index( "ि" )
      while ( position_of_f != nil ) do
        character_left_to_f = modified_substring[position_of_f - 1].chr
        modified_substring = modified_substring.gsub(character_left_to_f + "ि" ,  "f" + character_left_to_f )
        position_of_f = position_of_f - 1 
        
        while (( modified_substring[position_of_f - 1].chr == "्" )  and  ( position_of_f != 0  ) ) do
          string_to_be_replaced = modified_substring[position_of_f - 2 ].chr + "्"
          modified_substring = modified_substring.gsub( string_to_be_replaced + "f", "f" + string_to_be_replaced ) ;
          position_of_f = position_of_f - 2
        end
        position_of_f = modified_substring.index( /ि/);
      end

      set_of_matras = "ािीुूृेैोौं:ँॅ" 
      modified_substring += '  '  
      position_of_half_R = modified_substring.index( "र्" ) ;
      while ( position_of_half_R != nil  ) do
        probable_position_of_Z = position_of_half_R + 2  
        character_at_probable_position_of_Z = modified_substring[probable_position_of_Z].chr

        while( set_of_matras.scan( character_at_probable_position_of_Z ).length > 0 ) do
          probable_position_of_Z = probable_position_of_Z + 1 ;
          character_at_probable_position_of_Z = modified_substring[probable_position_of_Z].chr
        end

        right_to_position_of_Z = probable_position_of_Z + 1 ;

        if (right_to_position_of_Z > 0) 
          character_right_to_position_of_Z = modified_substring[right_to_position_of_Z].chr
          while ( character_right_to_position_of_Z == "्" ) do 
             probable_position_of_Z = right_to_position_of_Z + 1;
             character_at_probable_position_of_Z = modified_substring[probable_position_of_Z].chr
             right_to_position_of_Z = probable_position_of_Z + 1;
             character_right_to_position_of_Z = modified_substring[right_to_position_of_Z].chr
          end
        end
        string_to_be_replaced = modified_substring[position_of_half_R + 2,(probable_position_of_Z - position_of_half_R)-1] ;
        modified_substring = modified_substring.gsub( "र्" + string_to_be_replaced, string_to_be_replaced + "Z" ) ;
        position_of_half_R = modified_substring.index( "र्" ) ;
      end

      modified_substring = modified_substring[0 , modified_substring.length - 2]

      # for(input_symbol_idx = 0; input_symbol_idx < array_one_length; input_symbol_idx++ ){
      #   idx = 0 # index of the symbol being searched for replacement
      #   while (idx != -1 ){
      #     modified_substring = modified_substring.replace( array_one[ input_symbol_idx ] , array_two[input_symbol_idx] )
      #     idx = modified_substring.indexOf( array_one[input_symbol_idx] )
      #   }
      # }
      array_one.each_with_index do | array_one_chr, index |
        idx = 0 
        while (idx != nil ) do
          modified_substring = modified_substring.gsub( array_one_chr , array_two[index] )
          idx = modified_substring.index(array_one_chr)
        end 
      end

    end
    modified_substring = modified_substring.gsub( /Zksa/ , "ksZa" )
    modified_substring = modified_substring.gsub( /~ Z/ , "Z~" )
    modified_substring = modified_substring.gsub( /Zk/ , "kZ" )
    modified_substring = modified_substring.gsub( /Zh/ , "Ê" )
  end

  def convert_kruti_to_unicode(sourceTextElement) 
    array_one = [ 
      "ñ","Q+Z","sas","aa",")Z","ZZ","‘","’","“","”",
      "å","ƒ","„","…","†","‡","ˆ","‰","Š","‹", 
      "¶+","d+","[+k","[+","x+","T+","t+","M+","<+","Q+",";+","j+","u+",
      "Ùk","Ù","ä","–","—","é","™","=kk","f=k",  
      "à","á","â","ã","ºz","º","í","{k","{","=","«",   
      "Nî","Vî","Bî","Mî","<î","|","K","}",
      "J","Vª","Mª","<ªª","Nª","Ø","Ý","nzZ","æ","ç","Á","xz","#",":",
      "v‚","vks","vkS","vk","v","b±","Ã","bZ","b","m","Å",",s",",","_",
      "ô","d","Dk","D","£","[k","[","x","Xk","X","Ä","?k","?","³", 
      "p","Pk","P","N","t","Tk","T",">","÷","¥",
      "ê","ë","V","B","ì","ï","M+","<+","M","<",".k",".",    
      "r","Rk","R","Fk","F",")","n","/k","èk","/","Ë","è","u","Uk","U",   
      "i","Ik","I","Q","¶","c","Ck","C","Hk","H","e","Ek","E",
      ";","¸","j","y","Yk","Y","G","o","Ok","O",
      "'k","'","\"k","\"","l","Lk","L","g", 
      "È","z", 
      "Ì","Í","Î","Ï","Ñ","Ò","Ó","Ô","Ö","Ø","Ù","Ük","Ü",
      "‚","¨","ks","©","kS","k","h","q","w","`","s","¢","S",
      "a","¡","%","W","•","·","∙","·","~j","~","\\","+"," ः",
      "^","*","Þ","ß","(","¼","½","¿","À","¾","A","-","&","&","Œ","]","~ ","@",
      "ाे","ाॅ","ंै","े्र","अौ","अो","आॅ"]

    array_two = [ 
      "॰","QZ+","sa","a","र्द्ध","Z","\"","\"","'","'",
      "०","१","२","३","४","५","६","७","८","९",   
      "फ़्","क़","ख़","ख़्","ग़","ज़्","ज़","ड़","ढ़","फ़","य़","ऱ","ऩ",    # one-byte nukta varNas
      "त्त","त्त्","क्त","दृ","कृ","न्न","न्न्","=k","f=",
      "ह्न","ह्य","हृ","ह्म","ह्र","ह्","द्द","क्ष","क्ष्","त्र","त्र्", 
      "छ्य","ट्य","ठ्य","ड्य","ढ्य","द्य","ज्ञ","द्व",
      "श्र","ट्र","ड्र","ढ्र","छ्र","क्र","फ्र","र्द्र","द्र","प्र","प्र","ग्र","रु","रू",
      "ऑ","ओ","औ","आ","अ","ईं","ई","ई","इ","उ","ऊ","ऐ","ए","ऋ",
      "क्क","क","क","क्","ख","ख","ख्","ग","ग","ग्","घ","घ","घ्","ङ",
      "च","च","च्","छ","ज","ज","ज्","झ","झ्","ञ",
      "ट्ट","ट्ठ","ट","ठ","ड्ड","ड्ढ","ड़","ढ़","ड","ढ","ण","ण्",   
      "त","त","त्","थ","थ्","द्ध","द","ध","ध","ध्","ध्","ध्","न","न","न्",    
      "प","प","प्","फ","फ्","ब","ब","ब्","भ","भ्","म","म","म्",  
      "य","य्","र","ल","ल","ल्","ळ","व","व","व्",   
      "श","श्","ष","ष्","स","स","स्","ह", 
      "ीं","्र",    
      "द्द","ट्ट","ट्ठ","ड्ड","कृ","भ","्य","ड्ढ","झ्","क्र","त्त्","श","श्",
      "ॉ","ो","ो","ौ","ौ","ा","ी","ु","ू","ृ","े","े","ै",
      "ं","ँ","ः","ॅ","ऽ","ऽ","ऽ","ऽ","्र","्","?","़",":",
      "‘","’","“","”",";","(",")","{","}","=","।",".","-","µ","॰",",","् ","/",
      "ो","ॉ","ैं","्रे","औ","ओ","ऑ"]

    array_one_length = array_one.length 
    # modified_substring = document.getElementById("legacy_text").value  
    # text_size = document.getElementById("legacy_text").value.length 
    modified_substring = sourceTextElement  
    text_size = sourceTextElement.length 
    processed_text = ''   #blank
    sthiti1 = 0   
    sthiti2 = 0   
    chale_chalo = 1 
    max_text_size = 6000

    while ( chale_chalo == 1 ) do
      sthiti1 = sthiti2 

      if ( sthiti2 < ( text_size - max_text_size ) ) 
        sthiti2 +=  max_text_size 
        # while (document.getElementById("legacy_text").value.charAt ( sthiti2 ) != ' ') {sthiti2--}
        while (sourceTextElement.charAt ( sthiti2 ) != ' ') do
          sthiti2 = sthiti2 - 1
        end
      else  
        sthiti2 = text_size
        chale_chalo = 0 
      end

      #modified_substring = document.getElementById("legacy_text").value.substring ( sthiti1, sthiti2 );
      modified_substring = sourceTextElement[sthiti1, sthiti2]  

      modified_substring = self.replace_symbols_kruti_to_unicode(modified_substring, array_one, array_two)

      processed_text = modified_substring    
      #document.getElementById("unicode_text").value = processed_text
      #outputTextElement.value = processed_text
    end

    return processed_text
  end

  def convert_unicode_to_kruti(sourceTextElement) 
    array_one = [
      "‘","’","“","”","(",")","{","}","=","।","?","-","µ","॰",",",".","् ", 
      "०","१","२","३","४","५","६","७","८","९","x","+",";","_",
      "फ़्","क़","ख़","ग़","ज़्","ज़","ड़","ढ़","फ़","य़","ऱ","ऩ",
      "त्त्","त्त","क्त","दृ","कृ",
      "श्व","ह्न","ह्य","हृ","ह्म","ह्र","ह्","द्द","क्ष्","क्ष","त्र्","त्र","ज्ञ",
      "छ्य","ट्य","ठ्य","ड्य","ढ्य","द्य","द्व",
      "श्र","ट्र","ड्र","ढ्र","छ्र","क्र","फ्र","द्र","प्र","ग्र","रु","रू",
      "्र",
      "ओ","औ","आ","अ","ई","इ","उ","ऊ","ऐ","ए","ऋ",
      "क्","क","क्क","ख्","ख","ग्","ग","घ्","घ","ङ",
      "चै","च्","च","छ","ज्","ज","झ्","झ","ञ",
      "ट्ट","ट्ठ","ट","ठ","ड्ड","ड्ढ","ड","ढ","ण्","ण",  
      "त्","त","थ्","थ","द्ध","द","ध्","ध","न्","न",  
      "प्","प","फ्","फ","ब्","ब","भ्","भ","म्","म",
      "य्","य","र","ल्","ल","ळ","व्","व", 
      "श्", "श",  "ष्", "ष",  "स्",   "स",   "ह",     
      "ऑ","ॉ","ो","ौ","ा","ी","ु","ू","ृ","े","ै",
     "ं","ँ","ः","ॅ","ऽ","् ","्","़","/"]

    array_two = [ 
      "^","*","Þ","ß","¼","½","¿","À","¾","A","\\","&","&","Œ","]","-","~ ", 
      "å","ƒ","„","…","†","‡","ˆ","‰","Š","‹","Û","$","(","&",
      "¶+","d+","[k+","x+","T+","t+","M+","<+","Q+",";+","j+","u+",
      "Ù","Ùk","ä","–","—",       
      "Üo","à","á","â","ã","ºz","º","í","{","{k","«","=","K", 
      "Nî","Vî","Bî","Mî","<î","|","}",
      "J","Vª","Mª","<ªª","Nª","Ø","Ý","æ","ç","xz","#",":",
      "z",
      "vks","vkS","vk","v","bZ","b","m","Å",",s",",","_",
      "D","d","ô","[","[k","X","x","?","?k","³", 
      "pkS","P","p","N","T","t","÷",">","¥",
      "ê","ë","V","B","ì","ï","M","<",".",".k",   
      "R","r","F","Fk",")","n","è","èk","U","u",   
      "I","i","¶","Q","C","c","H","Hk","E","e",
      "¸",";","j","Y","y","G","O","o",
      "'","'k","\"","\"k","L","l","g",      
      "v‚","‚","ks","kS","k","h","q","w","`","s","S",
      "a","¡","%","W","·","~ ","~","+","@"
    ]

    array_one_length = array_one.length
    modified_substring = sourceTextElement 
    text_size = sourceTextElement.length 
    processed_text = ''
    sthiti1 = 0 
    sthiti2 = 0
    chale_chalo = 1
    max_text_size = 6000

    while ( chale_chalo == 1 ) do
      sthiti1 = sthiti2 

      if ( sthiti2 < ( text_size - max_text_size ) ) 
        sthiti2 +=  max_text_size 
        while (sourceTextElement[sthiti2].chr != ' ') do
          sthiti2 = sthiti2 - 1
        end
      else 
        sthiti2 = text_size
        chale_chalo = 0
      end
      modified_substring = sourceTextElement[sthiti1, sthiti2]
      modified_substring = self.replace_symbols_unicode_to_kruti(sourceTextElement, array_one, array_two)
      processed_text = modified_substring
    end
   
    return processed_text
  end

  # def convert_docs_kruti_to_unicode(file_path)
  #   doc = Docx::Document.open(file_path)
  #   doc.paragraphs.each do |p|
  #     translated = self.convert_kruti_to_unicode(p.text)
  #     p.text = translated
  #   end
  #   return doc
  # end

  def convert_docs_kruti_to_unicode(docs)
    docs.paragraphs.each do |p|
      translated = self.convert_kruti_to_unicode(p.text)
      p.text = translated
    end
    return docs
  end

  def convert_docs_unicode_to_kruti(docs)
    docs.paragraphs.each do |p|
      translated = self.convert_unicode_to_kruti(p.text)
      p.text = translated
    end
    return docs
  end

  def convert_xls_kruti_to_unicode(xls_book)
    new_workbook = RubyXL::Workbook.new
    new_worksheet = new_workbook[0]
    sheet1 = xls_book.worksheets[0]

    sheet1.each_with_index do |row, row_index|
      row.cells.each_with_index do | cell, cell_index |
        if [1, 2].include?(cell_index) && row_index != 0
          translated_text = convert_kruti_to_unicode(cell.value)
          new_worksheet.add_cell(row_index, cell_index, translated_text) 
        else
          new_worksheet.add_cell(row_index, cell_index, cell.value)
          # print "#{row_index}  #{cell_index} #{cell.value} \n"
        end 
      end 
    end
    columns = new_workbook.worksheets[0][1]
    print columns.cells.collect{|c| c.value }
    new_workbook.write('test.xlsx')
  end

  def convert_xls_unicode_to_kruti(xls_book)
    new_workbook = RubyXL::Workbook.new
    new_worksheet = new_workbook[0]
    sheet1 = xls_book.worksheets[0]

    sheet1.each_with_index do |row, row_index|
      row.cells.each_with_index do | cell, cell_index |
        if [1, 2].include?(cell_index) && row_index != 0
          translated_text = convert_unicode_to_kruti(cell.value)
          new_worksheet.add_cell(row_index, cell_index, translated_text) 
        else
          new_worksheet.add_cell(row_index, cell_index, cell.value)
          # print "#{row_index}  #{cell_index} #{cell.value} \n"
        end 
      end 
    end
    columns = new_workbook.worksheets[0][1]
    print columns.cells.collect{|c| c.value }
    new_workbook.write('test1.xlsx')
  end

end
# def get_worksheet_as_string
#   workbook = RubyXL::Workbook.new
#   # Fill workbook here or leave as is to download empty
#   send_data workbook.stream.string, filename: "myworkbook.xlsx",
#                                     disposition: 'attachment'
# end