defmodule Splurty.QuoteTest do
  use Splurty.ModelCase

  alias Splurty.Quote
  alias Splurty.Repo

  @valid_attrs %{author: "some content", saying: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Quote.changeset(%Quote{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Quote.changeset(%Quote{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "random returns a quote" do
    {:ok, quote} = %Quote{
        author: "Nelson Mandela",
        saying: "It always seems impossible until its done."
      }
      |> Repo.insert

    random = Quote.random
    assert random.id == quote.id
    assert random.__struct__ == Quote
  end
end
