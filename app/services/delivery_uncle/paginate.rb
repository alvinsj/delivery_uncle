module DeliveryUncle
  class Paginate
    def initialize(per_page=20)
      @per_page = per_page
    end
    
    def page(model, params) 
      @page = params[:page].present? ? params[:page].to_i :  1
      @params = params
      start = (@page-1) * @per_page 
      start = 0 if start < 0
      @size = model.count
      @model = model.limit(@per_page).offset(start)
      self
    end
    
    def data
      @model
    end

    def prev_page_url
      return nil unless @page > 1
      @params.merge({page: @page-1})
    end

    def next_page_url
      return nil if end_of_page?
      @params.merge(page: @page +1)
    end

    def end_of_page?
      @page*@per_page > @size
    end
  end
end
