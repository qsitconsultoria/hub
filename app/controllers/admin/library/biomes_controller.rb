class Admin::Library::BiomesController < Admin::AdminController
  def index
    @biomes = Biome.with_files
  end

  def show
    @biome = Biome.friendly.find(params[:id])
    @files = @biome.library_files.page(params[:page]).per(10)
  end
end
