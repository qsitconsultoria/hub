require 'spec_helper'

describe Admin::TopicsController do
  before { sign_in_teacher }

  let(:valid_attributes) { build(:topic).attributes }

  let(:unit) { create :unit }
  let(:course) { create :course, unit: unit }
  let(:subject) { create :subject, course: course }

  describe 'GET index' do
    let(:topic) { create :topic, subject: subject }

    it 'assigns all topics as @topics' do
      get :index, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param
      expect(assigns(:topics)).to eq([topic])
    end
  end

  describe 'GET new' do
    it 'assigns a new topic as @topic' do
      get :new, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param
      expect(assigns(:topic)).to be_a_new(Topic)
    end
  end

  describe 'GET edit' do
    let(:topic) { create :topic, subject: subject }

    it 'assigns the requested topic as @topic' do
      get :edit, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param
      expect(assigns(:topic)).to eq(topic)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Topic' do
        expect {
          post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, topic: valid_attributes
        }.to change(Topic, :count).by(1)
      end

      it 'assigns a newly created topic as @topic' do
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, topic: valid_attributes
        expect(assigns(:topic)).to be_a(Topic)
        expect(assigns(:topic)).to be_persisted
      end

      it 'redirects to the created topic' do
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, topic: valid_attributes
        expect(response).to redirect_to([:edit, :admin, unit, course, subject, Topic.last])
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved topic as @topic' do
        allow_any_instance_of(Topic).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, topic: { 'name' => 'invalid value' }
        expect(assigns(:topic)).to be_a_new(Topic)
      end

      it 're-renders the "edit" template' do
        allow_any_instance_of(Topic).to receive(:save).and_return(false)
        post :create, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, topic: { 'name' => 'invalid value' }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let!(:topic) { create :topic, subject: subject }

      it 'updates the requested topic' do
        expect_any_instance_of(Topic).to receive(:update).with({ 'name' => 'MyString' })
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param, topic: { 'name' => 'MyString' }
      end

      it 'assigns the requested topic as @topic' do
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param, topic: valid_attributes
        expect(assigns(:topic)).to eq(topic)
      end

      it 'redirects to the topic' do
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param, topic: valid_attributes
        expect(response).to redirect_to([:edit, :admin, unit, course, subject, Topic.last])
      end
    end

    describe 'with invalid params' do
      let(:topic) { create :topic, subject: subject }

      it 'assigns the topic as @topic' do
        allow_any_instance_of(Topic).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param, topic: { 'name' => 'invalid value' }
        expect(assigns(:topic)).to eq(topic)
      end

      it 're-renders the "edit" template' do
        allow_any_instance_of(Topic).to receive(:save).and_return(false)
        put :update, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param, topic: { 'name' => 'invalid value' }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:topic) { create :topic, subject: subject }

    it 'destroys the requested topic' do
      expect {
        delete :destroy, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param
      }.to change(Topic, :count).by(-1)
    end

    it 'redirects to the topics list' do
      delete :destroy, unit_id: unit.to_param, course_id: course.to_param, subject_id: subject.to_param, id: topic.to_param
      expect(response).to redirect_to(admin_unit_course_subject_topics_url(unit, course, subject))
    end
  end

end
