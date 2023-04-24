User.create!(name:                  "Hogehoge user",
             email:                 "hogehoge@foo.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:                  true,
             activated:              true,
             activated_at:           Time.zone.now)





character_names = ["ハイド(HYDE)",        "リンネ(LINNE)",       "ワレンシュタイン(WALDSTEIN)",
                   "カーマイン(CARMINE)", "オリエ(ORIE)",        "ゴルドー(GORDEAU)",
                   "メルカヴァ(MERKAVA)", "バティスタ(VATISTA)",  "セト(SETH)",
                   "ユズリハ(YUZURIHA)",  "ヒルダ(HILDA)",       "エルトナム(ELTNUM)",
                   "ケイアス(CHAOS)",     "アカツキ(AKATSUKI)",  "ナナセ(NANASE)",
                   "ビャクヤ(BYAKUYA)",   "フォノン(PHONON)",    "ミカ(MIKA)",
                   "ワーグナー(WAGNER)",  "エンキドゥ (ENKIDU)", "ロンドレキア(LONDREKIA)"]

character_names.each do |name|
    Character.create!(character_name: name)
end

situations = ["端", "端背負い", "確定反撃", "100%", "200%", "瀕死", "カウンター", "ハイカウンター"]
situations.each { |situation| Situation.create!(name: situation) }