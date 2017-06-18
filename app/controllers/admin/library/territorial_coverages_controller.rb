class Admin::Library::TerritorialCoveragesController < Admin::AdminController

  def index
    @territorial_coverages = TerritorialCoverage.with_files
  end

  def show
    @territorial_coverage = TerritorialCoverage.friendly.find(params[:id])
    @files = @territorial_coverage.library_files.page(params[:page]).per(10)
  end
end
