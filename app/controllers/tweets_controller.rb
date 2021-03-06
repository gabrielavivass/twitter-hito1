class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy retweet]

  # GET /tweets or /tweets.json
  def index
    @q = Tweet.ransack(params[:q])
    @tweet = Tweet.new
    #if signed_in?
      #@tweets = User.tweets_for_me(current_user).page(params[:page]).per(50)
    #else
      @tweets = @q.result(distinct: true).order("created_at DESC").page(params[:page]).per(50)
    #end
  end

  def retweet
    redirect_to root_path, alert: 'it is not possible to retweet' and return if @tweet.user == current_user
    retweeted = Tweet.new(content: @tweet.content)
    retweeted.user = current_user
    retweeted.rt_ref = @tweet.id
    if retweeted.save
      if @tweet.retweet.nil?
        @tweet.update(retweet: @tweet.retweet = 1)  
      else
        
        @tweet.update(retweet: @tweet.retweet += 1)
      end
      
      redirect_to root_path, notice: 'successfully entered'
    else
      redirect_to root_path, alert: 'it is not possible to retweet'
    end 
  end

  # GET /tweets/1 or /tweets/1.json
  def show
    
  end
  
  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id)
    end
end