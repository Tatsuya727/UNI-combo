User.create!(name:                  "Hogehoge user",
             email:                 "hogehoge@foo.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:                  true,
             activated:              true,
             activated_at:           Time.zone.now)



99.times do |n|
    name  = Faker::Name.name
    email = "hogehoge-#{n+1}@foo.com"
    password = "password"
    User.create!(name:                  name,
                 email:                 email,
                 password:              password,
                 password_confirmation: password,
                 activated:             true,
                 activated_at:          Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
    title       = Faker::Lorem.sentence(word_count: 5)
    comando     = Faker::Lorem.sentence(word_count: 5)
    description = Faker::Lorem.sentence(word_count: 5)
    users.each { |user| user.combo.create!(title:        title,
                                            description:  description,
                                            comando:      comando,
                                            damage:       1,
                                            hit_count:    1,
                                            character_id: 1) }
end