namespace :harvest do
  desc "backfill_hours: Updates last four weeks of hours. Does not overwrite bounties already paid."
  task :bacon => :environment do

    ####

    doc = Nokogiri::HTML(open('/Users/brendan/team-pleb-govathon/lib/tasks/test.html'))

    puts doc.class

    INDEX =[]

    (1..1767).each do |num|
      INDEX << num*2
    end

    for i in INDEX do

  #/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td/table/tbody/tr/td[2]
  #/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td/table/tbody/tr/td[5]
  #/html/body/table[2]/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/p/text()
  #/html/body/table[2]/tbody/tr/td/table/tbody/tr[2]/td/table/tbody/tr[2]/td[2]/p/a/




   @MEETING_DATE = doc.xpath('/html/body/table[2]/tbody/tr/td/table/tbody/tr[%s]/td/table/tbody/tr/td[2]/text()' % (i-1)).to_s

   @MEETING_ID = doc.xpath('/html/body/table[2]/tbody/tr/td/table/tbody/tr[%s]/td/table/tbody/tr/td[5]/text()' % (i-1)).to_s
   @MEETING_TEXT = doc.xpath('/html/body/table[2]/tbody/tr/td/table/tbody/tr[%s]/td/table/tbody/tr[1]/td[2]/p/text()' % i).to_s
   @MEETING_LINK = doc.xpath('/html/body/table[2]/tbody/tr/td/table/tbody/tr[%s]/td/table/tbody/tr[2]/td[2]/p/a/text()' % i).to_s

   @MEETING_TITLE = @MEETING_TEXT[(0..27)]

   	@YEA_LOCATION = @MEETING_TEXT.index(/YEA/,0)
   	@NAY_LOCATION = @MEETING_TEXT.index(/NAY/, 0)
   	
   	if @YEA_LOCATION && @NAY_LOCATION
   	  @YEA_VOTE_BEGIN= @MEETING_TEXT.index(/\s/, @YEA_LOCATION - 4) + 1
     	@YEA_VOTE_END= @MEETING_TEXT.index(/\s/, @YEA_LOCATION - 2) - 1
     	@MEETING_YEA = @MEETING_TEXT[(@YEA_VOTE_BEGIN..@YEA_VOTE_END)]


   	
     	@NAY_VOTE_BEGIN= @MEETING_TEXT.index(/\s/, (@NAY_LOCATION - 4)) + 1
     	@NAY_VOTE_END= @MEETING_TEXT.index(/\s/,(@NAY_LOCATION - 2)) - 1
    	@MEETING_NAY = @MEETING_TEXT[(@NAY_VOTE_BEGIN)..(@NAY_VOTE_END)]
 

    if @MEETING_TEXT.include?("Carla")
    	@DISTRICT = 1
    elsif @MEETING_TEXT.include?("Kwanza")
    	@DISTRICT = 2
    elsif @MEETING_TEXT.include?("Ivory")
    	@DISTRICT = 3
    elsif @MEETING_TEXT.include?("Winslow")
    	@DISTRICT = 4
    elsif @MEETING_TEXT.include?("Archibong")
    	@DISTRICT = 5
    elsif @MEETING_TEXT.include?("Wan")
    	@DISTRICT = 6
    elsif @MEETING_TEXT.include?("Shook")
    	@DISTRICT = 7
    elsif @MEETING_TEXT.include?("Adrean")
    	@DISTRICT = 8
    elsif @MEETING_TEXT.include?("Moore")
    	@DISTRICT = 9
    elsif @MEETING_TEXT.include?("Martin")
    	@DISTRICT = 10
    elsif @MEETING_TEXT.include?("Bottoms")
    	@DISTRICT = 11
    elsif @MEETING_TEXT.include?("Sheperd")
    	@DISTRICT = 12
    else
    	@DISTRICT = 13
    end


     ###something### 


    	puts "Date: #{@MEETING_DATE}"
    	puts "Id: #{@MEETING_ID}"
    	puts "Yes: #{@MEETING_YEA}"
    	puts "No: #{@MEETING_NAY}"
    	puts "Text: #{@MEETING_TEXT}"
    	puts "District: #{@DISTRICT}"
    	puts "Title: #{@MEETING_TITLE}"

    	if @MEETING_ID.include? "O"
     		Legislation.create(:title => @MEETING_TITLE, :date => @MEETING_DATE,:content => @MEETING_TEXT, :num_for_votes => @MEETING_YEA, :num_no_votes => @MEETING_NAY, :district => @DISTRICT, :ordinance_id => @MEETING_ID )

     	else

    	end
  	end
    end
  end
end
