RSpec.describe User do
  describe "model class" do
    it "is loaded" do
      expect { User }.to_not raise_error
    end
  end

  describe "active record" do
    context "#create" do
      it "is persisted in database" do
        user = create(:user)

        expect(user.id).to be_present
        expect(user.name).to be_present
      end
    end

    context "#find_by_name" do
      it "finds a user by name" do
        name = "Pikachu"
        create(:user, name: name)

        user = User.find_by_name(name)

        expect(user).to be_present
        expect(user.name).to eq name
      end
    end

    context "#destroy" do
      it "is deleted from database" do
        name = "Pikachu"
        create(:user, name: name)

        User.destroy_all

        expect(User.where(name: name)).to be_blank
      end
    end

    context "polymorphic relation" do
      context "regular model" do
        it "populates parent_type by the class name" do
          parent = create(:user, :parent)
          child = create(:user, parent: parent)

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User.to_s
          expect(child.parent.class).to eq User
        end
      end

      context "STI model" do
        it "populates parent_type by the base class name" do
          parent = create(:customer)
          child = create(:user, parent: parent)

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User.to_s
          expect(child.parent.class).to eq Customer
        end
      end

      context "namespaced model" do
        it "populates parent_type by the base class name" do
          parent = create(:admin)
          child = create(:user, parent: parent)

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User.to_s
          expect(child.parent.class).to eq User::Admin
        end
      end

      context "legacy associations" do
        context "STI model" do
          it "populates parent_type by the base class name" do
            parent = create(:customer)
            child = create(:user, {
              parent_id: parent.id,
              parent_type: Customer.to_s
            })

            expect(child.parent_id).to eq parent.id
            expect(child.parent_type).to eq Customer.to_s
            expect(child.parent.class).to eq Customer
          end
        end

        context "namespaced model" do
          it "populates parent_type by the base class name" do
            parent = create(:admin)
            child = create(:user, {
              parent_id: parent.id,
              parent_type: User::Admin.to_s
            })

            expect(child.parent_id).to eq parent.id
            expect(child.parent_type).to eq User::Admin.to_s
            expect(child.parent.class).to eq User::Admin
          end
        end
      end
    end
  end
end
