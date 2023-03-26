FactoryBot.define do
    factory :user do
        name                  { "Example User" }
        email                 { "user@example.com" }
        password              { "foobar" }
        password_confirmation { "foobar" }
    end
    
    factory :other_user, class: "User" do
        name                  { "Hogehoge User" }
        email                 { "user@hogehoge.com" }
        password              { "hogehoge" }
        password_confirmation { "hogehoge" }
    end
end