RSpec.describe Antecedent do
  it "has a version number" do
    expect(Antecedent::VERSION).not_to be nil
  end

  describe "default behavior" do
    describe "without antecedent" do
      it "returns result in STI model class" do
        parent = create(:admin,)

        child = create(:user, parent: parent)

        expect(child.parent_id).to eq parent.id
        expect(child.parent_type).to eq User.to_s
        expect(child.parent.class).to eq User::Admin
      end
    end
  end

  context "supported ActiveRecord version" do
    before do
      Antecedent.enable_sti
    end

    describe "#disable_sti" do
      context "inheritance column" do
        it "is updated to non-existant column" do
          Antecedent.disable_sti

          expect(
            ActiveRecord::Base.inheritance_column
          ).to eq "_type_disabled"
        end
      end

      context "without namespacing" do
        it "returns result in base class" do
          parent = create(:admin)
          child = create(:user, parent: parent)

          Antecedent.disable_sti
          child.reload

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User.to_s
          expect(child.parent.class).to eq User
        end
      end

      context "with namespacing" do
        it "returns result in base class" do
          parent = create(:admin)
          child = create(:user, {
            parent_id: parent.id,
            parent_type: parent.class.to_s
          })

          Antecedent.disable_sti
          child.reload

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User::Admin.to_s
          expect(child.parent.class).to eq User
        end
      end
    end

    describe "#enable_sti" do
      before do
        Antecedent.disable_sti
        Antecedent.enable_sti
      end

      context "inheritance column" do
        it "is restored to type column" do
          expect(
            ActiveRecord::Base.inheritance_column
          ).to eq "type"
        end
      end

      context "without namespacing" do
        it "returns result in base class" do
          parent = create(:admin,)

          child = create(:user, parent: parent)
          child.reload

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User.to_s
          expect(child.parent.class).to eq User::Admin
        end
      end

      context "with namespacing" do
        it "returns result in base class" do
          parent = create(:admin)

          child = create(:user, {
            parent_id: parent.id,
            parent_type: parent.class.to_s
          })
          child.reload

          expect(child.parent_id).to eq parent.id
          expect(child.parent_type).to eq User::Admin.to_s
          expect(child.parent.class).to eq User::Admin
        end
      end
    end
  end

  context "unsupported ActiveRecord version" do
    before do
      stub_const("ActiveRecord::VERSION::STRING", "4.2.0")
      require "antecedent/fallback"
    end

    describe "#disable_sti" do
      it "raises exception" do
        expect {
          Antecedent.disable_sti
        }.to raise_error(Antecedent::ActiveRecordVersionNotSupported)
      end
    end

    describe "#enable_sti" do
      it "raises exception" do
        expect {
          Antecedent.enable_sti
        }.to raise_error(Antecedent::ActiveRecordVersionNotSupported)
      end
    end
  end
end
