defmodule Splurty.Factory do
  use ExMachina.Ecto, repo: Splurty.Repo

  def quote_factory do
    %Splurty.Quote{
      author: Faker.Name.name,
      saying: Faker.Lorem.sentence
    }
  end
end
