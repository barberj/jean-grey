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
alias Splurty.Quote
valid_attrs = %{author: "some content", saying: "some content"}
changeset = Quote.changeset(%Quote{}, valid_attrs)
changeset.valid?
alias Splurty.Repo
Repo.insert(changeset)
```
