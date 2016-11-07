# encoding: utf-8
class BibleController < ApplicationController
  helper BibleHelper

  def index
    @books = Book.all
    respond_to do |format|
      format.html
    end
  end

  def bid
    @bibles = Bible.where(:book_id=>params[:id]).all
    respond_to do |format|
      format.js
    end
  end

  def get_content
    @contents = BibleContent.where(:bible_bid=>params[:bid]).all
    respond_to do |format|
      format.js
    end
  end

  def create
    File.open("#{Rails.root}/bible_index",'r').each_with_index  do |fileb,book_index|
      book_index +=1
      next if book_index < 26
      lines = fileb.squish.split(",")
      book = lines[0]
      chapter_count=lines[1]
      (1..chapter_count.to_i).each do |c_index|
        @doc = Nokogiri::HTML(open("http://www.taiwanbible.com/web/bible/readChapter.jsp?Book=#{book}&Chapter=#{c_index}").read, nil, "UTF-8")
        @doc.xpath('//div[contains(@id, "CONTROL_HHV")]').to_a.each_with_index do |div, index|
          index+=1
          content = div.text.strip
          bible = Bible.new(bid:book_index.to_s+"-"+c_index.to_s+"-"+index.to_s, book: book, content: content)
          bible.save!
        end
      end
    end
  end

  def download
    @bibles = Bible.all
    respond_to do |format|
      format.html # don't forget if you pass html
      format.xls { send_data(@bibles.to_a.to_xls) }
    end
  end

  def prepare
  end
end
