require "spec_helper"

RSpec.describe Podcast, type: :model do
  it { should have_valid(:name).when("Podcast1") }
  it { should_not have_valid(:name).when(nil, "") }

  it { should have_valid(:url).when("www.podcast2.com") }
  it { should_not have_valid(:url).when(nil, "") }
end
