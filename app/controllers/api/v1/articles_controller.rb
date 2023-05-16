module Api
  module V1
    class ArticlesController < ApplicationController

      def index
        begin
          @articles = Article.all
          render json: {
            status: "True",
            data: @articles
          },status: :ok
        rescue => exception
          render json: {
            status: "False",
            msg: exception
          }
        end
      end
 
      def show
        begin
          article = Article.find(params[:id])
          render json: {
            status: "True",
            data: article
          },status: :ok
        rescue => exception
          render json: {
            status: "False",
            msg: exception
          }
        end
      end

      def create
        begin
          article = Article.new(params.require(:article).permit(:title,:body))
          if article.save
            render json: {
              status: "True",
              msg: "Article Created succesfully",
              data: article
            },status: :ok
          else
            render json: {
              status: "False",
              data: article.errors
            },status: :unprocessable_entity
          end
        rescue => exception
          render json: {
            status: "False",
            msg: exception
          }
        end
      end

      def update
        begin
          article = Article.find(params[:id])
          if article.update(params.require(:article).permit(:title,:body))
            render json: {
              status: "True",
              msg: "Article Updated succesfully",
              data: article
            },status: :ok
          else
            render json: {
              status: "False",
              msg: "Article Not Updated",
              data: article.errors
            },status: :unprocessable_entity
          end
        rescue => exception
          render json: {
            status: "False",
            msg: exception
          }
        end
      end

      def destroy
        begin
          article = Article.find(params[:id])
          if article.destroy
            render json: {
              status: "True",
              msg: "Article deleted succesfully"
            },status: :ok
          else
            render json: {
              status: "False",
              msg: "Article could not be deleted succesfully"
            },status: :unprocessable_entity
          end
        rescue => exception
          render json: {
            status: "False",
            msg: exception
          }
        end
      end
    end
  end
end
