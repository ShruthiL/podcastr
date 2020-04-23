import React from "react";

const PodcastTile = (props) => {
  return (
    <div className="podcast-tile">
      <p>{props.podcast.name}</p>
    </div>
  );
};

export default PodcastTile;
