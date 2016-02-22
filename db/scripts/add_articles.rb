i = Issue.create(:pdf_number => 129, :volume => "XXI", :volume_number => '2', :month => "Summer", :year => 1995)

[
['Interview with NSA\'s Chief Information Officer'],
['Writing as a Continuation of Analysis'],
['Journalistic Style, Yes; Creeping Clancyism, No!'],
['Managing Linguists in Low-density Languages'],
['The National Information Infrastructure (NII)'],
['What\'s this New Intercept I\'m Seeing?'],
['The Unfocused Eye: [Redacted]'],
['Intelligence Analysis Off-site and Open Forum'],
['IA Vs. TA/IR: An Editorial'],
['The Phoenix HF: An Editorial by N.G. Gerson'],
['NSA\'s "Lessons Learned" Database'],
['The 1995 Joint Mathematics Meetings'],
['SIGINT Bloopers'],
['Book Reviews'],
['SIGINT Glossary: The Chun Wheel']
].each do |article|
	a = Article.new(:title => article[0], :issue => i)
	p = Person.new(:name => article[1]) if article[1]
	a.person = p
	p.try(:save)
	a.save
end
