class UsersController < ApplicationController

  # before_action :authenticate_user!,{only: [:edit, :show, :update]}
 
  before_action :set_current_user

  # before_action :logged_in_user, only: [:index, :edit, :update]
  # before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
    @q = User.ransack(params[:q])
    # @users = @q.result.includes(:age)
    @users = @q.result(distinct: true)
  end

  def search
    # @search_word = params[:q][:age_or_prefecture_id_cont] if params[:q]
    @user = User.find_by(id: session[:user_id]) #ユーザー呼び出し
    @q = User.ransack([:q], {sex_not_eq: @user.sex})
    # @users = @q.result.includes(:age)
    @users = @q.result(distinct: true)

  end

  def list
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    birthday = @user.birthday
    @age = (Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i) / 10000
    @like = Like.new
    @likes_count = Like.where(liked_user_id: @user.id).count
    #チャット
    if user_signed_in?
        #Entry内のuser_idがcurrent_userと同じEntry
        @currentUserEntry = Entry.where(user_id: current_user.id)
        #Entry内のuser_idがMYPAGEのparams.idと同じEntry
        @userEntry = Entry.where(user_id: @user.id)
            #@user.idとcurrent_user.idが同じでなければ
            unless @user.id == current_user.id
              @currentUserEntry.each do |cu|
                @userEntry.each do |u|
                  #もしcurrent_user側のルームidと＠user側のルームidが同じであれば存在するルームに飛ぶ
                  if cu.room_id == u.room_id then
                    @isRoom = true
                    @roomId = cu.room_id
                  end
                end
              end
              #ルームが存在していなければルームとエントリーを作成する
              unless @isRoom
                @room = Room.new
                @entry = Entry.new
              end
            end
    end
end


    # @user = User.find_by(id: params[:id])
  #   @user=User.find(params[:id])
  #   @currentUserEntry=Entry.where(user_id: current_user.id)
  #   @userEntry=Entry.where(user_id: @user.id)
  #   unless @user.id == current_user.id
  #     @currentUserEntry.each do |cu|
  #       @userEntry.each do |u|
  #         if cu.room_id == u.room_id then
  #           @isRoom = true
  #           @roomId = cu.room_id
  #         end
  #       end
  #     end
  #     if @isRoom
  #     else
  #       @room = Room.new
  #       @entry = Entry.new
  #     end
  #   end
  # end


  
  def mypage
    @user = User.find_by(id: session[:user_id])
    birthday = @user.birthday
    @age = (Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i) / 10000

  end


  # def myedit
  #   @user = User.find_by(id: params[:id])
  #   birthday = @user.birthday
  #   @age = (Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i) / 10000

    # @user = current_user
  # end

  def update
    @user = User.find_by(id: params[:id])
    birthday = @user.birthday
    @user.age = (Date.today.strftime("%Y%m%d").to_i - birthday.strftime("%Y%m%d").to_i) / 10000

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      　redirect_to("/users/show")
    end
  end
  #   @user = User.find_by(params[:id])
  #   # @user = current_user
  #   # @user.name = "ka1112221"
  #   # @user.email = "kaz@mjuyhn"
  #   @user.name = params[:name]
  #   @user.email = params[:email]

  #   if @user.save
  #     flash[:notice] = "ユーザー情報を編集しました"
  #     redirect_to("/users/show")
  #   else
  #     render 'myedit'
  #   end
  # end

  def follow
    
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    redirect_to("/users/#{@user.id}")
  end

  def unfollow
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
    redirect_to("/users/#{@user.id}")
  end


  def follow_list
    @user = User.find(params[:user_id])
  end

  def follower_list
    @user = User.find(params[:user_id])
  end  

  private
  def user_params
    params.require(:user).permit(:name, :prefecture_id, :image)
  end
  # def set_user
  #   @user = User.find_by(id: params[:id])
  # end

  # def set_current_user
  #   @current_user = User.find_by(id: session[:user_id])
  # end
end