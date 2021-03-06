require('rspec')
require('book')
require('patron')
require('pry')
require('pg')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")
  end
end
