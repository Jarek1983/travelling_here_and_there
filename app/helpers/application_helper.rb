module ApplicationHelper

  def sponsored_article?(article)
    article.type == 'SponsoredArticle'
  end
  #metody te możemy tak samo zapisac w modelu
  
end
