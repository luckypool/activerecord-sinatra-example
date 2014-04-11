require "spec_helper"
require "date"

describe User do
  describe ".new" do
    it { should_not be nil }
  end

  describe "#age" do
    let(:birthday) { Date.new(2000,1,1) }
    let(:user) { User.new(name:"foo", birthday:birthday) }
    before do
      @today = Date.new(2014,1,1)
      Data.stub(:today).and_return(@today)
    end
    it "returns 14" do
      expect(user.age).to eq 14
    end
  end
end
