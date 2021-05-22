class SearchController < ApplicationController
  
  def index
    if params[:query].start_with?('#')
      query = params[:query].gsub('#', '')
      @tweets = Tweet.joins(:hash_tags).where(hash_tags: {name: query}).order("created_at DESC").page(params[:page])
    else
      @tweets = Tweet.where("content like ?", "%#{params[:query]}%").order("created_at DESC").page(params[:page])
    end
  end
end
