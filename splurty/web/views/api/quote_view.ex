defmodule Splurty.Api.QuoteView do
  use Splurty.Web, :view

  def render("index.json", %{quotes: quotes}) do
    %{data: render_many(quotes, Splurty.Api.QuoteView, "quote.json")}
  end

  def render("show.json", %{quote: quote}) do
    render_one(quote, Splurty.Api.QuoteView, "quote.json")
  end

  def render("quote.json", %{quote: quote}) do
    %{id: quote.id,
      saying: quote.saying,
      author: quote.author}
  end
end
