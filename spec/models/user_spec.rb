RSpec.describe User do
  it_behaves_like User

  describe "single table inheritance" do
    it "populates type column with nil value" do
      user = User.create(name: "Pikachu")

      expect(user.type).to be_blank
    end
  end
end
