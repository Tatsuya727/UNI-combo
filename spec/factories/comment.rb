FactoryBot.define do
    factory :comment do
        body     { "example comment" }
        user_id  { 1 }
        combo_id { 1 }
    end
end