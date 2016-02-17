class IdeasController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  def index
    @ideas = Idea.select("ideas.*, COUNT(likes.id) like_count").joins("LEFT OUTER JOIN likes ON likes.idea_id = ideas.id").group("ideas.id").order("like_count DESC", "created_at DESC")


    @new_idea = Idea.new
  end

  def new
  end

  def create
    idea = Idea.new(content: params[:idea][:content], user: current_user)
    idea.save if idea.valid?
    redirect_to '/bright_ideas'


  end

  def e
  end

  def show
    @idea = Idea.find(params[:idea_id])
    @likers = Like.where(idea:Idea.find(params[:idea_id])).group("user_id").joins(:user).select("name, alias, user_id")

  end

  def destroy
    idea = Idea.find(params[:idea_id])
    idea.destroy if idea.user == current_user
    redirect_to '/bright_ideas'
  end
end
