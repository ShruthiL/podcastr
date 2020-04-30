import React, { useState, useEffect } from "react";
import ReviewTile from "../components/ReviewTile";
import PodcastReviewFormContainer from "./PodcastReviewFormContainer"

const PodcastShowContainer = (props) => {
  const [podcast, setPodcast] = useState({});
  const [reviews, setReviews] = useState([]);
  const [user, setUser] = useState({});

  useEffect(() => {
    const id = props.match.params.id;
    fetch(`/api/v1/podcasts/${id}`)
      .then((response) => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`;
          let error = new Error(errorMessage);
          throw error;
        }
      })
      .then((response) => response.json())
      .then((body) => {
        setPodcast(body.podcast.podcast);
        setReviews(body.podcast.podcast.reviews);
        setUser(body.user.user)
      })
      .catch((error) => console.error(`Error in fetch: ${error.message}`));
  }, []);

  let reviewTiles;
  if (reviews.length === 0) {
    reviewTiles = <div><p> No reviews yet</p></div>
  } else {
    reviewTiles = reviews.map((review) => {
      return <ReviewTile key={review.id} review={review} />
    });
  }

  let reviewForm;
  if (user.user_name === "") {
    reviewForm = <></>
  } else {
    reviewForm = <PodcastReviewFormContainer
      id={props.match.params.id}
      rerender={rerender}
      user={user} />
  }

  const rerender = (review) => {
    setReviews (
      [...reviews, review] 
    )
  }

  return (
    <div>
      <p>{podcast.name}</p>
      <a href={podcast.url} target="_blank">
        {podcast.url}
      </a>
      <div>
        {reviewForm}
        <h6>Reviews:</h6>
        {reviewTiles}
      </div>
    </div>
  );
};

export default PodcastShowContainer;
