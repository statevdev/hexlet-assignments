# frozen_string_literal: true

module Web
  module Movies
    class CommentsController < ApplicationController
      def index
        @comments = resource_movie.comments
      end

      def new
        @comment = resource_movie.comments.build
      end

      def edit
        @comment = resource_movie.comments.find params[:id]
      end

      def create
        @comment = resource_movie.comments.build(permitted_comments_params)

        if @comment.save
          redirect_to movie_comments_path(resource_movie), notice: t('success')
        else
          flash[:alert] = t('fail')
          render :new, status: :unprocessable_entity
        end
      end

      def update
        @comment = resource_movie.comments.find params[:id]

        if @comment.update(permitted_comments_params)
          redirect_to movie_comments_path(resource_movie), notice: t('success')
        else
          flash[:alert] = t('fail')
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @comment = resource_movie.comments.find params[:id]

        @comment&.destroy!

        redirect_to movie_comments_path(resource_movie), notice: t('.success')
      end

      private

      def permitted_comments_params
        params.require(:comment).permit(:body, :movie_id)
      end
    end
  end
end
