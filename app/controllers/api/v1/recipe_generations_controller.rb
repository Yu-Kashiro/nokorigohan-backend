class Api::V1::RecipeGenerationsController < ApplicationController
  def create
    client = OpenAI::Client.new
    ingredients = params[:ingredients]

    prompt = <<~PROMPT
      以下の材料を使って、簡単なレシピを一つ提案してください：#{ingredients.join(', ')}

      必ず以下のJSON形式で回答してください：
      {
        "name": "レシピ名",
        "ingredients": ["食材1", "食材2", "食材3"],
        "instructions": ["手順1", "手順2", "手順3"],
        "cooking_time": 30
      }

      - name: レシピの名前を日本語で記載
      - ingredients: 使用する食材のリスト（量も含めて記載）
      - instructions: 調理手順を順番に記載
      - cooking_time: 調理時間を分単位で記載

      JSON以外のテキストは含めないでください。
    PROMPT

    response = client.chat(
      parameters: {
        model: "gpt-5-nano",
        messages: [
          { role: "user", content: prompt }
        ]
      }
    )

    recipe_text = response.dig("choices", 0, "message", "content")

    # JSONをパース
    begin
      # コードブロックを削除（```json ... ``` の形式に対応）
      cleaned_text = recipe_text.gsub(/```json\s*/, "").gsub(/```\s*$/, "").strip

      recipe_data = JSON.parse(cleaned_text)

      # データの検証
      unless recipe_data.is_a?(Hash) &&
             recipe_data["name"] &&
             recipe_data["ingredients"].is_a?(Array) &&
             recipe_data["instructions"].is_a?(Array)
        raise "Invalid recipe format"
      end

      render json: { recipe: recipe_data }
    rescue JSON::ParserError, StandardError => e
      # パースに失敗した場合は元のテキストを返す
      Rails.logger.error "Recipe parsing error: #{e.message}"
      Rails.logger.error "Recipe text: #{recipe_text}"
      render json: { recipe: { raw_text: recipe_text } }
    end
  end
end
