class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index, :show ]
  before_filter :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show

    #@post = Post.find_by_permalink(params[:post_id])
 #puts "DD====*********===#{@post.id}"
 #puts @post
 #@category = Category.find_by_permalink(params[:id => @post.category_id])
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
    @post = Post.find_by_permalink(params[:post_id])
     
  end

  def create
    #@comment = Comment.new(params[:comment])
    #@comment.save
    #respond_with(@comment)
    @post = Post.find_by_permalink(params[:post_id])

   
    @id = current_user.id
    params[:comment].merge!(:user_id => @id)
     @comment = @post.comments.create!(params[:comment])

     redirect_to category_post_path(@post.category,@post)
                
  end

  def update
    #raise params.inspect
    #@post = Post.find_by_permalink(params[:id])
     @comment.update_attributes(params[:comment])
     

redirect_to category_post_path(@comment.post.category, @comment.post)
  end

  def destroy
    @comment.destroy
   
    redirect_to category_post_path(@comment.post.category, @comment.post)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end
end
