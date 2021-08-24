import "jquery-bar-rating";

const initRating = () => {
 $('#review_rating').barrating({
    theme: 'css-stars'
  });
}

export { initRating };
