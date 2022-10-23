class User::RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    # ユーザーがやりとりしているroomIDをすべて取得
    current_entries = current_user.entries
    # IDを配列化してmy_room_idとする
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    # Entryテーブルからmy_room_idでuser_idが自分のIDではないレコードを取り出す
    @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: current_user.id)
  end

  def create
    @room = Room.create
    @entryCurrentUser = Entry.create(user_id: current_user.id, room_id: @room.id)
    @entryUser = Entry.create(user_id: params[:entry][:user_id], room_id: @room.id)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first
  end

end