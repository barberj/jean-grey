defmodule Splurty.Api.QuoteController do
  use Splurty.Web, :controller

  alias Splurty.Quote
  #alias Splurty.Paginator

  def index(conn, quote_params) do
    paginator = Quote
      |> Paginator.new(quote_params)

    render(conn, "index.json", paginator: paginator)
  end

  def create(conn, %{"quote" => quote_params}) do
    changeset = Quote.changeset(%Quote{}, quote_params)

    case Repo.insert(changeset) do
      {:ok, quote} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", quote_path(conn, :show, quote))
        |> render("show.json", quote: quote)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Splurty.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)
    render(conn, "show.json", quote: quote)
  end

  def update(conn, %{"id" => id, "quote" => quote_params}) do
    quote = Repo.get!(Quote, id)
    changeset = Quote.changeset(quote, quote_params)

    case Repo.update(changeset) do
      {:ok, quote} ->
        render(conn, "show.json", quote: quote)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Splurty.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quote = Repo.get!(Quote, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(quote)

    send_resp(conn, :no_content, "")
  end
end
