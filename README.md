<p align="center">
  <img src="https://github.com/barberj/jean-grey/blob/master/phoenix.png" />
</p>

# Tutorial Followed
http://phoenix.thefirehoseproject.com/1.html

> mix phoenix.new splurty .  
> createuser postgres -s --pwprompt  
> mix ecto.create  
> mix phoenix.gen.html Quote quotes saying:string author:string
> mix ecto.migrate  

I noted when i added the `yolo` line (http://phoenix.thefirehoseproject.com/2.html) it instantaneously updated in the browser. Websockets at play here. Very cool. Curious if only a dev env thing or this is how it works in production. Coworker who I showed was curious is data would also automatically show up. To the console!

```
iex -S mix phoenix.server
> alias Splurty.Quote
> valid_attrs = %{author: "some content", saying: "some content"}
> changeset = Quote.changeset(%Quote{}, valid_attrs)
> changeset.valid?
true
> alias Splurty.Repo
> Repo.insert(changeset)
```
New Quote did not show up without a refresh.


Alternative formats (without aliasing)
```
> changeset = Splurty.Quote.changeset(%Splurty.Quote{}, %{author: "some content", saying: "some content"})
> Splurty.Repo.insert(changeset)
> Splurty.Repo.all(Splurty.Quote)
[debug] QUERY OK db=0.9ms
SELECT q0."id", q0."saying", q0."author", q0."inserted_at", q0."updated_at" FROM "quotes" AS q0 []
[%Splurty.Quote{__meta__: #Ecto.Schema.Metadata<:loaded, "quotes">,
  author: "William", id: 1, inserted_at: #Ecto.DateTime<2016-07-29 17:00:40>,
  saying: "Pokemon will be mine",
  updated_at: #Ecto.DateTime<2016-07-29 17:00:40>},
 %Splurty.Quote{__meta__: #Ecto.Schema.Metadata<:loaded, "quotes">,
  author: "some content", id: 2,
  inserted_at: #Ecto.DateTime<2016-07-29 17:09:26>, saying: "some content",
  updated_at: #Ecto.DateTime<2016-07-29 17:09:26>},
 %Splurty.Quote{__meta__: #Ecto.Schema.Metadata<:loaded, "quotes">,
  author: "some content", id: 3,
  inserted_at: #Ecto.DateTime<2016-07-29 17:29:37>, saying: "some content",
  updated_at: #Ecto.DateTime<2016-07-29 17:29:37>}]
```
