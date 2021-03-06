require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Ticket" do
  before(:each) do
    VCR.use_cassette('tickets-instance')  { @github = TicketMaster.new(:github, {:login => 'cored'}) }
    VCR.use_cassette('github-public-project-jquery') { @project = @github.project('translator') }
    @ticket_id = 1
    @klass = TicketMaster::Provider::Github::Ticket
  end
  
  it "should be able to load all tickets" do
    VCR.use_cassette('project-tickets') { @tickets = @project.tickets }
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to load tickets from an array of ids" do
    VCR.use_cassette('github-tickets-by-array-id') { @tickets = @project.tickets([@ticket_id]) }
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to find tickets based on attributes" do
    VCR.use_cassette('github-tickets-attributes') { @tickets = @project.tickets(:id => @ticket_id) }
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
  end

  it "should find a ticket by id(number)" do
    VCR.use_cassette('github-by-id') { @ticket = @project.ticket(@ticket_id) }
    @ticket.should be_an_instance_of(@klass)
    @ticket.title.should be_eql('hello')
  end

# it "should return author in ticket" 
#
# it "should be able to open a new ticket" 
#
# it "should be able to update a existing ticket" 
#
# it "should be able to reopen a ticket" 
#
# it "should be able to close a ticket" 
end
