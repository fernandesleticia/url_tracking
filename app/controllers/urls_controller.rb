# frozen_string_literal: true

class UrlsController < ApplicationController
  def index
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
    @url = Url.find_by_short_url(params[:url])
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
    url = Url.find_by_original_url(params[:short_url])
    url.update(clicks_count: 1)
  
    Click.create(url_id: url.id, browser: browser.name, platform: browser.platform.name)
  
    render plain: 'redirecting to url...'
  end

  private 

  def browser
    @browser ||= Browser.new(request.headers['User-Agent'])
  end

  def url_params
    params.require(:url).permit(:original_url)
  end
end
