class Stock < ApplicationRecord
  # Associations (Many to Many with Users)
  has_many :user_stocks
  has_many :users, through: :user_stocks

  # Validations
  validates :name , :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: 'pk_3d6bbacde6f64f2abd5c868cee872eb1',
      secret_token:  Rails.application.credentials.iex_client[:sandbox_api_key],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    # client.price(ticker_symbol)
    if(find_by(ticker: ticker_symbol.upcase))
      find_by(ticker: ticker_symbol.upcase)
    else
      begin
        create(ticker: ticker_symbol.upcase, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
      rescue => exception
        nil
      end
    end
  end
end

