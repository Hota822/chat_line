# frozen_string_literal: true

# for kadai
class KadaiController < ApplicationController
  def api
    id = params[:id]
    case id
    when '1'
      value = { id: id, neme: 'hoge' }
    when '2'
      value = { id: id, neme: 'fuga' }
    end
     render json: value

#     render 'api.js.erb'
    #  respond_to do |format|
    #   format.html {redirect_to root_path, flash: {alert: 'please activate javascript'}}
    #   format.js { render 'api'}
    # end
     
  end
end
