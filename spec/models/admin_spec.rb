RSpec.describe User::Admin do
  it_behaves_like User

  describe "single table inheritance" do
    it "correctly populates type column" do
      customer = User::Admin.create(name: "Pikachu")

      expect(customer.type).to eq User::Admin.to_s
    end
  end
end
