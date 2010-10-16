class SearchTermsController < ApplicationController
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
    if search_term.save
      flash[:success] = "Successfully created search term"
      redirect_to dashboard_path
    else
      flash.now[:error] = "There was a problem creating your search term"
      render :new
    end
  end
end
