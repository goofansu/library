defmodule Library.Inventory.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :image, :string
    field :info, :string
    field :isbn, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:isbn, :title, :image, :info])
    |> validate_required([:isbn])
    |> unique_constraint(:isbn)
  end
end
