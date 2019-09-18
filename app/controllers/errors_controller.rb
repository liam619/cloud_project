class ErrorsController < ApplicationController
  def index
    render 'index', locals: {statuscode: '404', message: "The page you were looking for doesn't exist."}
  end

  def unprocessable
    render 'index', locals: {statuscode: '422', message: "The change you wanted was rejected."}
  end

  def internal_server_error
    render 'index', locals: {statuscode: '500', message: "We're sorry, but something went wrong."}
  end

end
