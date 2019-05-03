defmodule DtodoaquiWeb.ListingController do
  use DtodoaquiWeb, :controller

  alias Dtodoaqui.Directories
  alias Dtodoaqui.Directories.Listing

  action_fallback DtodoaquiWeb.FallbackController

  def index(conn, _params) do
    listings = Directories.list_listings()
    render(conn, "index.json", listings: listings)
  end

  def create(conn, %{"listing" => listing_params}) do
    with {:ok, %Listing{} = listing} <- Directories.create_listing(listing_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.listing_path(conn, :show, listing))
      |> render("show.json", listing: listing)
    end
  end

  def show(conn, %{"id" => id}) do
    listing = Directories.get_listing!(id)
    render(conn, "show.json", listing: listing)
  end

  def update(conn, %{"id" => id, "listing" => listing_params}) do
    listing = Directories.get_listing!(id)

    with {:ok, %Listing{} = listing} <- Directories.update_listing(listing, listing_params) do
      render(conn, "show.json", listing: listing)
    end
  end

  def delete(conn, %{"id" => id}) do
    listing = Directories.get_listing!(id)

    with {:ok, %Listing{}} <- Directories.delete_listing(listing) do
      send_resp(conn, :no_content, "")
    end
  end
end