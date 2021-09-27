require 'faker'

class MapUrlsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def show
    @map_url = MapUrl.find_by(shorten_url: params[:id])
    if @map_url
      render json: @map_url
    else
      render json: {}
    end
  end

  def create
    origin = request.headers["HTTP_ORIGIN"]
    original_url = params.require(:original_url)
    shorten_name = params[:shorten_name]

    if shorten_name
      user_shorten_url = format(I18n.t('s_s'), origin, shorten_name)
      map_url = MapUrl.find_or_initialize_by(shorten_url: user_shorten_url) do |m|
        m.original_url = original_url
      end

      if map_url.new_record?
        map_url.save
        render json: { error: { message: 'Shorten URL created successfully.' } }
      else
        render json: { error: { message: 'Shorten URL has already been existed.' } }
      end
    else
      loop do
        shorten_url = format(I18n.t('s_s'), origin, Faker::Alphanumeric.alphanumeric(number: 10))
        unless MapUrl.find_by(shorten_url: shorten_url)
          MapUrl.create({ shorten_url: shorten_url, original_url: original_url })
          break
        end
      end

      render json: { error: { message: 'Shorten URL created successfully.' } }
    end
  end
end
