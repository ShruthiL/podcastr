import React from "react";
import { Link } from "react-router-dom";

const PodcastTile = (props) => {
  // let deleteButton = "Hello";
  let deleteButton;
  // debugger
  // if ('undefined' !== typeof props.user) {
    if (props.user.admin) {
      deleteButton = "Admin"
    } else {
      deleteButton = "Hello"
    }
  // }
  // debugger

  return (
    <div className="podcast-tile">
      <Link to={`/podcasts/${props.podcast.id}`}>{props.podcast.name}</Link>
      <div>{deleteButton}</div>
    </div>
  );
};

export default PodcastTile;
