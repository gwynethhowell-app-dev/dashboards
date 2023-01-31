class CurrenciesController < ApplicationController
  def forex_home

  @raw_data = open("https://api.exchangerate.host/symbols").read
  @parsed_data = JSON.parse(@raw_data)
  @symbols_hash = @parsed_data.fetch("symbols")

  @array_of_symbols =  @symbols_hash.keys
    render({ :template => "currency_templates/step_one.html.erb"})
  end
  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
  
    @array_of_symbols =  @symbols_hash.keys
    # params are: {"from_currency"=>"ARS"}
    @from_symbol = params.fetch("from_currency")

    render({ :template => "currency_templates/step_two.html.erb"})
  end
  def convert
  @raw_data = open("https://api.exchangerate.host/symbols").read
  @parsed_data = JSON.parse(@raw_data)
  @symbols_hash = @parsed_data.fetch("symbols")
  
  @array_of_symbols =  @symbols_hash.keys
  @from_symbol = params.fetch("from_currency")
  @to_currency = params.fetch("to_currency")

  @conversion_raw = open("https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@to_currency}").read
  @conversion_parsed = JSON.parse(@conversion_raw)
  @rate = @conversion_parsed.fetch("result")

    render({ :template => "currency_templates/conversion.html.erb"})
  end
end
