class ApplicationController < ActionController::Base
  class UnauthorizedException < Exception
  end

  class ForbiddenException < Exception
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
