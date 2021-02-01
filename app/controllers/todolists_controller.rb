class TodolistsController < ApplicationController

  def new
    @list = List.new
  end

  # 以下を追加
  def create
    # １. データを新規登録するためのインスタンス作成
    list = List.new(list_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    list.save
    # ３.　詳細画面へリダイレクト
    redirect_to todolist_path(list.id)
  end

  #一覧画面の表示
  def index
    @lists = List.all
  end

  def show
    #routes.rbのURLの:idを取得し、そのidのデータをfindによって探す。
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list =List.find(params[:id])
    list.update(list_params)
    #showアクションにリダイレクト
    redirect_to todolist_path(list.id)
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to todolists_path
  end

  private
  # ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
