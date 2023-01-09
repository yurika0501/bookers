class BooksController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @book = Book.new
  end

  # 2章参考
  # データを追加（保存）する
  def create
    # １. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 2. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
    # 3フラッシュメッセ
      flash[:notice] = "Data Storage was successfully"
    # 4. books/id(idはURLで数字になる)画面へリダイレクト
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
    # フラッシュメッセ。更新に成功
      flash[:notice] = "Update successfully"
      redirect_to book_path(book.id)
    else
      @books = Book.all
      render :edit
    end
  end


  # 7章参考
  def destroy
    book = Book.find(params[:id]) # データ（レコード）を1件取得
    book.destroy # データ（レコード）を削除
    redirect_to books_path # 投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
