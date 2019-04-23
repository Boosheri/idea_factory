class ReviewsController < ApplicationController
    before_action :find_review, only: [:show, :edit, :update, :destroy]
    before_action :authorize!, only: [:edit, :destroy, :update]

    def create
        @idea = Idea.find(params[:idea_id])
        @review = Review.new review_params
        @review.idea = @idea
        @review.user = current_user
        if @review.save
            redirect_to idea_path(@idea)
        else
            @reviews = @idea.reviews.order(created_at: :desc)
            render 'ideas/show'
        end
    end

    def destroy
        @review = Review.find(params[:id])
        if can?(:crud, @review)
            @review.destroy
            redirect_to idea_path(@review.idea)
          else
            head :unauthorized
          end
    end

    private
    
      def review_params
        params.require(:review).permit(:body)
      end

      def find_review
        @review = Review.find(params[:id])
      end

    def authorize!
        redirect_to root_path, alert: "access denied" unless can? :crud, @review
    end
end