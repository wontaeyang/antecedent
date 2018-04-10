RSpec.describe User do
  describe "model class" do
    it "is loaded" do
      expect { User }.to_not raise_error
    end
  end

  describe "active record" do
    context "#create" do
      it "is persisted in database" do
        name = "Pikachu"
        object = User.create(name: name)

        expect(object.name).to eq name
      end
    end

    context "#find_by_name" do
      it "finds a user by name" do
        name = "Pikachu"
        User.create(name: name)

        object = User.find_by_name(name)

        expect(object).to be_present
        expect(object.name).to eq name
      end
    end

    context "#destroy" do
      it "is deleted from database" do
        name = "Pikachu"
        User.create(name: name)

        User.destroy_all

        expect(User.where(name: name)).to be_blank
      end
    end

    context "polymorphic relation" do
      context "regular model" do
        it "populates parent_type by the class name" do
          parent = User.create(name: "Raichu")
          child = User.create(name: "Pikachu", parent: parent)

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User.to_s
          expect(child.parent.class).to eq User
        end
      end

      context "STI model" do
        it "populates parent_type by the base class name" do
          parent = Customer.create(name: "Raichu")
          child = User.create(name: "Pikachu", parent: parent)

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User.to_s
          expect(child.parent.class).to eq Customer
        end
      end

      context "namespaced model" do
        it "populates parent_type by the base class name" do
          parent = User::Admin.create(name: "Raichu")
          child = User.create(name: "Pikachu", parent: parent)

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User.to_s
          expect(child.parent.class).to eq User::Admin
        end
      end
    end
  end
end
