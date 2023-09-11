class Api::NewQuestionController < ApplicationController
	before_action :authenticate_user!

end
