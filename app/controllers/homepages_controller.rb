class HomepagesController < ApplicationController
  def index
    @drivers = Driver.all
    @passengers = Passenger.all
    @trips = Trip.all
  end
  
  def show
    homepage_id = params[:id].to_i
    # Both find and find_by will work... But Dee has a preference for find_by. Why?
    @homepage = Homepage.find_by(id: homepage_id)
    if @homepage.nil?
      head :not_found
      return
    end
  end
  
  def new
    # This new "empty" instance of the homepage model is used in the view's form... When it's "empty", the form will be empty
    @homepage = homepage.new
  end
  
  def create
    # Step 2: Create an action so that the form data actually gets processed by Rails (by the server) and creates that new homepage, and changes the database... Also, if there is an error in changing the database, we will handle it here.
    
    # First, we will access the form data from the new homepage form using params and its very specific data structure
    
    # Every time I call something like homepage.new, homepage.create, homepage.update in the controller, I will replace the params with strong params
    @homepage = homepage.new( homepage_params )
    
    if @homepage.save
      redirect_to homepage_path(@homepage.id)
    else
      render new_homepage_path
    end
  end
  
  def edit
    @homepage = Homepage.find_by(id: params[:id] )
  end
  
  def update
    @homepage = Homepage.find_by(id: params[:id] )
    
    # Instead of doing @homepage.title = ... assignment, and then @homepage.save, we will instead do "if @homepage.update( homepage_params )" to use strong params pattern. @homepage.update() will be false if the update was unsuccessful
    if @homepage.update( homepage_params )
      redirect_to homepage_path(@homepage.id)
    else
      render new_homepage_path
    end
  end
  
  def destroy
    # We will find the right homepage using the id found in params
    # Then, depending on if we find it...
    #   we will either destroy it, then we will redirect to root page
    #   or not! and we will redirect to index page
    
    the_correct_homepage = Homepage.find_by( id: params[:id] )
    
    # Because find_by will give back nil if the homepage is not found...
    
    if the_correct_homepage.nil?
      # Then the homepage was not found!
      redirect_to homepages_path
      return
    else
      # Then we did find it!
      the_correct_homepage.destroy
      redirect_to root_path
      return
    end
  end
  
  private
  
  # Every method defined under the word private is going to be a private method
  
  def homepage_params
    # The responsibility of this method is to return "strong params"
    # .require is used when we use form_with and a model, and therefore our expected form data has the "homepage" hash inside of it
    # .permit takes in a list of names of attributes to allow... (aka the new homepage form has title, author, description)
    return params.require(:homepage).permit(:title, :author_id, :description)
    
    # Remember: If you ever update the database, model, and form, this will also need to be updated
  end
  
end
