class Issue < ActiveRecord::Base
		belongs_to :person, :foreign_key => 'editor_id'
		has_many :articles
		has_attached_file :pdf
		validates_attachment :pdf, content_type: { content_type: "application/pdf" }

		def name
			"Vol. #{volume} No. #{volume_number}, #{month} #{year}"
		end

		def date
			"#{month} #{year}"
		end

		def self.create_issue_with_articles(pdf_number, volume, vol_no, month, year, toc_string)
		  issue = Issue.create(:pdf_number => pdf_number, :volume => volume, :volume_number => vol_no, :month => month, :year => year)

		  articles = toc_string.split("\n").map{ |x| x.split(" by ").map(&:strip) }

		  articles.each do |article_data|
		  	article = Article.new(:title => article_data[0], :issue => issue)
		  	author = Person.find_or_create_by(:name => article_data[1]) if article_data[1]
		  	article.person = author
		  	author.try(:save)
		  	article.save
		  end
		end

end
