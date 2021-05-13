# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
    # recent 10 short urls
    @url = Url.new
    @urls = Url.all
  end

  def create
    @url = Url.new(url_params)

    if @url.save
      render json: @url, status: 201
    else
      render json: {errors: @url.errors}, status: 422
    end
  end

  def show
    @url = Url.new(short_url: 'ABCDE', original_url: 'http://google.com', created_at: Time.now)
    # implement queries
    @daily_clicks = [
      ['1', 13],
      ['2', 2],
      ['3', 1],
      ['4', 7],
      ['5', 20],
      ['6', 18],
      ['7', 10],
      ['8', 20],
      ['9', 15],
      ['10', 5]
    ]
    @browsers_clicks = [
      ['IE', 13],
      ['Firefox', 22],
      ['Chrome', 17],
      ['Safari', 7]
    ]
    @platform_clicks = [
      ['Windows', 13],
      ['macOS', 22],
      ['Ubuntu', 17],
      ['Other', 7]
    ]
  end

  def visit
    # params[:short_url]
    render plain: 'redirecting to url...'
  end

  private 

  def url_params
    params.require(:url).permit(:original_url)
  end
end
