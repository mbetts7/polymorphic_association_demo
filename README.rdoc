# Polymorphic Association
## When you have one model that could belong to any one of a set of models.
## Comments is the classic example.
## A comments could belong to a book, an event or a photo.
</br>

## Goals:

* <h3> Understand overview of polymorphic relationships.</h3>
* <h3> How to set up model relationships. </h3>
  * <h4>comment.rb: "belongs_to :commentable, polymorphic: true"</h4>
  * <h4>book.rb: "has_many :comments, as: :commentable"</h4>
* <h3> How to set up the migration file. </h3>
  * <h4>commentable_id:integer, commentable_type:string</h4>
* <h3> How to use the active record relationship commands.</h3>
  * <h4> book.comments => finds all comments for a book </h4>
  * <h4> comment.commentable => to find model type for a comment</h4>

## Start a new rails app:
    rails _4.0.2_ new polymorf

    rails g model comment content:text commentable_id:integer commentable_type:string
    rails g model book title:string
    rails g model event name:string
    rails g model photo caption:string

    rails g controller books index show

## Edit Gemfile:

  group :development, :test do
    gem 'pry'
    gem 'pry-rails'
    gem 'dotenv-rails'
  end

## Edit the Comments migration file

  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :commentable, polymorphic: true
      t.timestamps
      end
      add_index :comments, [:commentable_id, :commentable_type]
    end

## Edit comment.rb file:

  class Comment < ActiveRecord::Base
    belongs_to :commentable, polymorphic: true
  end

## Edit book.rb file:
  class Book < ActiveRecord::Base
    has_many :comments, as: :commentable
  end

## Create books_controller.rb file:
  rails g controller books index show

## Edit books_controller.rb file:
  class BooksController < ApplicationController
    def index
      @books = Book.all
    end

    def show
      @book = Book.find(params[:id])
      @book_comments = @book.comments
    end
  end

## Edit view/books/index.html.erb:
  <h1>Books</h1>

  <% @books.each do |book| %>

    <h2><a href="/books/<%= book.id%>"><li><%= book.title %></li></a></h2>

  <% end %>

## Edit view/books/show.html.erb
  <h1><%=  @book.title %></h1>

  <% @book_comments.each do |comment| %>

    <h2><li><%= comment.content %></li></h2>

  <% end %>