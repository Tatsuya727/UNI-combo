User.create!(name:                  "Hogehoge user",
             email:                 "hogehoge@foo.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)



99.times do |n|
    name  = Faker::Name.name
    email = "hogehoge-#{n+1}@foo.com"
    password = "password"
    User.create!(name:                  name,
                 email:                 email,
                 password:              password,
                 password_confirmation: password)
end