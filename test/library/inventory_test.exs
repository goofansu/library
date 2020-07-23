defmodule Library.InventoryTest do
  use Library.DataCase

  alias Library.Inventory

  describe "books" do
    alias Library.Inventory.Book

    @valid_attrs %{image: "some image", info: "some info", isbn: "some isbn", title: "some title"}
    @update_attrs %{image: "some updated image", info: "some updated info", isbn: "some updated isbn", title: "some updated title"}
    @invalid_attrs %{image: nil, info: nil, isbn: nil, title: nil}

    def book_fixture(attrs \\ %{}) do
      {:ok, book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_book()

      book
    end

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Inventory.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Inventory.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      assert {:ok, %Book{} = book} = Inventory.create_book(@valid_attrs)
      assert book.image == "some image"
      assert book.info == "some info"
      assert book.isbn == "some isbn"
      assert book.title == "some title"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      assert {:ok, %Book{} = book} = Inventory.update_book(book, @update_attrs)
      assert book.image == "some updated image"
      assert book.info == "some updated info"
      assert book.isbn == "some updated isbn"
      assert book.title == "some updated title"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_book(book, @invalid_attrs)
      assert book == Inventory.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Inventory.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Inventory.change_book(book)
    end
  end
end
