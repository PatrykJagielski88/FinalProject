class AboutController < ApplicationController
  def show
    @about_page = true

    @about_a = About.all
  end
end
