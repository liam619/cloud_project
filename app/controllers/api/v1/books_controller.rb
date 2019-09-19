module Api
  module V1
    class BooksController < ApplicationController
      respond_to :json

      def index
        respond_with Book.all
      end

      def show
        respond_with Book.where(["name like ?", "%#{params[:name]}%"])
      end

    end
  end
end