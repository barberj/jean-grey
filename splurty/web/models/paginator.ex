defmodule Paginator do
  import Ecto.Query
  alias Splurty.Repo

  defstruct [:entries, :current, :size, :total]

  def new(query, %{"page" => page, "page_size" => page_size}) do
    build(query, page: page, size: page_size)
  end

  def new(query, %{"page" => page}) do
    build(query, page: page, size: 25)
  end

  def new(query, %{"page_size" => page_size}) do
    build(query, page: 1, size: page_size)
  end

  def new(query, _params) do
    build(query, page: 1, size: 25)
  end

  defp build(query, page: page, size: size) do
    page = to_int(page, 1)
    size = to_int(size, 25)
    entries = entries(query, page, size)

    %Paginator{
      entries: entries,
      current: page,
      size: size,
      total: total_pages(query, size)
    }
  end

  defp entries(query, page_number, page_size) do
    offset = page_size * (page_number - 1)

    query
      |> limit([_], ^page_size)
      |> offset([_], ^offset)
      |> Repo.all
  end

  defp total_pages(query, page_size) do
    count = query
      |> exclude(:order_by)
      |> exclude(:preload)
      |> exclude(:select)
      |> select([e], count(e.id))
      |> Repo.one

    ceiling(count / page_size)
  end

  defp ceiling(float) do
    t = trunc(float)

    case float - t do
      neg when neg < 0 ->
        t
      pos when pos > 0 ->
        t + 1
      _ -> t
    end
  end

  defp to_int(i, _) when is_integer(i), do: i
  defp to_int(s, default) when is_binary(s) do
    case Integer.parse(s) do
      {i, _} -> i
      :error -> default
    end
  end
end
