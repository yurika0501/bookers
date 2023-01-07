class BooksController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @book = Book.new
  end

  # 2章参考
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    book.save
    # 4. books/id(idはURLで数字になる)画面へリダイレクト
    redirect_to book_path(book.id)
  end

  def index
    @books = Book.all
  end

  def show
  end

  def edit
  end

  # 7章参考
  def destroy
    book = Book.find(params[:id]) # データ（レコード）を1件取得
    book.destroy # データ（レコード）を削除
    redirect_to '/books' # 投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
