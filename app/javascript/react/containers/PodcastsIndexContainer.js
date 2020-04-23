import React, { useState, useEffect } from "react";
import PodcastTile from "../components/PodcastTile";

const PodcastsIndexContainer = (props) => {
  const [podcasts, setPodcasts] = useState([]);

  useEffect(() => {
    fetch("/api/v1/podcasts")
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
        setPodcasts(body);
      })
      .catch((error) => console.error(`Error in fetch: ${error.message}`));
  }, []);

  let podcastTiles;
  if (podcasts.length === 0) {
    podcastTiles = <div><p>No podcasts yet</p></div>
  } else {
    podcastTiles = podcasts.map((podcast) => {
      return <PodcastTile key={podcast.id} podcast={podcast} />;
    });
  }
  return <div>{podcastTiles}</div>;
};

export default PodcastsIndexContainer;
