require 'spec_helper'

describe Course do
  context 'validations' do
    let(:course) { build :course }

    it 'is invalid without name' do
      expect(Course.new).to have(1).error_on(:name)
    end

    it 'is invalid with duplicated name' do
      create :course, name: 'Rails for Designers'
      duplicated = Course.new(name: 'Rails for Designers')
      expect(duplicated).to have(1).error_on(:name)
    end

    it 'is invalid without slug' do
      expect(Course.new).to have(1).error_on(:slug)
    end

    it 'is invalid with duplicated slug' do
      create :course, slug: 'rails-for-designers'
      duplicated = Course.new(slug: 'rails-for-designers')
      expect(duplicated).to have(1).error_on(:slug)
    end
  end

  context 'associations' do
    it 'has many subjects' do
      rails = build :course
      intro = build :subject
      rails.subjects << intro
      expect(rails.subjects).to eq [intro]
    end

    it 'destroy subjects when destroyed' do
      rails = create :course
      intro = create :subject
      rails.subjects << intro
      expect{
        rails.destroy
      }.to change(Subject, :count).from(1).to(0)
    end
  end

  describe '#slug' do
    context 'when provided' do
      it 'keeps provided slug' do
        course = create :course, name: 'Rails for Designers', slug: 'rails'
        expect(course.slug).to eql 'rails'
      end
    end

    context 'when not provided' do
      it 'creates slug from name' do
        course = create :course, name: 'Rails for Designers', slug: ''
        expect(course.slug).to eql 'rails-for-designers'
      end
    end
  end
end