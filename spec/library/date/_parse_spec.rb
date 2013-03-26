require File.expand_path('../../../spec_helper', __FILE__)
require 'time'


describe Date do

  before do
    # TODO: I'm not sure there's a way to clean this up after the spec is done,
    # but since it doesn't actually change anything, I think it's okay.
    class << Date

      # Alias for stdlib Date._parse
      alias _original_parse _parse

      # We're monkeypatching for some obviously awesome reason,
      # but the arity is different than the current _parse method,
      # so a call to _parse/3 will give an ArgumentError.
      #
      # To fix this, I've delegated to __parse/3 for those calls that
      # require the return_bag flag, and _parse/2 for everything else,
      # which is compatible with the MRI version of _parse.
      def _parse(string, comp=true)
        _original_parse(string, comp)
      end

    end

  end

  it "doesn't complain when monkeypatching _parse" do

    # Make sure Time#parse still works
    now = Time.new(2002, 10, 31, 2, 2, 2, "+02:00")
    t = Time.parse(now.to_s)
    t.should == now

    # Make sure Date#parse still works
    d = Date.parse("10.01.07", true)
    d.year.should  == 2010
    d.month.should == 1
    d.day.should   == 7

    # Make sure Date#_parse still works
    d = Date._parse('friday')
    d.class.should == Hash

    # Make sure Date#__parse still works
    d = Date.__parse('friday')
    d.class.should == Hash

    # Make sure Date#__parse still can return a Bag
    d = Date.__parse('friday', true, true)
    d.class.should == Date::Format::Bag

  end

end
