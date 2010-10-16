require 'spec_helper'

describe User do
  context "associations" do
    it { should have_many(:search_terms) }
  end

  context "before creation" do
    it "assigns itself a claim code" do
      subject.should_receive(:generate_claim_code)
      subject.run_callbacks(:create, :before)
    end
  end

  describe "#generate_claim_code" do
    it "assigns a claim code" do
      subject.send(:generate_claim_code)
      subject.claim_code.should_not be_nil
    end
  end
end
