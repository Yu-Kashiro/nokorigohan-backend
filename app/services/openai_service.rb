class OpenaiService
  def initialize
    @client = OpenAI::Client.new(
      access_token: ENV['OPENAI_API_KEY']
    )
  end

  def generate_recipes(user_ingredients, user_preferences, serving_size)
    # ユーザーの食材をテキスト形式に変換
    ingredients_text = user_ingredients.map do |ui|
      "#{ui.ingredient.name} #{ui.quantity}#{ui.ingredient.unit}"
    end.join(', ')

    # アレルギー情報を取得
    allergies = user_preferences.allergies.join(', ') if user_preferences.allergies.any?
    
    # 調理器具を取得
    cooking_tools = user_preferences.cooking_tools.join(', ') if user_preferences.cooking_tools.any?
    
    # 調味料を取得
    seasonings = user_preferences.seasonings.join(', ') if user_preferences.seasonings.any?

    # 栄養目標を取得
    nutritional_goals = user_preferences.nutritional_goals

    prompt = build_prompt(
      ingredients_text,
      allergies,
      cooking_tools,
      seasonings,
      nutritional_goals,
      serving_size
    )

    response = @client.chat(
      parameters: {
        model: "gpt-4o-mini", # GPT-4o mini を使用
        messages: [
          {
            role: "system",
            content: "あなたは優秀な料理専門家です。与えられた食材と条件に基づいて、2パターンのレシピを提案してください。必ずJSON形式で回答してください。"
          },
          {
            role: "user", 
            content: prompt
          }
        ],
        max_tokens: 2000,
        temperature: 0.7
      }
    )

    parse_response(response.dig("choices", 0, "message", "content"))
  rescue StandardError => e
    Rails.logger.error "OpenAI API Error: #{e.message}"
    raise "レシピ生成に失敗しました: #{e.message}"
  end

  private

  def build_prompt(ingredients, allergies, cooking_tools, seasonings, nutritional_goals, serving_size)
    prompt = <<~PROMPT
      以下の条件でレシピを2パターン作成してください：

      【利用可能な食材】
      #{ingredients}

      【調理人数】
      #{serving_size}人分

      【制約条件】
    PROMPT

    if allergies.present?
      prompt += "・アレルギー: #{allergies}\n"
    end

    if cooking_tools.present?
      prompt += "・利用可能な調理器具: #{cooking_tools}\n"
    end

    if seasonings.present?
      prompt += "・常備調味料: #{seasonings}\n"
    end

    if nutritional_goals.present?
      prompt += <<~NUTRITION
        ・栄養目標:
          - 1日の目標カロリー: #{nutritional_goals['daily_calories']}kcal
          - たんぱく質比率: #{nutritional_goals['protein_ratio']}%
          - 炭水化物比率: #{nutritional_goals['carb_ratio']}%
          - 脂質比率: #{nutritional_goals['fat_ratio']}%
      NUTRITION
    end

    prompt += <<~REQUEST

      以下の2パターンのレシピを作成してください：

      パターン1: 残り物完全活用レシピ
      - 上記の食材のみを使用
      - 追加購入不要
      - シンプルで手軽

      パターン2: 栄養バランス最適化レシピ  
      - 栄養目標に合わせて最適化
      - 必要に応じて追加食材を使用
      - より美味しく栄養価の高いレシピ

      回答は以下のJSON形式でお願いします：
      {
        "leftover_only": {
          "title": "レシピ名",
          "cooking_time": 調理時間（分）,
          "instructions": "調理手順を番号付きで詳細に",
          "nutritional_info": {
            "calories": カロリー,
            "protein": たんぱく質（g）,
            "carbs": 炭水化物（g）,
            "fat": 脂質（g）
          }
        },
        "balanced": {
          "title": "レシピ名", 
          "cooking_time": 調理時間（分）,
          "instructions": "調理手順を番号付きで詳細に",
          "nutritional_info": {
            "calories": カロリー,
            "protein": たんぱく質（g）,
            "carbs": 炭水化物（g）,
            "fat": 脂質（g）
          },
          "additional_ingredients": [
            {
              "name": "追加食材名",
              "quantity": 必要な量,
              "unit": "単位"
            }
          ]
        }
      }
    REQUEST

    prompt
  end

  def parse_response(response_text)
    # レスポンスからJSONを抽出
    json_match = response_text.match(/\{.*\}/m)
    return nil unless json_match

    JSON.parse(json_match[0])
  rescue JSON::ParserError => e
    Rails.logger.error "JSON Parse Error: #{e.message}"
    Rails.logger.error "Response text: #{response_text}"
    raise "レシピの解析に失敗しました"
  end
end