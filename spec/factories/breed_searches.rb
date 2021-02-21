FactoryBot.define do
  factory :breed_search do
    query_term { 'ab' }
    search_by { 'breed_name' }

    factory :sucessful_breed_search do
      succeed { true }
    end

    factory :failed_breed_search do
      succeed { false }
    end
  end
end
