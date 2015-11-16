class MoviesController < ApplicationController
helper_method :sort_column

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.find(order(sort_column)
    @movies = Movie.where(rating: my_ratings.keys)
    @movies.order!(sort_column)
    @all_ratings = Movie.give_ratings
    @current_ratings = my_ratings.keys
    
    
    
    sort_column == 'title' ? @klass = 'hilite' : ''
    sort_column == "release_date" ? @klass1 = 'hilite' : ''
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

private
  def sort_column
    %w[title release_date].include?(params[:sort]) ? params[:sort] : "title"
  end
  def my_ratings
    params[:ratings] ||= {G: '1', PG: '1', "PG-13" => '1', R: '1'}
  end
end
