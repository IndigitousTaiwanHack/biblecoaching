class Api::BibleController < Api::ApplicationController

   def show
     params[:bid]
     bible = Bible.find_by_bid(params[:bid])
     contents = get_bible_contents(bible)

     render :json => {result: 0, bid:params[:bid], title: bible.book.title, content: contents }
   end

   def index
     begin
       bibles = Bible.all
       data = []
       bibles.each do |bible|
         contents = []
         count = Book.find(bible.book_id).bibles.count
         bible.bible_contents.to_a.each do |content|
           puts content.id
           contents << "#{content.content_id.to_s }: #{content.content.to_s}"
         end
         data << {bid:bible.bid, title: bible.book.title, content: contents.join("\n"), count:count }
       end
       result = 0
     rescue
       result = -1
     end

     render :json => {result: result, bibles:data}
   end

  def popular
    data = Hash.new
    begin
      bible = Bible.popular
      data[:bible_title] = bible.book.title
      data[:bid] = bible.bid
      data[:post_count] =  bible.count
      result = 0
    rescue
      result = -1
    end
    render :json => {result: result, post:data}
  end

  def book_list
    begin
      books = Book.all
      result = 0
    rescue
      result = -1
    end

    render :json => {result: result, books:books.as_json(only: [:id, :title, :abbr])}
  end

  def bible_list
    begin
      bibles = Bible.find_by_book(params[:book_id]).all
      result = 0
    rescue
      result = -1
    end

    render :json => {result: result, bibles:bibles.as_json(only: [:bid])}
  end

   # random bible
  def emotion
    data = Hash.new
    begin
      bible = Bible.offset(rand(Bible.count)).first
      data[:bible_title] = bible.book.title
      data[:bid] = bible.bid
      data[:contents] =  get_bible_contents(bible)
      result = 0
    rescue
      result = -1
    end

    render :json => {result: result, bible:data}
  end

end
