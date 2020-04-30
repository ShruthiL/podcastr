import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import PodcastTile from "../components/PodcastTile";

const PodcastsIndexContainer = (props) => {
  const [podcasts, setPodcasts] = useState([]);
  const [user, setUser] = useState({
    user_name: "",
    email: "",
    admin: false,
  });

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
        setUser(body.user);
      })
      .catch((error) => console.error(`Error in fetch: ${error.message}`));
  }, []);

  let podcastTiles;
  if (podcasts.length === 0) {
    podcastTiles = (
      <div>
        <p>No podcasts yet</p>
      </div>
    );
  } else {
    podcastTiles = podcasts.map((podcast) => {
      return <PodcastTile key={podcast.id} podcast={podcast} />;
    });
  }
  return (
    <div>
      <Link className="button" to="/podcasts/new">
        Add a New Podcast
      </Link>
      {podcastTiles}
    </div>
  );
};

export default PodcastsIndexContainer;
