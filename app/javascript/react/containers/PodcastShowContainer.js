import React, { useState, useEffect } from "react";
import { Link } from 'react-router-dom';
import ReviewTile from "../components/ReviewTile";
import PodcastReviewFormContainer from "./PodcastReviewFormContainer"

const PodcastShowContainer = (props) => {
  const [podcast, setPodcast] = useState({});
  const [user, setUser] = useState({});
  const [reviews, setReviews] = useState([]);

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
        setPodcast(body.podcast);
        setReviews(body.podcast.reviews);
        setUser(body.podcast.user)
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

  const rerender = (review) => {
    setReviews(
      [...reviews, review]
    )
  }

  let reviewForm;
  if (user.userName != null) {
    reviewForm = <PodcastReviewFormContainer
      id={props.match.params.id}
      rerender={rerender}
      user={user} />
  } else {
    reviewForm = <></>
  }

  return (
    <div>
      <div className="grid-container no-padding">
        <div className="grid-x grid-margin-x callout">
          <h3 className="cell small-8 large-10">{podcast.name}</h3>
          <a className="button cell small-4 large-2 listen" href={podcast.url} target="_blank">
            Listen Here
          </a>
        </div>
      </div>
      {reviewForm}
      <div className="callout">
        <h4>Reviews:</h4>
        {reviewTiles}
      </div>
      <Link to="/" className="button">All Podcasts</Link>
    </div>
  );
};

export default PodcastShowContainer;
