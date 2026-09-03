class Api::V1::PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    @posts = @user.posts
    render json: @posts
  end

  def create
    @post = @user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @post
  end

  def destroy
    @post.destroy
    head :no_content
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
