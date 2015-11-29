class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :check_user_auth, only: :create

  attr_accessor :raiting

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    if params[:search].present?
      @posts = Post.where('title LIKE ? or body LIKE ? or tags LIKE ?',
                          "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    elsif params['sort_by'] == 'popular'
      @posts = @posts.sort_by { |post| post.likes.like_post.count}.reverse
    elsif params['sort_by'] == 'active'
      @posts = @posts.sort_by { |post| post[:updated_at]}.reverse
    elsif params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all.newest.reverse
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments.where(ancestry: nil)
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
    if session[:user_id].nil?
      redirect_to login_path
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        current_user.update_attribute('raiting', current_user.raiting *= 5)
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    current_user.update_attribute('raiting', current_user.raiting /= 5)
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :tag_list, :post_image_url)
    end

    def check_user
      if @post.user_id != session[:user_id]
        flash[:alert] = 'You have not permission!'
        redirect_to root_path
      end
    end

    def check_user_auth
      if session[:user_id].nil?
        flash[:alert] = 'You have not permission!'
        redirect_to root_path
      end
    end
end
