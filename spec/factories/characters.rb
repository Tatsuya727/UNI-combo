FactoryBot.define do
    factory :character do
        sequence(:character_name) { |n| ["ハイド(HYDE)", "リンネ(LINNE)", "ワレンシュタイン(WALDSTEIN)",
                                         "カーマイン(CARMINE)", "オリエ(ORIE)", "ゴルドー(GORDEAU)", 
                                         "メルカヴァ(MERKAVA)", "バティスタ(VATISTA)",  "セト(SETH)", 
                                         "ユズリハ(YUZURIHA)",  "ヒルダ(HILDA)", "エルトナム(ELTNUM)", 
                                         "ケイアス(CHAOS)", "アカツキ(AKATSUKI)",  "ナナセ(NANASE)",
                                         "ビャクヤ(BYAKUYA)",   "フォノン(PHONON)", "ミカ(MIKA)", 
                                         "ワーグナー(WAGNER)",  "エンキドゥ (ENKIDU)", "ロンドレキア(LONDREKIA)"][n] }
    end
end