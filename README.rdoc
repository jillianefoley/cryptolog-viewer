== README

This is a Rails-based explorer for articles of a declassified NSA magazine, Cryptolog. The files were declassified in 2012 and are available in PDF format here: https://www.nsa.gov/public_info/declass/cryptologs.shtml

This app is not hosted publicly anywhere and is still under development. Only 8 of 136 issues have been entered into the database so far.

This code was initially created for a Digital Humanities class taught at the University of Chicago by James Sparrow, Robert Morrissey, and Clovis Gladstone. I'm ABBYY FineReader to extract article text from the PDFs. I make no guarantees about the accuracy of the extracted text, or the metadata.

*Versions*
This app was developed using Ruby 2.1.2p95 and Rails 4.2.5.1.

* Deployment instructions
```
gem install bundler
bundle install
bundle exec rake db:migrate # Initialize databases
bundle exec rake sunspot:solr:start # Initialize solr search index
bundle exec rails server # Start local server
```

The app can be viewed at `http://localhost:3000/issues`

*Notes*
I am indebted to cryptome.org for
* providing a comprehensive index of article titles and authors by issue: http://cryptome.org/2013/03/cryptologs/nsa-cryptologs-contents-01.htm & http://cryptome.org/2013/03/cryptologs/nsa-cryptologs-contents-02.htm
* providing dirty OCR of the Cryptolog files for searching purposes


