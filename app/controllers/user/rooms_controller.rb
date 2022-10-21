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
    @entryUser = Entry.create(entry_room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.entries.pluck(:room_id)
    user_room = Entry.find_by(user_id: @user.id, room_id: rooms)
  if user_room.nil?
    @roomnew = Room.new
    @roomnew.save
    @room = Room.find(params[:id])
    Entry.create(user_id: @user.id, room_id: @room.id)
    Entry.create(user_id: current_user.id, room_id: @room.id)
  else
    @entryroom = user_room.room
  end
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = Message.new(room_id: @room.id)
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first
  end

  private
  
  def entry_room_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

  def message_params
    params.permit(:content, :room_id)
  end
  
end