require 'spec_helper'

describe TopicsController do
  before { sign_in_student }

  describe 'GET show' do
    let(:unit) { create(:unit) }
    let(:course) { create(:course, unit: unit) }
    let(:subject) { create(:subject, course: course) }
    let(:topic) { create(:topic, subject: subject) }

    it 'assigns the requested unit as @unit' do
      get :show, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param
      expect(assigns(:unit)).to eq(unit)
    end

    it 'assigns the requested course as @course' do
      get :show, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param
      expect(assigns(:course)).to eq(course)
    end

    it 'assigns the requested subject as @subject' do
      get :show, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param
      expect(assigns(:subject)).to eq(subject)
    end

    it 'assigns the requested topic as @topic' do
      get :show, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param
      expect(assigns(:topic)).to eq(topic)
    end
  end
end
