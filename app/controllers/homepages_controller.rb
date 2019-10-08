class HomepagesController < ApplicationController
  def index
  end
  
  def nope
    @msg = params[:nope]
  end
end
