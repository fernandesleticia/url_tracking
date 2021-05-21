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
    render json: {errors: 'record not found'}, status: 404 and return if @url.nil?
    
    clicks = Click.where(url_id: @url.id)

    @daily_clicks = clicks.pluck(:created_at).group_by(&:day).map {|k,v| [k, v.length]}
    @browsers_clicks = clicks.pluck(:browser).group_by(&:capitalize).map {|k,v| [k, v.length]}
    @platform_clicks = clicks.pluck(:platform).group_by(&:capitalize).map {|k,v| [k, v.length]}
  end

  def visit
    url = Url.find_by_short_url(params[:short_url])
    render json: {errors: 'record not found'}, status: 404 and return if url.nil?

    url.update_attribute(:clicks_count, url.clicks_count + 1)
    Click.create(url_id: url.id, browser: browser.name, platform: browser.platform.name)
  
    render plain: 'redirecting to url...'
  end

  def latest
    render json: { latest_urls: Url.latest(params[:amount]) }, status: 200
  end

  private 

  def browser
    @browser ||= Browser.new(request.headers['User-Agent'])
  end

  def url_params
    params.require(:url).permit(:original_url)
  end
end
