FactoryBot.define do
  factory :breed_search_result do
    association :breed_search, factory: :sucessful_breed_search

    breed_id { 'abys' }
  end
end
