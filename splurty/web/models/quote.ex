defmodule Splurty.Quote do
  use Splurty.Web, :model

  schema "quotes" do
    field :saying, :string
    field :author, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:saying, :author])
    |> validate_required([:saying, :author])
  end

  @doc """
  Returns random quote
  """
  def random do
    {:ok, result} = Ecto.Adapters.SQL.query(
      Splurty.Repo,
      "SELECT id, saying, author from quotes ORDER BY RANDOM() LIMIT 1",
      []
    )
    %Postgrex.Result{rows: [row]} = result
    [id, saying, author] = row
    %Splurty.Quote{id: id, saying: saying, author: author}
    #from q in Splurty.Quote, order_by: fragment("RANDOM()"), limit: 1
  end
end
