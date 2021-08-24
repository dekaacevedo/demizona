import "jquery-bar-rating";

const initRating = () => {
  $("#review_rating").barrating({
    theme: "fontawesome-stars",
  });
};

export { initRating };
