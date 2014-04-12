require "spec_helper"
require "date"

describe User do
  describe ".new" do
    it { should_not be nil }
  end

  describe "#age" do
    let(:user_1000) { User.new(name:"foo", birthday:Date.new(1000,1,1)) }
    let(:user_2000) { User.new(name:"foo", birthday:Date.new(2000,1,1)) }
    context "when today is 2014/1/1" do
      before do
        today = Date.new(2014,1,1)
        Data.stub(:today).and_return(today)
      end
      it "returns 14 for 2000/1/1" do
        expect(user_2000.age).to eq 14
      end
      it "returns 1014 for 1000/1/1" do
        expect(user_1000.age).to eq 1014
      end
    end
  end
end
