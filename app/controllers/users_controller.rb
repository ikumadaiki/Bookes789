class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    #DM用のコード
    #それぞれ保持しているEntryを列挙
    @current_user_entries = Entry.where(user_id: current_user.id)
    @user_entries = Entry.where(user_id: @user.id)
    #ログインしているuserページでは無いとき
    if @user != current_user
      @current_user_entries.each do |current_user_entry|
        #@current_user_entryのもつroom_idと同じroom_idを持つか判定
        if @user_entries.find_by(room_id: current_user_entry.room_id)
          @is_room = true
          @room = current_user_entry.room
        end
      end
      #roomが存在しない場合には新規作成
      if not @is_room
        @room = Room.new
        @entry = Entry.new
      end

    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
