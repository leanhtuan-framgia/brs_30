module BooksHelper
  def favorite_status user_book
    name = Settings.btn.btn_favorite
    if user_book.favorite
      name += Settings.btn.btn_default
    else
      name += Settings.btn.btn_success
    end
  end
end
