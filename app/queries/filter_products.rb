class FilterProducts

  attr_reader :products

  def initialize(products = initial_scope)
    @products = products
  end

  def call(params = {})
    scoped = products
    scoped = filter_by_title(scoped, params[:title])
    scoped = filter_by_min_price(scoped, params[:min_price])
    scoped = filter_by_max_price(scoped, params[:max_price])
    scoped = filter_by_category_id(scoped, params[:category_id])
    sorting(scoped, params[:sorting_by])
  end

  private

  def initial_scope
    Product.all
  end

  def filter_by_title(scoped, title)
    return scoped unless title.present?

    scoped.where("title ilike '%#{title}%'")
  end

  def filter_by_min_price(scoped, min_price)
    return scoped unless min_price.present?

    scoped.where("price >= ?", min_price)
  end

  def filter_by_max_price(scoped, max_price)
    return scoped unless max_price.present?

    scoped.where("price <= ?", max_price)
  end

  def filter_by_category_id(scoped, category_id)
    return scoped unless category_id.present?

    scoped.where(category_id: category_id)
  end

  def sorting(scoped, sorting_by)
    options = {
      'newest': 'created_at DESC',
      'oldest': 'created_at ASC',
      'expensive': 'price DESC',
      'cheapest': 'price ASC'
    }
    scoped.order(options[sorting_by&.to_sym] || options[:newest])
  end
end