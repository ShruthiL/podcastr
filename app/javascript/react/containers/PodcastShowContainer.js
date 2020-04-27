import React, { useState, useEffect } from "react";

const PodcastShowContainer = (props) => {
  const [podcast, setPodcast] = useState({});
  const [reviews, setReviews] = useState({
    rating: "",
    review: ""
  });

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
        setPodcast(body["podcast"]);
        setReviews(body["reviews"])
      })
      .catch((error) => console.error(`Error in fetch: ${error.message}`));
  }, []);

  return (
    <div>
      <p>{podcast.name}</p>
      <a href={podcast.url} target="_blank">
        {podcast.url}
      </a>
    </div>
  );
};

export default PodcastShowContainer;
