FactoryBot.define do
  factory :breed_search do
    query_term { 'ab' }

    factory :sucessful_breed_search do
      breed_id { 'abys' }
      succeed { true }
    end
  end
end
