defmodule Splurty.Api.QuoteView do
  use Splurty.Web, :view

  def render("index.json", %{paginator: %Paginator{ entries: entries, current: page, size: size, total: total }}) do
    %{
      quotes: render_many(entries, Splurty.Api.QuoteView, "quote.json"),
      meta: %{
        current_page: page,
        page_size: size,
        total_pages: total
      }
    }
  end

  def render("show.json", %{quote: quote}) do
    render_one(quote, Splurty.Api.QuoteView, "quote.json")
  end

  def render("quote.json", %{quote: quote}) do
    %{
      id: quote.id,
      saying: quote.saying,
      author: quote.author
    }
  end
end
