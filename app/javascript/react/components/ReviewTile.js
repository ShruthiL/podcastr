import React from "react";

const ReviewTile = (props) => {
    return (
        <div>
            <p> {props.review.rating}/5</p>
            <p> {props.review.review}</p>
        </div>
    );
};

export default ReviewTile;
