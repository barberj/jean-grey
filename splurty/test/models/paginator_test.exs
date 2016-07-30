defmodule PaginatorTest do
  use Splurty.ModelCase

  alias Splurty.Quote
  alias Splurty.Repo

  setup do
    Splurty.Factory.insert_list(25, :quote)

    :ok
  end

  test "it returns meta data" do
    paginator = Paginator.new(Quote, %{"page" => "2", "page_size" => "1"})
    assert paginator.current == 2
    assert paginator.size == 1
    assert paginator.total == 25
  end

  test "it defaults page and size" do
    paginator = Paginator.new(Quote, %{})
    assert paginator.current == 1
    assert paginator.size == 25
    assert paginator.total == 1
  end

  test "it defaults page" do
    paginator = Paginator.new(Quote, %{"page_size" => 1})
    assert paginator.current == 1
    assert paginator.size == 1
    assert paginator.total == 25
  end

  test "it defaults page_size" do
    paginator = Paginator.new(Quote, %{"page" => 2})
    assert paginator.current == 2
    assert paginator.size == 25
    assert paginator.total == 1
  end

  test "it ignores invalid page and size" do
    paginator = Paginator.new(Quote, %{"page" => "a", "page_size" => "b"})
    assert paginator.current == 1
    assert paginator.size == 25
  end
end
