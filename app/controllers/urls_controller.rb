# frozen_string_literal: true

class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)

    duplicate = @url.find_duplicate

    if duplicate
      flash[:info] = 'Url is already in the database'

      redirect_to show_url_path(duplicate.shortened_url)
    else
      @url.shortened_url = UrlShortener::GenerateShortUrl.new(length: Url::SHORT_URL_LENGTH).call

      if @url.save
        redirect_to show_url_path(@url.shortened_url)
      else
        flash[:danger] = 'Please provide a valid url'

        redirect_to new_url_path
      end
    end
  end

  def show
    url = set_url
    @original_url = url.original_url
    @shortened_url = "#{request.host_with_port}/#{url.shortened_url}"
  end

  def redirect_to_original_url
    url = set_url
    sanitized_url = UrlShortener::SanitizeUrl.new(url: url.original_url).call
    redirect_to sanitized_url
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end

  def set_url
    Url.find_by(shortened_url: params[:shortened_url])
  end
end
