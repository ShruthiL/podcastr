import React from "react";
import { Link } from "react-router-dom";

const PodcastTile = (props) => {
  let deleteButton = <></>;

  if (props.user.admin) {
    deleteButton = <input type="button" value="Delete"></input>
  }

  return (
    <div className="podcast-tile">
      <Link to={`/podcasts/${props.podcast.id}`}>{props.podcast.name}</Link>
      {deleteButton}
    </div>
  );
};

export default PodcastTile;
