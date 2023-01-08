class BooksController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @book = Book.new
  end

  # 2章参考
  def create
    # １. データを受け取り新規登録するためのインスタンス作成
    book = Book.new(book_params)
    # 2. データをデータベースに保存するためのsaveメソッド実行
    book.save
    # 3フラッシュメッセ
    flash[:notice] = "Submission was successfully"
    # 4. books/id(idはURLで数字になる)画面へリダイレクト
    redirect_to book_path(book.id)
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end
    

  # 7章参考
  def destroy
    @book = Book.find(params[:id]) # データ（レコード）を1件取得
    book.destroy # データ（レコード）を削除
    redirect_to book_path(book.id) # 投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
