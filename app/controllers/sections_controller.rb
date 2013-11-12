class SectionsController < ApplicationController

  layout 'admin'

  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  before_filter :find_page
  
  def index
  	list
  	render('list')
  end

  def list
    @sections = Section.order("sections.position ASC").where(:page_id => @page.id)
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new(:page_id => @page.id)
    @section_count = @page.sections.size + 1
    @pages = Page.order('postion ASC')
  end 

  def create
  	new_position = params[:section].delete(:position)
    @section = Section.new(params[:section].permit!)
  	if @section.save
      @section.move_to_position(new_position)
  		flash[:notice] = "Section Created"
  		redirect_to(:action => 'list', :page_id => @page.id)
    else
    	@section_count = @page.sections.size + 1
      @pages = Page.order('postion ASC')
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @section_count = @page.sections.size
    @pages = Page.order('postion ASC')
  end

  def update
  	new_position = params[:section].delete(:position)
    @section = Section.find(params[:id])
  	  if @section.update_attributes(params[:section].permit!)
  		@section.move_to_position(new_position)
      flash[:notice] = "Section Updated!"
  		redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
  	  else
  		@section_count = @page.sections.size
      @pages = Page.order('postion ASC')
      render('edit')
  	  end
  end

  def delete
  	@section = Section.find(params[:id])
  end

  def destroy
  	section = Section.find(params[:id])
    section.move_to_position(nil)
    section.destroy
  	flash[:notice] = "Section Deleted"
  	redirect_to(:action => 'list', :page_id => @page.id)
  end

  private
  def find_page
    if params[:page_id]
      @page = Page.find_by_id(params[:page_id])
    end
  end
end
