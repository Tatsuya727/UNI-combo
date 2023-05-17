FactoryBot.define do
    factory :situation do
        sequence(:name) { |n| ["端", "端背負い", "確定反撃", "100%", "200%", "瀕死", "カウンター", "ハイカウンター"][n] }
    end
end
