class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    idea = Idea.find params[:idea_id]
    like = Like.new(user: current_user, idea: idea)
  
    if not can?(:like, idea)
      flash[:danger] = "That's a bit narcissistic..."
      return redirect_to idea_path(idea)
    end
    if like.save
      flash[:success] = "Idea Liked!"
    else
      flash[:danger] = "Already Liked..."
    end

    redirect_to idea_path(idea)
  end

  def destroy
    idea = Idea.find params[:idea_id]
    @like = Like.find params[:id]
    @like.destroy

    flash[:success] = "Idea Unliked!"
    redirect_to idea_path(idea)
  end
end