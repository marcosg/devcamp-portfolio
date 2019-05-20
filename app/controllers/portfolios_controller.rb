class PortfoliosController < ApplicationController
  layout 'portfolio'
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit, :sort]}, site_admin: :all

  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  before_action :hide_masthead, only: [:new, :edit]

  def index
    @portfolio_items = Portfolio.by_position
  end

  def sort
    params[:order].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
    end
    render body: nil
  end

  def new
    @portfolio_item = Portfolio.new
  end

  def angular
    @angular_portfolio_items = Portfolio.angular
  end

  def create
    @portfolio_item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, success: 'Portfolio was created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to portfolios_path, success: 'Portfolio was updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show; end

  def destroy
    @portfolio_item.destroy
    respond_to do |format|
      format.html {redirect_to portfolios_path, success: 'Portfolio was removed'}
    end
  end

  private

  def hide_masthead
    @hide_masthead = true
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_portfolio
    @portfolio_item = Portfolio.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def portfolio_params
    params.require(:portfolio).permit(:title,
                                      :subtitle,
                                      :body,
                                      technologies_attributes: [:id, :name, :_destroy]
    )
  end
end
