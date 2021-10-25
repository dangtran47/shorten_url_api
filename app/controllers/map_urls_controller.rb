require 'faker'

class MapUrlsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def index
    if current_user
      render json: { data: current_user.map_urls }
    else
      render json: { data: [] }
    end
  end

  def show
    @map_url = MapUrl.find_by(shorten_url: params[:id])
    if @map_url
      render json: { data: @map_url }
    else
      render json: {}
    end
  end

  def create
    origin = request.headers['HTTP_ORIGIN']
    original_url = params.require(:original_url)
    shorten_name = params[:shorten_name]

    if shorten_name.to_s.strip.empty?
      loop do
        shorten_url = format(I18n.t('s_s'), origin, Faker::Alphanumeric.alphanumeric(number: 10))
        next if MapUrl.find_by(shorten_url: shorten_url)

        map_url = MapUrl.create({ shorten_url: shorten_url, original_url: original_url, user_id: @current_user_id })
        render json: { data: { shorten_url: map_url.shorten_url } }
        break
      end

    else
      user_shorten_url = format(I18n.t('s_s'), origin, shorten_name)
      map_url = MapUrl.find_or_initialize_by(shorten_url: user_shorten_url, user_id: @current_user_id) do |m|
        m.original_url = original_url
      end

      if map_url.new_record?
        map_url.save
        render json: { data: { shorten_url: map_url.shorten_url } }
      else
        render json: { errors: { message: 'Shorten URL has already been existed.' } }, status: :bad_request
      end
    end
  end
end
