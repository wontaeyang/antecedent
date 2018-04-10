FactoryBot.define do
  factory :user do
    name "Pikachu"

    trait :parent do
      name "Raichu"
    end
  end

  factory :customer do
    name "Charizard"
  end

  factory :admin, class: 'User::Admin'  do
    name "Bulbasaur"
  end
end
