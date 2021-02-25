FactoryBot.define do
  factory :user_click do
    path_name { '/breeds' }
    clicks_amount { 4 }
  end
end
