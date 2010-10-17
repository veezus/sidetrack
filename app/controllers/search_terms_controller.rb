class SearchTermsController < ApplicationController
  before_filter :authorize, :only => :index

  assume(:search_term) do
    # TODO (while sober): Figure out why the default assumption isn't working
    if search_term = current_user.search_terms.find_by_id(params[:id])
      search_term
    else
      current_user.search_terms.new(params[:search_term])
    end
  end

  assume(:search_terms) { current_user.search_terms }

  def create
    # TODO: Do nothing if the search term already exists
    if search_term.save
      flash[:success] = "Successfully created search term"
      redirect_to dashboard_path
    else
      flash.now[:error] = "There was a problem creating your search term"
      render :new
    end
  end

  def destroy
    current_user.search_terms.find(params[:id]).destroy
    redirect_to dashboard_path
  end

private

  def sign_in!
    session[ 'twitter_rtoken' ], session[ 'twitter_stoken' ] = nil, nil
    redirect_to twitter_connect_path
  end

  def authorize
    if current_user.twitter_atoken? && current_user.twitter_stoken?
      oauth.authorize_from_access(current_user.twitter_atoken, current_user.twitter_stoken)
      @profile = Twitter::Base.new(oauth)
    else
      sign_in!
    end
  end
end
