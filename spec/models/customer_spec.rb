RSpec.describe Customer do
  it_behaves_like User

  describe "single table inheritance" do
    it "correctly populates type column" do
      customer = Customer.create(name: "Pikachu")

      expect(customer.type).to eq Customer.to_s
    end
  end
end
