import React from "react";
import { Link } from "react-router-dom";

const PodcastTile = (props) => {
  let deleteButton = <></>;

  if (props.user.admin) {
    deleteButton = <input id={`${props.podcast.id}`} type="button" value="Delete" onClick={props.deleteClick} className="delete button"></input>
  }

  return (
    <div className="podcast-tile callout">
      <Link to={`/podcasts/${props.podcast.id}`}>{props.podcast.name}</Link>
      {deleteButton}
    </div>
  );
};

export default PodcastTile;
