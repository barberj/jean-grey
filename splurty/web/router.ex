defmodule Splurty.Router do
  use Splurty.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Splurty do
    pipe_through :browser # Use the default browser stack

    get "/", QuoteController, :root
    resources "/quotes", QuoteController
  end

  # Other scopes may use custom stacks.
  scope "/api", Splurty, as: :api do
     pipe_through :api

     resources "/quotes", Api.QuoteController, except: [:new, :edit]
  end
end
