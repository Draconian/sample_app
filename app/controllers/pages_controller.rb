class PagesController < ApplicationController
  def home
  	@titre = "Acceuil"
  end

  def contact
  	@titre = "Contact"
  end

  def about
  	@titre = "À propos"
  end

  	def help 
  		@titre = "Aides"
  	end
end
