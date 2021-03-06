require('spec_helper')

describe(Patron) do

  describe('#name') do
    it "returns the name of the patron" do
      test_patron = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      expect(test_patron.name()).to(eq('Mr. Rogers'))
    end
  end

  describe('#id') do
    it "returns the id of the patron" do
      test_patron = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron.save()
      expect(test_patron.id().class()).to(eq(Fixnum))
    end
  end

  describe('.all') do
    it 'is an empty array at first' do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#==') do
    it 'compares two patrons by name and id to see if they are the same' do
      test_patron1 = Patron.new({:id => 1, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron2 = Patron.new({:id => 1, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron1.eql?(test_patron2)
    end
  end

  describe('#save') do
    it 'saves a patron' do
      test_patron = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  describe('.find_by_name') do
    it 'locates patrons with a given name' do
      test_patron1 = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron2 = Patron.new({:id => nil, :name => 'Julia Childs',:phone => '206-345-1198'})
      test_patron1.save()
      test_patron2.save()
      expect(Patron.find_by_name(test_patron1.name())).to(eq([test_patron1]))
    end
  end

  describe('.find_by_id') do
    it 'locates a patron with a given id' do
      test_patron1 = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron2 = Patron.new({:id => nil, :name => 'Julia Childs',:phone => '206-345-1198'})
      test_patron1.save()
      test_patron2.save()
      expect(Patron.find_by_id(test_patron1.id())).to(eq(test_patron1))
    end
  end

  describe('#update') do
    it 'lets the user update the attributes of the patron' do
      test_patron1 = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron1.save()
      test_patron1.update({:id => nil, :name => 'Fred Rogers',:phone => '971-358-9742'})
      expect(test_patron1.name()).to(eq('Fred Rogers'))
      expect(test_patron1.phone()).to(eq('971-358-9742'))
    end
    it 'lets you add a book to a patron' do
      book = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
      book.save()
      patron = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      patron.save()
      patron.update({:book_ids => [book.id()]})
      expect(patron.books()).to(eq([book]))
    end
  end

  describe("#books") do
  it("returns all of the books a particular patron has checked out") do
    book = Book.new({:id => nil, :title => '19Q4',:author => 'Haruki Murakami', :year_published => '2009'})
    book.save()
    book2 = Book.new({:id => nil, :title => 'Bossypants',:author => 'Tina Fey', :year_published => '2011'})
    book2.save()
    patron = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
    patron.save()
    patron.update(:book_ids => [book.id()])
    patron.update(:book_ids => [book2.id()])
    expect(patron.books()).to(eq([book, book2]))
  end
end



  describe('#delete') do
    it 'lets the user delete a patron' do
      test_patron1 = Patron.new({:id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron2 = Patron.new({:id => nil, :name => 'Julia Childs',:phone => '206-345-1198'})
      test_patron1.save()
      test_patron2.save()
      test_patron1.delete()
      expect(Patron.all()).to(eq([test_patron2]))
    end
  end

end
