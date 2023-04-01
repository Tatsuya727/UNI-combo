FactoryBot.define do
    factory :combo do
        title        { "example combo" }
        comando      { "632A > 623C" }
        video_url    { "hoge_url" }
        description  { "説明" }
        situation    { "端" }
        damage       { 3000 }
        hit_count    { 10 }
        character_id { 1 }
        user_id      { 1 }
        created_at   { 10.minutes.ago }

        trait :latest_post do
            video_url  { "foo_url" }
            created_at { Time.zone.now }
        end
    end
end

def user_with_posts(posts_count: 5)
    FactoryBot.create_list(:combo, posts_count, user_id: 1)
end