require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../shared/min', __FILE__)

describe "DateTime.min" do
  it_behaves_like :datetime_min, :min
end
