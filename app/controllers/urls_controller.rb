# frozen_string_literal: true

class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)

    @url.shortened_url = UrlShortener::GenerateShortUrl.new(length: Url::SHORT_URL_LENGTH).call

    if @url.save
      redirect_to show_url_path(@url.shortened_url)
    else
      flash[:error] = 'Please provide a valid url'

      redirect_to new_url_path
    end
  end

  def show
    url = set_url
    @original_url = url.original_url
    @shortened_url = "#{request.host_with_port}/#{url.shortened_url}"
  end

  def redirect_to_original_url
    url = set_url

    redirect_to url.original_url
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end

  def set_url
    Url.find_by(shortened_url: params[:shortened_url])
  end
end
