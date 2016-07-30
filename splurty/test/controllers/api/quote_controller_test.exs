defmodule Splurty.Api.QuoteControllerTest do
  use Splurty.ConnCase

  alias Splurty.Quote
  @valid_attrs %{author: "some content", saying: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_quote_path(conn, :index)
    assert json_response(conn, 200)["quotes"] == []
  end

  test "includes meta details on index", %{conn: conn} do
    conn = get conn, api_quote_path(conn, :index)
    assert json_response(conn, 200)["meta"] == %{
      "current_page" => 1,
      "page_size" => 25,
      "total_pages" => 0
    }
  end

  test "shows chosen resource", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = get conn, api_quote_path(conn, :show, quote)
    assert json_response(conn, 200) == %{
      "id" => quote.id,
      "saying" => quote.saying,
      "author" => quote.author
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_quote_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_quote_path(conn, :create), quote: @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(Quote, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_quote_path(conn, :create), quote: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = put conn, api_quote_path(conn, :update, quote), quote: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Quote, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = put conn, api_quote_path(conn, :update, quote), quote: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    quote = Repo.insert! %Quote{}
    conn = delete conn, api_quote_path(conn, :delete, quote)
    assert response(conn, 204)
    refute Repo.get(Quote, quote.id)
  end
end
