class Api::PostsController < ApplicationController
  def index
    group = Group.find(params[:group_id])
    last_message_id = params[:id].to_i
    @posts = group.posts.includes(:user).where("id > #{last_message_id}")
  end
end
