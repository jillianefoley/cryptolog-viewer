def create_issue_with_articles(pdf_number, volume, vol_no, month, year, toc_string)
  i = Issue.create(:pdf_number => pdf_number, :volume => volume, :volume_number => vol_no, :month => month, :year => year)

  articles = toc_string.split("\n").map{ |x| x.split(" by ").map(&:strip) }

  articles.each do |article|
  	a = Article.new(:title => article[0], :issue => i)
  	p = Person.find_or_create_by(:name => article[1]) if article[1]
  	a.person = p
  	p.try(:save)
  	a.save
  end
end
