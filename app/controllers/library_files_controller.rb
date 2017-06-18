class LibraryFilesController < ApplicationController
  include ActiveSupport::Inflector
  before_action :set_dependencies, only: [:index]

  def index
    if params[:query] && params[:query][:searchable_title_cont].present?
      params[:query][:searchable_title_cont] = transliterate(params[:query][:searchable_title_cont])
    end

    @q = LibraryFile.ransack(params[:query])

    if params[:query]
      @files = @q.result(distinct: true).includes(:themes, :territorial_coverages, :biomes, :courses).page(params[:page]).per(10)
    end
  end

  def show
    @file = LibraryFile.friendly.find(params[:id])
    @comment = Comment.new
  end

  def autocomplete
    render json: LibraryFile.ransack(searchable_title_cont: transliterate(params[:query])).result
  end

  private
    def set_dependencies
      @themes = Theme.all
      @territorial_coverages = TerritorialCoverage.all
      @biomes = Biome.all
      @courses = Course.all
      @authors = LibraryFile.authors
      @filetypes = LibraryFile.filetypes
      @languages = LibraryFile.languages
      @years = LibraryFile.pluck(:year).uniq.delete_if { |v| v.nil? }.sort.reverse
    end
end
