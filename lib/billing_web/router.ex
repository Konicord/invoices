defmodule BillingWeb.Router do
  use BillingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BillingWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :pdf do
    plug :put_root_layout, {BillingWeb.LayoutView, :pdf}
    plug :put_layout, false # disable layout
  end

  scope "/", BillingWeb do
    pipe_through [:browser]

    get "/", InvoiceController, :index
  end

  scope "/", BillingWeb do
    pipe_through [:browser, :pdf]

    get "/:invoice_id", InvoiceController, :show
  end
end
