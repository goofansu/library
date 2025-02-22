defmodule LibraryWeb.BookController do
  use LibraryWeb, :controller

  alias Library.Inventory
  alias Library.Inventory.Book

  def index(conn, _params) do
    books = Inventory.list_books()
    render(conn, "index.html", books: books)
  end

  def new(conn, _params) do
    changeset = Inventory.change_book(%Book{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    case Inventory.upsert_book(book_params) do
      {:ok, book} ->
        update_book_information(book)

        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Inventory.get_book!(id)
    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = Inventory.get_book!(id)
    changeset = Inventory.change_book(book)
    render(conn, "edit.html", book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Inventory.get_book!(id)

    case Inventory.update_book(book, book_params) do
      {:ok, book} ->
        update_book_information(book)

        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Inventory.get_book!(id)
    {:ok, _book} = Inventory.delete_book(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: Routes.book_path(conn, :index))
  end

  defp update_book_information(%Book{isbn: isbn} = book) do
    {:ok, channel} = GRPC.Stub.connect("127.0.0.1:50051")
    request = Library.BookReq.new(isbn: isbn)
    {:ok, reply} = channel |> Library.BookService.Stub.get_book(request)

    Inventory.update_book(book, %{
      title: reply.title,
      image: reply.image,
      info: reply.info
    })
  end
end
