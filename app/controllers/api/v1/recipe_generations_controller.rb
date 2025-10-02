class Api::V1::RecipeGenerationsController < ApplicationController
  def create
    client = OpenAI::Client.new
    ingredients = params[:ingredients]
    prompt = "以下の材料を使って、簡単なレシピを一つ提案してください：#{ingredients.join(', ')}"

    response = client.chat(
      parameters: {
        model: "gpt-5-nano",
        messages: [
          { role: "user", content: prompt }
        ]
      }
    )

    render json: { recipe: response.dig("choices", 0, "message", "content") }
  end
end
