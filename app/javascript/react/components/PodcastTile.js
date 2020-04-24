import React from "react";
import { Link } from "react-router-dom";

const PodcastTile = (props) => {
  return (
    <div className="podcast-tile">
      <Link to={`/podcasts/${props.podcast.id}`}>{props.podcast.name}</Link>
    </div>
  );
};

export default PodcastTile;
