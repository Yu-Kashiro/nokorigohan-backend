# 基本的な食材を追加
ingredients = [
  # 野菜類
  { name: 'にんじん', category: '野菜', unit: '本' },
  { name: 'じゃがいも', category: '野菜', unit: '個' },
  { name: 'たまねぎ', category: '野菜', unit: '個' },
  { name: 'キャベツ', category: '野菜', unit: '玉' },
  { name: 'もやし', category: '野菜', unit: '袋' },
  { name: 'きのこ', category: '野菜', unit: 'パック' },
  { name: 'ピーマン', category: '野菜', unit: '個' },
  { name: 'ブロッコリー', category: '野菜', unit: '株' },

  # 肉類
  { name: '鶏胸肉', category: '肉類', unit: 'g' },
  { name: '鶏もも肉', category: '肉類', unit: 'g' },
  { name: '豚肉', category: '肉類', unit: 'g' },
  { name: '牛肉', category: '肉類', unit: 'g' },
  { name: 'ひき肉', category: '肉類', unit: 'g' },

  # 魚介類
  { name: '鮭', category: '魚介類', unit: '切れ' },
  { name: 'さば', category: '魚介類', unit: '匹' },
  { name: 'えび', category: '魚介類', unit: 'g' },

  # 乳製品・卵
  { name: '卵', category: '卵・乳製品', unit: '個' },
  { name: '牛乳', category: '卵・乳製品', unit: 'ml' },
  { name: 'チーズ', category: '卵・乳製品', unit: 'g' },
  { name: 'バター', category: '卵・乳製品', unit: 'g' },

  # 穀類
  { name: 'ご飯', category: '穀類', unit: '合' },
  { name: 'パン', category: '穀類', unit: '枚' },
  { name: 'パスタ', category: '穀類', unit: 'g' },
  { name: 'うどん', category: '穀類', unit: '玉' },

  # その他
  { name: '豆腐', category: 'その他', unit: '丁' },
  { name: '油揚げ', category: 'その他', unit: '枚' },
  { name: '納豆', category: 'その他', unit: 'パック' },
  { name: 'わかめ', category: 'その他', unit: 'g' }
]

ingredients.each do |ingredient_attrs|
  Ingredient.find_or_create_by(name: ingredient_attrs[:name]) do |ingredient|
    ingredient.category = ingredient_attrs[:category]
    ingredient.unit = ingredient_attrs[:unit]
  end
end

puts "#{Ingredient.count}種類の食材を登録しました"
