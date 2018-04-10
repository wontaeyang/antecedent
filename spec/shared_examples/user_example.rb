RSpec.shared_examples User do
  describe "model class" do
    it "is loaded" do
      expect { described_class }.to_not raise_error(NameError)
    end
  end

  describe "active record" do
    context "#create" do
      it "is persisted in database" do
        name = "Pikachu"
        object = described_class.create(name: name)

        expect(object.name).to eq name
      end
    end

    context "#find_by_name" do
      it "finds a user by name" do
        name = "Pikachu"
        described_class.create(name: name)

        object = described_class.find_by_name(name)

        expect(object).to be_present
        expect(object.name).to eq name
      end
    end

    context "#destroy" do
      it "is deleted from database" do
        name = "Pikachu"
        described_class.create(name: name)

        described_class.destroy_all

        expect(described_class.where(name: name)).to be_blank
      end
    end
  end
end
