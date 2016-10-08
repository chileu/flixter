class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]

  def show
  end

  private
  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_lesson
    @course = current_lesson.section.course
    if !current_user.enrolled_in?(@course)
      redirect_to course_path(@course), alert: 'Only users enrolled in this course can view lessons. Please enroll below.'
    end
  end

end
