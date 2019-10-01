class Api::V1::PageController < ApplicationController

  def load_pages
    if Page.all.none? and PagesLoader.call
      payload = {
        message: "wikipedia pages sucessfully load",
        status: 200
      }
      render json: payload, status: :ok
    else
      payload = {
        message: "wikipedia pages already loaded",
        status: 200
      }
      render json: payload, status: :ok
    end

  end

  

end
